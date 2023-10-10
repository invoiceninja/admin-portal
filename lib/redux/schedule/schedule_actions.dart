import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';

class ViewScheduleList implements PersistUI {
  ViewScheduleList({this.force = false});

  final bool force;
}

class ViewSchedule implements PersistUI, PersistPrefs {
  ViewSchedule({
    required this.scheduleId,
    this.force = false,
  });

  final String? scheduleId;
  final bool force;
}

class EditSchedule implements PersistUI, PersistPrefs {
  EditSchedule(
      {required this.schedule,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final ScheduleEntity schedule;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateSchedule implements PersistUI {
  UpdateSchedule(this.schedule);

  final ScheduleEntity schedule;
}

class LoadSchedule {
  LoadSchedule({this.completer, this.scheduleId});

  final Completer? completer;
  final String? scheduleId;
}

class LoadScheduleActivity {
  LoadScheduleActivity({this.completer, this.scheduleId});

  final Completer? completer;
  final String? scheduleId;
}

class LoadSchedules {
  LoadSchedules({this.completer});

  final Completer? completer;
}

class LoadScheduleRequest implements StartLoading {}

class LoadScheduleFailure implements StopLoading {
  LoadScheduleFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadScheduleFailure{error: $error}';
  }
}

class LoadScheduleSuccess implements StopLoading, PersistData {
  LoadScheduleSuccess(this.schedule);

  final ScheduleEntity schedule;

  @override
  String toString() {
    return 'LoadScheduleSuccess{schedule: $schedule}';
  }
}

class LoadSchedulesRequest implements StartLoading {}

class LoadSchedulesFailure implements StopLoading {
  LoadSchedulesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadSchedulesFailure{error: $error}';
  }
}

class LoadSchedulesSuccess implements StopLoading {
  LoadSchedulesSuccess(this.schedules);

  final BuiltList<ScheduleEntity> schedules;

  @override
  String toString() {
    return 'LoadSchedulesSuccess{schedules: $schedules}';
  }
}

class SaveScheduleRequest implements StartSaving {
  SaveScheduleRequest({this.completer, this.schedule});

  final Completer? completer;
  final ScheduleEntity? schedule;
}

class SaveScheduleSuccess implements StopSaving, PersistData, PersistUI {
  SaveScheduleSuccess(this.schedule);

  final ScheduleEntity schedule;
}

class AddScheduleSuccess implements StopSaving, PersistData, PersistUI {
  AddScheduleSuccess(this.schedule);

  final ScheduleEntity schedule;
}

class SaveScheduleFailure implements StopSaving {
  SaveScheduleFailure(this.error);

  final Object error;
}

class ArchiveSchedulesRequest implements StartSaving {
  ArchiveSchedulesRequest(this.completer, this.scheduleIds);

  final Completer completer;
  final List<String> scheduleIds;
}

class ArchiveSchedulesSuccess implements StopSaving, PersistData {
  ArchiveSchedulesSuccess(this.schedules);

  final List<ScheduleEntity> schedules;
}

class ArchiveSchedulesFailure implements StopSaving {
  ArchiveSchedulesFailure(this.schedules);

  final List<ScheduleEntity?> schedules;
}

class DeleteSchedulesRequest implements StartSaving {
  DeleteSchedulesRequest(this.completer, this.scheduleIds);

  final Completer completer;
  final List<String> scheduleIds;
}

class DeleteSchedulesSuccess implements StopSaving, PersistData {
  DeleteSchedulesSuccess(this.schedules);

  final List<ScheduleEntity> schedules;
}

class DeleteSchedulesFailure implements StopSaving {
  DeleteSchedulesFailure(this.schedules);

  final List<ScheduleEntity?> schedules;
}

class RestoreSchedulesRequest implements StartSaving {
  RestoreSchedulesRequest(this.completer, this.scheduleIds);

  final Completer completer;
  final List<String> scheduleIds;
}

class RestoreSchedulesSuccess implements StopSaving, PersistData {
  RestoreSchedulesSuccess(this.schedules);

  final List<ScheduleEntity> schedules;
}

class RestoreSchedulesFailure implements StopSaving {
  RestoreSchedulesFailure(this.schedules);

  final List<ScheduleEntity?> schedules;
}

class FilterSchedules implements PersistUI {
  FilterSchedules(this.filter);

  final String? filter;
}

class SortSchedules implements PersistUI, PersistPrefs {
  SortSchedules(this.field);

  final String field;
}

class FilterSchedulesByState implements PersistUI {
  FilterSchedulesByState(this.state);

  final EntityState state;
}

class FilterSchedulesByCustom1 implements PersistUI {
  FilterSchedulesByCustom1(this.value);

  final String value;
}

class FilterSchedulesByCustom2 implements PersistUI {
  FilterSchedulesByCustom2(this.value);

  final String value;
}

class FilterSchedulesByCustom3 implements PersistUI {
  FilterSchedulesByCustom3(this.value);

  final String value;
}

class FilterSchedulesByCustom4 implements PersistUI {
  FilterSchedulesByCustom4(this.value);

  final String value;
}

class StartScheduleMultiselect {
  StartScheduleMultiselect();
}

class AddToScheduleMultiselect {
  AddToScheduleMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromScheduleMultiselect {
  RemoveFromScheduleMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearScheduleMultiselect {
  ClearScheduleMultiselect();
}

class UpdateScheduleTab implements PersistUI {
  UpdateScheduleTab({this.tabIndex});

  final int? tabIndex;
}

void handleScheduleAction(
    BuildContext? context, List<BaseEntity> schedules, EntityAction? action) {
  if (schedules.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final localization = AppLocalization.of(context);
  final schedule = schedules.first as ScheduleEntity;
  final scheduleIds = schedules.map((schedule) => schedule.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: schedule);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreSchedulesRequest(
          snackBarCompleter<Null>(localization!.restoredSchedule),
          scheduleIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveSchedulesRequest(
          snackBarCompleter<Null>(localization!.archivedSchedule),
          scheduleIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteSchedulesRequest(
          snackBarCompleter<Null>(localization!.deletedSchedule), scheduleIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.scheduleListState.isInMultiselect()) {
        store.dispatch(StartScheduleMultiselect());
      }

      if (schedules.isEmpty) {
        break;
      }

      for (final schedule in schedules) {
        if (!store.state.scheduleListState.isSelected(schedule.id)) {
          store.dispatch(AddToScheduleMultiselect(entity: schedule));
        } else {
          store.dispatch(RemoveFromScheduleMultiselect(entity: schedule));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [schedule],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in schedule_actions');
      break;
  }
}
