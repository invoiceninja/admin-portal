// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'recurring_invoice_screen.dart';

class RecurringInvoiceScreenBuilder extends StatelessWidget {
  const RecurringInvoiceScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceScreenVM>(
      converter: RecurringInvoiceScreenVM.fromStore,
      builder: (context, vm) {
        return RecurringInvoiceScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class RecurringInvoiceScreenVM {
  RecurringInvoiceScreenVM({
    required this.isInMultiselect,
    required this.recurringInvoiceList,
    required this.userCompany,
    required this.onEntityAction,
    required this.recurringInvoiceMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> recurringInvoiceList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, InvoiceEntity> recurringInvoiceMap;

  static RecurringInvoiceScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return RecurringInvoiceScreenVM(
      recurringInvoiceMap: state.recurringInvoiceState.map,
      recurringInvoiceList: memoizedFilteredRecurringInvoiceList(
          state.getUISelection(EntityType.recurringInvoice),
          state.recurringInvoiceState.map,
          state.clientState.map,
          state.vendorState.map,
          state.recurringInvoiceState.list,
          state.recurringInvoiceListState,
          state.userState.map),
      userCompany: state.userCompany,
      isInMultiselect: state.recurringInvoiceListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> recurringInvoices,
              EntityAction action) =>
          handleRecurringInvoiceAction(context, recurringInvoices, action),
    );
  }
}
