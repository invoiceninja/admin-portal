import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({Key key}) : super(key: key);
  static const String route = '/project/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProjectViewVM>(
      converter: (Store<AppState> store) {
        return ProjectViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ProjectView(
          viewModel: vm,
        );
      },
    );
  }
}

class ProjectViewVM {
  ProjectViewVM({
    @required this.state,
    @required this.project,
    @required this.client,
    @required this.company,
    @required this.onEntityAction,
    @required this.onTasksPressed,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onAddTaskPressed,
    @required this.onClientPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ProjectViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final project = state.projectState.map[state.projectUIState.selectedId] ??
        ProjectEntity(id: state.projectUIState.selectedId);
    final client = state.clientState.map[project.clientId] ??
        ClientEntity(id: project.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProject(completer: completer, projectId: project.id));
      return completer.future;
    }

    return ProjectViewVM(
      state: state,
      company: state.selectedCompany,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: project.isNew,
      project: project,
      client: client,
      onEditPressed: (BuildContext context) {
        store.dispatch(EditProject(project: project, context: context));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onClientPressed: (BuildContext context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
              userCompany: state.userCompany,
              context: context,
              entities: [client],
              onEntityAction: (BuildContext context, List<BaseEntity> clients,
                      EntityAction action) =>
                  handleClientAction(context, clients, action));
        } else {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        }
      },
      onTasksPressed: (BuildContext context, {bool longPress = false}) {
        if (longPress && project.isActive && client.isActive) {
          store.dispatch(EditTask(
              task: TaskEntity(isRunning: state.uiState.autoStartTasks)
                  .rebuild((b) => b
                    ..projectId = project.id
                    ..clientId = project.clientId),
              context: context));
        } else {
          store.dispatch(FilterTasksByEntity(
              entityId: project.id, entityType: EntityType.project));
          store.dispatch(ViewTaskList(context: context));
        }
      },
      onAddTaskPressed: (context) => store.dispatch(EditTask(
        context: context,
        task:
            TaskEntity(isRunning: state.uiState.autoStartTasks).rebuild((b) => b
              ..projectId = project.id
              ..clientId = project.clientId),
        force: true,
      )),
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(ProjectScreen.route)) {
          store.dispatch(UpdateCurrentRoute(ProjectScreen.route));
        }
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleProjectAction(context, [project], action),
    );
  }

  final AppState state;
  final ProjectEntity project;
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onEditPressed;
  final Function(BuildContext, [bool]) onClientPressed;
  final Function onBackPressed;
  final Function(BuildContext) onAddTaskPressed;
  final Function(BuildContext, {bool longPress}) onTasksPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
