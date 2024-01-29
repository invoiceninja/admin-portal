// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/duration_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/growable_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/time_picker.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_times_vm.dart';
import 'package:invoiceninja_flutter/ui/task/task_time_view.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskEditTimes extends StatefulWidget {
  const TaskEditTimes({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TaskEditTimesVM viewModel;

  @override
  _TaskEditTimesState createState() => _TaskEditTimesState();
}

class _TaskEditTimesState extends State<TaskEditTimes> {
  TaskTime? selectedTaskTime;

  void _showTaskTimeEditor(TaskTime? taskTime, BuildContext context) {
    if (taskTime == null) {
      return;
    }

    final viewModel = widget.viewModel;
    final task = viewModel.task!;
    final taskTimes = task.getTaskTimes();

    if (taskTimes.where((time) => time.equalTo(taskTime)).isEmpty) {
      return;
    }

    showDialog<ResponsivePadding>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return TimeEditDetails(
            viewModel: viewModel,
            taskTime: taskTime,
            index: taskTimes.indexOf(
                taskTimes.firstWhere((time) => time.equalTo(taskTime))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final task = viewModel.task!;
    final taskTimes = task.getTaskTimes();
    final invalidTimes = task.getInvalidTimeIndices;
    final taskTime = viewModel.taskTimeIndex != null &&
            taskTimes.length > viewModel.taskTimeIndex!
        ? taskTimes[viewModel.taskTimeIndex!]
        : null;

    if (taskTime != null && taskTime != selectedTaskTime) {
      viewModel.clearSelectedTaskTime();
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        _showTaskTimeEditor(taskTime, context);
      });
    }

    if (task.getTaskTimes().isEmpty) {
      return HelpText(localization!.clickPlusToAddTime);
    }

    final sortedTaskTimes = task.getTaskTimes().toList().reversed.toList();
    final taskTimeWidgets = <Widget>[];

    for (var i = 0; i < sortedTaskTimes.length; i++) {
      final taskTime = sortedTaskTimes[i];
      taskTimeWidgets.add(TaskTimeListTile(
        task: task,
        taskTime: taskTime,
        onTap: (context) => _showTaskTimeEditor(taskTime, context),
        isValid: !invalidTimes.contains(sortedTaskTimes.length - i - 1),
      ));
    }

    return ScrollableListView(
      children: taskTimeWidgets.toList(),
    );
  }
}

class TimeEditDetails extends StatefulWidget {
  const TimeEditDetails({
    Key? key,
    required this.index,
    required this.taskTime,
    required this.viewModel,
  }) : super(key: key);

  final int index;
  final TaskTime? taskTime;
  final TaskEditTimesVM viewModel;

  @override
  TimeEditDetailsState createState() => TimeEditDetailsState();
}

class TimeEditDetailsState extends State<TimeEditDetails> {
  TaskTime? _taskTime = TaskTime();
  int _startDateUpdatedAt = 0;
  int _startTimeUpdatedAt = 0;
  int _endDateUpdatedAt = 0;
  int _endTimeUpdatedAt = 0;
  int _durationUpdateAt = 0;

  @override
  void didChangeDependencies() {
    _taskTime = widget.taskTime;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final company = viewModel.company!;
    final showEndDate = company.showTaskEndDate;

    // Handle the end time being before the start time
    final times = _taskTime!.asList;
    final duration = Duration(seconds: times[1] - times[0]);

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DatePicker(
              key: ValueKey('__date_${_startTimeUpdatedAt}__'),
              labelText:
                  showEndDate ? localization.startDate : localization.date,
              selectedDate: _taskTime!.startDate == null
                  ? null
                  : convertDateTimeToSqlDate(_taskTime!.startDate!.toLocal()),
              onSelected: (date, _) {
                setState(() {
                  _taskTime = _taskTime!
                      .copyWithStartDate(date, syncDates: !showEndDate);
                  viewModel.onUpdatedTaskTime(_taskTime, widget.index);
                  _startDateUpdatedAt = DateTime.now().millisecondsSinceEpoch;
                });
              },
            ),
            TimePicker(
              key: ValueKey('__start_time_${_durationUpdateAt}__'),
              labelText: localization.startTime,
              selectedDateTime: _taskTime!.startDate,
              onSelected: (timeOfDay) {
                if (timeOfDay == null) {
                  return;
                }

                setState(() {
                  _taskTime = _taskTime!.copyWithStartTime(timeOfDay);
                  viewModel.onUpdatedTaskTime(_taskTime, widget.index);
                  _startTimeUpdatedAt = DateTime.now().millisecondsSinceEpoch;
                });
              },
            ),
            if (showEndDate)
              DatePicker(
                labelText: localization.endDate,
                key: ValueKey(
                    '__${_startDateUpdatedAt}_${_durationUpdateAt}_${_endTimeUpdatedAt}__'),
                selectedDate: _taskTime!.endDate == null
                    ? null
                    : convertDateTimeToSqlDate(_taskTime!.endDate!.toLocal()),
                onSelected: (date, _) {
                  setState(() {
                    _taskTime = _taskTime!.copyWithEndDate(date);
                    viewModel.onUpdatedTaskTime(_taskTime, widget.index);
                    _endDateUpdatedAt = DateTime.now().millisecondsSinceEpoch;
                  });
                },
              ),
            TimePicker(
              key: ValueKey(
                  '__end_time_${_endDateUpdatedAt}_${_durationUpdateAt}__'),
              labelText: localization.endTime,
              selectedDateTime: _taskTime!.endDate,
              isEndTime: true,
              onSelected: (timeOfDay) {
                setState(() {
                  if (timeOfDay == null) {
                    return;
                  }

                  _taskTime = _taskTime!.copyWithEndTime(timeOfDay);
                  viewModel.onUpdatedTaskTime(_taskTime, widget.index);
                  _endTimeUpdatedAt = DateTime.now().millisecondsSinceEpoch;
                });
              },
            ),
            DurationPicker(
              key: ValueKey(
                  '__duration_${_startTimeUpdatedAt}_${_endTimeUpdatedAt}_${_startDateUpdatedAt}_${_endDateUpdatedAt}_'),
              labelText: localization.duration,
              onSelected: (Duration duration) {
                setState(() {
                  _taskTime = _taskTime!.copyWithDuration(duration);
                  viewModel.onUpdatedTaskTime(_taskTime, widget.index);
                  _durationUpdateAt = DateTime.now().millisecondsSinceEpoch;
                });
              },
              selectedDuration:
                  (_taskTime!.startDate == null || _taskTime!.endDate == null)
                      ? null
                      : duration,
            ),
            if (company.settings.showTaskItemDescription!)
              GrowableFormField(
                label: localization.description,
                initialValue: _taskTime!.description,
                onChanged: (value) {
                  _taskTime = _taskTime!.rebuild((b) => b..description = value);
                  viewModel.onUpdatedTaskTime(_taskTime, widget.index);
                },
              ),
            if (company.settings.allowBillableTaskItems!)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SwitchListTile(
                    title: Text(localization.billable),
                    value: _taskTime!.isBillable,
                    onChanged: (value) {
                      _taskTime =
                          _taskTime!.rebuild((b) => b..isBillable = value);
                      viewModel.onUpdatedTaskTime(_taskTime, widget.index);
                      setState(() {});
                    }),
              )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(localization.remove.toUpperCase()),
          onPressed: () {
            widget.viewModel.onRemoveTaskTimePressed(widget.index);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(localization.done.toUpperCase()),
          onPressed: () {
            widget.viewModel.onDoneTaskTimePressed();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
