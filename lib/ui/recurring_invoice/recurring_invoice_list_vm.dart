// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class RecurringInvoiceListBuilder extends StatelessWidget {
  const RecurringInvoiceListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceListVM>(
      converter: RecurringInvoiceListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.recurringInvoice,
            presenter: RecurringInvoicePresenter(),
            state: viewModel.state,
            entityList: viewModel.recurringInvoiceList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final recurringInvoiceId = viewModel.recurringInvoiceList[index];
              final recurringInvoice =
                  viewModel.recurringInvoiceMap[recurringInvoiceId]!;

              return RecurringInvoiceListItem(
                filter: viewModel.filter,
                invoice: recurringInvoice,
              );
            });
      },
    );
  }
}

class RecurringInvoiceListVM {
  RecurringInvoiceListVM({
    required this.state,
    required this.userCompany,
    required this.recurringInvoiceList,
    required this.recurringInvoiceMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static RecurringInvoiceListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return RecurringInvoiceListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.recurringInvoiceListState,
      recurringInvoiceList: memoizedFilteredRecurringInvoiceList(
          state.getUISelection(EntityType.recurringInvoice),
          state.recurringInvoiceState.map,
          state.clientState.map,
          state.vendorState.map,
          state.recurringInvoiceState.list,
          state.recurringInvoiceListState,
          state.userState.map),
      recurringInvoiceMap: state.recurringInvoiceState.map,
      isLoading: state.isLoading,
      filter: state.recurringInvoiceUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> recurringInvoices,
              EntityAction action) =>
          handleRecurringInvoiceAction(context, recurringInvoices, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: state.userCompany.settings
              .getTableColumns(EntityType.recurringInvoice) ??
          RecurringInvoicePresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortRecurringInvoices(field)),
      onClearMultielsect: () =>
          store.dispatch(ClearRecurringInvoiceMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> recurringInvoiceList;
  final BuiltMap<String, InvoiceEntity> recurringInvoiceMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
