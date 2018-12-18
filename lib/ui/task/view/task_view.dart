import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class TaskView extends StatefulWidget {

  const TaskView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskViewVM viewModel;

  @override
  _TaskViewState createState() => new _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final task = viewModel.task;

    return Scaffold(
      appBar: AppBar(
        title: Text(task.description),
        actions: task.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  user: viewModel.company.user,
                  isSaving: viewModel.isSaving,
                  entity: task,
                  onSelected: viewModel.onActionSelected,
                ),
              ],
      ),
      body: FormCard(
        children: [
          // STARTER: widgets - do not remove comment
        ]
      ),
    );
  }
}
