import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_state.dart';

EntityUIState scheduleUIReducer(ScheduleUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(scheduleListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewSchedule>((completer, action) => true),
  TypedReducer<bool?, ViewScheduleList>((completer, action) => false),
  TypedReducer<bool?, FilterSchedulesByState>((completer, action) => false),
  TypedReducer<bool?, FilterSchedules>((completer, action) => false),
  TypedReducer<bool?, FilterSchedulesByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterSchedulesByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterSchedulesByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterSchedulesByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateScheduleTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveSchedulesSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteSchedulesSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.schedule ? action.entityId : selectedId),
  TypedReducer<String?, ViewSchedule>(
      (String? selectedId, dynamic action) => action.scheduleId),
  TypedReducer<String?, AddScheduleSuccess>(
      (String? selectedId, dynamic action) => action.schedule.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortSchedules>((selectedId, action) => ''),
  TypedReducer<String?, FilterSchedules>((selectedId, action) => ''),
  TypedReducer<String?, FilterSchedulesByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterSchedulesByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterSchedulesByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterSchedulesByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterSchedulesByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.schedule
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<ScheduleEntity?>([
  TypedReducer<ScheduleEntity?, SaveScheduleSuccess>(_updateEditing),
  TypedReducer<ScheduleEntity?, AddScheduleSuccess>(_updateEditing),
  TypedReducer<ScheduleEntity?, RestoreSchedulesSuccess>((schedules, action) {
    return action.schedules[0];
  }),
  TypedReducer<ScheduleEntity?, ArchiveSchedulesSuccess>((schedules, action) {
    return action.schedules[0];
  }),
  TypedReducer<ScheduleEntity?, DeleteSchedulesSuccess>((schedules, action) {
    return action.schedules[0];
  }),
  TypedReducer<ScheduleEntity?, EditSchedule>(_updateEditing),
  TypedReducer<ScheduleEntity?, UpdateSchedule>((schedule, action) {
    return action.schedule.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ScheduleEntity?, DiscardChanges>(_clearEditing),
]);

ScheduleEntity _clearEditing(ScheduleEntity? schedule, dynamic action) {
  return ScheduleEntity(ScheduleEntity.TEMPLATE_EMAIL_STATEMENT);
}

ScheduleEntity? _updateEditing(ScheduleEntity? schedule, dynamic action) {
  return action.schedule;
}

final scheduleListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortSchedules>(_sortSchedules),
  TypedReducer<ListUIState, FilterSchedulesByState>(_filterSchedulesByState),
  TypedReducer<ListUIState, FilterSchedules>(_filterSchedules),
  TypedReducer<ListUIState, FilterSchedulesByCustom1>(
      _filterSchedulesByCustom1),
  TypedReducer<ListUIState, FilterSchedulesByCustom2>(
      _filterSchedulesByCustom2),
  TypedReducer<ListUIState, StartScheduleMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToScheduleMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromScheduleMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearScheduleMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewScheduleList>(_viewScheduleList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewScheduleList(
    ListUIState scheduleListState, ViewScheduleList action) {
  return scheduleListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterSchedulesByCustom1(
    ListUIState scheduleListState, FilterSchedulesByCustom1 action) {
  if (scheduleListState.custom1Filters.contains(action.value)) {
    return scheduleListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return scheduleListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterSchedulesByCustom2(
    ListUIState scheduleListState, FilterSchedulesByCustom2 action) {
  if (scheduleListState.custom2Filters.contains(action.value)) {
    return scheduleListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return scheduleListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterSchedulesByState(
    ListUIState scheduleListState, FilterSchedulesByState action) {
  if (scheduleListState.stateFilters.contains(action.state)) {
    return scheduleListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return scheduleListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterSchedules(
    ListUIState scheduleListState, FilterSchedules action) {
  return scheduleListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : scheduleListState.filterClearedAt);
}

ListUIState _sortSchedules(
    ListUIState scheduleListState, SortSchedules action) {
  return scheduleListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartScheduleMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToScheduleMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromScheduleMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearScheduleMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final schedulesReducer = combineReducers<ScheduleState>([
  TypedReducer<ScheduleState, SaveScheduleSuccess>(_updateSchedule),
  TypedReducer<ScheduleState, AddScheduleSuccess>(_addSchedule),
  TypedReducer<ScheduleState, LoadSchedulesSuccess>(_setLoadedSchedules),
  TypedReducer<ScheduleState, LoadScheduleSuccess>(_setLoadedSchedule),
  TypedReducer<ScheduleState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<ScheduleState, ArchiveSchedulesSuccess>(_archiveScheduleSuccess),
  TypedReducer<ScheduleState, DeleteSchedulesSuccess>(_deleteScheduleSuccess),
  TypedReducer<ScheduleState, RestoreSchedulesSuccess>(_restoreScheduleSuccess),
]);

ScheduleState _archiveScheduleSuccess(
    ScheduleState scheduleState, ArchiveSchedulesSuccess action) {
  return scheduleState.rebuild((b) {
    for (final schedule in action.schedules) {
      b.map[schedule.id] = schedule;
    }
  });
}

ScheduleState _deleteScheduleSuccess(
    ScheduleState scheduleState, DeleteSchedulesSuccess action) {
  return scheduleState.rebuild((b) {
    for (final schedule in action.schedules) {
      b.map[schedule.id] = schedule;
    }
  });
}

ScheduleState _restoreScheduleSuccess(
    ScheduleState scheduleState, RestoreSchedulesSuccess action) {
  return scheduleState.rebuild((b) {
    for (final schedule in action.schedules) {
      b.map[schedule.id] = schedule;
    }
  });
}

ScheduleState _addSchedule(
    ScheduleState scheduleState, AddScheduleSuccess action) {
  return scheduleState.rebuild((b) => b
    ..map[action.schedule.id] = action.schedule
    ..list.add(action.schedule.id));
}

ScheduleState _updateSchedule(
    ScheduleState scheduleState, SaveScheduleSuccess action) {
  return scheduleState
      .rebuild((b) => b..map[action.schedule.id] = action.schedule);
}

ScheduleState _setLoadedSchedule(
    ScheduleState scheduleState, LoadScheduleSuccess action) {
  return scheduleState
      .rebuild((b) => b..map[action.schedule.id] = action.schedule);
}

ScheduleState _setLoadedSchedules(
        ScheduleState scheduleState, LoadSchedulesSuccess action) =>
    scheduleState.loadSchedules(action.schedules);

ScheduleState _setLoadedCompany(
    ScheduleState scheduleState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return scheduleState.loadSchedules(company.schedules);
}
