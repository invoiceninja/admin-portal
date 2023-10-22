// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'task_state.g.dart';

abstract class TaskState implements Built<TaskState, TaskStateBuilder> {
  factory TaskState() {
    return _$TaskState._(
      map: BuiltMap<String, TaskEntity>(),
      list: BuiltList<String>(),
    );
  }

  TaskState._();

  @override
  @memoized
  int get hashCode;

  TaskEntity get(String taskId) {
    if (map.containsKey(taskId)) {
      return map[taskId]!;
    } else {
      return TaskEntity(id: taskId);
    }
  }

  BuiltMap<String, TaskEntity> get map;

  BuiltList<String> get list;

  TaskState loadTasks(BuiltList<TaskEntity> clients) {
    final map = Map<String, TaskEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<TaskState> get serializer => _$taskStateSerializer;
}

abstract class TaskUIState extends Object
    with EntityUIState
    implements Built<TaskUIState, TaskUIStateBuilder> {
  factory TaskUIState(PrefStateSortField? sortField) {
    return _$TaskUIState._(
      listUIState: ListUIState(sortField?.field ?? TaskFields.number,
          sortAscending: sortField?.ascending ?? false),
      editing: TaskEntity(),
      selectedId: '',
      tabIndex: 0,
      kanbanLastUpdated: 0,
    );
  }

  TaskUIState._();

  @override
  @memoized
  int get hashCode;

  TaskEntity? get editing;

  @BuiltValueField(serialize: false)
  int? get editingTimeIndex;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  int? get kanbanLastUpdated;

  static Serializer<TaskUIState> get serializer => _$taskUIStateSerializer;
}
