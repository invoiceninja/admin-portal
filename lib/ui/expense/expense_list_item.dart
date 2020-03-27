import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    @required this.userCompany,
    @required this.onTap,
    @required this.expense,
    @required this.client,
    @required this.vendor,
    @required this.filter,
    @required this.hasDocuments,
    this.onEntityAction,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final ValueChanged<bool> onCheckboxChanged;
  final ExpenseEntity expense;
  final ClientEntity client;
  final bool isChecked;
  final VendorEntity vendor;
  final String filter;
  final bool hasDocuments;

  static final expenseItemKey = (int id) => Key('__expense_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final expenseUIState = uiState.expenseUIState;

    final filterMatch = filter != null && filter.isNotEmpty
        ? expense.matchesFilterValue(filter)
        : null;

    final company = state.company;
    final category = company.expenseCategoryMap[expense.categoryId];

    String subtitle = '';
    if (filterMatch != null) {
      subtitle = filterMatch;
    } else if (client != null || vendor != null || category != null) {
      if (category != null) {
        subtitle += category.name;
        if (vendor != null || client != null) {
          subtitle += ' • ';
        }
      }
      if (vendor != null) {
        subtitle += vendor.name;
        if (client != null) {
          subtitle += ' • ';
        }
      }
      if (client != null) {
        subtitle += client.displayName;
      }
    }
    if (hasDocuments) {
      if (subtitle.isNotEmpty) {
        subtitle += '  ';
      }
      subtitle += '📎';
    }
    final listUIState = expenseUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    return DismissibleEntity(
      isSelected: expense.id ==
          (uiState.isEditing
              ? expenseUIState.editing.id
              : expenseUIState.selectedId),
      userCompany: userCompany,
      entity: expense,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: isInMultiselect
            ? () => onEntityAction(EntityAction.toggleMultiselect)
            : onTap,
        onLongPress: onLongPress,
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged(value),
                  activeColor: Theme.of(context).accentColor,
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  expense.publicNotes.isNotEmpty
                      ? expense.publicNotes
                      : formatDate(expense.expenseDate, context),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(
                  formatNumber(expense.amountWithTax, context,
                      currencyId: expense.expenseCurrencyId),
                  style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: subtitle != null && subtitle.isNotEmpty
                      ? Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
                ),
                Text(localization.lookup('expense_status_${expense.statusId}'),
                    style: TextStyle(
                      color: ExpenseStatusColors.colors[expense.statusId],
                    )),
              ],
            ),
            EntityStateLabel(expense),
          ],
        ),
      ),
    );
  }
}
