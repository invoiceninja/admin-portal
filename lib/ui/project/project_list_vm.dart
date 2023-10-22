// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_item.dart';
import 'package:invoiceninja_flutter/ui/project/project_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectListBuilder extends StatelessWidget {
  const ProjectListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProjectListVM>(
      converter: ProjectListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.project,
            presenter: ProjectPresenter(),
            state: viewModel.state,
            entityList: viewModel.projectList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final projectId = viewModel.projectList[index];
              final project = viewModel.projectMap[projectId]!;
              final listState = state.getListState(EntityType.project);
              final isInMultiselect = listState.isInMultiselect();

              return ProjectListItem(
                user: state.user,
                filter: viewModel.filter,
                project: project,
                isChecked: isInMultiselect && listState.isSelected(project.id),
              );
            });
      },
    );
  }
}

class ProjectListVM {
  ProjectListVM({
    required this.state,
    required this.projectList,
    required this.projectMap,
    required this.clientMap,
    required this.listState,
    required this.filter,
    required this.isLoading,
    required this.onRefreshed,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static ProjectListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return ProjectListVM(
      state: state,
      listState: state.projectListState,
      projectList: memoizedFilteredProjectList(
        state.getUISelection(EntityType.project),
        state.projectState.map,
        state.projectState.list,
        state.projectListState,
        state.clientState.map,
        state.userState.map,
      ),
      projectMap: state.projectState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.projectUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.project) ??
              ProjectPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortProjects(field)),
      onClearMultielsect: () => store.dispatch(ClearProjectMultiselect()),
    );
  }

  final AppState state;
  final List<String> projectList;
  final BuiltMap<String, ProjectEntity> projectMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
