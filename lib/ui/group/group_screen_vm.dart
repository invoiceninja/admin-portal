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
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_selectors.dart';
import 'group_screen.dart';

class GroupScreenBuilder extends StatelessWidget {
  const GroupScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupScreenVM>(
      converter: GroupScreenVM.fromStore,
      builder: (context, vm) {
        return GroupSettingsScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class GroupScreenVM {
  GroupScreenVM({
    required this.isInMultiselect,
    required this.groupList,
    required this.userCompany,
    required this.groupMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> groupList;
  final BuiltMap<String, GroupEntity> groupMap;

  static GroupScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return GroupScreenVM(
      groupMap: state.groupState.map,
      groupList: memoizedFilteredGroupList(
          state.getUISelection(EntityType.group),
          state.groupState.map,
          state.groupState.list,
          state.groupListState),
      userCompany: state.userCompany,
      isInMultiselect: state.groupListState.isInMultiselect(),
    );
  }
}
