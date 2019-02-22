import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_times_vm.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';

class TaskEdit extends StatefulWidget {
  const TaskEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskEditVM viewModel;

  @override
  _TaskEditState createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit>
    with SingleTickerProviderStateMixin {

  Timer _timer;
  TabController _controller;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const kDetailsScreen = 0;
  static const kTimesScreen = 1;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1),
        (Timer t) => mounted ? setState(() => false) : false);

    final task = widget.viewModel.task;
    final taskTime = widget.viewModel.taskTime;

    final index =
        task.taskTimes.contains(taskTime) ? kTimesScreen : kDetailsScreen;

    _controller = TabController(vsync: this, length: 3, initialIndex: index);
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final task = viewModel.task;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(task.isNew ? localization.newTask : localization.editTask),
          actions: <Widget>[
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: !task.isDeleted,
              isSaving: widget.viewModel.isSaving,
              isDirty: task.isNew || task != viewModel.origTask,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                widget.viewModel.onSavePressed(context);
              },
            )
          ],
          bottom: TabBar(
            controller: _controller,
            //isScrollable: true,
            tabs: [
              Tab(
                text: localization.details,
              ),
              Tab(
                text: localization.times,
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              TaskEditDetailsScreen(),
              TaskEditTimesScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              '${localization.duration}: ${formatDuration(task.calculateDuration)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: task.isInvoiced || task.isDeleted
            ? SizedBox()
            : FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () => viewModel.onFabPressed(),
          child: Icon(
            task.isRunning ? Icons.stop : Icons.play_arrow,
            color: Colors.white,
          ),
          tooltip: task.isRunning ? localization.stop : localization.start,
        ),
      ),
    );
  }
}
