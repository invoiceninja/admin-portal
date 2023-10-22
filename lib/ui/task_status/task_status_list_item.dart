// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class TaskStatusListItem extends StatelessWidget {
  const TaskStatusListItem({
    Key? key,
    required this.user,
    required this.taskStatus,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  }) : super(key: key);

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final TaskStatusEntity? taskStatus;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final taskStatusUIState = uiState.taskStatusUIState;
    final listUIState = taskStatusUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter!.isNotEmpty
        ? taskStatus!.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;

    final child = ListTile(
      onTap: () => onTap != null ? onTap!() : selectEntity(entity: taskStatus!),
      onLongPress: () => onLongPress != null
          ? onLongPress!()
          : selectEntity(entity: taskStatus!, longPress: true),
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
                taskStatus!.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(formatNumber(taskStatus!.listDisplayAmount, context)!,
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
          EntityStateLabel(taskStatus),
        ],
      ),
    );

    return child;

    /*
    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: taskStatus,
      isSelected: taskStatus.id ==
          (uiState.isEditing
              ? taskStatusUIState.editing.id
              : taskStatusUIState.selectedId),
      child: child,
    );
    */
  }
}
