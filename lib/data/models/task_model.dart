import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'task_model.g.dart';

abstract class TaskListResponse implements Built<TaskListResponse, TaskListResponseBuilder> {

  BuiltList<TaskEntity> get data;

  TaskListResponse._();
  factory TaskListResponse([void updates(TaskListResponseBuilder b)]) = _$TaskListResponse;
  static Serializer<TaskListResponse> get serializer => _$taskListResponseSerializer;
}

abstract class TaskItemResponse implements Built<TaskItemResponse, TaskItemResponseBuilder> {

  TaskEntity get data;

  TaskItemResponse._();
  factory TaskItemResponse([void updates(TaskItemResponseBuilder b)]) = _$TaskItemResponse;
  static Serializer<TaskItemResponse> get serializer => _$taskItemResponseSerializer;
}

class TaskFields {
  static const String description = 'description';
  static const String duration = 'duration';
  static const String invoiceId = 'invoiceId';
  static const String clientId = 'clientId';
  static const String projectId = 'projectId';
  static const String timeLog = 'timeLog';
  static const String isRunning = 'isRunning';
  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';
  
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class TaskEntity extends Object with BaseEntity implements Built<TaskEntity, TaskEntityBuilder> {

  @override
  EntityType get entityType {
    return EntityType.task;
  }

  static int counter = 0;
  factory TaskEntity() {
    return _$TaskEntity._(
        id: --TaskEntity.counter,
        description: '',
        duration: 0,
        invoiceId: 0,
        clientId: 0,
        projectId: 0,
        timeLog: '',
        isRunning: false,
        customValue1: '',
        customValue2: '',
        
        updatedAt: 0,
        archivedAt: 0,
        isDeleted: false,
    );
  }

  String get description;

  int get duration;

  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;
  
  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @BuiltValueField(wireName: 'project_id')
  int get projectId;

  @BuiltValueField(wireName: 'time_log')
  String get timeLog;

  @BuiltValueField(wireName: 'is_running')
  bool get isRunning;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  int compareTo(TaskEntity task, String sortField, bool sortAscending) {
    int response = 0;
    TaskEntity taskA = sortAscending ? this : task;
    TaskEntity taskB = sortAscending ? task: this;

    switch (sortField) {
      case TaskFields.duration:
        response = taskA.clientId.compareTo(taskB.clientId);
    }

    if (response == 0) {
      return taskA.projectId.compareTo(taskB.projectId);
    } else {
      return response;
    }
  }

  @override
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return description.contains(search);
  }

  TaskEntity._();
  static Serializer<TaskEntity> get serializer => _$taskEntitySerializer;
}
