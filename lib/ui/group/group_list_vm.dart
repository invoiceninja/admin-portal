import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/group/group_list.dart';
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
        return GroupList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class GroupListVM {
  GroupListVM({
    @required this.userCompany,
    @required this.groupList,
    @required this.groupMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onGroupTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  static GroupListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadGroups(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return GroupListVM(
      userCompany: state.userCompany,
      listState: state.groupListState,
      groupList: memoizedFilteredGroupList(
          state.groupState.map, state.groupState.list, state.groupListState),
      groupMap: state.groupState.map,
      isLoading: state.isLoading,
      isLoaded: state.groupState.isLoaded,
      filter: state.groupUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterGroupsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => store.dispatch(
          ViewClient(
              clientId: state.groupListState.filterEntityId, context: context)),
      onGroupTap: (context, group) {
        store.dispatch(ViewGroup(groupId: group.id, context: context));
      },
      onEntityAction: (BuildContext context, List<BaseEntity> groups,
              EntityAction action) =>
          handleGroupAction(context, groups, action),
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final UserCompanyEntity userCompany;
  final List<String> groupList;
  final BuiltMap<String, GroupEntity> groupMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, GroupEntity) onGroupTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
