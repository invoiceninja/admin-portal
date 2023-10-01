import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'schedule_state.g.dart';

abstract class ScheduleState
    implements Built<ScheduleState, ScheduleStateBuilder> {
  factory ScheduleState() {
    return _$ScheduleState._(
      map: BuiltMap<String, ScheduleEntity>(),
      list: BuiltList<String>(),
    );
  }
  ScheduleState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, ScheduleEntity> get map;
  BuiltList<String> get list;

  ScheduleEntity get(String scheduleId) {
    if (map.containsKey(scheduleId)) {
      return map[scheduleId]!;
    } else {
      return ScheduleEntity(ScheduleEntity.TEMPLATE_EMAIL_STATEMENT,
          id: scheduleId);
    }
  }

  ScheduleState loadSchedules(BuiltList<ScheduleEntity> clients) {
    final map = Map<String, ScheduleEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<ScheduleState> get serializer => _$scheduleStateSerializer;
}

abstract class ScheduleUIState extends Object
    with EntityUIState
    implements Built<ScheduleUIState, ScheduleUIStateBuilder> {
  factory ScheduleUIState(PrefStateSortField? sortField) {
    return _$ScheduleUIState._(
      listUIState: ListUIState(sortField?.field ?? ScheduleFields.nextRun,
          sortAscending: sortField?.ascending),
      editing: ScheduleEntity(ScheduleEntity.TEMPLATE_EMAIL_STATEMENT),
      selectedId: '',
      tabIndex: 0,
    );
  }
  ScheduleUIState._();

  @override
  @memoized
  int get hashCode;

  ScheduleEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<ScheduleUIState> get serializer =>
      _$scheduleUIStateSerializer;
}
