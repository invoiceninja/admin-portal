import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';

class InvoiceListBuilder extends StatelessWidget {
  static const String route = '/invoices/edit';

  const InvoiceListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceListVM>(
      converter: InvoiceListVM.fromStore,
      builder: (context, vm) {
        return InvoiceList(
          viewModel: vm,
        );
      },
    );
  }
}

class EntityListVM {
  final UserEntity user;
  final ListUIState listState;
  final List<int> invoiceList;
  final BuiltMap<int, InvoiceEntity> invoiceMap;
  final BuiltMap<int, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, InvoiceEntity) onInvoiceTap;
  final Function(BuildContext, InvoiceEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final Function(BuildContext, InvoiceEntity, EntityAction) onEntityAction;

  EntityListVM({
    @required this.user,
    @required this.listState,
    @required this.invoiceList,
    @required this.invoiceMap,
    @required this.clientMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.filter,
    @required this.onInvoiceTap,
    @required this.onDismissed,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onEntityAction,
  });
}

class InvoiceListVM extends EntityListVM {
  InvoiceListVM({
    UserEntity user,
    ListUIState listState,
    List<int> invoiceList,
    BuiltMap<int, InvoiceEntity> invoiceMap,
    BuiltMap<int, ClientEntity> clientMap,
    String filter,
    bool isLoading,
    bool isLoaded,
    Function(BuildContext, InvoiceEntity) onInvoiceTap,
    Function(BuildContext, InvoiceEntity, DismissDirection) onDismissed,
    Function(BuildContext) onRefreshed,
    Function onClearEntityFilterPressed,
    Function(BuildContext) onViewEntityFilterPressed,
    Function(BuildContext, InvoiceEntity, EntityAction) onEntityAction,
  }) : super(
          user: user,
          listState: listState,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          isLoaded: isLoaded,
          onInvoiceTap: onInvoiceTap,
          onDismissed: onDismissed,
          onRefreshed: onRefreshed,
          onClearEntityFilterPressed: onClearEntityFilterPressed,
          onViewEntityFilterPressed: onViewEntityFilterPressed,
          onEntityAction: onEntityAction,
        );

  static InvoiceListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadInvoices(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return InvoiceListVM(
        user: state.user,
        listState: state.invoiceListState,
        invoiceList: memoizedFilteredInvoiceList(
            state.invoiceState.map,
            state.invoiceState.list,
            state.clientState.map,
            state.invoiceListState),
        invoiceMap: state.invoiceState.map,
        clientMap: state.clientState.map,
        isLoading: state.isLoading,
        isLoaded: state.invoiceState.isLoaded && state.clientState.isLoaded,
        filter: state.invoiceListState.filter,
        onInvoiceTap: (context, invoice) {
          store.dispatch(ViewInvoice(invoiceId: invoice.id, context: context));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onClearEntityFilterPressed: () =>
            store.dispatch(FilterInvoicesByEntity()),
        onViewEntityFilterPressed: (BuildContext context) => store.dispatch(
            ViewClient(
                clientId: state.invoiceListState.filterEntityId,
                context: context)),
        onEntityAction: (context, invoice, action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.pdf:
              Navigator.of(context).pop();
              viewPdf(invoice, context);
              break;
            case EntityAction.markSent:
              store.dispatch(MarkSentInvoiceRequest(
                  popCompleter(context, localization.markedInvoiceAsSent),
                  invoice.id));
              break;
            case EntityAction.email:
              store.dispatch(ShowEmailInvoice(
                  completer: popCompleter(context, localization.emailedInvoice),
                  invoice: invoice,
                  context: context));
              break;
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(
                  EditInvoice(context: context, invoice: invoice.clone));
              break;
            case EntityAction.payment:
              Navigator.of(context).pop();
              store.dispatch(EditPayment(
                  context: context,
                  payment: PaymentEntity().rebuild((b) => b
                    ..invoiceId = invoice.id
                    ..clientId = invoice.clientId
                    ..amount = invoice.balance)));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreInvoiceRequest(
                  popCompleter(context, localization.restoredInvoice),
                  invoice.id));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveInvoiceRequest(
                  popCompleter(context, localization.archivedInvoice),
                  invoice.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteInvoiceRequest(
                  popCompleter(context, localization.deletedInvoice),
                  invoice.id));
              break;
          }
        },
        onDismissed: (BuildContext context, InvoiceEntity invoice,
            DismissDirection direction) {
          final localization = AppLocalization.of(context);
          if (direction == DismissDirection.endToStart) {
            if (invoice.isDeleted || invoice.isArchived) {
              store.dispatch(RestoreInvoiceRequest(
                  snackBarCompleter(context, localization.restoredInvoice),
                  invoice.id));
            } else {
              store.dispatch(ArchiveInvoiceRequest(
                  snackBarCompleter(context, localization.archivedInvoice),
                  invoice.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (invoice.isDeleted) {
              store.dispatch(RestoreInvoiceRequest(
                  snackBarCompleter(context, localization.restoredInvoice),
                  invoice.id));
            } else {
              store.dispatch(DeleteInvoiceRequest(
                  snackBarCompleter(context, localization.deletedInvoice),
                  invoice.id));
            }
          }
        });
  }
}
