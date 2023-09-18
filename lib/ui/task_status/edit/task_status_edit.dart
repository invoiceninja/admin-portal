// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/task_status/edit/task_status_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskStatusEdit extends StatefulWidget {
  const TaskStatusEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TaskStatusEditVM viewModel;

  @override
  _TaskStatusEditState createState() => _TaskStatusEditState();
}

class _TaskStatusEditState extends State<TaskStatusEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_taskStatusEdit');
  final _debouncer = Debouncer();

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final taskStatus = widget.viewModel.taskStatus;
    _nameController.text = taskStatus.name;

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
    final taskStatus = widget.viewModel.taskStatus
        .rebuild((b) => b..name = _nameController.text.trim());
    if (taskStatus != widget.viewModel.taskStatus) {
      _debouncer.run(() {
        widget.viewModel.onChanged(taskStatus);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final taskStatus = viewModel.taskStatus;

    return EditScaffold(
      entity: taskStatus,
      title: taskStatus.isNew
          ? localization!.newTaskStatus
          : localization!.editTaskStatus,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: _onSavePressed,
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      autofocus: true,
                      controller: _nameController,
                      label: localization.name,
                      keyboardType: TextInputType.text,
                      validator: (val) => val.isEmpty || val.trim().isEmpty
                          ? localization.pleaseEnterAName
                          : null,
                      onSavePressed: _onSavePressed,
                    ),
                    FormColorPicker(
                      initialValue: taskStatus.color,
                      onSelected: (value) => viewModel.onChanged(
                          taskStatus.rebuild((b) => b..color = value)),
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
