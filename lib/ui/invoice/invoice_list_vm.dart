import 'dart:async';
import 'package:built_collection/built_collection.dart';
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
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_vm.dart';

class InvoiceListBuilder extends StatelessWidget {
  InvoiceListBuilder({Key key}) : super(key: key);

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
  final List<int> invoiceList;
  final BuiltMap<int, InvoiceEntity> invoiceMap;
  final BuiltMap<int, ClientEntity> clientMap;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, InvoiceEntity) onInvoiceTap;
  final Function(BuildContext, InvoiceEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  InvoiceListVM({
    @required this.invoiceList,
    @required this.invoiceMap,
    @required this.clientMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onInvoiceTap,
    @required this.onDismissed,
    @required this.onRefreshed,
  });

  static InvoiceListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final Completer<Null> completer = new Completer<Null>();
      store.dispatch(LoadInvoices(completer, true));
      return completer.future.then((_) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: SnackBarRow(
              message: AppLocalization.of(context).refreshComplete,
            ),
            duration: Duration(seconds: 3)));
      });
    }

    return InvoiceListVM(
        invoiceList: memoizedInvoiceList(store.state.invoiceState.map,
            store.state.invoiceState.list, store.state.invoiceListState),
        invoiceMap: store.state.invoiceState.map,
        clientMap: store.state.clientState.map,
        isLoading: store.state.isLoading,
        isLoaded: store.state.invoiceState.isLoaded &&
            store.state.clientState.isLoaded,
        onInvoiceTap: (context, invoice) {
          store.dispatch(SelectInvoice(invoice));
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => InvoiceEditScreen()));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, InvoiceEntity invoice,
            DismissDirection direction) {
          final Completer<Null> completer = new Completer<Null>();
          var message = '';
          if (direction == DismissDirection.endToStart) {
            if (invoice.isArchived()) {
              store.dispatch(RestoreInvoiceRequest(completer, invoice.id));
              message = AppLocalization.of(context).successfullyRestoredInvoice;
            } else {
              store.dispatch(ArchiveInvoiceRequest(completer, invoice.id));
              message = AppLocalization.of(context).successfullyArchivedInvoice;
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (invoice.isArchived() || invoice.isDeleted) {
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
                ),
                duration: Duration(seconds: 3)));
          });
        });
  }
}
