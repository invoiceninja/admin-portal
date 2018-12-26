import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    @required this.user,
    @required this.client,
    @required this.project,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.task,
    @required this.filter,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final ClientEntity client;
  final ProjectEntity project;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;
  final TaskEntity task;
  final String filter;

  static final taskItemKey = (int id) => Key('__task_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final filterMatch = filter != null && filter.isNotEmpty
        ? task.matchesFilterValue(filter)
        : null;

    //final subtitle = filterMatch ?? client?.displayName ?? task.description;
    String subtitle;
    if (filterMatch != null) {
      subtitle = filterMatch;
    } else if (client != null) {
      subtitle = client.displayName;
      if (project != null) {
        subtitle += ' • ' + project.name;
      }
    }

    return DismissibleEntity(
      user: user,
      entity: task,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: onCheckboxChanged != null ? Checkbox(
          //key: NinjaKeys.taskItemCheckbox(task.id),
          value: isChecked,
          onChanged: (value) => onCheckboxChanged(value),
          activeColor: Theme.of(context).accentColor,
        ) : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  task.description.isNotEmpty
                      ? task.description
                      : formatDate(convertTimestampToDateString(task.updatedAt),
                          context),
                  overflow: TextOverflow.ellipsis,
                  //key: NinjaKeys.clientItemClientKey(client.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              LiveText(() {
                return formatNumber(task.listDisplayAmount, context,
                    formatNumberType: FormatNumberType.duration);
              }, style: Theme.of(context).textTheme.title),
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
            EntityStateLabel(task),
          ],
        ),
      ),
    );
  }
}

