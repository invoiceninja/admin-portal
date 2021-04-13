import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    @required this.expense,
    this.filter,
    this.onTap,
    this.onCheckboxChanged,
    this.showCheckbox = true,
    this.isDismissible = true,
    this.isChecked = false,
  });

  final Function(bool) onCheckboxChanged;
  final GestureTapCallback onTap;
  final ExpenseEntity expense;
  final String filter;
  final bool showCheckbox;
  final bool isDismissible;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final expenseUIState = uiState.expenseUIState;
    final client = state.clientState.get(expense.clientId);
    final vendor = state.vendorState.get(expense.vendorId);
    final category = state.expenseCategoryState.get(expense.categoryId);
    final filterMatch = filter != null && filter.isNotEmpty
        ? (expense.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;
    final listUIState = expenseUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final isChecked = isDismissible
        ? (isInMultiselect && listUIState.isSelected(expense.id))
        : this.isChecked;
    final textStyle = TextStyle(fontSize: 16);
    final textColor = Theme.of(context).textTheme.bodyText1.color;

    String subtitle = '';
    if (filterMatch != null) {
      subtitle = filterMatch;
    } else if (client != null || vendor != null || category != null) {
      final parts = <String>[];
      if (category != null && category.isOld) {
        parts.add(category.name);
      }
      if (vendor != null && vendor.isOld) {
        parts.add(vendor.name);
      }
      if (client != null && client.isOld) {
        parts.add(client.displayName);
      }
      subtitle = parts.join(' • ');
    }

    return DismissibleEntity(
      showCheckbox: this.showCheckbox,
      isDismissible: isDismissible,
      isSelected: isDesktop(context) &&
          expense.id ==
              (uiState.isEditing
                  ? expenseUIState.editing.id
                  : expenseUIState.selectedId),
      userCompany: store.state.userCompany,
      entity: expense,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > kTableListWidthCutoff
            ? InkWell(
                onTap: () => onTap != null
                    ? onTap()
                    : selectEntity(
                        entity: expense,
                        context: context,
                      ),
                onLongPress: () => selectEntity(
                    entity: expense, context: context, longPress: true),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 28,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: showCheckbox
                            ? Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: IgnorePointer(
                                  ignoring: listUIState.isInMultiselect(),
                                  child: Checkbox(
                                    value: isChecked,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) =>
                                        onCheckboxChanged(value),
                                    activeColor: Theme.of(context).accentColor,
                                  ),
                                ),
                              )
                            : ActionMenuButton(
                                entityActions: expense.getActions(
                                    userCompany: state.userCompany),
                                isSaving: false,
                                entity: expense,
                                onSelected: (context, action) =>
                                    handleEntityAction(context.getAppContext(),
                                        expense, action),
                              ),
                      ),
                      SizedBox(
                        width: kListNumberWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              expense.number,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!expense.isActive) EntityStateLabel(expense)
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              (expense.publicNotes ?? '') +
                                  (expense.documents.isNotEmpty ? '  📎' : ''),
                              style: textStyle,
                              maxLines: 1,
                            ),
                            Text(subtitle ?? filterMatch,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      color: textColor
                                          .withOpacity(kLighterOpacity),
                                    )),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        formatNumber(expense.convertedAmount, context,
                            currencyId: expense.currencyId),
                        style: textStyle,
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 16),
                      EntityStatusChip(entity: expense),
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () => onTap != null
                    ? onTap()
                    : selectEntity(
                        entity: expense,
                        context: context,
                      ),
                onLongPress: () => selectEntity(
                    entity: expense, context: context, longPress: true),
                leading: showCheckbox
                    ? IgnorePointer(
                        ignoring: listUIState.isInMultiselect(),
                        child: Checkbox(
                          value: isChecked,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                          (expense.number ?? '') +
                              (expense.documents.isNotEmpty ? '  📎' : ''),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Text(
                          formatNumber(expense.convertedAmount, context,
                              currencyId: expense.currencyId),
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(subtitle ?? filterMatch,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: textColor.withOpacity(kLighterOpacity),
                            )),
                    EntityStateLabel(expense),
                  ],
                ),
              );
      }),
    );
  }
}
