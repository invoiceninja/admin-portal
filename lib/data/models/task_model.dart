import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'task_model.g.dart';

abstract class TaskListResponse
    implements Built<TaskListResponse, TaskListResponseBuilder> {
  factory TaskListResponse([void updates(TaskListResponseBuilder b)]) =
      _$TaskListResponse;

  TaskListResponse._();

  BuiltList<TaskEntity> get data;

  static Serializer<TaskListResponse> get serializer =>
      _$taskListResponseSerializer;
}

abstract class TaskItemResponse
    implements Built<TaskItemResponse, TaskItemResponseBuilder> {
  factory TaskItemResponse([void updates(TaskItemResponseBuilder b)]) =
      _$TaskItemResponse;

  TaskItemResponse._();

  TaskEntity get data;

  static Serializer<TaskItemResponse> get serializer =>
      _$taskItemResponseSerializer;
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

abstract class TaskEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<TaskEntity, TaskEntityBuilder> {
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

  TaskEntity._();

  static int counter = 0;

  TaskEntity get clone => rebuild((b) => b..id = --TaskEntity.counter);

  @override
  EntityType get entityType {
    return EntityType.task;
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
    final TaskEntity taskA = sortAscending ? this : task;
    final TaskEntity taskB = sortAscending ? task : this;

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
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    return description.toLowerCase().contains(filter);
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return description;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<TaskEntity> get serializer => _$taskEntitySerializer;
}
