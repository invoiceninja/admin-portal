import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'task_state.g.dart';

abstract class TaskState implements Built<TaskState, TaskStateBuilder> {
  factory TaskState() {
    return _$TaskState._(
      lastUpdated: 0,
      map: BuiltMap<String, TaskEntity>(),
      list: BuiltList<String>(),
    );
  }
  TaskState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, TaskEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  TaskState loadTasks(BuiltList<TaskEntity> clients) {
    final map = Map<String, TaskEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<TaskState> get serializer => _$taskStateSerializer;
}

abstract class TaskUIState extends Object
    with EntityUIState
    implements Built<TaskUIState, TaskUIStateBuilder> {
  factory TaskUIState() {
    return _$TaskUIState._(
      listUIState: ListUIState(TaskFields.updatedAt, sortAscending: false),
      editing: TaskEntity(),
      editingTime: TaskTime(),
      selectedId: '',
    );
  }
  TaskUIState._();

  @nullable
  TaskEntity get editing;

  @nullable
  TaskTime get editingTime;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<TaskUIState> get serializer => _$taskUIStateSerializer;
}
