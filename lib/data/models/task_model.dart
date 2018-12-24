import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
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

abstract class TaskTime implements Built<TaskTime, TaskTimeBuilder> {
  factory TaskTime({DateTime startDate, DateTime endDate}) {
    return _$TaskTime._(
      startDate: startDate ?? DateTime.now().toUtc(),
      endDate: endDate,
    );
  }

  TaskTime._();

  DateTime get startDate;

  @nullable
  DateTime get endDate;

  Duration get duration => (endDate ?? DateTime.now()).difference(startDate);

  List<dynamic> get asList => <dynamic>[
        (startDate.millisecondsSinceEpoch / 1000).floor(),
        endDate != null ? (endDate.millisecondsSinceEpoch / 1000).floor() : 0
      ];

  TaskTime get stop => rebuild((b) => b..endDate = DateTime.now().toUtc());

  bool equalTo(TaskTime taskTime) =>
      startDate == taskTime.startDate && endDate == taskTime.endDate;

  bool get isRunning => endDate == null;

  static Serializer<TaskTime> get serializer => _$taskTimeSerializer;
}

abstract class TaskEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<TaskEntity, TaskEntityBuilder> {
  factory TaskEntity({bool isRunning = false}) {
    return _$TaskEntity._(
      id: --TaskEntity.counter,
      description: '',
      duration: 0,
      invoiceId: null,
      clientId: null,
      projectId: null,
      timeLog: isRunning
          ? '[[${(DateTime.now().millisecondsSinceEpoch / 1000).floor()},0]]'
          : '[]',
      isRunning: isRunning,
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

  TaskEntity toggle() => isRunning ? stop() : start();

  TaskEntity start() => addTaskTime(TaskTime());

  TaskEntity stop() {
    final times = taskTimes;
    final taskTime = times.last.stop;

    return updateTaskTime(taskTime, times.length - 1);
  }

  bool get isPaid => invoiceId != null && invoiceId > 0;

  @override
  EntityType get entityType {
    return EntityType.task;
  }

  String get description;

  int get duration;

  List<TaskTime> get taskTimes {
    final List<TaskTime> details = [];

    if (timeLog.isEmpty) {
      return details;
    }

    final List<dynamic> log = jsonDecode(timeLog);
    log.forEach((dynamic detail) {
      final int startDate = (detail as List)[0];
      final int endDate = (detail as List)[1];

      final taskTime = TaskTime(
          startDate: convertTimestampToDate(startDate).toUtc(),
          endDate:
              endDate > 0 ? convertTimestampToDate(endDate).toUtc() : null);

      details.add(taskTime);
    });

    return details;
  }

  TaskEntity addTaskTime(TaskTime time) {
    final List<dynamic> taskTimes =
        timeLog.isNotEmpty ? jsonDecode(timeLog) : <dynamic>[];

    taskTimes.add(time.asList);

    return rebuild((b) => b
      ..timeLog = jsonEncode(taskTimes)
      ..isRunning = time.isRunning);
  }

  TaskEntity updateTaskTime(TaskTime time, int index) {
    final List<dynamic> taskTimes =
        timeLog.isNotEmpty ? jsonDecode(timeLog) : <dynamic>[];

    taskTimes[index] = time.asList;

    bool isRunning = false;
    if (taskTimes.isNotEmpty) {
      final last = taskTimes.last as List;
      if (last.length == 1 || (last.length == 2 && last[1] == 0)) {
        isRunning = true;
      }
    }

    return rebuild((b) => b
      ..timeLog = jsonEncode(taskTimes)
      ..isRunning = isRunning);
  }

  TaskEntity deleteTaskTime(int index) {
    final List<dynamic> taskTimes =
        timeLog.isNotEmpty ? jsonDecode(timeLog) : <dynamic>[];

    taskTimes.removeAt(index);

    bool isRunning = false;
    if (taskTimes.isNotEmpty) {
      final last = taskTimes.last as List;
      if (last.length == 1 || (last.length == 2 && last[1] == 0)) {
        isRunning = true;
      }
    }

    return rebuild((b) => b
      ..timeLog = jsonEncode(taskTimes)
      ..isRunning = isRunning);
  }

  double calculateAmount(double taskRate) =>
      taskRate * calculateDuration.inSeconds / 3600;

  Duration get calculateDuration {
    int seconds = 0;

    taskTimes.forEach((taskTime) {
      seconds += taskTime.duration.inSeconds;
    });

    return Duration(seconds: seconds);
  }

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @nullable
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

  List<EntityAction> getEntityActions({UserEntity user, ClientEntity client}) {
    final actions = <EntityAction>[];

    return actions..addAll(getBaseActions(user: user));
  }

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
  double get listDisplayAmount => calculateDuration.inSeconds.toDouble();

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.duration;

  static Serializer<TaskEntity> get serializer => _$taskEntitySerializer;
}
