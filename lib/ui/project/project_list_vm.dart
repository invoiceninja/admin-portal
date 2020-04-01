import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_item.dart';
import 'package:invoiceninja_flutter/ui/project/project_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class ProjectListBuilder extends StatelessWidget {
  const ProjectListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProjectListVM>(
      converter: ProjectListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            isLoaded: viewModel.isLoaded,
            entityType: EntityType.project,
            presenter: ProjectPresenter(),
            state: viewModel.state,
            entityList: viewModel.projectList,
            onEntityTap: viewModel.onProjectTap,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final projectId = viewModel.projectList[index];
              final project = viewModel.projectMap[projectId];
              final client = viewModel.clientMap[project.clientId] ??
                  ClientEntity(id: project.clientId);
              final listState = state.getListState(EntityType.project);
              final isInMultiselect = listState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [project],
                    context: context,
                    client: client,
                  );

              return ProjectListItem(
                userCompany: viewModel.state.userCompany,
                filter: viewModel.filter,
                project: project,
                client: viewModel.clientMap[project.clientId] ?? ClientEntity(),
                onTap: () => viewModel.onProjectTap(context, project),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleProjectAction(context, [project], action);
                  }
                },
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleProjectAction(
                        context, [project], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked: isInMultiselect && listState.isSelected(project.id),
              );
            });
      },
    );
  }
}

class ProjectListVM {
  ProjectListVM({
    @required this.state,
    @required this.projectList,
    @required this.projectMap,
    @required this.clientMap,
    @required this.listState,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onProjectTap,
    @required this.onRefreshed,
    @required this.tableColumns,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static ProjectListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProjects(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ProjectListVM(
      state: state,
      listState: state.projectListState,
      projectList: memoizedFilteredProjectList(
          state.projectState.map,
          state.projectState.list,
          state.projectListState,
          state.clientState.map),
      projectMap: state.projectState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.projectState.isLoaded,
      filter: state.projectUIState.listUIState.filter,
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterProjectsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.projectListState.filterEntityId,
          entityType: state.projectListState.filterEntityType),
      onProjectTap: (context, project) {
        if (store.state.projectListState.isInMultiselect()) {
          handleProjectAction(
              context, [project], EntityAction.toggleMultiselect);
        } else {
          viewEntity(context: context, entity: project);
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: ProjectPresenter.getTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortProjects(field)),
    );
  }

  final AppState state;
  final List<String> projectList;
  final BuiltMap<String, ProjectEntity> projectMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, BaseEntity) onProjectTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
}
