// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';

class TaskViewDocuments extends StatelessWidget {
  const TaskViewDocuments({Key? key, required this.viewModel})
      : super(key: key);

  final TaskViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final task = viewModel.task;

    return DocumentGrid(
      documents: task.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments(context, path, isPrivate),
      onRenamedDocument: () => store.dispatch(LoadTask(taskId: task.id)),
    );
  }
}
