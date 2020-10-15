import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final ProjectViewVM viewModel;
  final bool isFilter;

  @override
  _ProjectViewState createState() => new _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
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
    final project = viewModel.project;
    final client = viewModel.client;
    final company = viewModel.company;
    final localization = AppLocalization.of(context);

    final Map<String, String> fields = {
      ProjectFields.dueDate: formatDate(project.dueDate, context),
      ProjectFields.taskRate: formatNumber(project.taskRate, context,
          formatNumberType: FormatNumberType.money),
    };

    if (project.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.project1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.project1,
          value: project.customValue1);
    }
    if (project.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.project2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.project2,
          value: project.customValue2);
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: project,
      body: Builder(
        builder: (BuildContext context) {
          List<Widget> _buildView() {
            final widgets = <Widget>[
              EntityHeader(
                entity: project,
                label: localization.total,
                value: formatDuration(taskDurationForProject(
                    project, viewModel.state.taskState.map)),
                secondLabel: localization.budgeted,
                secondValue: formatDuration(
                    Duration(hours: project.budgetedHours.toInt()),
                    showSeconds: false),
              ),
              ListDivider(),
              EntityListTile(
                entity: client,
                isFilter: widget.isFilter,
              ),
              EntitiesListTile(
                isFilter: widget.isFilter,
                entityType: EntityType.task,
                title: localization.tasks,
                onTap: () => viewModel.onTasksPressed(context),
                onLongPress: () =>
                    viewModel.onTasksPressed(context, longPress: true),
                subtitle: memoizedTaskStatsForProject(
                        project.id, viewModel.state.taskState.map)
                    .present(localization.active, localization.archived),
              ),
            ];

            if (project.privateNotes != null &&
                project.privateNotes.isNotEmpty) {
              widgets.addAll([
                IconMessage(project.privateNotes),
                Container(
                  color: Theme.of(context).backgroundColor,
                  height: 12.0,
                ),
              ]);
            }

            widgets.addAll([
              FieldGrid(fields),
            ]);

            return widgets;
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed(context),
            child: ListView(
              children: _buildView(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'project_view_fab',
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () => viewModel.onAddTaskPressed(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: localization.newTask,
      ),
    );
  }
}
