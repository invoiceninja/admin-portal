import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';

class ProjectEditScreen extends StatelessWidget {
  static const String route = '/project/edit';
  ProjectEditScreen({Key key}) : super(key: key);

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
  final ProjectEntity project;
  final Function(ProjectEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final bool isSaving;
  final ProjectEntity origProject;
  final Function onBackPressed;
  final bool isLoading;

  ProjectEditVM({
    @required this.project,
    @required this.onChanged,
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
      project: project,
      origProject: state.projectState.map[project.id],
      onChanged: (ProjectEntity project) {
        store.dispatch(UpdateProject(project));
      },
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(ProjectScreen.route));
      },
      onSavePressed: (BuildContext context) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(SaveProjectRequest(completer: completer, project: project));
        return completer.future.then((_) {
          /*
          Scaffold.of(context).showSnackBar(SnackBar(
              content: IconMessage(
                message: project.isNew
                    ? 'Successfully Created Project'
                    : 'Successfully Updated Project',
              ),
              duration: Duration(seconds: 3)));
              */
        });
      },
    );
  }
}
