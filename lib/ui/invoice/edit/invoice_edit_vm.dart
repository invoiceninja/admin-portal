import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';

class InvoiceEditScreen extends StatelessWidget {
  static const String route = '/invoice/edit';
  const InvoiceEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditVM>(
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
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final InvoiceEntity origInvoice;
  final BuiltMap<int, ProductEntity> productMap;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(List<InvoiceItemEntity>) onItemsAdded;
  final Function onBackPressed;
  final bool isSaving;

  InvoiceEditVM({
    @required this.company,
    @required this.invoice,
    @required this.invoiceItem,
    @required this.origInvoice,
    @required this.productMap,
    @required this.onSavePressed,
    @required this.onItemsAdded,
    @required this.onBackPressed,
    @required this.onActionSelected,
    @required this.isSaving,
  });

  factory InvoiceEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditVM(
        company: state.selectedCompany,
        isSaving: state.isSaving,
        productMap: state.selectedCompanyState.productState.map,
        invoice: invoice,
        invoiceItem: state.invoiceUIState.editingItem,
        origInvoice: store.state.invoiceState.map[invoice.id],
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(InvoiceScreen.route)),
        onSavePressed: (BuildContext context) {
          final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
          store.dispatch(
              SaveInvoiceRequest(completer: completer, invoice: invoice));
          return completer.future.then((savedInvoice) {
            if (invoice.isNew) {
              Navigator.of(context).pushReplacementNamed(InvoiceViewScreen.route);
            } else {
              Navigator.of(context).pop(savedInvoice);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        },
        onItemsAdded: (items) {
          if (items.length == 1) {
            store.dispatch(EditInvoiceItem(items[0]));
          }
          store.dispatch(AddInvoiceItems(items));
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final Completer<Null> completer = Completer<Null>();
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
            if ([EntityAction.archive, EntityAction.delete].contains(action)) {
              Navigator.of(context).pop(message);
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: SnackBarRow(
                    message: message,
                  )
              ));
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
  }
}
