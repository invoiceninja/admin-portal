import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class GroupListBuilder extends StatelessWidget {
  const GroupListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupListVM>(
      converter: GroupListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            isLoaded: viewModel.isLoaded,
            entityType: EntityType.group,
            //presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.groupList,
            onEntityTap: viewModel.onGroupTap,
            //tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final groupId = viewModel.groupList[index];
              final group = viewModel.groupMap[groupId];
              final listState = state.getListState(EntityType.group);
              final isInMultiselect = listState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [group],
                    context: context,
                  );

              return GroupListItem(
                user: viewModel.userCompany.user,
                filter: viewModel.filter,
                group: group,
                onTap: () => viewModel.onGroupTap(context, group),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleGroupAction(context, [group], action);
                  }
                },
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleGroupAction(
                        context, [group], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked: isInMultiselect && listState.isSelected(group.id),
              );
            });
      },
    );
  }
}

class GroupListVM {
  GroupListVM({
    @required this.state,
    @required this.userCompany,
    @required this.groupList,
    @required this.groupMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onGroupTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static GroupListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadGroups(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return GroupListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.groupListState,
      groupList: memoizedFilteredGroupList(
          state.groupState.map, state.groupState.list, state.groupListState),
      groupMap: state.groupState.map,
      isLoading: state.isLoading,
      isLoaded: state.groupState.isLoaded,
      filter: state.groupUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterGroupsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.groupListState.filterEntityId,
          entityType: state.groupListState.filterEntityType),
      onGroupTap: (context, group) {
        if (store.state.groupListState.isInMultiselect()) {
          handleGroupAction(context, [group], EntityAction.toggleMultiselect);
        } else {
          viewEntity(context: context, entity: group);
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortGroups(field)),
    );
  }

  final AppState state;
  final UserCompanyEntity userCompany;
  final List<String> groupList;
  final BuiltMap<String, GroupEntity> groupMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, BaseEntity) onGroupTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final Function(String) onSortColumn;
}
