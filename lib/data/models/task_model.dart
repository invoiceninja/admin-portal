import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
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
      startDate: startDate ??
          DateTime.fromMillisecondsSinceEpoch(
              (DateTime.now().millisecondsSinceEpoch / 1000).floor() * 1000,
              isUtc: true),
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

  Map<String, Duration> getParts(int timezoneOffset) {
    final localStartDate = startDate.toLocal();
    final localEndDate = (endDate ?? DateTime.now()).toLocal();
    final startSqlDate = convertDateTimeToSqlDate(localStartDate);
    final endSqlDate = convertDateTimeToSqlDate(localEndDate);

    if (startSqlDate == endSqlDate) {
      return {startSqlDate: duration};
    }

    int offset = 1;
    DateTime nextDate;
    final Map<String, Duration> dates = {
      startSqlDate: DateTime(
              localStartDate.year, localStartDate.month, localStartDate.day)
          .add(Duration(days: offset))
          .difference(localStartDate)
    };

    do {
      nextDate = DateTime(
              localStartDate.year, localStartDate.month, localStartDate.day)
          .add(Duration(days: offset));
      offset++;

      Duration duration = localEndDate.difference(nextDate);
      if (duration.inHours > 24) {
        duration = Duration(hours: 24);
      }

      dates[convertDateTimeToSqlDate(nextDate)] = duration;
    } while (nextDate.isBefore(localEndDate.subtract(Duration(days: 1))));

    return dates;
  }

  static Serializer<TaskTime> get serializer => _$taskTimeSerializer;
}

abstract class TaskEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<TaskEntity, TaskEntityBuilder> {
  factory TaskEntity({int id, bool isRunning = false}) {
    return _$TaskEntity._(
      id: id ?? --TaskEntity.counter,
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

  TaskEntity get clone => rebuild((b) => b
    ..id = --TaskEntity.counter
    ..isDeleted = false
    ..invoiceId = null
    ..isRunning = false
    ..duration = 0
    ..timeLog = '[]'
    ..description = '');

  TaskEntity toggle() => isRunning ? stop() : start();

  TaskEntity start() => addTaskTime(TaskTime());

  TaskEntity stop() {
    final times = taskTimes;
    final taskTime = times.last.stop;

    return updateTaskTime(taskTime, times.length - 1);
  }

  bool get isInvoiced => invoiceId != null && invoiceId > 0;

  @override
  EntityType get entityType {
    return EntityType.task;
  }

  String get description;

  int get duration;

  bool get areTimesValid {
    final times = taskTimes;
    DateTime lastDateTime = DateTime(2000);
    int countRunning = 0;
    bool isValid = true;

    times.forEach((time) {
      final startDate = time.startDate;
      final endDate = time.endDate;

      if (time.isRunning) {
        countRunning++;
      } else {
        if (startDate.isBefore(lastDateTime) || startDate.isAfter(endDate)) {
          isValid = false;
        }
        if (endDate.isBefore(startDate) || endDate.isBefore(lastDateTime)) {
          isValid = false;
        }
        lastDateTime = lastDateTime.isAfter(endDate) ? lastDateTime : endDate;
      }
    });

    return isValid && countRunning <= 1;
  }

  bool isBetween(String startDate, String endDate) {
    final times = taskTimes;
    if (times.isEmpty) {
      return false;
    }
    final firstEndDate = times.first.endDate ?? DateTime.now();
    final lastEndDate = times.first.endDate ?? DateTime.now();
    return DateTime.parse(startDate).compareTo(firstEndDate.toLocal()) <= 0 &&
        DateTime.parse(endDate).compareTo(lastEndDate.toLocal()) == 1;
  }

  List<TaskTime> get taskTimes {
    final List<TaskTime> details = [];

    if (timeLog.isEmpty) {
      return details;
    }

    final List<dynamic> log = jsonDecode(timeLog);
    log.forEach((dynamic detail) {
      int startDate;
      int endDate;

      if ((detail as List)[0] == false || (detail as List)[0] == null) {
        startDate = 0;
      } else {
        startDate = ((detail as List)[0]).round();
      }

      if (startDate > 0) {
        if ((detail as List)[1] == false || (detail as List)[1] == null) {
          endDate = 0;
        } else {
          endDate = ((detail as List)[1]).round();
        }

        final taskTime = TaskTime(
            startDate: convertTimestampToDate(startDate).toUtc(),
            endDate: (endDate ?? 0) > 0
                ? convertTimestampToDate(endDate).toUtc()
                : null);

        details.add(taskTime);
      }
    });

    details.sort((timeA, timeB) => timeA.startDate.compareTo(timeB.startDate));

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
      taskRate * round(calculateDuration.inSeconds / 3600, 3);

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

  @override
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

  @nullable
  @BuiltValueField(wireName: 'task_status_id')
  int get taskStatusId;

  @nullable
  @BuiltValueField(wireName: 'task_status_sort_order')
  int get taskStatusSortOrder;

  List<EntityAction> getEntityActions(
      {UserEntity user, ClientEntity client, bool includeEdit = false}) {
    final actions = <EntityAction>[];

    if (includeEdit && user.canEditEntity(this)) {
      actions.add(EntityAction.edit);
    }

    if (isInvoiced) {
      actions.add(EntityAction.viewInvoice);
    } else {
      if (isRunning) {
        actions.add(EntityAction.stop);
      } else {
        actions.add(EntityAction.newInvoice);
        if (duration > 0) {
          actions.add(EntityAction.resume);
        } else {
          actions.add(EntityAction.start);
        }
      }
    }

    if (user.canCreate(EntityType.task)) {
      actions.add(EntityAction.clone);
    }

    actions.add(null);

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
  bool matchesStatuses(BuiltList<EntityStatus> statuses) {
    if (statuses.isEmpty) {
      return true;
    }

    for (final status in statuses) {
      if (status.id == kTaskStatusRunning && isRunning) {
        return true;
      } else if (status.id == kTaskStatusInvoiced && isInvoiced) {
        return true;
      } else if (status.id == kTaskStatusLogged && isStopped && !isInvoiced) {
        return true;
      }
    }

    return false;
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

  bool get isStopped => !isRunning;

  static Serializer<TaskEntity> get serializer => _$taskEntitySerializer;
}

abstract class TaskStatusEntity extends Object
    with EntityStatus, SelectableEntity
    implements Built<TaskStatusEntity, TaskStatusEntityBuilder> {
  factory TaskStatusEntity() {
    return _$TaskStatusEntity._(
      id: 0,
      name: '',
      sortOrder: 0,
    );
  }

  TaskStatusEntity._();

  @BuiltValueField(wireName: 'sort_order')
  int get sortOrder;

  @override
  String get listDisplayName => name;

  static Serializer<TaskStatusEntity> get serializer =>
      _$taskStatusEntitySerializer;
}
