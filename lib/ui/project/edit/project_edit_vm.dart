// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ProjectEditScreen extends StatelessWidget {
  const ProjectEditScreen({Key? key}) : super(key: key);

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
          key: ValueKey(viewModel.project.updatedAt),
        );
      },
    );
  }
}

class ProjectEditVM {
  ProjectEditVM({
    required this.state,
    required this.company,
    required this.project,
    required this.onChanged,
    required this.onAddClientPressed,
    required this.isSaving,
    required this.origProject,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
  });

  factory ProjectEditVM.fromStore(Store<AppState> store) {
    final project = store.state.projectUIState.editing!;
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
        createEntity(entity: ProjectEntity(), force: true);
        if (state.projectUIState.cancelCompleter != null) {
          state.projectUIState.cancelCompleter!.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then<Null>((_) {
                store.dispatch(UpdateCurrentRoute(ProjectEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(ProjectEditScreen.route));
        });
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final project = store.state.projectUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          final Completer<ProjectEntity> completer =
              new Completer<ProjectEntity>();
          store.dispatch(
              SaveProjectRequest(completer: completer, project: project));
          return completer.future.then((savedProject) {
            showToast(project!.isNew
                ? localization!.createdProject
                : localization!.updatedProject);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(ProjectViewScreen.route));
              if (project.isNew && state.projectUIState.saveCompleter == null) {
                navigator!.pushReplacementNamed(ProjectViewScreen.route);
              } else {
                navigator!.pop(savedProject);
              }
            } else if (state.projectUIState.saveCompleter == null) {
              if (!state.prefState.isPreviewVisible) {
                store.dispatch(TogglePreviewSidebar());
              }
              viewEntity(entity: savedProject, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final ProjectEntity project;
  final CompanyEntity? company;
  final Function(ProjectEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isSaving;
  final ProjectEntity? origProject;
  final bool isLoading;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
}
