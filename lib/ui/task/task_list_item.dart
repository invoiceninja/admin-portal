import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    @required this.user,
    @required this.task,
    @required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final TaskEntity task;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final taskUIState = uiState.taskUIState;
    final client = state.clientState.get(task.clientId);
    final filterMatch = filter != null && filter.isNotEmpty
        ? (task.matchesFilterValue(filter) ?? client.matchesFilterValue(filter))
        : null;
    final listUIState = taskUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 16);
    final subtitle = client.displayName;
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final localization = AppLocalization.of(context);

    final duration = LiveText(() {
      return formatNumber(task.listDisplayAmount, context,
          formatNumberType: FormatNumberType.duration);
    }, style: textStyle);

    return DismissibleEntity(
      isSelected: isDesktop(context) &&
          task.id ==
              (uiState.isEditing
                  ? taskUIState.editing.id
                  : taskUIState.selectedId),
      userCompany: store.state.userCompany,
      entity: task,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > kTableListWidthCutoff
            ? InkWell(
                onTap: () => onTap != null
                    ? onTap()
                    : selectEntity(entity: task, context: context),
                onLongPress: () => onLongPress != null
                    ? onLongPress()
                    : selectEntity(
                        entity: task, context: context, longPress: true),
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
                                entityActions: task.getActions(
                                    userCompany: state.userCompany),
                                isSaving: false,
                                entity: task,
                                onSelected: (context, action) =>
                                    handleEntityAction(context, task, action),
                              ),
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (!task.isActive) EntityStateLabel(task)
                          ],
                        ),
                        width: 120,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                task.description +
                                    (task.documents.isNotEmpty ? '  📎' : ''),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle),
                            Text(
                              subtitle ?? filterMatch,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color:
                                        textColor.withOpacity(kLighterOpacity),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      duration,
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () => onTap != null
                    ? onTap()
                    : selectEntity(entity: task, context: context),
                onLongPress: () => onLongPress != null
                    ? onLongPress()
                    : selectEntity(
                        entity: task, context: context, longPress: true),
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
                trailing: IconButton(
                  icon: Icon(
                    getEntityActionIcon(task.isRunning
                        ? EntityAction.stop
                        : EntityAction.start),
                    color: task.isRunning ? state.accentColor : null,
                  ),
                  onPressed: () => handleEntityAction(context, task,
                      task.isRunning ? EntityAction.stop : EntityAction.start),
                  visualDensity: VisualDensity.compact,
                ),
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          task.description +
                              (task.documents.isNotEmpty ? '  📎' : ''),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      duration,
                    ],
                  ),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(subtitle ?? filterMatch,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color:
                                        textColor.withOpacity(kLighterOpacity),
                                  )),
                          EntityStateLabel(task),
                        ],
                      ),
                    ),
                    Text(localization.logged),
                  ],
                ),
              );
      }),
    );
  }
}
