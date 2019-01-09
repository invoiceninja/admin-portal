import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceEditScreen extends StatelessWidget {
  const InvoiceEditScreen({Key key}) : super(key: key);

  static const String route = '/invoice/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEdit(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditVM {
  EntityEditVM({
    @required this.state,
    @required this.company,
    @required this.invoice,
    @required this.invoiceItem,
    @required this.origInvoice,
    @required this.onSavePressed,
    @required this.onItemsAdded,
    @required this.onBackPressed,
    @required this.isSaving,
  });

  final AppState state;
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final InvoiceEntity origInvoice;
  final Function(BuildContext) onSavePressed;
  final Function(List<InvoiceItemEntity>, int) onItemsAdded;
  final Function onBackPressed;
  final bool isSaving;
}

class InvoiceEditVM extends EntityEditVM {
  InvoiceEditVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    InvoiceItemEntity invoiceItem,
    InvoiceEntity origInvoice,
    Function(BuildContext) onSavePressed,
    Function(List<InvoiceItemEntity>, int) onItemsAdded,
    Function onBackPressed,
    bool isSaving,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          invoiceItem: invoiceItem,
          origInvoice: origInvoice,
          onSavePressed: onSavePressed,
          onItemsAdded: onItemsAdded,
          onBackPressed: onBackPressed,
          isSaving: isSaving,
        );

  factory InvoiceEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditVM(
      state: state,
      company: state.selectedCompany,
      isSaving: state.isSaving,
      invoice: invoice,
      invoiceItem: state.invoiceUIState.editingItem,
      origInvoice: store.state.invoiceState.map[invoice.id],
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(InvoiceScreen.route)) {
          store.dispatch(UpdateCurrentRoute(
              invoice.isNew ? InvoiceScreen.route : InvoiceViewScreen.route));
        }
      },
      onSavePressed: (BuildContext context) {
        final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
        store.dispatch(
            SaveInvoiceRequest(completer: completer, invoice: invoice));
        return completer.future.then((savedInvoice) {
          store.dispatch(UpdateCurrentRoute(InvoiceViewScreen.route));
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
      onItemsAdded: (items, clientId) {
        if (clientId != null && clientId > 0) {
          store.dispatch(
              UpdateInvoice(invoice.rebuild((b) => b..clientId = clientId)));
        }
        store.dispatch(AddInvoiceItems(items));
        // if we're just adding one item automatically show the editor
        if (items.length == 1) {
          store.dispatch(EditInvoiceItem(items[0]));
        }
      },
    );
  }
}
