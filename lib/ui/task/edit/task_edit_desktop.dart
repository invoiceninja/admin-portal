// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/duration_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';
import 'package:invoiceninja_flutter/ui/app/forms/growable_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/project_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/time_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskEditDesktop extends StatefulWidget {
  const TaskEditDesktop({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TaskEditDetailsVM viewModel;

  @override
  _TaskEditDesktopState createState() => _TaskEditDesktopState();
}

class _TaskEditDesktopState extends State<TaskEditDesktop> {
  final _numberController = TextEditingController();
  final _rateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  final _debouncer = Debouncer();
  List<TextEditingController> _controllers = [];

  int _updatedAt = 0;
  int _startDateUpdatedAt = 0;
  int _startTimeUpdatedAt = 0;
  int _endDateUpdatedAt = 0;
  int _endTimeUpdatedAt = 0;
  int _durationUpdateAt = 0;

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
    _updatedAt = DateTime.now().millisecondsSinceEpoch;

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
    final settings = company.settings;
    final client = state.clientState.get(task.clientId);
    final showEndDate = company.showTaskEndDate;
    final taskTimes = task.getTaskTimes(sort: false);

    if (!taskTimes.any((taskTime) => taskTime.isEmpty)) {
      taskTimes.add(TaskTime().rebuild((b) => b..startDate = null));
    }

    final overlapping = task.getInvalidTimeIndices;
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
      primary: true,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: FormCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding / 2,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding),
                children: [
                  if (!task.isInvoiced) ...[
                    EntityDropdown(
                      autofocus: true,
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
                        final project =
                            store.state.projectState.get(selectedId);
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
                    onChanged: (userId) => viewModel.onChanged(
                        task.rebuild((b) => b..assignedUserId = userId)),
                  ),
                  CustomField(
                    controller: _custom1Controller,
                    field: CustomFieldType.task1,
                    value: task.customValue1,
                  ),
                  CustomField(
                    controller: _custom3Controller,
                    field: CustomFieldType.task3,
                    value: task.customValue3,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FormCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding / 2,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding / 2),
                children: [
                  DecoratedFormField(
                    controller: _numberController,
                    label: localization.taskNumber,
                    keyboardType: TextInputType.text,
                  ),
                  DecoratedFormField(
                    key: ValueKey('__rate__'),
                    controller: _rateController,
                    label: rateLabel,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: true),
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
                        ..statusId = taskStatus?.id ?? ''
                        ..statusOrder = null));
                    },
                  ),
                  CustomField(
                    controller: _custom2Controller,
                    field: CustomFieldType.task2,
                    value: task.customValue2,
                  ),
                  CustomField(
                    controller: _custom4Controller,
                    field: CustomFieldType.task4,
                    value: task.customValue4,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FormCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding / 2),
                children: [
                  DecoratedFormField(
                    maxLines: 6,
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    label: localization.description,
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
        FormCard(
          key: ValueKey('__table_${_updatedAt}__'),
          padding: const EdgeInsets.symmetric(horizontal: kMobileDialogPadding),
          children: [
            if (!settings.showTaskItemDescription!)
              Row(
                children: [
                  Expanded(child: Text(localization.startDate)),
                  Expanded(child: Text(localization.startTime)),
                  if (showEndDate) Expanded(child: Text(localization.endDate)),
                  Expanded(child: Text(localization.endTime)),
                  Expanded(child: Text(localization.duration)),
                  if (settings.allowBillableTaskItems!) SizedBox(width: 50),
                  SizedBox(width: 38),
                ],
              ),
            ...taskTimes.map((taskTime) {
              final index = taskTimes.indexOf(taskTime);
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: kTableColumnGap),
                                child: DatePicker(
                                  key: ValueKey(
                                      '__${_startTimeUpdatedAt}_${_durationUpdateAt}_${index}__'),
                                  labelText: settings.showTaskItemDescription!
                                      ? localization.startDate
                                      : null,
                                  selectedDate:
                                      taskTimes[index].startDate == null
                                          ? null
                                          : convertDateTimeToSqlDate(
                                              taskTimes[index].startDate!
                                                  .toLocal()),
                                  onSelected: (date, _) {
                                    final taskTime = taskTimes[index].copyWithStartDate(date,
                                            syncDates: !showEndDate);
                                    viewModel.onUpdatedTaskTime(
                                        taskTime, index);
                                    setState(() {
                                      _startDateUpdatedAt =
                                          DateTime.now().millisecondsSinceEpoch;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: kTableColumnGap),
                                child: TimePicker(
                                  key: ValueKey(
                                      '__${_durationUpdateAt}_${index}__'),
                                  labelText: settings.showTaskItemDescription!
                                      ? localization.startTime
                                      : null,
                                  selectedDateTime: taskTimes[index].startDate,
                                  onSelected: (timeOfDay) {
                                    if (timeOfDay == null) {
                                      return;
                                    }

                                    final taskTime = taskTimes[index].copyWithStartTime(timeOfDay);
                                    viewModel.onUpdatedTaskTime(
                                        taskTime, index);
                                    setState(() {
                                      _startTimeUpdatedAt =
                                          DateTime.now().millisecondsSinceEpoch;
                                    });
                                  },
                                ),
                              ),
                            ),
                            if (showEndDate)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: kTableColumnGap),
                                  child: DatePicker(
                                    key: ValueKey(
                                        '__${_startDateUpdatedAt}_${_durationUpdateAt}_${_endTimeUpdatedAt}_${index}__'),
                                    labelText: settings.showTaskItemDescription!
                                        ? localization.endDate
                                        : null,
                                    selectedDate:
                                        taskTimes[index].endDate == null
                                            ? null
                                            : convertDateTimeToSqlDate(
                                                taskTimes[index].endDate!
                                                    .toLocal()),
                                    onSelected: (date, _) {
                                      final taskTime = taskTimes[index].copyWithEndDate(date);
                                      viewModel.onUpdatedTaskTime(
                                          taskTime, index);
                                      setState(() {
                                        _endDateUpdatedAt = DateTime.now()
                                            .millisecondsSinceEpoch;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: kTableColumnGap),
                                child: TimePicker(
                                  key: ValueKey(
                                      '__${_endDateUpdatedAt}_${_durationUpdateAt}_${index}__'),
                                  labelText: settings.showTaskItemDescription!
                                      ? localization.endTime
                                      : null,
                                  selectedDateTime: taskTimes[index].endDate,
                                  isEndTime: true,
                                  onSelected: (timeOfDay) {
                                    if (timeOfDay == null) {
                                      return;
                                    }

                                    final taskTime = taskTimes[index].copyWithEndTime(timeOfDay);
                                    viewModel.onUpdatedTaskTime(
                                        taskTime, index);
                                    setState(() {
                                      _endTimeUpdatedAt =
                                          DateTime.now().millisecondsSinceEpoch;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: kTableColumnGap),
                                child: DurationPicker(
                                  key: ValueKey(
                                      '__${_startTimeUpdatedAt}_${_endTimeUpdatedAt}_${_startDateUpdatedAt}_${_endDateUpdatedAt}_${index}__'),
                                  labelText: settings.showTaskItemDescription!
                                      ? localization.duration
                                      : null,
                                  onSelected: (Duration duration) {
                                    final taskTime = taskTimes[index].copyWithDuration(duration);
                                    viewModel.onUpdatedTaskTime(
                                        taskTime, index);
                                    setState(() {
                                      _durationUpdateAt =
                                          DateTime.now().millisecondsSinceEpoch;
                                    });
                                  },
                                  selectedDuration:
                                      (taskTimes[index].startDate == null ||
                                              taskTimes[index].endDate == null)
                                          ? null
                                          : taskTimes[index].duration,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (settings.showTaskItemDescription!)
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 16, right: 16),
                            child: GrowableFormField(
                              label: localization.description,
                              initialValue: taskTime.description,
                              onChanged: (value) {
                                viewModel.onUpdatedTaskTime(
                                    taskTime
                                        .rebuild((b) => b..description = value),
                                    index);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (settings.allowBillableTaskItems!)
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 4),
                      child: IconButton(
                          tooltip: taskTime.isBillable
                              ? localization.billable
                              : localization.notBillable,
                          onPressed: taskTime.isEmpty
                              ? null
                              : () => viewModel.onUpdatedTaskTime(
                                  taskTime.rebuild((b) =>
                                      b..isBillable = !taskTime.isBillable),
                                  index),
                          icon: Icon(taskTime.isBillable && !taskTime.isEmpty
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank)),
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: overlapping.contains(index) ? Colors.red : null,
                    ),
                    tooltip: overlapping.contains(index)
                        ? localization.invalidTime
                        : localization.remove,
                    onPressed: taskTimes[index].isEmpty
                        ? null
                        : () {
                            confirmCallback(
                                context: context,
                                callback: (_) {
                                  viewModel.onRemoveTaskTime(index);
                                  setState(() {
                                    _updatedAt =
                                        DateTime.now().millisecondsSinceEpoch;
                                  });
                                });
                          },
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        SizedBox(
          height: kMobileDialogPadding,
        ),
      ],
    );
  }
}
