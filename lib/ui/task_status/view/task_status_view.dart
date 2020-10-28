import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/task_status/view/task_status_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';

class TaskStatusView extends StatefulWidget {
  const TaskStatusView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final TaskStatusViewVM viewModel;
  final bool isFilter;

  @override
  _TaskStatusViewState createState() => new _TaskStatusViewState();
}

class _TaskStatusViewState extends State<TaskStatusView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final taskStatus = viewModel.taskStatus;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: taskStatus,
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
