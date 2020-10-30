import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/duration_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/time_picker.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_times_vm.dart';
import 'package:invoiceninja_flutter/ui/task/task_time_view.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class TaskEditTimes extends StatefulWidget {
  const TaskEditTimes({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskEditTimesVM viewModel;

  @override
  _TaskEditTimesState createState() => _TaskEditTimesState();
}

class _TaskEditTimesState extends State<TaskEditTimes> {
  TaskTime selectedTaskTime;

  void _showTaskTimeEditor(TaskTime taskTime, BuildContext context) {
    showDialog<ResponsivePadding>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final task = viewModel.task;
          final taskTimes = task.taskTimes;
          return ResponsivePadding(
            child: TimeEditDetails(
              viewModel: viewModel,
              //key: Key(taskTime.entityKey),
              taskTime: taskTime,
              index: taskTimes.indexOf(
                  taskTimes.firstWhere((time) => time.equalTo(taskTime))),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final task = viewModel.task;
    final taskTime = viewModel.taskTimeIndex != null &&
            task.taskTimes.length > viewModel.taskTimeIndex
        ? task.taskTimes[viewModel.taskTimeIndex]
        : null;

    if (taskTime != null && taskTime != selectedTaskTime) {
      selectedTaskTime = taskTime;
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        _showTaskTimeEditor(taskTime, context);
      });
    }

    if (task.taskTimes.isEmpty) {
      return HelpText(localization.clickPlusToAddTime);
    }

    final taskTimes = task.taskTimes
        .toList()
        .reversed
        .map<Widget>((taskTime) => TaskTimeListTile(
              task: task,
              taskTime: taskTime,
              onTap: (context) => _showTaskTimeEditor(taskTime, context),
            ));

    return ListView(
      children: taskTimes.toList(),
    );
  }
}

class TimeEditDetails extends StatefulWidget {
  const TimeEditDetails({
    Key key,
    @required this.index,
    @required this.taskTime,
    @required this.viewModel,
  }) : super(key: key);

  final int index;
  final TaskTime taskTime;
  final TaskEditTimesVM viewModel;

  @override
  TimeEditDetailsState createState() => TimeEditDetailsState();
}

class TimeEditDetailsState extends State<TimeEditDetails> {
  String _date;
  DateTime _startDate;
  DateTime _endDate;
  Duration _duration;

  DateTime _endDateChanged;
  DateTime _durationChanged;

  @override
  void didChangeDependencies() {
    final taskTime = widget.taskTime;
    final startDate = taskTime.startDate;
    final endDate = taskTime.endDate;

    _date = startDate.toIso8601String();
    _startDate = startDate.toLocal();

    if (endDate != null) {
      _endDate = endDate.toLocal();
      _duration = taskTime.duration;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // stay clear of the keyboard
      ),
      child: SingleChildScrollView(
        child: FormCard(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppButton(
                  color: Colors.red,
                  iconData: Icons.delete,
                  label: localization.remove,
                  onPressed: () {
                    widget.viewModel.onRemoveTaskTimePressed(widget.index);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                AppButton(
                  iconData: Icons.check_circle,
                  label: localization.done,
                  onPressed: () {
                    final startDate = DateTime.parse(_date);
                    DateTime endDate = startDate;
                    if (_startDate.isAfter(DateTime(
                        _startDate.year,
                        _startDate.month,
                        _startDate.day,
                        _endDate?.hour ?? _startDate.hour,
                        _endDate?.minute ?? _startDate.minute,
                        _endDate?.second ?? _startDate.second))) {
                      endDate = endDate.add(Duration(days: 1));
                    }

                    final taskTime = TaskTime(
                      startDate: DateTime(
                              startDate.year,
                              startDate.month,
                              startDate.day,
                              _startDate.hour,
                              _startDate.minute,
                              _startDate.second)
                          .toUtc(),
                      endDate: _endDate != null
                          ? DateTime(
                                  endDate.year,
                                  endDate.month,
                                  endDate.day,
                                  _endDate.hour,
                                  _endDate.minute,
                                  _endDate.second)
                              .toUtc()
                          : null,
                    );
                    widget.viewModel
                        .onDoneTaskTimePressed(taskTime, widget.index);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            DatePicker(
              labelText: localization.date,
              selectedDate: _date,
              onSelected: (date) {
                setState(() {
                  _date = date;
                });
              },
            ),
            TimePicker(
              labelText: localization.startTime,
              selectedDate: _startDate,
              selectedDateTime: _startDate,
              onSelected: (timeOfDay) {
                setState(() {
                  _startDate = timeOfDay;
                });
              },
            ),
            TimePicker(
              key: ValueKey('$_startDate$_durationChanged'),
              labelText: localization.endTime,
              selectedDate: _startDate,
              selectedDateTime: _endDate,
              allowClearing: true,
              onSelected: (timeOfDay) {
                setState(() {
                  _endDate = timeOfDay;
                  _endDateChanged = DateTime.now();
                });
              },
            ),
            DurationPicker(
              key: ValueKey(_endDateChanged),
              onSelected: (Duration duration) {
                setState(() {
                  _endDate = _startDate.add(duration);
                  _durationChanged = DateTime.now();
                });
              },
              duration: (_endDate != null && _startDate != null)
                  ? _endDate.difference(_startDate)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
