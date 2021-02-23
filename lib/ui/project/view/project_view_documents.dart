import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';

class ProjectViewDocuments extends StatelessWidget {
  const ProjectViewDocuments({Key key, @required this.viewModel})
      : super(key: key);

  final ProjectViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final project = viewModel.project;

    return DocumentGrid(
      documents: project.documents.toList(),
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document, password, idToken) =>
          viewModel.onDeleteDocument(context, document, password, idToken),
    );
  }
}
