import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_selectors.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class InvoiceEditScreen extends StatelessWidget {
  static final String route = '/invoices/edit';
  InvoiceEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditVM>(
      //ignoreChange: (state) => invoiceSelector(state.invoice().list, id).isNotPresent,
      converter: (Store<AppState> store) {
        return InvoiceEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoiceEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class InvoiceEditVM {
  final InvoiceEntity invoice;
  final List<int> clientList;
  final BuiltMap<int, ClientEntity> clientMap;
  final Function onDelete;
  final Function(BuildContext, InvoiceEntity) onSaveClicked;
  final Function(BuildContext, EntityAction) onActionSelected;
  final bool isLoading;
  final bool isDirty;

  InvoiceEditVM({
    @required this.invoice,
    @required this.clientList,
    @required this.clientMap,
    @required this.onDelete,
    @required this.onSaveClicked,
    @required this.onActionSelected,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory InvoiceEditVM.fromStore(Store<AppState> store) {
    AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditVM(
      isLoading: state.isLoading,
      isDirty: invoice.isNew(),
      invoice: invoice,
      clientList: memoizedActiveClientList(state.clientState.map, state.clientState.list),
      clientMap: state.clientState.map,
      onDelete: () => false,
      onSaveClicked: (BuildContext context, InvoiceEntity invoice) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(SaveInvoiceRequest(completer, invoice));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: invoice.isNew()
                    ? AppLocalization.of(context).successfullyCreatedInvoice
                    : AppLocalization.of(context).successfullyUpdatedInvoice,
              ),
              duration: Duration(seconds: 3)));
        });
      },
      onActionSelected: (BuildContext context, EntityAction action) {
        final Completer<Null> completer = new Completer<Null>();
        var message = '';
        switch (action) {
          case EntityAction.archive:
            store.dispatch(ArchiveInvoiceRequest(completer, invoice.id));
            message = AppLocalization.of(context).successfullyArchivedInvoice;
            break;
          case EntityAction.delete:
            store.dispatch(DeleteInvoiceRequest(completer, invoice.id));
            message = AppLocalization.of(context).successfullyDeletedInvoice;
            break;
          case EntityAction.restore:
            store.dispatch(RestoreInvoiceRequest(completer, invoice.id));
            message = AppLocalization.of(context).successfullyRestoredInvoice;
            break;
        }
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: message,
              ),
              duration: Duration(seconds: 3)));
        });
      }
    );
  }
}
