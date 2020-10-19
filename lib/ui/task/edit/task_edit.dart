import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_times_vm.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_taskEdit');

  static const kDetailsScreen = 0;
  static const kTimesScreen = 1;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1),
        (Timer t) => mounted ? setState(() => false) : false);

    final index =
        widget.viewModel.taskTimeIndex != null ? kTimesScreen : kDetailsScreen;

    _controller = TabController(vsync: this, length: 2, initialIndex: index);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.viewModel.taskTimeIndex != null) {
      _controller.animateTo(kTimesScreen);
    }
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

    return EditScaffold(
      entity: task,
      title: task.isNew ? localization.newTask : localization.editTask,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
        setState(() {
          autoValidate = !isValid ?? false;
        });
         */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      appBarBottom: TabBar(
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
      body: Form(
        key: _formKey,
        child: TabBarView(
          key: ValueKey(viewModel.task.id),
          controller: _controller,
          children: <Widget>[
            TaskEditDetailsScreen(),
            TaskEditTimesScreen(),
          ],
        ),
      ),
      floatingActionButton: task.isInvoiced || task.isDeleted
          ? SizedBox()
          : FloatingActionButton(
              heroTag: 'task_edit_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () => viewModel.onFabPressed(),
              child: Icon(
                task.isRunning ? Icons.stop : Icons.play_arrow,
                color: Colors.white,
              ),
              tooltip: task.isRunning ? localization.stop : localization.start,
            ),
    );
  }
}
