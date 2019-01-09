import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_overview.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProjectViewVM viewModel;

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
      fields[label1] = project.customValue1;
    }
    if (project.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.project2);
      fields[label2] = project.customValue2;
    }

    List<Widget> _buildView() {
      final widgets = <Widget>[
        TwoValueHeader(
          label1: localization.total,
          value1: formatDuration(
              taskDurationForProject(project, viewModel.state.taskState.map)),
          label2: localization.budgeted,
          value2: formatDuration(Duration(hours: project.budgetedHours.toInt()),
              showSeconds: false),
        ),
        Material(
          color: Theme.of(context).canvasColor,
          child: ListTile(
            title: Text(client.displayName),
            leading: Icon(FontAwesomeIcons.users, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () => viewModel.onClientPressed(context),
            onLongPress: () => viewModel.onClientPressed(context, true),
          ),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        EntityListTile(
          icon: getEntityIcon(EntityType.task),
          title: localization.tasks,
          onTap: () => viewModel.onTasksPressed(context),
          subtitle: memoizedTaskStatsForProject(
              client.id,
              viewModel.state.taskState.map,
              localization.active,
              localization.archived),
        ),
      ];

      if (project.privateNotes != null && project.privateNotes.isNotEmpty) {
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () => viewModel.onAddTaskPressed(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          tooltip: localization.newTask,
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
  });

  final ProjectViewVM viewModel;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final project = viewModel.project;
    final user = viewModel.company.user;

    return AppBar(
      title: Text(project.name),
      actions: project.isNew
          ? []
          : [
              user.canEditEntity(project)
                  ? EditIconButton(
                      isVisible: !project.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                user: user,
                entityActions: project.getEntityActions(
                    client: viewModel.client, user: user),
                isSaving: viewModel.isSaving,
                entity: project,
                onSelected: viewModel.onActionSelected,
              )
            ],
    );
  }
}
