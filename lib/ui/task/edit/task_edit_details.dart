// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';
import 'package:invoiceninja_flutter/ui/app/forms/project_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskEditDetails extends StatefulWidget {
  const TaskEditDetails({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TaskEditDetailsVM viewModel;

  @override
  _TaskEditDetailsState createState() => _TaskEditDetailsState();
}

class _TaskEditDetailsState extends State<TaskEditDetails> {
  final _numberController = TextEditingController();
  final _rateController = TextEditingController();
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
      _numberController,
      _rateController,
      _descriptionController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final task = widget.viewModel.task;
    _numberController.text = task.number;
    _rateController.text = formatNumber(task.rate, context,
        formatNumberType: FormatNumberType.inputMoney)!;
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
    final task = widget.viewModel.task.rebuild((b) => b
      ..number = _numberController.text.trim()
      ..rate = parseDouble(_rateController.text.trim())
      ..description = _descriptionController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());
    if (task != widget.viewModel.task) {
      _debouncer.run(() {
        widget.viewModel.onChanged(task);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context)!;
    final task = viewModel.task;
    final state = viewModel.state;

    final company = state.company;
    final client = state.clientState.get(task.clientId);
    final rateLabel = localization.rate +
        ' • ' +
        formatNumber(
            taskRateSelector(
              company: company,
              task: TaskEntity(),
              client: client,
              group: state.groupState.get(client.groupId),
              project: state.projectState.get(task.projectId),
            ),
            context,
            currencyId: (client.currencyId ?? '').isNotEmpty
                ? client.currencyId
                : company.currencyId)!;

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          isLast: true,
          children: <Widget>[
            if (!task.isInvoiced) ...[
              EntityDropdown(
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
                    ..clientId = client?.id ?? ''
                    ..projectId = ''));
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
                  final project = store.state.projectState.get(selectedId);
                  viewModel.onChanged(task.rebuild((b) => b
                    ..projectId = project.id
                    ..clientId = project.clientId.isNotEmpty
                        ? project.clientId
                        : task.clientId));
                },
                onAddPressed: (completer) {
                  viewModel.onAddProjectPressed(context, completer);
                },
              ),
            ],
            UserPicker(
              userId: task.assignedUserId,
              onChanged: (userId) => viewModel
                  .onChanged(task.rebuild((b) => b..assignedUserId = userId)),
            ),
            DecoratedFormField(
              controller: _numberController,
              label: localization.taskNumber,
              autocorrect: false,
              keyboardType: TextInputType.text,
            ),
            DecoratedFormField(
              key: ValueKey('__rate__'),
              controller: _rateController,
              label: rateLabel,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              autocorrect: false,
            ),
            DynamicSelector(
              key: ValueKey('__task_status_${task.statusId}__'),
              allowClearing: false,
              entityType: EntityType.taskStatus,
              labelText: localization.status,
              entityId: task.statusId,
              entityIds: memoizedDropdownTaskStatusList(
                  state.taskStatusState.map,
                  state.taskStatusState.list,
                  state.staticState,
                  state.userState.map),
              onChanged: (selectedId) {
                final taskStatus = state.taskStatusState.map[selectedId];
                viewModel.onChanged(task.rebuild((b) => b
                  ..statusId = taskStatus?.id
                  ..statusOrder = null));
              },
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
            DecoratedFormField(
              maxLines: 4,
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              label: localization.description,
            ),
          ],
        ),
      ],
    );
  }
}
