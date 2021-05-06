import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/duration_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';
import 'package:invoiceninja_flutter/ui/app/forms/project_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/time_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_desktop.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';

class TaskEditDesktop extends StatefulWidget {
  const TaskEditDesktop({
    Key key,
    @required this.viewModel,
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
        formatNumberType: FormatNumberType.inputMoney);
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
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final task = viewModel.task;
    final state = viewModel.state;

    final company = state.company;
    final client = state.clientState.get(task.clientId);
    final showEndDate = company.showTaskEndDate;
    final taskTimes = task.getTaskTimes(sort: false);
    if (!taskTimes.any((taskTime) => taskTime.isEmpty)) {
      taskTimes.add(TaskTime().rebuild((b) => b..startDate = null));
    }

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
                : company.currencyId);

    return ScrollableListView(
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
                      key: ValueKey('__client_${task.clientId}__'),
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
                    isMoney: false,
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
                    entityIds: state.taskStatusState.list.toList(),
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
          padding: const EdgeInsets.symmetric(horizontal: kMobileDialogPadding),
          child: FocusTraversalGroup(
            policy: ReadingOrderTraversalPolicy(),
            child: Table(
              key: ValueKey('__table_${_updatedAt}__'),
              columnWidths: {
                showEndDate ? 5 : 4: FixedColumnWidth(kMinInteractiveDimension),
              },
              children: [
                TableRow(
                  children: [
                    TableHeader(localization.startDate),
                    TableHeader(localization.startTime),
                    if (showEndDate) TableHeader(localization.endDate),
                    TableHeader(localization.endTime),
                    TableHeader(localization.duration),
                    TableHeader(''),
                  ],
                ),
                for (var index = 0; index < taskTimes.length; index++)
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: DatePicker(
                        key: ValueKey(
                            '__${_startTimeUpdatedAt}_${_durationUpdateAt}_${index}__'),
                        selectedDate: taskTimes[index].startDate == null
                            ? null
                            : convertDateTimeToSqlDate(
                                taskTimes[index].startDate.toLocal()),
                        onSelected: (date) {
                          final taskTime = taskTimes[index]
                              .copyWithStartDate(date, syncDates: !showEndDate);
                          viewModel.onUpdatedTaskTime(taskTime, index);
                          setState(() {
                            _startDateUpdatedAt =
                                DateTime.now().millisecondsSinceEpoch;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: TimePicker(
                        key: ValueKey('__${_durationUpdateAt}_${index}__'),
                        selectedDateTime: taskTimes[index].startDate,
                        onSelected: (timeOfDay) {
                          final taskTime =
                              taskTimes[index].copyWithStartTime(timeOfDay);
                          viewModel.onUpdatedTaskTime(taskTime, index);
                          setState(() {
                            _startTimeUpdatedAt =
                                DateTime.now().millisecondsSinceEpoch;
                          });
                        },
                      ),
                    ),
                    if (showEndDate)
                      Padding(
                        padding: const EdgeInsets.only(right: kTableColumnGap),
                        child: DatePicker(
                          key: ValueKey(
                              '__${_startDateUpdatedAt}_${_durationUpdateAt}_${_endTimeUpdatedAt}_${index}__'),
                          selectedDate: taskTimes[index].endDate == null
                              ? null
                              : convertDateTimeToSqlDate(
                                  taskTimes[index].endDate.toLocal()),
                          onSelected: (date) {
                            final taskTime =
                                taskTimes[index].copyWithEndDate(date);
                            viewModel.onUpdatedTaskTime(taskTime, index);
                            setState(() {
                              _endDateUpdatedAt =
                                  DateTime.now().millisecondsSinceEpoch;
                            });
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: TimePicker(
                        key: ValueKey(
                            '__${_endDateUpdatedAt}_${_durationUpdateAt}_${index}__'),
                        selectedDateTime: taskTimes[index].endDate,
                        isEndTime: true,
                        onSelected: (timeOfDay) {
                          final taskTime =
                              taskTimes[index].copyWithEndTime(timeOfDay);
                          viewModel.onUpdatedTaskTime(taskTime, index);
                          setState(() {
                            _endTimeUpdatedAt =
                                DateTime.now().millisecondsSinceEpoch;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: DurationPicker(
                        key: ValueKey(
                            '__${_startTimeUpdatedAt}_${_endTimeUpdatedAt}_${_startDateUpdatedAt}_${_endDateUpdatedAt}_${index}__'),
                        onSelected: (Duration duration) {
                          final taskTime =
                              taskTimes[index].copyWithDuration(duration);
                          viewModel.onUpdatedTaskTime(taskTime, index);
                          setState(() {
                            _durationUpdateAt =
                                DateTime.now().millisecondsSinceEpoch;
                          });
                        },
                        selectedDuration: (taskTimes[index].startDate == null ||
                                taskTimes[index].endDate == null)
                            ? null
                            : taskTimes[index].duration,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        tooltip: localization.remove,
                        onPressed: taskTimes[index].isEmpty
                            ? null
                            : () {
                                viewModel.onRemoveTaskTime(index);
                                setState(() {
                                  _updatedAt =
                                      DateTime.now().millisecondsSinceEpoch;
                                });
                              },
                      ),
                    ),
                  ]),
              ],
            ),
          ),
        )
      ],
    );
  }
}
