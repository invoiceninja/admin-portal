import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
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
          isFilter: isFilter,
          tabIndex: vm.state.projectUIState.tabIndex,
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
    @required this.onEntityPressed,
    @required this.onAddTaskPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
  });

  factory ProjectViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final project = state.projectState.map[state.projectUIState.selectedId] ??
        ProjectEntity(id: state.projectUIState.selectedId);
    final client = state.clientState.map[project.clientId] ??
        ClientEntity(id: project.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProject(completer: completer, projectId: project.id));
      return completer.future;
    }

    return ProjectViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: project.isNew,
      project: project,
      client: client,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityPressed: (BuildContext context, EntityType entityType,
          {bool longPress = false}) {
        if (longPress && project.isActive && client.isActive) {
          handleProjectAction(
              context, [project], EntityAction.newEntityType(entityType));
        } else {
          viewEntitiesByType(
            appContext: context.getAppContext(),
            entityType: entityType,
            filterEntity: project,
          );
        }
      },
      onAddTaskPressed: (context) {
        createEntity(
            context: context,
            entity: TaskEntity(state: state).rebuild((b) => b
              ..projectId = project.id
              ..clientId = project.clientId),
            force: true);
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context.getAppContext(), [project], action,
              autoPop: true),
      onUploadDocument: (BuildContext context, MultipartFile multipartFile) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        store.dispatch(SaveProjectDocumentRequest(
            multipartFile: multipartFile,
            project: project,
            completer: completer));
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
        completer.future.then<Null>(
            (value) => store.dispatch(LoadProject(projectId: project.id)));
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
  final ProjectEntity project;
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onAddTaskPressed;
  final Function(BuildContext, EntityType, {bool longPress}) onEntityPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
  final Function(BuildContext, MultipartFile) onUploadDocument;
  final Function(BuildContext, DocumentEntity, String, String) onDeleteDocument;
}
