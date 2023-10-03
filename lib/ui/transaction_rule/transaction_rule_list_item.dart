import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class TransactionRuleListItem extends StatelessWidget {
  const TransactionRuleListItem({
    required this.user,
    required this.transactionRule,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final TransactionRuleEntity transactionRule;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final transactionRuleUIState = uiState.transactionRuleUIState;
    final listUIState = transactionRuleUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter!.isNotEmpty
        ? transactionRule.matchesFilterValue(filter)
        : null;

    var subtitle = '';

    if (filterMatch != null) {
      subtitle = filterMatch;
    } else {
      final vendor = state.vendorState.map[transactionRule.vendorId];
      final category =
          state.expenseCategoryState.map[transactionRule.categoryId];

      if (vendor != null) {
        subtitle += vendor.name;

        if (category != null) {
          subtitle += ' • ';
        }
      }

      if (category != null) {
        subtitle += category.name;
      }
    }

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: transactionRule,
      isSelected: transactionRule.id ==
          (uiState.isEditing
              ? transactionRuleUIState.editing!.id
              : transactionRuleUIState.selectedId),
      child: ListTile(
        onTap: () =>
            onTap != null ? onTap!() : selectEntity(entity: transactionRule),
        onLongPress: () => onLongPress != null
            ? onLongPress!()
            : selectEntity(entity: transactionRule, longPress: true),
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged!(value),
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  transactionRule.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(formatNumber(transactionRule.listDisplayAmount, context)!,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(transactionRule),
          ],
        ),
      ),
    );
  }
}
