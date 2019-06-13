import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseListVM viewModel;

  void _showMenu(BuildContext context, ExpenseEntity expense) async {
    if (expense == null) {
      return;
    }

    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) => SimpleDialog(
                children: expense
                    .getEntityActions(user: user, includeEdit: true)
                    .map((entityAction) {
              if (entityAction == null) {
                return Divider();
              } else {
                return ListTile(
                  leading: Icon(getEntityActionIcon(entityAction)),
                  title: Text(AppLocalization.of(context)
                      .lookup(entityAction.toString())),
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    viewModel.onEntityAction(context, expense, entityAction);
                  },
                );
              }
            }).toList()));

    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final state = viewModel.state;
    final widgets = <Widget>[];
    BaseEntity filteredEntity;

    if (listState.filterEntityType == EntityType.vendor) {
      filteredEntity = state.vendorState.map[listState.filterEntityId];
    } else if (listState.filterEntityType == EntityType.client) {
      filteredEntity = state.clientState.map[listState.filterEntityId];
    }

    if (filteredEntity != null) {
      widgets.add(Material(
        color: Colors.orangeAccent,
        elevation: 6.0,
        child: InkWell(
          onTap: () => viewModel.onViewEntityFilterPressed(context),
          child: Row(
            children: <Widget>[
              SizedBox(width: 18.0),
              Expanded(
                child: Text(
                  '${localization.filteredBy} ${filteredEntity.listDisplayName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => viewModel.onClearEntityFilterPressed(),
              )
            ],
          ),
        ),
      ));
    }

    widgets.add(Expanded(
      child: !viewModel.isLoaded
          ? LoadingIndicator()
          : RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: viewModel.expenseList.isEmpty
                  ? Opacity(
                      opacity: 0.5,
                      child: Center(
                        child: Text(
                          AppLocalization.of(context).noRecordsFound,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )
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
                        return ExpenseListItem(
                          user: viewModel.user,
                          filter: viewModel.filter,
                          expense: expense,
                          client: client,
                          vendor: vendor,
                          onTap: () => viewModel.onExpenseTap(context, expense),
                          onEntityAction: (EntityAction action) {
                            if (action == EntityAction.more) {
                              _showMenu(context, expense);
                            } else {
                              viewModel.onEntityAction(
                                  context, expense, action);
                            }
                          },
                          onLongPress: () => _showMenu(context, expense),
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
