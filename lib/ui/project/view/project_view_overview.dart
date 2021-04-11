import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectOverview extends StatefulWidget {
  const ProjectOverview({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final ProjectViewVM viewModel;
  final bool isFilter;

  @override
  _ProjectOverviewState createState() => _ProjectOverviewState();
}

class _ProjectOverviewState extends State<ProjectOverview> {
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
    final project = widget.viewModel.project;
    final client = widget.viewModel.client;
    final company = widget.viewModel.company;
    final state = widget.viewModel.state;
    final localization = AppLocalization.of(context);

    final Map<String, String> fields = {
      ProjectFields.dueDate: formatDate(project.dueDate, context),
      ProjectFields.taskRate: formatNumber(project.taskRate, context,
          formatNumberType: FormatNumberType.money, clientId: project.clientId),
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

    List<Widget> _buildView() {
      final widgets = <Widget>[
        EntityHeader(
          entity: project,
          label: localization.total,
          value: formatDuration(
              taskDurationForProject(project, state.taskState.map)),
          secondLabel: localization.budgeted,
          secondValue:
              formatDuration(Duration(hours: project.budgetedHours.toInt())),
        ),
        ListDivider(),
        if ((project.privateNotes ?? '').isNotEmpty) ...[
          IconMessage(project.privateNotes, iconData: Icons.lock),
          ListDivider()
        ],
        EntityListTile(
          entity: client,
          isFilter: widget.isFilter,
        ),
        EntityListTile(
          entity: state.userState.get(project.assignedUserId),
          isFilter: widget.isFilter,
        ),
        if (company.isModuleEnabled(EntityType.task))
          EntitiesListTile(
            entity: project,
            isFilter: widget.isFilter,
            entityType: EntityType.task,
            title: localization.tasks,
            subtitle:
                memoizedTaskStatsForProject(project.id, state.taskState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.expense))
          EntitiesListTile(
            entity: project,
            isFilter: widget.isFilter,
            entityType: EntityType.expense,
            title: localization.expenses,
            subtitle: memoizedExpenseStatsForProject(
                    project.id, state.expenseState.map)
                .present(localization.active, localization.archived),
          ),
      ];

      widgets.addAll([
        FieldGrid(fields),
      ]);

      if ((project.publicNotes ?? '').isNotEmpty) {
        widgets.addAll([IconMessage(project.publicNotes), ListDivider()]);
      }

      return widgets;
    }

    return RefreshIndicator(
      onRefresh: () => widget.viewModel.onRefreshed(context),
      child: ScrollableListView(
        children: _buildView(),
      ),
    );
  }
}
