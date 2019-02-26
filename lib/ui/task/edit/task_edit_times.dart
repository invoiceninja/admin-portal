import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/time_picker.dart';
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
    showDialog<TimeEditDetails>(
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final task = viewModel.task;
          final taskTimes = task.taskTimes;
          return TimeEditDetails(
            viewModel: viewModel,
            //key: Key(taskTime.entityKey),
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
    final task = viewModel.task;
    final taskTime =
        task.taskTimes.contains(viewModel.taskTime) ? viewModel.taskTime : null;

    if (taskTime != null && taskTime != selectedTaskTime) {
      selectedTaskTime = taskTime;
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        _showTaskTimeEditor(taskTime, context);
      });
    }

    if (task.taskTimes.isEmpty) {
      return Center(
        child: Text(
          localization.clickPlusToAddTime,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),
        ),
      );
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

  final _durationController = TextEditingController();

  @override
  void didChangeDependencies() {
    final taskTime = widget.taskTime;
    final startDate = taskTime.startDate;
    final endDate = taskTime.endDate;

    _date = startDate.toIso8601String();
    _startDate = startDate.toLocal();

    if (endDate != null) {
      _endDate = endDate.toLocal();
      _durationController.text = formatDuration(taskTime.duration);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
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
                ElevatedButton(
                  color: Colors.red,
                  icon: Icons.delete,
                  label: localization.remove,
                  onPressed: () {
                    widget.viewModel.onRemoveTaskTimePressed(widget.index);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  icon: Icons.check_circle,
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
              onSelected: (date) => _date = date,
            ),
            TimePicker(
              labelText: localization.startTime,
              selectedDate: _startDate,
              onSelected: (timeOfDay) {
                _startDate = timeOfDay;
                _durationController.text = _endDate != null
                    ? formatDuration(_endDate.difference(_startDate))
                    : '';
              },
            ),
            TimePicker(
              key: ValueKey(_endDate),
              labelText: localization.endTime,
              selectedDate: _endDate,
              previousDate: _startDate,
              onSelected: (timeOfDay) {
                _endDate = timeOfDay;
                _durationController.text = _endDate != null
                    ? formatDuration(_endDate.difference(_startDate))
                    : '';
              },
            ),
            PopupMenuButton<int>(
              padding: EdgeInsets.zero,
              initialValue: null,
              itemBuilder: (BuildContext context) =>
                  [15, 30, 45, 60, 75, 90, 105, 120]
                      .map((minutes) => PopupMenuItem<int>(
                            child: Text(formatDuration(
                                Duration(minutes: minutes),
                                showSeconds: false)),
                            value: minutes,
                          ))
                      .toList(),
              onSelected: (minutes) {
                setState(() {
                  _durationController.text =
                      formatDuration(Duration(minutes: minutes));
                  final dateTime = _startDate.add(Duration(minutes: minutes));
                  _endDate = dateTime;
                });
              },
              child: InkWell(
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _durationController,
                    decoration: InputDecoration(
                      labelText: localization.duration,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
