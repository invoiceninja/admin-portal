import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/invoice/invoice_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/invoice/invoice_list.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';

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
  final AppState state;
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

  InvoiceListVM({
    @required this.state,
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
  });

  static InvoiceListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final Completer<Null> completer = new Completer<Null>();
      store.dispatch(LoadInvoices(completer, true));
      return completer.future.then((_) {
        Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).refreshComplete,
            )));
      });
    }

    final state = store.state;

    return InvoiceListVM(
        state: state,
        invoiceList: memoizedInvoiceList(
            state.invoiceState.map,
            state.invoiceState.list,
            state.clientState.map,
            state.invoiceListState),
        invoiceMap: state.invoiceState.map,
        clientMap: state.clientState.map,
        isLoading: state.isLoading,
        isLoaded: state.invoiceState.isLoaded && state.clientState.isLoaded,
        filter: state.invoiceListState.search,
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
        onDismissed: (BuildContext context, InvoiceEntity invoice,
            DismissDirection direction) {
          final Completer<Null> completer = new Completer<Null>();
          var message = '';
          if (direction == DismissDirection.endToStart) {
            if (invoice.isDeleted || invoice.isArchived) {
              store.dispatch(RestoreInvoiceRequest(completer, invoice.id));
              message = AppLocalization.of(context).successfullyRestoredInvoice;
            } else {
              store.dispatch(ArchiveInvoiceRequest(completer, invoice.id));
              message = AppLocalization.of(context).successfullyArchivedInvoice;
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (invoice.isDeleted) {
              store.dispatch(RestoreInvoiceRequest(completer, invoice.id));
              message = AppLocalization.of(context).successfullyRestoredInvoice;
            } else {
              store.dispatch(DeleteInvoiceRequest(completer, invoice.id));
              message = AppLocalization.of(context).successfullyDeletedInvoice;
            }
          }
          return completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(
                    content: SnackBarRow(
                  message: message,
                )));
          });
        });
  }
}
