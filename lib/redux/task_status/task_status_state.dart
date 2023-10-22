// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'task_status_state.g.dart';

abstract class TaskStatusState
    implements Built<TaskStatusState, TaskStatusStateBuilder> {
  factory TaskStatusState() {
    return _$TaskStatusState._(
      map: BuiltMap<String, TaskStatusEntity>(),
      list: BuiltList<String>(),
    );
  }

  TaskStatusState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, TaskStatusEntity> get map;

  TaskStatusEntity get(String statusId) {
    if (map.containsKey(statusId)) {
      return map[statusId]!;
    } else {
      return TaskStatusEntity(id: statusId);
    }
  }

  BuiltList<String> get list;

  TaskStatusState loadTaskStatuses(BuiltList<TaskStatusEntity> clients) {
    final map = Map<String, TaskStatusEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<TaskStatusState> get serializer =>
      _$taskStatusStateSerializer;
}

abstract class TaskStatusUIState extends Object
    with EntityUIState
    implements Built<TaskStatusUIState, TaskStatusUIStateBuilder> {
  factory TaskStatusUIState(PrefStateSortField? sortField) {
    return _$TaskStatusUIState._(
      listUIState: ListUIState(sortField?.field ?? TaskStatusFields.order,
          sortAscending: sortField?.ascending),
      editing: TaskStatusEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  TaskStatusUIState._();

  @override
  @memoized
  int get hashCode;

  TaskStatusEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<TaskStatusUIState> get serializer =>
      _$taskStatusUIStateSerializer;
}
