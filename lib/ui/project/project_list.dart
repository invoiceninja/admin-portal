import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_item.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoaded) {
      return LoadingIndicator();
    } else if (viewModel.projectList.isEmpty) {
      return Opacity(
        opacity: 0.5,
        child: Center(
          child: Text(
            AppLocalization.of(context).noRecordsFound,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }

    return _buildListView(context);
  }

  void _showMenu(BuildContext context, ProjectEntity project) async {
  if (project == null) {
    return;
  }
    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: <Widget>[
              user.canCreate(EntityType.project)
                  ? ListTile(
                      leading: Icon(Icons.control_point_duplicate),
                      title: Text(AppLocalization.of(context).clone),
                      onTap: () => viewModel.onEntityAction(
                          context, project, EntityAction.clone),
                    )
                  : Container(),
              Divider(),
              user.canEditEntity(project) && !project.isActive
                  ? ListTile(
                      leading: Icon(Icons.restore),
                      title: Text(AppLocalization.of(context).restore),
                      onTap: () => viewModel.onEntityAction(
                          context, project, EntityAction.restore),
                    )
                  : Container(),
              user.canEditEntity(project) && project.isActive
                  ? ListTile(
                      leading: Icon(Icons.archive),
                      title: Text(AppLocalization.of(context).archive),
                      onTap: () => viewModel.onEntityAction(
                          context, project, EntityAction.archive),
                    )
                  : Container(),
              user.canEditEntity(project) && !project.isDeleted
                  ? ListTile(
                      leading: Icon(Icons.delete),
                      title: Text(AppLocalization.of(context).delete),
                      onTap: () => viewModel.onEntityAction(
                          context, project, EntityAction.delete),
                    )
                  : Container(),
            ]));
    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          itemCount: viewModel.projectList.length,
          itemBuilder: (BuildContext context, index) {
            final projectId = viewModel.projectList[index];
            final project = viewModel.projectMap[projectId];
            return Column(children: <Widget>[
              ProjectListItem(
                user: viewModel.user,
                filter: viewModel.filter,
                project: project,
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    _showMenu(context, project);
                  } else {
                    viewModel.onEntityAction(context, project, action);
                  }
                },
                onTap: () => viewModel.onProjectTap(context, project),
                onLongPress: () => _showMenu(context, project),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }

  final ProjectListVM viewModel;
}
