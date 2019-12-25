import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final listState = viewModel.listState;
    final state = viewModel.state;
    final widgets = <Widget>[];

    final documentMap = memoizedEntityDocumentMap(
        EntityType.expense, state.documentState.map, state.expenseState.map);

    if (listState.filterEntityId != null) {
      widgets.add(ListFilterMessage(
        filterEntityType: listState.filterEntityType,
        filterEntityId: listState.filterEntityId,
        onPressed: viewModel.onViewEntityFilterPressed,
        onClearPressed: viewModel.onClearEntityFilterPressed,
      ));
    }
    final store = StoreProvider.of<AppState>(context);
    final listUIState = store.state.uiState.expenseUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final expenseList = viewModel.expenseList;

    if (isNotMobile(context) &&
        expenseList.isNotEmpty &&
        !state.uiState.isEditing &&
        !expenseList.contains(state.expenseUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.expense,
          entityId: expenseList.first);
    }

    widgets.add(Expanded(
      child: !viewModel.isLoaded
          ? LoadingIndicator()
          : RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: viewModel.expenseList.isEmpty
                  ? HelpText(AppLocalization.of(context).noRecordsFound)
                  : ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => ListDivider(),
                      itemCount: viewModel.expenseList.length,
                      itemBuilder: (BuildContext context, index) {
                        final expenseId = viewModel.expenseList[index];
                        final expense = viewModel.expenseMap[expenseId];
                        final client =
                            viewModel.state.clientState.map[expense.clientId];
                        final vendor =
                            viewModel.state.vendorState.map[expense.vendorId];

                        void showDialog() => showEntityActionsDialog(
                              entities: [expense],
                              context: context,
                              client: client,
                            );

                        return ExpenseListItem(
                          userCompany: viewModel.state.userCompany,
                          filter: viewModel.filter,
                          hasDocuments: documentMap[expense.id] == true,
                          expense: expense,
                          client: client,
                          vendor: vendor,
                          onTap: () => viewModel.onExpenseTap(context, expense),
                          onEntityAction: (EntityAction action) {
                            if (action == EntityAction.more) {
                              showDialog();
                            } else {
                              handleExpenseAction(context, [expense], action);
                            }
                          },
                          onLongPress: () async {
                            final longPressIsSelection = store.state.prefState
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
                    ),
            ),
    ));

    return Column(
      children: widgets,
    );
  }
}
