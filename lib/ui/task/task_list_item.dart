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
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    @required this.task,
    this.filter,
    this.onTap,
    this.onCheckboxChanged,
    this.showCheckbox = true,
    this.isDismissible = true,
    this.isChecked = false,
  });

  final Function(bool) onCheckboxChanged;
  final GestureTapCallback onTap;
  final TaskEntity task;
  final String filter;
  final bool showCheckbox;
  final bool isDismissible;
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
    final isChecked = isDismissible
        ? (isInMultiselect && listUIState.isSelected(task.id))
        : this.isChecked;
    final textStyle = TextStyle(fontSize: 16);
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final localization = AppLocalization.of(context);

    String subtitle = client.displayName;
    if (task.projectId.isNotEmpty) {
      subtitle +=
          ' • ' + state.projectState.get(task.projectId).listDisplayName;
    }

    final duration = LiveText(() {
      return formatNumber(task.listDisplayAmount, context,
          formatNumberType: FormatNumberType.duration);
    }, style: textStyle);

    final startStopButton = !isDismissible
        ? SizedBox()
        : IconButton(
            icon: task.isInvoiced
                ? SizedBox()
                : Icon(
                    getEntityActionIcon(task.isRunning
                        ? EntityAction.stop
                        : EntityAction.start),
                  ),
            onPressed: task.isInvoiced
                ? null
                : () => handleEntityAction(context.getAppContext(), task,
                    task.isRunning ? EntityAction.stop : EntityAction.start),
            visualDensity: VisualDensity.compact,
          );

    return DismissibleEntity(
      showCheckbox: this.showCheckbox,
      isDismissible: isDismissible,
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
                    : selectEntity(
                        entity: task,
                        context: context,
                      ),
                onLongPress: () => selectEntity(
                  entity: task,
                  context: context,
                  longPress: true,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 16,
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
                                    handleEntityAction(
                                        context.getAppContext(), task, action),
                              ),
                      ),
                      SizedBox(
                        width: kListNumberWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              task.number,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!task.isActive) EntityStateLabel(task)
                          ],
                        ),
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
                      SizedBox(width: 8),
                      duration,
                      SizedBox(width: 24),
                      EntityStatusChip(entity: task),
                      SizedBox(width: 8),
                      startStopButton,
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () => onTap != null
                    ? onTap()
                    : selectEntity(
                        entity: task,
                        context: context,
                      ),
                onLongPress: () => selectEntity(
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
                trailing: startStopButton,
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
                    Text(
                      task.isRunning
                          ? localization.running
                          : task.isInvoiced
                              ? localization.invoiced
                              : task.statusId.isNotEmpty
                                  ? state.taskStatusState
                                      .get(task.statusId)
                                      .name
                                  : localization.logged,
                      style: TextStyle(
                          color: task.isInvoiced
                              ? state.prefState.colorThemeModel.colorSuccess
                              : convertHexStringToColor(state.taskStatusState
                                  .get(task.statusId)
                                  .color)),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
