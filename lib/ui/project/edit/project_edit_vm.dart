import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ProjectEditScreen extends StatelessWidget {
  const ProjectEditScreen({Key key}) : super(key: key);

  static const String route = '/project/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProjectEditVM>(
      converter: (Store<AppState> store) {
        return ProjectEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return ProjectEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.project.id),
        );
      },
    );
  }
}

class ProjectEditVM {
  ProjectEditVM({
    @required this.state,
    @required this.company,
    @required this.project,
    @required this.onChanged,
    @required this.onAddClientPressed,
    @required this.isSaving,
    @required this.origProject,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory ProjectEditVM.fromStore(Store<AppState> store) {
    final project = store.state.projectUIState.editing;
    final state = store.state;

    return ProjectEditVM(
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      company: state.company,
      project: project,
      state: state,
      origProject: state.projectState.map[project.id],
      onChanged: (ProjectEntity project) {
        store.dispatch(UpdateProject(project));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: ProjectEntity(), force: true);
        if (state.projectUIState.cancelCompleter != null) {
          state.projectUIState.cancelCompleter.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            context: context,
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then((_) {
                store.dispatch(UpdateCurrentRoute(ProjectEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(ProjectEditScreen.route));
        });
      },
      onSavePressed: (BuildContext context) {
        final appContext = context.getAppContext();
        Debouncer.runOnComplete(() {
          final project = store.state.projectUIState.editing;
          final localization = appContext.localization;
          final Completer<ProjectEntity> completer =
              new Completer<ProjectEntity>();
          store.dispatch(
              SaveProjectRequest(completer: completer, project: project));
          return completer.future.then((savedProject) {
            showToast(project.isNew
                ? localization.createdProject
                : localization.updatedProject);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(ProjectViewScreen.route));
              if (project.isNew && state.projectUIState.saveCompleter == null) {
                appContext.navigator
                    .pushReplacementNamed(ProjectViewScreen.route);
              } else {
                appContext.navigator.pop(savedProject);
              }
            } else {
              viewEntity(
                  appContext: appContext, entity: savedProject, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final ProjectEntity project;
  final CompanyEntity company;
  final Function(ProjectEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isSaving;
  final ProjectEntity origProject;
  final bool isLoading;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
}
