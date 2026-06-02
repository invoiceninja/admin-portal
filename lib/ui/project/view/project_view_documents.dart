// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';

class ProjectViewDocuments extends StatelessWidget {
  const ProjectViewDocuments({Key? key, required this.viewModel})
      : super(key: key);

  final ProjectViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final project = viewModel.project;

    return DocumentGrid(
      documents: project.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments(context, path, isPrivate),
      onRenamedDocument: () =>
          store.dispatch(LoadProject(projectId: project.id)),
    );
  }
}
