import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
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
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory ProjectEditVM.fromStore(Store<AppState> store) {
    final project = store.state.projectUIState.editing;
    final state = store.state;

    return ProjectEditVM(
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      company: state.selectedCompany,
      project: project,
      state: state,
      origProject: state.projectState.map[project.id],
      onChanged: (ProjectEntity project) {
        store.dispatch(UpdateProject(project));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(ProjectScreen.route)) {
          store.dispatch(UpdateCurrentRoute(
              project.isNew ? ProjectScreen.route : ProjectViewScreen.route));
        }
      },
      onAddClientPressed: (context, completer) {
        store.dispatch(EditClient(
            client: ClientEntity(),
            context: context,
            completer: completer,
            trackRoute: false));
        completer.future.then((SelectableEntity client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).createdClient,
          )));
        });
      },
      onSavePressed: (BuildContext context) {
        final Completer<ProjectEntity> completer =
            new Completer<ProjectEntity>();
        store.dispatch(
            SaveProjectRequest(completer: completer, project: project));
        return completer.future.then((savedProject) {
          if (state.uiState.currentRoute.contains(ProjectScreen.route)) {
            store.dispatch(UpdateCurrentRoute(ProjectScreen.route));
          }
          if (project.isNew) {
            if ([
              TaskEditScreen.route,
            ].contains(store.state.uiState.currentRoute)) {
              Navigator.of(context).pop(savedProject);
            } else {
              Navigator.of(context)
                  .pushReplacementNamed(ProjectViewScreen.route);
            }
          } else {
            Navigator.of(context).pop(savedProject);
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final ProjectEntity project;
  final CompanyEntity company;
  final Function(ProjectEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final bool isSaving;
  final ProjectEntity origProject;
  final Function onBackPressed;
  final bool isLoading;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
}
