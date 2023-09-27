import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_selectors.dart';
import 'package:redux/redux.dart';

import 'schedule_screen.dart';

class ScheduleScreenBuilder extends StatelessWidget {
  const ScheduleScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ScheduleScreenVM>(
      converter: ScheduleScreenVM.fromStore,
      builder: (context, vm) {
        return ScheduleScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ScheduleScreenVM {
  ScheduleScreenVM({
    required this.isInMultiselect,
    required this.scheduleList,
    required this.userCompany,
    required this.onEntityAction,
    required this.scheduleMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> scheduleList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, ScheduleEntity> scheduleMap;

  static ScheduleScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ScheduleScreenVM(
      scheduleMap: state.scheduleState.map,
      scheduleList: memoizedFilteredScheduleList(
        state.getUISelection(EntityType.schedule),
        state.scheduleState.map,
        state.scheduleState.list,
        state.scheduleListState,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.scheduleListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> schedules,
              EntityAction action) =>
          handleScheduleAction(context, schedules, action),
    );
  }
}
