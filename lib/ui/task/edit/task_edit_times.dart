import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/time_picker.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_times_vm.dart';
import 'package:invoiceninja_flutter/ui/task/task_item_view.dart';
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

    final taskTimes =
        task.taskTimes.toList().map<Widget>((taskTime) => TaskItemListTile(
              task: task,
              taskItem: taskTime,
              onTap: () => _showTaskTimeEditor(taskTime, context),
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
  TimeOfDay _startTime;
  TimeOfDay _endTime;

  @override
  void didChangeDependencies() {
    _date = widget.taskTime.startDate.toIso8601String();
    _startTime = TimeOfDay(
        hour: widget.taskTime.startDate.hour,
        minute: widget.taskTime.startDate.minute);
    if (widget.taskTime.endDate != null) {
      _endTime = TimeOfDay(
          hour: widget.taskTime.endDate.hour,
          minute: widget.taskTime.endDate.minute);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    void _confirmDelete() {
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              semanticLabel: localization.areYouSure,
              title: Text(localization.areYouSure),
              actions: <Widget>[
                FlatButton(
                    child: Text(localization.cancel.toUpperCase()),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FlatButton(
                    child: Text(localization.ok.toUpperCase()),
                    onPressed: () {
                      widget.viewModel.onRemoveTaskTimePressed(widget.index);
                      Navigator.pop(context); // confirmation dialog
                      Navigator.pop(context); // task item editor
                    })
              ],
            ),
      );
    }

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
                  onPressed: _confirmDelete,
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  icon: Icons.check_circle,
                  label: localization.done,
                  onPressed: () {
                    final date = DateTime.parse(_date);
                    final taskTime = TaskTime(
                      startDate: DateTime(date.year, date.month, date.day,
                          _startTime.hour, _startTime.minute).toUtc(),
                      endDate: _endTime != null
                          ? DateTime(date.year, date.month, date.day,
                              _endTime.hour, _endTime.minute).toUtc()
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
              selectedDate: convertDateTimeToSqlDate(widget.taskTime.startDate),
              onSelected: (date) => _date = date,
            ),
            TimePicker(
              labelText: localization.startTime,
              timeOfDay: TimeOfDay(
                  hour: widget.taskTime.startDate.hour,
                  minute: widget.taskTime.startDate.minute),
              onSelected: (timeOfDay) => _startTime = timeOfDay,
            ),
            TimePicker(
              labelText: localization.endTime,
              timeOfDay: widget.taskTime.endDate != null
                  ? TimeOfDay(
                      hour: widget.taskTime.endDate.hour,
                      minute: widget.taskTime.endDate.minute)
                  : null,
              onSelected: (timeOfDay) => _endTime = timeOfDay,
            ),
          ],
        ),
      ),
    );
  }
}
