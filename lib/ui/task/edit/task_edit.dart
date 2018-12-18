import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/refresh_icon_button.dart';
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

class _TaskEditState extends State<TaskEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final task = widget.viewModel.task;
    // STARTER: read value - do not remove comment

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final task = widget.viewModel.task.rebuild((b) => b
      // STARTER: set value - do not remove comment
    );
    if (task != widget.viewModel.task) {
      widget.viewModel.onChanged(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final task = viewModel.task;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.task.isNew
              ? localization.newTask
              : localization.editTask),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
                RefreshIconButton(
                  icon: Icons.cloud_upload,
                  tooltip: localization.save,
                  isVisible: !task.isDeleted,
                  isDirty: task.isNew || task != viewModel.origTask,
                  isSaving: viewModel.isSaving,
                  onPressed: () {
                    if (! _formKey.currentState.validate()) {
                      return;
                    }
                    viewModel.onSavePressed(context);
                  },
                );
            }),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Builder(builder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      // STARTER: widgets - do not remove comment
                    ],
                  ),
                ],
              );
            })
        ),
      ),
    );
  }
}
