// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ExpenseCategoryListItem extends StatelessWidget {
  const ExpenseCategoryListItem({
    required this.expenseCategory,
    this.filter = '',
    this.onTap,
    this.onLongPress,
    this.isChecked = false,
    this.showCheck = false,
  });

  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final ExpenseCategoryEntity expenseCategory;
  final String? filter;
  final bool isChecked;
  final bool showCheck;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final expenseCategoryUIState = uiState.expenseCategoryUIState;

    final filterMatch = filter != null && filter!.isNotEmpty
        ? expenseCategory.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: expenseCategory,
      isSelected: !showCheck &&
          expenseCategory.id ==
              (uiState.isEditing
                  ? expenseCategoryUIState.editing!.id
                  : expenseCategoryUIState.selectedId),
      showMultiselect: showCheck,
      child: ListTile(
        onTap: () =>
            onTap != null ? onTap!() : selectEntity(entity: expenseCategory),
        onLongPress: () => onLongPress != null
            ? onLongPress!()
            : selectEntity(entity: expenseCategory, longPress: true),
        leading: showCheck
            ? IgnorePointer(
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (_) => null,
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  expenseCategory.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(formatNumber(expenseCategory.listDisplayAmount, context)!,
                  style: Theme.of(context).textTheme.titleMedium),
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
            EntityStateLabel(expenseCategory),
          ],
        ),
      ),
    );
  }
}
