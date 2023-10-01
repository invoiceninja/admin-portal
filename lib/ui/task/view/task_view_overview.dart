// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/task/task_time_view.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskOverview extends StatefulWidget {
  const TaskOverview({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final TaskViewVM viewModel;
  final bool isFilter;

  @override
  _TaskOverviewState createState() => new _TaskOverviewState();
}

class _TaskOverviewState extends State<TaskOverview> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1),
        (Timer timer) => mounted ? setState(() => false) : false);
  }

  @override
  void dispose() {
    _timer!.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final task = viewModel.task;
    final localization = AppLocalization.of(context);

    final project = viewModel.project;
    final client = viewModel.client;
    final company = viewModel.company!;
    final invoice = viewModel.state.invoiceState.map[task.invoiceId];
    final user = viewModel.state.userState.map[task.assignedUserId];
    final group = state.groupState.get(client?.groupId ?? '');
    final status = state.taskStatusState.get(task.statusId);

    final Map<String, String?> fields = {
      TaskFields.rate: formatNumber(task.rate, context,
          zeroIsNull: true, clientId: client?.id),
    };

    if (task.statusId.isNotEmpty) {
      fields[localization!.status] =
          company.taskStatusMap[task.statusId]?.name ?? '';
    }

    if (company.hasCustomField(CustomFieldType.task1) &&
        task.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.task1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.task1,
          value: task.customValue1);
    }

    if (company.hasCustomField(CustomFieldType.task2) &&
        task.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.task2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.task2,
          value: task.customValue2);
    }

    if (company.hasCustomField(CustomFieldType.task3) &&
        task.customValue3.isNotEmpty) {
      final label3 = company.getCustomFieldLabel(CustomFieldType.task3);
      fields[label3] = formatCustomValue(
          context: context,
          field: CustomFieldType.task3,
          value: task.customValue3);
    }

    if (company.hasCustomField(CustomFieldType.task4) &&
        task.customValue4.isNotEmpty) {
      final label4 = company.getCustomFieldLabel(CustomFieldType.task4);
      fields[label4] = formatCustomValue(
          context: context,
          field: CustomFieldType.task4,
          value: task.customValue4);
    }

    List<Widget> _buildView() {
      final widgets = <Widget>[
        EntityHeader(
          entity: task,
          statusLabel: state.taskStatusState.get(task.statusId).name,
          statusColor: task.isInvoiced
              ? Colors.green
              : task.isRunning
                  ? Colors.blue
                  : null,
          label: localization!.duration,
          value: formatDuration(task.calculateDuration()),
          secondLabel: localization.amount,
          secondValue: formatNumber(
            task.calculateAmount(
              taskRateSelector(
                company: company,
                project: project,
                client: client,
                task: task,
                group: group,
              )!,
            ),
            context,
            clientId: client?.id,
          ),
        ),
        ListDivider(),
      ];

      if (client != null) {
        widgets.addAll([
          EntityListTile(
            entity: client,
            isFilter: widget.isFilter,
          ),
        ]);
      }

      if (project != null) {
        widgets.addAll([
          EntityListTile(
            entity: project,
            isFilter: widget.isFilter,
          ),
        ]);
      }

      widgets.addAll([
        EntityListTile(
          entity: status,
          isFilter: widget.isFilter,
        ),
      ]);

      if (user != null) {
        widgets.addAll([
          EntityListTile(
            entity: user,
            isFilter: widget.isFilter,
          ),
        ]);
      }

      if (invoice != null) {
        widgets.addAll([
          EntityListTile(
            entity: invoice,
            isFilter: widget.isFilter,
          ),
        ]);
      }

      if (task.description.isNotEmpty) {
        widgets.addAll([
          IconMessage(task.description, copyToClipboard: true),
          ListDivider(),
        ]);
      }

      if (fields.isNotEmpty) {
        widgets.addAll([
          FieldGrid(fields),
        ]);
      }

      final items = task.getTaskTimes();
      if (items.isNotEmpty) {
        items.reversed.forEach((taskTime) {
          widgets.addAll([
            TaskTimeListTile(
              task: task,
              taskTime: taskTime,
              isValid: true,
              onTap: (BuildContext context) =>
                  viewModel.state.userCompany.canEditEntity(task)
                      ? viewModel.onEditPressed(context, taskTime)
                      : null,
            )
          ]);
        });
      }

      return widgets;
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ScrollableListView(
        children: _buildView(),
      ),
    );
  }
}
