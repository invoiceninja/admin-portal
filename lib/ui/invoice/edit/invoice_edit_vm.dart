import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceEditScreen extends StatelessWidget {
  const InvoiceEditScreen({Key key}) : super(key: key);

  static const String route = '/invoice/edit';

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEdit(
          viewModel: viewModel,
          formKey: _formKey,
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
    @required this.invoiceItemIndex,
    @required this.origInvoice,
    @required this.onSavePressed,
    @required this.onItemsAdded,
    @required this.onBackPressed,
    @required this.isSaving,
    @required this.onCancelPressed,
  });

  final AppState state;
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final int invoiceItemIndex;
  final InvoiceEntity origInvoice;
  final Function(BuildContext) onSavePressed;
  final Function(List<InvoiceItemEntity>, String) onItemsAdded;
  final Function onBackPressed;
  final bool isSaving;
  final Function(BuildContext) onCancelPressed;
}

class InvoiceEditVM extends EntityEditVM {
  InvoiceEditVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    int invoiceItemIndex,
    InvoiceEntity origInvoice,
    Function(BuildContext) onSavePressed,
    Function(List<InvoiceItemEntity>, String) onItemsAdded,
    Function onBackPressed,
    bool isSaving,
    Function(BuildContext) onCancelPressed,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          invoiceItemIndex: invoiceItemIndex,
          origInvoice: origInvoice,
          onSavePressed: onSavePressed,
          onItemsAdded: onItemsAdded,
          onBackPressed: onBackPressed,
          isSaving: isSaving,
          onCancelPressed: onCancelPressed,
        );

  factory InvoiceEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: invoice,
      invoiceItemIndex: state.invoiceUIState.editingItemIndex,
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
          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(InvoiceViewScreen.route));
            if (invoice.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(InvoiceViewScreen.route);
            } else {
              Navigator.of(context).pop(savedInvoice);
            }
          } else {
            store.dispatch(ViewInvoice(
                context: context, invoiceId: savedInvoice.id, force: true));
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
        if (clientId != null && clientId.isNotEmpty) {
          store.dispatch(
              UpdateInvoice(invoice.rebuild((b) => b..clientId = clientId)));
        }
        store.dispatch(AddInvoiceItems(items));
        // if we're just adding one item automatically show the editor
        if (items.length == 1) {
          store.dispatch(EditInvoiceItem(invoice.lineItems.length));
        }
      },
      onCancelPressed: (BuildContext context) {
        store.dispatch(EditInvoice(
            invoice: InvoiceEntity(), context: context, force: true));
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
    );
  }
}
