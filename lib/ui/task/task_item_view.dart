import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';

class TaskItemListTile extends StatelessWidget {
  const TaskItemListTile({
    @required this.task,
    @required this.taskItem,
    @required this.onTap,
  });

  final Function onTap;
  final TaskEntity task;
  final TaskTime taskItem;

  @override
  Widget build(BuildContext context) {
    final startDateString = formatDate(
        taskItem.startDate.toIso8601String(), context,
        showTime: true, showDate: false);
    final endDateString = formatDate(
        taskItem.endDate.toIso8601String(), context,
        showTime: true, showDate: false);

    final state = StoreProvider.of<AppState>(context).state;
    final title = DateFormat('EEE MMM d, yyy', localeSelector(state))
        .format(taskItem.startDate);
    final subtitle = '$startDateString - $endDateString';
    final duration =
        formatDuration(taskItem.duration);

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
                subtitle: Text(subtitle),
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
