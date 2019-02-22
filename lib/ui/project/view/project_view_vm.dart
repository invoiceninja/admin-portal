import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

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
    @required this.onActionSelected,
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
        onClientPressed: (BuildContext context, [bool longPress = false]) =>
            store.dispatch(longPress
                ? EditClient(client: client, context: context)
                : ViewClient(clientId: project.clientId, context: context)),
        onTasksPressed: (BuildContext context) {
          store.dispatch(FilterTasksByEntity(
              entityId: project.id, entityType: EntityType.project));
          store.dispatch(ViewTaskList(context));
        },
        onAddTaskPressed: (context) => store.dispatch(EditTask(
            context: context,
            task: TaskEntity(isRunning: state.uiState.autoStartTasks)
                .rebuild((b) => b
                  ..projectId = project.id
                  ..clientId = project.clientId))),
        onBackPressed: () {
          if (state.uiState.currentRoute.contains(ProjectScreen.route)) {
            store.dispatch(UpdateCurrentRoute(ProjectScreen.route));
          }
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.newInvoice:
              final items = convertProjectToInvoiceItem(
                  project: project, context: context);
              store.dispatch(EditInvoice(
                  invoice: InvoiceEntity(company: state.selectedCompany)
                      .rebuild((b) => b
                        ..hasTasks = true
                        ..clientId = project.clientId
                        ..invoiceItems.addAll(items)),
                  context: context));
              break;
            case EntityAction.clone:
              store.dispatch(
                  EditProject(context: context, project: project.clone));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveProjectRequest(
                  popCompleter(context, localization.archivedProject),
                  project.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteProjectRequest(
                  popCompleter(context, localization.deletedProject),
                  project.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreProjectRequest(
                  snackBarCompleter(context, localization.restoredProject),
                  project.id));
              break;
          }
        });
  }

  final AppState state;
  final ProjectEntity project;
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext) onEditPressed;
  final Function(BuildContext, [bool]) onClientPressed;
  final Function onBackPressed;
  final Function(BuildContext) onAddTaskPressed;
  final Function(BuildContext) onTasksPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
