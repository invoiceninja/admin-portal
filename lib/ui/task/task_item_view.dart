import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskItemListTile extends StatelessWidget {
  const TaskItemListTile({
    @required this.task,
    @required this.taskItem,
    @required this.onTap,
  });

  final Function onTap;
  final TaskEntity task;
  final List<int> taskItem;

  @override
  Widget build(BuildContext context) {
    final startDate = convertTimestampToDate(taskItem[0]);
    final endDate = convertTimestampToDate(taskItem[1]);

    final startDateString =
        formatDate(startDate.toIso8601String(), context, showTime: true);
    final endDateString = formatDate(endDate.toIso8601String(), context,
        showTime: true, showDate: startDate.day != endDate.day);

    final title = '$startDateString - $endDateString';
    final duration = formatDuration(endDate.difference(startDate));

    return Material(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: onTap,
                title: Row(
                  children: <Widget>[
                    Expanded(child: Text(title)),
                    Text(duration),
                  ],
                ),
                trailing: onTap != null ? Icon(Icons.navigate_next) : null,
              ),
              Divider(
                height: 1.0,
              ),
            ],
          ),
        ));
  }
}
