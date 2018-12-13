import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: project.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  user: viewModel.company.user,
                  isSaving: viewModel.isSaving,
                  entity: project,
                  onSelected: viewModel.onActionSelected,
                ),
              ],
      ),
      body: FormCard(
        children: [
          // STARTER: widgets - do not remove comment
        ]
      ),
    );
  }
}
