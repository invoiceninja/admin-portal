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
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class GroupListBuilder extends StatelessWidget {
  const GroupListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupListVM>(
      converter: GroupListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.group,
            //presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.groupList,
            //tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final groupId = viewModel.groupList[index];
              final group = viewModel.groupMap[groupId]!;
              final listState = state.getListState(EntityType.group);
              final isInMultiselect = listState.isInMultiselect();

              return GroupListItem(
                user: viewModel.userCompany!.user,
                filter: viewModel.filter,
                group: group,
                isChecked: isInMultiselect && listState.isSelected(group.id),
              );
            });
      },
    );
  }
}

class GroupListVM {
  GroupListVM({
    required this.state,
    required this.userCompany,
    required this.groupList,
    required this.groupMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static GroupListVM fromStore(Store<AppState> store) {
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

    return GroupListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.groupListState,
      groupList: memoizedFilteredGroupList(
          state.getUISelection(EntityType.group),
          state.groupState.map,
          state.groupState.list,
          state.groupListState),
      groupMap: state.groupState.map,
      isLoading: state.isLoading,
      filter: state.groupUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortGroups(field)),
      onClearMultielsect: () => store.dispatch(ClearGroupMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> groupList;
  final BuiltMap<String, GroupEntity> groupMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
