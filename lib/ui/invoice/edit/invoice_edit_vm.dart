import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
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
    @required this.invoiceItemIndex,
    @required this.origInvoice,
    @required this.onSavePressed,
    @required this.onItemsAdded,
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
          isSaving: isSaving,
          onCancelPressed: onCancelPressed,
        );

  factory InvoiceEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: invoice,
      invoiceItemIndex: state.invoiceUIState.editingItemIndex,
      origInvoice: store.state.invoiceState.map[invoice.id],
      onSavePressed: (BuildContext context) {
        if (invoice.clientId.isEmpty) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                    AppLocalization.of(context).pleaseSelectAClient);
              });
          return null;
        }
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
            viewEntity(context: context, entity: savedInvoice, force: true);
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
        createEntity(context: context, entity: InvoiceEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
    );
  }
}
