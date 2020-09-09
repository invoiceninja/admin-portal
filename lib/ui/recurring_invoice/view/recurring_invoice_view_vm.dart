import 'dart:async';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/view/recurring_invoice_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class RecurringInvoiceViewScreen extends StatelessWidget {
  const RecurringInvoiceViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/recurring_invoice/view';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceViewVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return RecurringInvoiceView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class RecurringInvoiceViewVM {
  RecurringInvoiceViewVM({
    @required this.state,
    @required this.recurringInvoice,
    @required this.company,
    @required this.onEntityAction,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory RecurringInvoiceViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final recurringInvoice = state.recurringInvoiceState
            .map[state.recurringInvoiceUIState.selectedId] ??
        InvoiceEntity(id: state.recurringInvoiceUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadRecurringInvoice(
          completer: completer, recurringInvoiceId: recurringInvoice.id));
      return completer.future;
    }

    return RecurringInvoiceViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: recurringInvoice.isNew,
      recurringInvoice: recurringInvoice,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context, [recurringInvoice], action,
              autoPop: true),
    );
  }

  final AppState state;
  final InvoiceEntity recurringInvoice;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
