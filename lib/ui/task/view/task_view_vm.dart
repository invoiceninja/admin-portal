import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';

class TaskViewScreen extends StatelessWidget {
  const TaskViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/task/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskViewVM>(
      converter: (Store<AppState> store) {
        return TaskViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return TaskView(
          viewModel: vm,
          isFilter: isFilter,
          tabIndex: vm.state.taskUIState.tabIndex,
        );
      },
    );
  }
}

class TaskViewVM {
  TaskViewVM({
    @required this.onFabPressed,
    @required this.task,
    @required this.client,
    @required this.project,
    @required this.company,
    @required this.state,
    @required this.onEntityAction,
    @required this.onEditPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
  });

  factory TaskViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final task = state.taskState.get(state.taskUIState.selectedId);
    final client = state.clientState.map[task.clientId];
    final project = state.projectState.map[task.projectId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadTask(completer: completer, taskId: task.id));
      return completer.future;
    }

    void _toggleTask(BuildContext context) {
      final Completer<TaskEntity> completer = new Completer<TaskEntity>();
      final localization = AppLocalization.of(context);
      store
          .dispatch(SaveTaskRequest(completer: completer, task: task.toggle()));
      completer.future.then((savedTask) {
        showToast(savedTask.isRunning
            ? (savedTask.duration > 0
                ? localization.resumedTask
                : localization.startedTask)
            : localization.stoppedTask);
      }).catchError((Object error) {
        showDialog<ErrorDialog>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(error);
            });
      });
    }

    return TaskViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: task.isNew,
      task: task,
      client: client,
      project: project,
      onFabPressed: (BuildContext context) => _toggleTask(context),
      onEditPressed: (BuildContext context, [TaskTime taskTime]) {
        editEntity(
            context: context,
            entity: task,
            subIndex: task.getTaskTimes().indexOf(taskTime),
            completer: snackBarCompleter<ClientEntity>(
                context, AppLocalization.of(context).updatedTask));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context.getAppContext(), [task], action,
              autoPop: true),
      onUploadDocument: (BuildContext context, MultipartFile multipartFile) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        store.dispatch(SaveTaskDocumentRequest(
            multipartFile: multipartFile, task: task, completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context).uploadedDocument);
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onDeleteDocument: (BuildContext context, DocumentEntity document,
          String password, String idToken) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).deletedDocument);
        completer.future
            .then<Null>((value) => store.dispatch(LoadTask(taskId: task.id)));
        store.dispatch(DeleteDocumentRequest(
          completer: completer,
          documentIds: [document.id],
          password: password,
          idToken: idToken,
        ));
      },
    );
  }

  final AppState state;
  final TaskEntity task;
  final ClientEntity client;
  final ProjectEntity project;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, [TaskTime]) onEditPressed;
  final Function(BuildContext) onFabPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
  final Function(BuildContext, MultipartFile) onUploadDocument;
  final Function(BuildContext, DocumentEntity, String, String) onDeleteDocument;
}
