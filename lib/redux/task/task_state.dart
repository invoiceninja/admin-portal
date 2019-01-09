import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'task_state.g.dart';

abstract class TaskState implements Built<TaskState, TaskStateBuilder> {

  factory TaskState() {
    return _$TaskState._(
      lastUpdated: 0,
      map: BuiltMap<int, TaskEntity>(),
      list: BuiltList<int>(),
    );
  }
  TaskState._();

  @nullable
  int get lastUpdated;

  BuiltMap<int, TaskEntity> get map;
  BuiltList<int> get list;

  bool get isStale {
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<TaskState> get serializer => _$taskStateSerializer;
}

abstract class TaskUIState extends Object with EntityUIState implements Built<TaskUIState, TaskUIStateBuilder> {

  factory TaskUIState() {
    return _$TaskUIState._(
      listUIState: ListUIState(TaskFields.updatedAt, sortAscending: false),
      editing: TaskEntity(),
      editingTime: TaskTime(),
      selectedId: 0,
    );
  }
  TaskUIState._();

  @nullable
  TaskEntity get editing;

  @nullable
  TaskTime get editingTime;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<TaskUIState> get serializer => _$taskUIStateSerializer;
}