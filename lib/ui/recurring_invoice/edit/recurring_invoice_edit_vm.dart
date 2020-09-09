import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/view/recurring_invoice_view_vm.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit.dart';
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
          key: ValueKey(viewModel.recurringInvoice.id),
        );
      },
    );
  }
}

class RecurringInvoiceEditVM {
  RecurringInvoiceEditVM({
    @required this.state,
    @required this.recurringInvoice,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origRecurringInvoice,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory RecurringInvoiceEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final recurringInvoice = state.recurringInvoiceUIState.editing;

    return RecurringInvoiceEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origRecurringInvoice:
          state.recurringInvoiceState.map[recurringInvoice.id],
      recurringInvoice: recurringInvoice,
      company: state.company,
      onChanged: (InvoiceEntity recurringInvoice) {
        store.dispatch(UpdateRecurringInvoice(recurringInvoice));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(
            context: context, entity: InvoiceEntity(), force: true);
      },
      onSavePressed: (BuildContext context) {
        final Completer<InvoiceEntity> completer =
            new Completer<InvoiceEntity>();
        store.dispatch(SaveRecurringInvoiceRequest(
            completer: completer, recurringInvoice: recurringInvoice));
        return completer.future.then((savedRecurringInvoice) {
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
            viewEntity(
                context: context, entity: savedRecurringInvoice, force: true);
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final InvoiceEntity recurringInvoice;
  final CompanyEntity company;
  final Function(InvoiceEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final InvoiceEntity origRecurringInvoice;
  final AppState state;
}
