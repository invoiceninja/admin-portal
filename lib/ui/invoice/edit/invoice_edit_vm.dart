import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_selectors.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class InvoiceEditScreen extends StatelessWidget {
  static final String route = '/invoice/edit';
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
  final Function(InvoiceEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function() onAddInvoiceItemPressed;
  final Function(int) onRemoveInvoiceItemPressed;
  final Function(InvoiceItemEntity, int) onChangedInvoiceItem;
  final Function onBackPressed;
  final bool isLoading;

  InvoiceEditVM({
    @required this.invoice,
    @required this.clientList,
    @required this.clientMap,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onAddInvoiceItemPressed,
    @required this.onRemoveInvoiceItemPressed,
    @required this.onChangedInvoiceItem,
    @required this.onBackPressed,
    @required this.onActionSelected,
    @required this.isLoading,
  });

  factory InvoiceEditVM.fromStore(Store<AppState> store) {
    AppState state = store.state;
    final invoice = state.invoiceUIState.selected;

    return InvoiceEditVM(
        isLoading: state.isLoading,
        invoice: invoice,
        clientList: memoizedActiveClientList(
            state.clientState.map, state.clientState.list),
        clientMap: state.clientState.map,
        onBackPressed: () => store.dispatch(UpdateCurrentRoute(InvoiceScreen.route)),
        onAddInvoiceItemPressed: () => store.dispatch(AddInvoiceItem()),
        onRemoveInvoiceItemPressed: (index) => store.dispatch(DeleteInvoiceItem(index)),
        onChangedInvoiceItem: (invoiceItem, index) {
          store.dispatch(UpdateInvoiceItem(invoiceItem: invoiceItem, index: index));
        },
        onChanged: (InvoiceEntity invoice) => store.dispatch(UpdateInvoice(invoice)),
        onSavePressed: (BuildContext context) {
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(
              SaveInvoiceRequest(completer: completer, invoice: invoice));
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
        });
  }
}
