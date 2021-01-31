import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditEditScreen extends StatelessWidget {
  const CreditEditScreen({Key key}) : super(key: key);

  static const String route = '/credit/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditVM>(
      converter: (Store<AppState> store) {
        return CreditEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return CreditEdit(
          viewModel: viewModel,
        );
      },
    );
  }
}

class CreditEditVM extends EntityEditVM {
  CreditEditVM({
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

  factory CreditEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final credit = state.creditUIState.editing;

    return CreditEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: credit,
      invoiceItemIndex: state.creditUIState.editingItemIndex,
      origInvoice: store.state.creditState.map[credit.id],
      onSavePressed: (BuildContext context, [EntityAction action]) {
        if (credit.clientId.isEmpty) {
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
        store.dispatch(SaveCreditRequest(completer: completer, credit: credit));
        return completer.future.then((savedCredit) {
          showToast(credit.isNew
              ? localization.createdCredit
              : localization.updatedCredit);

          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(CreditViewScreen.route));
            if (credit.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(CreditViewScreen.route);
            } else {
              Navigator.of(context).pop(savedCredit);
            }
          } else {
            if (action != null) {
              handleEntityAction(context, savedCredit, action);
            } else {
              viewEntity(context: context, entity: savedCredit, force: true);
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
          store.dispatch(EditCreditItem(credit.lineItems.length));
        }
        store.dispatch(AddCreditItems(items));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: InvoiceEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
    );
  }
}
