import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/project/project_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';

class ProjectListBuilder extends StatelessWidget {
  const ProjectListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProjectListVM>(
      converter: ProjectListVM.fromStore,
      builder: (context, viewModel) {
        return ProjectList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class ProjectListVM {
  final UserEntity user;
  final List<int> projectList;
  final BuiltMap<int, ProjectEntity> projectMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ProjectEntity) onProjectTap;
  final Function(BuildContext, ProjectEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, ProjectEntity, EntityAction) onEntityAction;

  ProjectListVM({
    @required this.user,
    @required this.projectList,
    @required this.projectMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onProjectTap,
    @required this.onDismissed,
    @required this.onRefreshed,
    @required this.onEntityAction,
  });

  static ProjectListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProjects(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ProjectListVM(
        user: state.user,
        projectList: memoizedFilteredProjectList(state.projectState.map,
            state.projectState.list, state.projectListState),
        projectMap: state.projectState.map,
        isLoading: state.isLoading,
        isLoaded: state.projectState.isLoaded,
        filter: state.projectUIState.listUIState.filter,
        onProjectTap: (context, project) {
          store.dispatch(EditProject(project: project, context: context));
        },
        onEntityAction: (context, project, action) {
          switch (action) {
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(
                  EditProject(context: context, project: project.clone));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreProjectRequest(
                  popCompleter(
                      context, AppLocalization.of(context).restoredProject),
                  project.id));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveProjectRequest(
                  popCompleter(
                      context, AppLocalization.of(context).archivedProject),
                  project.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteProjectRequest(
                  popCompleter(
                      context, AppLocalization.of(context).deletedProject),
                  project.id));
              break;
          }
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, ProjectEntity project,
            DismissDirection direction) {
          final localization = AppLocalization.of(context);
          if (direction == DismissDirection.endToStart) {
            if (project.isDeleted || project.isArchived) {
              store.dispatch(RestoreProjectRequest(
                  snackBarCompleter(context, localization.restoredProject),
                  project.id));
            } else {
              store.dispatch(ArchiveProjectRequest(
                  snackBarCompleter(context, localization.archivedProject),
                  project.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (project.isDeleted) {
              store.dispatch(RestoreProjectRequest(
                  snackBarCompleter(context, localization.restoredProject),
                  project.id));
            } else {
              store.dispatch(DeleteProjectRequest(
                  snackBarCompleter(context, localization.deletedProject),
                  project.id));
            }
          }
        });
  }
}
