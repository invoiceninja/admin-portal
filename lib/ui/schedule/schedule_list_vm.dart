import 'dart:async';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/schedule/schedule_list_item.dart';
import 'package:invoiceninja_flutter/ui/schedule/schedule_presenter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';

class ScheduleListBuilder extends StatelessWidget {
  const ScheduleListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ScheduleListVM>(
      converter: ScheduleListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.schedule,
            presenter: SchedulePresenter(),
            state: viewModel.state,
            entityList: viewModel.scheduleList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final scheduleId = viewModel.scheduleList[index];
              final schedule = viewModel.scheduleMap[scheduleId]!;
              final listState = state.getListState(EntityType.schedule);
              final isInMultiselect = listState.isInMultiselect();

              return ScheduleListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                schedule: schedule,
                isChecked: isInMultiselect && listState.isSelected(schedule.id),
              );
            });
      },
    );
  }
}

class ScheduleListVM {
  ScheduleListVM({
    required this.state,
    required this.userCompany,
    required this.scheduleList,
    required this.scheduleMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static ScheduleListVM fromStore(Store<AppState> store) {
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

    return ScheduleListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.scheduleListState,
      scheduleList: memoizedFilteredScheduleList(
          state.getUISelection(EntityType.schedule),
          state.scheduleState.map,
          state.scheduleState.list,
          state.scheduleListState),
      scheduleMap: state.scheduleState.map,
      isLoading: state.isLoading,
      filter: state.scheduleUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> schedules,
              EntityAction action) =>
          handleScheduleAction(context, schedules, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.schedule) ??
              SchedulePresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortSchedules(field)),
      onClearMultielsect: () => store.dispatch(ClearScheduleMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> scheduleList;
  final BuiltMap<String, ScheduleEntity> scheduleMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
