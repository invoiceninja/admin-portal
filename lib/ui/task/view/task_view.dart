import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/task/task_time_view.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
    final project = viewModel.project;
    final client = viewModel.client;
    final company = viewModel.company;
    final invoice = viewModel.state.invoiceState.map[task.invoiceId];
    final localization = AppLocalization.of(context);

    final Map<String, String> fields = {};

    // TODO Remove isNotEmpty check in v2
    if (company.taskStatusMap.isNotEmpty && (task.taskStatusId ?? 0) > 0) {
      fields[localization.status] =
          company.taskStatusMap[task.taskStatusId]?.name ?? '';
    }

    if (task.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.task1);
      fields[label1] = task.customValue1;
    }
    if (task.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.task2);
      fields[label2] = task.customValue2;
    }

    List<Widget> _buildView() {
      final widgets = <Widget>[
        TwoValueHeader(
          backgroundColor: task.isInvoiced
              ? Colors.green
              : task.isRunning ? Colors.blue : null,
          label1: localization.duration,
          value1: formatDuration(task.calculateDuration),
          label2: localization.amount,
          value2: formatNumber(
              task.calculateAmount(taskRateSelector(
                  company: company, project: project, client: client)),
              context,
              roundToTwo: true),
        ),
      ];

      if (client != null) {
        widgets.addAll([
          Material(
            color: Theme.of(context).canvasColor,
            child: ListTile(
              title: Text(client.displayName),
              leading: Icon(getEntityIcon(EntityType.client), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () => viewModel.onClientPressed(context),
              onLongPress: () => viewModel.onClientPressed(context, true),
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
              title: Text(project.name),
              leading: Icon(getEntityIcon(EntityType.project), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () => viewModel.onProjectPressed(context),
              onLongPress: () => viewModel.onProjectPressed(context, true),
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
              title: Text(invoice.invoiceNumber),
              leading: Icon(getEntityIcon(EntityType.invoice), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () => viewModel.onInvoicePressed(context),
              onLongPress: () => viewModel.onInvoicePressed(context, true),
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
      items.reversed.forEach((taskTime) {
        widgets.addAll([
          TaskTimeListTile(
            task: task,
            taskTime: taskTime,
            onTap: (BuildContext context) => company.user.canEditEntity(task)
                ? viewModel.onEditPressed(context, taskTime)
                : null,
          )
        ]);
      });

      return widgets;
    }

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: ListView(
                  children: _buildView(),
                ),
              ),
            );
          },
        ),
        floatingActionButton: Builder(builder: (BuildContext context) {
          return task.isInvoiced || task.isDeleted
              ? SizedBox()
              : FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  onPressed: () => viewModel.onFabPressed(context),
                  child: Icon(
                    task.isRunning ? Icons.stop : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  tooltip:
                      task.isRunning ? localization.stop : localization.start,
                );
        }),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
  });

  final TaskViewVM viewModel;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final task = viewModel.task;
    final user = viewModel.company.user;

    return AppBar(
      title: Text(AppLocalization.of(context).task),
      actions: task.isNew
          ? []
          : [
              user.canEditEntity(task)
                  ? EditIconButton(
                      isVisible: !task.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                user: user,
                entityActions:
                    task.getEntityActions(client: viewModel.client, user: user),
                isSaving: viewModel.isSaving,
                entity: task,
                onSelected: viewModel.onActionSelected,
              )
            ],
    );
  }
}
