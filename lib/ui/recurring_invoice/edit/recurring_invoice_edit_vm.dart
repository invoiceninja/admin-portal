import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/view/recurring_invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class RecurringInvoiceEditScreen extends StatelessWidget {
  const RecurringInvoiceEditScreen({Key key}) : super(key: key);

  static const String route = '/recurring_invoice/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceEditVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return RecurringInvoiceEdit(
          viewModel: viewModel,
        );
      },
    );
  }
}

class RecurringInvoiceEditVM extends EntityEditVM {
  RecurringInvoiceEditVM({
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

  factory RecurringInvoiceEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final recurringInvoice = state.recurringInvoiceUIState.editing;

    return RecurringInvoiceEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: recurringInvoice,
      invoiceItemIndex: state.recurringInvoiceUIState.editingItemIndex,
      origInvoice: store.state.recurringInvoiceState.map[recurringInvoice.id],
      onSavePressed: (BuildContext context, [EntityAction action]) {
        if (recurringInvoice.clientId.isEmpty) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                    AppLocalization.of(context).pleaseSelectAClient);
              });
          return null;
        }
        final localization = AppLocalization.of(context);
        final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
        store.dispatch(SaveRecurringInvoiceRequest(
            completer: completer, recurringInvoice: recurringInvoice));
        return completer.future.then((savedRecurringInvoice) {
          showToast(recurringInvoice.isNew
              ? localization.createdRecurringInvoice
              : localization.updatedRecurringInvoice);

          if (isMobile(context)) {
            store
                .dispatch(UpdateCurrentRoute(RecurringInvoiceViewScreen.route));
            if (recurringInvoice.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(RecurringInvoiceViewScreen.route);
            } else {
              Navigator.of(context).pop(savedRecurringInvoice);
            }
          } else {
            if (action != null) {
              handleEntityAction(context, savedRecurringInvoice, action);
            } else {
              viewEntity(
                  context: context, entity: savedRecurringInvoice, force: true);
            }
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
        if (items.length == 1) {
          store.dispatch(
              EditRecurringInvoiceItem(recurringInvoice.lineItems.length));
        }
        store.dispatch(AddRecurringInvoiceItems(items));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: InvoiceEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
    );
  }
}
