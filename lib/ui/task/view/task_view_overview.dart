import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/task/task_time_view.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskOverview extends StatefulWidget {
  const TaskOverview({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final TaskViewVM viewModel;
  final bool isFilter;

  @override
  _TaskOverviewState createState() => new _TaskOverviewState();
}

class _TaskOverviewState extends State<TaskOverview> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1),
        (Timer timer) => mounted ? setState(() => false) : false);
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final task = viewModel.task;
    final localization = AppLocalization.of(context);

    final project = viewModel.project;
    final client = viewModel.client;
    final company = viewModel.company;
    final invoice = viewModel.state.invoiceState.map[task.invoiceId];

    final Map<String, String> fields = {};

    // TODO Remove isNotEmpty check in v2
    if (company.taskStatusMap.isNotEmpty &&
        (task.taskStatusId ?? '').isNotEmpty) {
      fields[localization.status] =
          company.taskStatusMap[task.taskStatusId]?.name ?? '';
    }

    if (task.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.task1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.task1,
          value: task.customValue1);
    }
    if (task.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.task2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.task2,
          value: task.customValue2);
    }

    List<Widget> _buildView() {
      final widgets = <Widget>[
        EntityHeader(
          entity: task,
          statusColor: task.isInvoiced
              ? Colors.green
              : task.isRunning
                  ? Colors.blue
                  : null,
          label: localization.duration,
          value: formatDuration(task.calculateDuration),
          secondLabel: localization.amount,
          secondValue: formatNumber(
            task.calculateAmount(
              taskRateSelector(
                company: company,
                project: project,
                client: client,
              ),
            ),
            context,
          ),
        ),
      ];

      if (client != null) {
        widgets.addAll([
          Material(
            color: Theme.of(context).canvasColor,
            child: ListTile(
              title: EntityStateTitle(entity: client),
              leading: Icon(getEntityIcon(EntityType.client), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () => inspectEntity(context: context, entity: client),
              onLongPress: () => inspectEntity(
                  context: context, entity: client, longPress: true),
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ]);
      }

      if (project != null) {
        widgets.addAll([
          Material(
            color: Theme.of(context).canvasColor,
            child: ListTile(
              title: EntityStateTitle(entity: project),
              leading: Icon(getEntityIcon(EntityType.project), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () => inspectEntity(context: context, entity: project),
              onLongPress: () => inspectEntity(
                  context: context, entity: project, longPress: true),
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ]);
      }

      if (invoice != null) {
        widgets.addAll([
          Material(
            color: Theme.of(context).canvasColor,
            child: ListTile(
              title: EntityStateTitle(entity: invoice),
              leading: Icon(getEntityIcon(EntityType.invoice), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () => inspectEntity(context: context, entity: invoice),
              onLongPress: () => inspectEntity(
                  context: context, entity: invoice, longPress: true),
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ]);
      }

      if (task.description.isNotEmpty) {
        widgets.addAll([
          IconMessage(task.description),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ]);
      }

      if (fields.isNotEmpty) {
        widgets.addAll([
          FieldGrid(fields),
        ]);
      }

      final items = task.taskTimes;
      if (items.isNotEmpty) {
        items.reversed.forEach((taskTime) {
          widgets.addAll([
            TaskTimeListTile(
              task: task,
              taskTime: taskTime,
              onTap: (BuildContext context) =>
                  viewModel.state.userCompany.canEditEntity(task)
                      ? viewModel.onEditPressed(context, taskTime)
                      : null,
            )
          ]);
        });

        widgets.add(
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        );
      }

      return widgets;
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView(
        children: _buildView(),
      ),
    );
  }
}
