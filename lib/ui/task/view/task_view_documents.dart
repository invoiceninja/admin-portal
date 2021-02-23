import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';

class TaskViewDocuments extends StatelessWidget {
  const TaskViewDocuments({Key key, @required this.viewModel})
      : super(key: key);

  final TaskViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final task = viewModel.task;

    return DocumentGrid(
      documents: task.documents.toList(),
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document, password, idToken) =>
          viewModel.onDeleteDocument(context, document, password, idToken),
    );
  }
}
