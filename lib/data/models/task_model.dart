import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
  static const String invoiceId = 'invoice_id';
  static const String client = 'client';
  static const String clientId = 'client_id';
  static const String project = 'project';
  static const String projectId = 'project_id';
  static const String timeLog = 'time_log';
  static const String isRunning = 'is_running';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';

  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
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
  factory TaskEntity({String id, AppState state}) {
    final isRunning = state?.prefState?.autoStartTasks ?? false;
    return _$TaskEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
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
      customValue3: '',
      customValue4: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      assignedUserId: '',
      createdAt: 0,
      createdUserId: '',
      vendorId: '',
      taskStatusId: '',
      taskStatusSortOrder: 0,
    );
  }

  TaskEntity._();

  TaskEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
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

  bool get isInvoiced => invoiceId != null && invoiceId.isNotEmpty;

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
  String get invoiceId;

  @override
  @nullable
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @nullable
  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @BuiltValueField(wireName: 'time_log')
  String get timeLog;

  @BuiltValueField(wireName: 'is_running')
  bool get isRunning;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @nullable
  @BuiltValueField(wireName: 'task_status_id')
  String get taskStatusId;

  @nullable
  @BuiltValueField(wireName: 'task_status_sort_order')
  int get taskStatusSortOrder;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit && userCompany.canEditEntity(this) && !isDeleted) {
        actions.add(EntityAction.edit);
      }

      if (!isInvoiced) {
        if (isRunning) {
          actions.add(EntityAction.stop);
        } else {
          if (duration > 0) {
            actions.add(EntityAction.resume);
          } else {
            actions.add(EntityAction.start);
          }

          if (userCompany.canCreate(EntityType.invoice)) {
            actions.add(EntityAction.newInvoice);
          }
        }
      }
    }

    if (isInvoiced) {
      actions.add(EntityAction.viewInvoice);
    }

    if (userCompany.canCreate(EntityType.task)) {
      actions.add(EntityAction.clone);
    }

    actions.add(null);

    return actions..addAll(super.getActions(userCompany: userCompany));
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
    } else if (customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue3.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue4.toLowerCase().contains(filter)) {
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
    } else if (customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    } else if (customValue3.toLowerCase().contains(filter)) {
      return customValue3;
    } else if (customValue4.toLowerCase().contains(filter)) {
      return customValue4;
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
      id: '',
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
