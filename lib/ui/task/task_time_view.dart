// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskTimeListTile extends StatelessWidget {
  const TaskTimeListTile({
    required this.task,
    required this.taskTime,
    required this.onTap,
    required this.isValid,
  });

  final Function(BuildContext context) onTap;
  final TaskEntity task;
  final TaskTime? taskTime;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final startDateString = formatDate(
        taskTime!.startDate!.toIso8601String(), context,
        showTime: true, showDate: false);
    final endDateString = taskTime!.endDate != null
        ? formatDate(taskTime!.endDate!.toIso8601String(), context,
            showTime: true, showDate: false)
        : AppLocalization.of(context)!.now;

    final state = StoreProvider.of<AppState>(context).state;
    final title = DateFormat('EEE MMM d, yyy', localeSelector(state))
        .format(taskTime!.startDate!.toLocal());

    var subtitle = '$startDateString - $endDateString';
    if (taskTime!.description.isNotEmpty) {
      subtitle += '\n' + taskTime!.description;
    }

    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => onTap(context),
          title: Row(
            children: <Widget>[
              Expanded(child: Text(title)),
              LiveText(() => formatDuration(taskTime!.duration)),
            ],
          ),
          subtitle: Text(subtitle),
          trailing: Icon(isValid ? Icons.navigate_next : Icons.error),
        ),
        Divider(
          height: 1.0,
        ),
      ],
    );
  }
}
