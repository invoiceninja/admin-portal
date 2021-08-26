import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class RecurringExpenseListItem extends StatelessWidget {
  const RecurringExpenseListItem({
    @required this.user,
    @required this.recurringExpense,
    @required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final ExpenseEntity recurringExpense;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final recurringExpenseUIState = uiState.recurringExpenseUIState;
    final listUIState = recurringExpenseUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter.isNotEmpty
        ? recurringExpense.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: recurringExpense,
      isSelected: recurringExpense.id ==
          (uiState.isEditing
              ? recurringExpenseUIState.editing.id
              : recurringExpenseUIState.selectedId),
      child: ListTile(
        onTap: () => onTap != null
            ? onTap()
            : selectEntity(entity: recurringExpense, context: context),
        onLongPress: () => onLongPress != null
            ? onLongPress()
            : selectEntity(
                entity: recurringExpense, context: context, longPress: true),
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
                  recurringExpense.number,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(formatNumber(recurringExpense.listDisplayAmount, context),
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            subtitle != null && subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(recurringExpense),
          ],
        ),
      ),
    );
  }
}
