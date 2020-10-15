import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/project_picker.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';

class TaskEditDetails extends StatefulWidget {
  const TaskEditDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskEditDetailsVM viewModel;

  @override
  _TaskEditDetailsState createState() => _TaskEditDetailsState();
}

class _TaskEditDetailsState extends State<TaskEditDetails> {
  final _descriptionController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  final _debouncer = Debouncer();
  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _descriptionController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final task = widget.viewModel.task;
    _descriptionController.text = task.description;
    _custom1Controller.text = task.customValue1;
    _custom2Controller.text = task.customValue2;
    _custom3Controller.text = task.customValue3;
    _custom4Controller.text = task.customValue4;

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
    _debouncer.run(() {
      final task = widget.viewModel.task.rebuild((b) => b
        ..description = _descriptionController.text.trim()
        ..customValue1 = _custom1Controller.text.trim()
        ..customValue2 = _custom2Controller.text.trim()
        ..customValue3 = _custom3Controller.text.trim()
        ..customValue4 = _custom4Controller.text.trim());
      if (task != widget.viewModel.task) {
        widget.viewModel.onChanged(task);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final task = viewModel.task;
    final company = viewModel.company;
    final state = viewModel.state;

    return ListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            if (!task.isInvoiced) ...[
              EntityDropdown(
                key: Key('__client_${task.clientId}__'),
                allowClearing: true,
                entityType: EntityType.client,
                labelText: localization.client,
                entityId: task.clientId,
                entityList: memoizedDropdownClientList(
                    state.clientState.map,
                    state.clientState.list,
                    state.userState.map,
                    state.staticState),
                onSelected: (client) {
                  viewModel.onChanged(task.rebuild((b) => b
                    ..clientId = client?.id
                    ..projectId = null));
                },
                onAddPressed: (completer) {
                  viewModel.onAddClientPressed(context, completer);
                },
              ),
              ProjectPicker(
                key: Key('__project_${task.clientId}__'),
                projectId: task.projectId,
                clientId: task.clientId,
                onChanged: (selectedId) {
                  final project = state.projectState.get(selectedId);
                  viewModel.onChanged(task.rebuild((b) => b
                    ..projectId = project?.id
                    ..clientId = (project?.clientId ?? '').isNotEmpty
                        ? project.clientId
                        : task.clientId));
                },
                onAddPressed: (completer) {
                  viewModel.onAddProjectPressed(context, completer);
                },
              ),
            ],
            // TODO Remove isNotEmpty check in v2
            company.taskStatusMap.isNotEmpty
                ? EntityDropdown(
                    key: ValueKey('__task_status_${task.taskStatusId}__'),
                    entityType: EntityType.taskStatus,
                    labelText: localization.status,
                    entityId: task.taskStatusId,
                    entityList: company.taskStatusMap.keys.toList(),
                    onSelected: (selected) {
                      final taskStatus = selected as TaskStatusEntity;
                      viewModel.onChanged(task.rebuild((b) => b
                        ..taskStatusId = taskStatus?.id
                        ..taskStatusSortOrder = 9999));
                    },
                  )
                : SizedBox(),
            DecoratedFormField(
              maxLines: 4,
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              label: localization.description,
            ),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.task1,
              value: task.customValue1,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.task2,
              value: task.customValue2,
            ),
            CustomField(
              controller: _custom3Controller,
              field: CustomFieldType.task3,
              value: task.customValue3,
            ),
            CustomField(
              controller: _custom4Controller,
              field: CustomFieldType.task4,
              value: task.customValue4,
            ),
          ],
        ),
      ],
    );
  }
}
