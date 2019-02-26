import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';

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

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _descriptionController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final task = widget.viewModel.task;
    _descriptionController.text = task.description;
    _custom1Controller.text = task.customValue1;
    _custom2Controller.text = task.customValue2;

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
      ..description = _descriptionController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());
    if (task != widget.viewModel.task) {
      widget.viewModel.onChanged(task);
    }
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
            !task.isInvoiced
                ? EntityDropdown(
                    key: Key('__client_${task.clientId}__'),
                    entityType: EntityType.client,
                    labelText: localization.client,
                    initialValue:
                        (state.clientState.map[task.clientId] ?? ClientEntity())
                            .displayName,
                    entityMap: state.clientState.map,
                    entityList: memoizedDropdownClientList(
                        state.clientState.map, state.clientState.list),
                    onSelected: (client) {
                      viewModel.onChanged(task.rebuild((b) => b
                        ..clientId = client.id
                        ..projectId = 0));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddClientPressed(context, completer);
                    },
                  )
                : SizedBox(),
            !task.isInvoiced
                ? EntityDropdown(
                    key: Key('__project_${task.clientId}__'),
                    entityType: EntityType.project,
                    labelText: localization.project,
                    initialValue: (state.projectState.map[task.projectId] ??
                            ProjectEntity())
                        .name,
                    entityMap: state.projectState.map,
                    entityList: memoizedDropdownProjectList(
                        state.projectState.map,
                        state.projectState.list,
                        state.clientState.map,
                        task.clientId),
                    onSelected: (selected) {
                      final project = selected as ProjectEntity;
                      viewModel.onChanged(task.rebuild((b) => b
                        ..projectId = project.id
                        ..clientId = project.clientId));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddProjectPressed(context, completer);
                    },
                  )
                : SizedBox(),
            // TODO Remove isNotEmpty check in v2
            company.taskStatusMap.isNotEmpty ? EntityDropdown(
              entityType: EntityType.taskStatus,
              labelText: localization.status,
              initialValue: (company.taskStatusMap[task.taskStatusId] ??
                      TaskStatusEntity())
                  .name,
              entityMap: company.taskStatusMap,
              entityList: company.taskStatusMap.keys.toList(),
              onSelected: (selected) {
                final taskStatus = selected as TaskStatusEntity;
                viewModel.onChanged(task.rebuild((b) => b
                  ..taskStatusId = taskStatus.id
                  ..taskStatusSortOrder = 9999));
              },
            ) : SizedBox(),
            TextFormField(
              maxLines: 4,
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: localization.description,
              ),
            ),
            CustomField(
              controller: _custom1Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.task1),
              options: company.getCustomFieldValues(CustomFieldType.task1),
            ),
            CustomField(
              controller: _custom2Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.task2),
              options: company.getCustomFieldValues(CustomFieldType.task2),
            ),
          ],
        ),
      ],
    );
  }
}
