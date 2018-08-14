import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
      //rebuildOnChange: true,
      converter: InvoiceListVM.fromStore,
      builder: (context, vm) {
        return InvoiceList(
          viewModel: vm,
        );
      },
    );
  }
}

class InvoiceListVM {
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
  final Function onClearClientFilterPressed;
  final Function(BuildContext) onViewClientFilterPressed;
  final Function(BuildContext, InvoiceEntity, EntityAction) onEntityAction;

  InvoiceListVM({
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
    @required this.onClearClientFilterPressed,
    @required this.onViewClientFilterPressed,
    @required this.onEntityAction,
  });

  static InvoiceListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadInvoices(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return InvoiceListVM(
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
        onClearClientFilterPressed: () =>
            store.dispatch(FilterInvoicesByClient()),
        onViewClientFilterPressed: (BuildContext context) => store.dispatch(
            ViewClient(
                clientId: state.invoiceListState.filterClientId,
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
                  popCompleter(
                      context, localization.successfullyMarkedInvoiceAsSent),
                  invoice.id));
              break;
            case EntityAction.emailInvoice:
              Navigator.of(context).pop();
              store.dispatch(ShowEmailInvoice(
                  completer: snackBarCompleter(
                      context, localization.successfullyEmailedInvoice),
                  invoice: invoice,
                  context: context));
              break;
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(
                  EditInvoice(context: context, invoice: invoice.clone));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreInvoiceRequest(
                  popCompleter(
                      context, localization.successfullyRestoredInvoice),
                  invoice.id));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveInvoiceRequest(
                  popCompleter(
                      context, localization.successfullyArchivedInvoice),
                  invoice.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteInvoiceRequest(
                  popCompleter(
                      context, localization.successfullyDeletedInvoice),
                  invoice.id));
              break;
          }
        },
        onDismissed: (BuildContext context, InvoiceEntity invoice,
            DismissDirection direction) {
          final localization = AppLocalization.of(context);
          if (direction == DismissDirection.endToStart) {
            if (invoice.isDeleted || invoice.isArchived) {
              store.dispatch(RestoreClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyRestoredInvoice),
                  invoice.id));
            } else {
              store.dispatch(ArchiveClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyArchivedInvoice),
                  invoice.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (invoice.isDeleted) {
              store.dispatch(RestoreClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyRestoredInvoice),
                  invoice.id));
            } else {
              store.dispatch(DeleteClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyDeletedInvoice),
                  invoice.id));
            }
          }
        });
  }
}
