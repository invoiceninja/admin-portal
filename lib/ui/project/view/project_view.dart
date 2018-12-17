import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
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
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final project = viewModel.project;

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
                  //children: _buildView(),
                ),
              ),
            );
          },
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
    final localization = AppLocalization.of(context);
    final project = viewModel.project;
    final client = viewModel.client;
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
          entityActions:
          project.getEntityActions(client: viewModel.client, user: user),
          isSaving: viewModel.isSaving,
          entity: project,
          onSelected: viewModel.onActionSelected,
        )
      ],
    );
  }
}
