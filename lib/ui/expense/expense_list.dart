import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'file:///C:/Users/hillel/Documents/flutter-mobile/lib/ui/expense/expense_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseListVM viewModel;

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.expense,
        editingId: viewModel.state.expenseUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.expenseList,
        entityMap: viewModel.expenseMap,
        entityPresenter: ExpensePresenter(),
        onTap: (BaseEntity expense) =>
            viewModel.onExpenseTap(context, expense));
  }

  @override
  void didUpdateWidget(ExpenseList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.expenseUIState.editing.id;
    dataTableSource.entityList = viewModel.expenseList;
    dataTableSource.entityMap = viewModel.expenseMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final listState = widget.viewModel.listState;
    final state = widget.viewModel.state;
    final widgets = <Widget>[];

    final documentMap = memoizedEntityDocumentMap(
        EntityType.expense, state.documentState.map, state.expenseState.map);

    if (listState.filterEntityId != null) {
      widgets.add(ListFilterMessage(
        filterEntityType: listState.filterEntityType,
        filterEntityId: listState.filterEntityId,
        onPressed: widget.viewModel.onViewEntityFilterPressed,
        onClearPressed: widget.viewModel.onClearEntityFilterPressed,
      ));
    }
    final store = StoreProvider.of<AppState>(context);
    final listUIState = store.state.uiState.expenseUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final viewModel = widget.viewModel;
    final expenseList = viewModel.expenseList;

    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.expenseMap.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    if (state.shouldSelectEntity(
        entityType: EntityType.expense, hasRecords: expenseList.isNotEmpty)) {
      viewEntityById(
          context: context,
          entityType: EntityType.expense,
          entityId: expenseList.isEmpty ? null : expenseList.first);
    }

    widgets.add(Expanded(
      child: !widget.viewModel.isLoaded
          ? LoadingIndicator()
          : RefreshIndicator(
              onRefresh: () => widget.viewModel.onRefreshed(context),
              child: widget.viewModel.expenseMap.isEmpty
                  ? HelpText(AppLocalization.of(context).noRecordsFound)
                  : state.prefState.moduleLayout == ModuleLayout.list
                      ? ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: widget.viewModel.expenseList.length,
                          itemBuilder: (BuildContext context, index) {
                            final expenseId =
                                widget.viewModel.expenseList[index];
                            final expense =
                                widget.viewModel.expenseMap[expenseId];
                            final client = widget.viewModel.state.clientState
                                .map[expense.clientId];
                            final vendor = widget.viewModel.state.vendorState
                                .map[expense.vendorId];

                            void showDialog() => showEntityActionsDialog(
                                  entities: [expense],
                                  context: context,
                                  client: client,
                                );

                            return ExpenseListItem(
                              userCompany: widget.viewModel.state.userCompany,
                              filter: widget.viewModel.filter,
                              hasDocuments: documentMap[expense.id] == true,
                              expense: expense,
                              client: client,
                              vendor: vendor,
                              onTap: () => widget.viewModel
                                  .onExpenseTap(context, expense),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  handleExpenseAction(
                                      context, [expense], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = store
                                        .state
                                        .prefState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  handleExpenseAction(context, [expense],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listUIState.isSelected(expense.id),
                            );
                          },
                        )
                      : SingleChildScrollView(
                          child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: PaginatedDataTable(
                            onSelectAll: (value) {
                              final expenses = widget.viewModel.expenseList
                                  .map<ExpenseEntity>((expenseId) =>
                                      widget.viewModel.expenseMap[expenseId])
                                  .where((expense) =>
                                      value !=
                                      listUIState.isSelected(expense.id))
                                  .toList();
                              handleExpenseAction(context, expenses,
                                  EntityAction.toggleMultiselect);
                            },
                            columns: [
                              if (!listUIState.isInMultiselect())
                                DataColumn(label: SizedBox()),
                              ...widget.viewModel.tableColumns.map((field) =>
                                  DataColumn(
                                      label: Text(AppLocalization.of(context)
                                          .lookup(field)),
                                      numeric:
                                          EntityPresenter.isFieldNumeric(field),
                                      onSort: (int columnIndex,
                                              bool ascending) =>
                                          store.dispatch(SortExpenses(field)))),
                            ],
                            source: dataTableSource,
                            header: DatatableHeader(
                              entityType: EntityType.expense,
                              onClearPressed:
                                  widget.viewModel.onClearEntityFilterPressed,
                            ),
                          ),
                        )),
            ),
    ));

    return Column(
      children: widgets,
    );
  }
}
