import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaskViewScreen extends StatelessWidget {
  const TaskViewScreen({Key key}) : super(key: key);
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
        );
      },
    );
  }
}

class TaskViewVM {
  TaskViewVM({
    @required this.task,
    @required this.client,
    @required this.project,
    @required this.company,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.onClientPressed,
    @required this.onProjectPressed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory TaskViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final task = state.taskState.map[state.taskUIState.selectedId];
    final client = state.clientState.map[task.clientId];
    final project = state.projectState.map[task.projectId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadTask(completer: completer, taskId: task.id));
      return completer.future;
    }

    return TaskViewVM(
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isLoading: state.isLoading,
        isDirty: task.isNew,
        task: task,
        client: client,
        project: project,
        onClientPressed: (context, [longPress = false]) {
          if (longPress) {
            store.dispatch(EditClient(client: client, context: context));
          } else {
            store.dispatch(ViewClient(clientId: client.id, context: context));
          }
        },
        onProjectPressed: (context, [longPress = false]) {
          if (longPress) {
            store.dispatch(EditProject(project: project, context: context));
          } else {
            store
                .dispatch(ViewProject(projectId: project.id, context: context));
          }
        },
        onEditPressed: (BuildContext context, [int taskItemIndex]) {
          store.dispatch(EditTask(
              task: task, context: context, taskItemIndex: taskItemIndex));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onBackPressed: () {
          if (state.uiState.currentRoute.contains(TaskScreen.route)) {
            store.dispatch(UpdateCurrentRoute(TaskScreen.route));
          }
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.archive:
              store.dispatch(ArchiveTaskRequest(
                  popCompleter(context, localization.archivedTask), task.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteTaskRequest(
                  popCompleter(context, localization.deletedTask), task.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreTaskRequest(
                  snackBarCompleter(context, localization.restoredTask),
                  task.id));
              break;
          }
        });
  }

  final TaskEntity task;
  final ClientEntity client;
  final ProjectEntity project;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext, [int]) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, [bool]) onClientPressed;
  final Function(BuildContext, [bool]) onProjectPressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
