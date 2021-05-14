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
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'task_model.g.dart';

abstract class TaskListResponse
    implements Built<TaskListResponse, TaskListResponseBuilder> {
  factory TaskListResponse([void updates(TaskListResponseBuilder b)]) =
      _$TaskListResponse;

  TaskListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TaskEntity> get data;

  static Serializer<TaskListResponse> get serializer =>
      _$taskListResponseSerializer;
}

abstract class TaskItemResponse
    implements Built<TaskItemResponse, TaskItemResponseBuilder> {
  factory TaskItemResponse([void updates(TaskItemResponseBuilder b)]) =
      _$TaskItemResponse;

  TaskItemResponse._();

  @override
  @memoized
  int get hashCode;

  TaskEntity get data;

  static Serializer<TaskItemResponse> get serializer =>
      _$taskItemResponseSerializer;
}

class TaskFields {
  static const String number = 'number';
  static const String rate = 'rate';
  static const String calculatedRate = 'calculated_rate';
  static const String description = 'description';
  static const String duration = 'duration';
  static const String invoiceId = 'invoice_id';
  static const String invoice = 'invoice';
  static const String client = 'client';
  static const String clientId = 'client_id';
  static const String project = 'project';
  static const String projectId = 'project_id';
  static const String timeLog = 'time_log';
  static const String isRunning = 'is_running';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String documents = 'documents';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String status = 'status';
  static const String isInvoiced = 'is_invoiced';
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

  @override
  @memoized
  int get hashCode;

  @nullable
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

  bool get isEmpty => startDate == null && endDate == null;

  Map<String, Duration> getParts() {
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

  TaskTime copyWithStartDate(String date, {bool syncDates = false}) {
    if ((date ?? '').isEmpty) {
      return this;
    }

    final dateTime = DateTime.parse(date);
    final now = DateTime.now();

    return TaskTime(
      startDate: DateTime(
        dateTime.toLocal()?.year,
        dateTime.toLocal()?.month,
        dateTime.toLocal()?.day,
        startDate?.toLocal()?.hour ?? now.hour,
        startDate?.toLocal()?.minute ?? now.minute,
        startDate?.toLocal()?.second ?? now.second,
      ).toUtc(),
      endDate: syncDates && endDate != null
          ? DateTime(
              dateTime.toLocal()?.year,
              dateTime.toLocal()?.month,
              dateTime.toLocal()?.day,
              endDate.toLocal().hour,
              endDate.toLocal().minute,
              endDate.toLocal().second,
            )
          : endDate,
    );
  }

  TaskTime copyWithEndDate(String date) {
    if ((date ?? '').isEmpty) {
      return this;
    }

    final dateTime = DateTime.parse(date);
    final now = DateTime.now();

    return TaskTime(
        startDate: startDate,
        endDate: DateTime(
          dateTime.toLocal()?.year,
          dateTime.toLocal()?.month,
          dateTime.toLocal()?.day,
          endDate?.toLocal()?.hour ?? now.hour,
          endDate?.toLocal()?.minute ?? now.minute,
          endDate?.toLocal()?.second ?? now.second,
        ).toUtc());
  }

  TaskTime copyWithStartTime(DateTime dateTime) {
    final now = DateTime.now();

    return TaskTime(
      startDate: DateTime(
        startDate?.toLocal()?.year ?? now.year,
        startDate?.toLocal()?.month ?? now.month,
        startDate?.toLocal()?.day ?? now.day,
        dateTime.toLocal().hour,
        dateTime.toLocal().minute,
        dateTime.toLocal().second,
      ).toUtc(),
      endDate: endDate,
    );
  }

  TaskTime copyWithEndTime(DateTime dateTime) {
    final now = DateTime.now();
    return TaskTime(
      startDate: startDate,
      endDate: DateTime(
        endDate?.toLocal()?.year ?? startDate?.toLocal()?.year ?? now.year,
        endDate?.toLocal()?.month ?? startDate?.toLocal()?.month ?? now.month,
        endDate?.toLocal()?.day ?? startDate?.toLocal()?.day ?? now.day,
        dateTime.toLocal().hour,
        dateTime.toLocal().minute,
        dateTime.toLocal().second,
      ).toUtc(),
    );
  }

  TaskTime copyWithDuration(Duration duration) {
    final start = startDate ?? DateTime.now().subtract(duration);
    return TaskTime(
      startDate: start,
      endDate: start.add(duration),
    );
  }

  static Serializer<TaskTime> get serializer => _$taskTimeSerializer;
}

abstract class TaskEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<TaskEntity, TaskEntityBuilder> {
  factory TaskEntity({
    String id,
    AppState state,
    ClientEntity client,
    UserEntity user,
    ProjectEntity project,
  }) {
    final isRunning = state?.company?.autoStartTasks ?? false;

    return _$TaskEntity._(
      id: id ?? BaseEntity.nextId,
      number: '',
      isChanged: false,
      description: '',
      duration: 0,
      rate: 0,
      invoiceId: '',
      clientId: project?.clientId ?? client?.id ?? '',
      projectId: project?.id ?? '',
      timeLog: isRunning
          ? '[[${(DateTime.now().millisecondsSinceEpoch / 1000).floor()},0]]'
          : '[]',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      assignedUserId: user?.id ?? '',
      createdAt: 0,
      createdUserId: '',
      statusId: defaultTaskStatusId(
          state?.taskStatusState?.map ?? BuiltMap<String, TaskStatusEntity>()),
      documents: BuiltList<DocumentEntity>(),
      showAsRunning: state?.company?.autoStartTasks ?? false,
    );
  }

  TaskEntity._();

  @override
  @memoized
  int get hashCode;

  TaskEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..number = ''
    ..isChanged = false
    ..isDeleted = false
    ..invoiceId = ''
    ..duration = 0
    ..documents.clear()
    ..timeLog = '[]');

  TaskEntity toggle() => isRunning ? stop() : start();

  TaskEntity start() => addTaskTime(TaskTime());

  TaskEntity stop() {
    final times = getTaskTimes();
    final taskTime = times.last.stop;

    return updateTaskTime(taskTime, times.length - 1);
  }

  bool get isInvoiced => invoiceId != null && invoiceId.isNotEmpty;

  @override
  EntityType get entityType {
    return EntityType.task;
  }

  String get description;

  String get number;

  int get duration;

  bool get areTimesValid {
    final times = getTaskTimes();
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

  bool get isRunning {
    final taskTimes = getTaskTimes();

    if (taskTimes.isEmpty) {
      return false;
    }

    return taskTimes.any((taskTime) => taskTime.isRunning);
  }

  bool isBetween(String startDate, String endDate) {
    final taskTimes = getTaskTimes();

    if (taskTimes.isEmpty) {
      return false;
    }

    final date = convertDateTimeToSqlDate(taskTimes.first.startDate.toLocal());

    return startDate.compareTo(date) <= 0 && endDate.compareTo(date) >= 0;
  }

  int get startTimestamp {
    if (timeLog.isEmpty) {
      return null;
    }

    final List<dynamic> log = jsonDecode(timeLog);

    if (log.isEmpty) {
      return null;
    }

    final first = log.first as List;

    return first[0];
  }

  int get endTimestamp {
    if (timeLog.isEmpty) {
      return null;
    }

    final List<dynamic> log = jsonDecode(timeLog);

    if (log.isEmpty) {
      return null;
    }

    final last = log.last as List;

    if (last.length < 2) {
      return null;
    }

    return last[1];
  }

  List<TaskTime> getTaskTimes({bool sort = true}) {
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

    if (sort) {
      details
          .sort((timeA, timeB) => timeA.startDate.compareTo(timeB.startDate));
    }

    return details;
  }

  TaskEntity addTaskTime(TaskTime time) {
    final List<dynamic> taskTimes =
        timeLog.isNotEmpty ? jsonDecode(timeLog) : <dynamic>[];

    taskTimes.add(time.asList);

    return rebuild((b) => b
      ..isChanged = true
      ..timeLog = jsonEncode(taskTimes));
  }

  TaskEntity updateTaskTime(TaskTime time, int index) {
    final List<dynamic> taskTimes =
        timeLog.isNotEmpty ? jsonDecode(timeLog) : <dynamic>[];

    taskTimes[index] = time.asList;

    return rebuild((b) => b
      ..isChanged = true
      ..timeLog = jsonEncode(taskTimes));
  }

  TaskEntity deleteTaskTime(int index) {
    final List<dynamic> taskTimes =
        timeLog.isNotEmpty ? jsonDecode(timeLog) : <dynamic>[];

    taskTimes.removeAt(index);

    return rebuild((b) => b
      ..isChanged = true
      ..timeLog = jsonEncode(taskTimes));
  }

  double calculateAmount(double taskRate) =>
      taskRate * round(calculateDuration().inSeconds / 3600, 3);

  Duration calculateDuration({bool includeRunning = true}) {
    int seconds = 0;

    getTaskTimes().forEach((taskTime) {
      if (!taskTime.isRunning || includeRunning) {
        seconds += taskTime.duration.inSeconds;
      }
    });

    return Duration(seconds: seconds);
  }

  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @override
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  double get rate;

  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @BuiltValueField(wireName: 'time_log')
  String get timeLog;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @BuiltValueField(wireName: 'status_id')
  String get statusId;

  @nullable
  @BuiltValueField(wireName: 'status_order')
  int get statusOrder;

  BuiltList<DocumentEntity> get documents;

  @nullable
  bool get showAsRunning;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit &&
          userCompany.canEditEntity(this) &&
          !isDeleted &&
          !multiselect) {
        actions.add(EntityAction.edit);
      }

      if (!isInvoiced) {
        if (isRunning) {
          actions.add(EntityAction.stop);
        } else {
          if (!multiselect) {
            if (duration > 0) {
              actions.add(EntityAction.resume);
            } else {
              actions.add(EntityAction.start);
            }
          }

          if (userCompany.canCreate(EntityType.invoice)) {
            actions.add(EntityAction.invoiceTask);
          }
        }
      }
    }

    if (!multiselect) {
      if (userCompany.canCreate(EntityType.task)) {
        actions.add(EntityAction.clone);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(
      TaskEntity task,
      String sortField,
      bool sortAscending,
      BuiltMap<String, UserEntity> userMap,
      BuiltMap<String, ClientEntity> clientMap,
      BuiltMap<String, ProjectEntity> projectMap,
      BuiltMap<String, InvoiceEntity> invoiceMap) {
    int response = 0;
    final TaskEntity taskA = sortAscending ? this : task;
    final TaskEntity taskB = sortAscending ? task : this;

    switch (sortField) {
      case TaskFields.duration:
        response = taskA.duration.compareTo(taskB.duration);
        break;
      case TaskFields.description:
        response = taskA.description.compareTo(taskB.description);
        break;
      case TaskFields.customValue1:
        response = taskA.customValue1.compareTo(taskB.customValue1);
        break;
      case TaskFields.customValue2:
        response = taskA.customValue2.compareTo(taskB.customValue2);
        break;
      case TaskFields.customValue3:
        response = taskA.customValue3.compareTo(taskB.customValue3);
        break;
      case TaskFields.customValue4:
        response = taskA.customValue4.compareTo(taskB.customValue4);
        break;
      case TaskFields.clientId:
      case TaskFields.client:
        final clientA = clientMap[taskA.clientId] ?? ClientEntity();
        final clientB = clientMap[taskB.clientId] ?? ClientEntity();
        response = clientA.listDisplayName
            .toLowerCase()
            .compareTo(clientB.listDisplayName.toLowerCase());
        break;
      case TaskFields.projectId:
      case TaskFields.project:
        final projectA = projectMap[taskA.projectId] ?? ProjectEntity();
        final projectB = projectMap[taskB.projectId] ?? ProjectEntity();
        response = projectA.listDisplayName
            .toLowerCase()
            .compareTo(projectB.listDisplayName.toLowerCase());
        break;
      case TaskFields.invoiceId:
        final invoiceA = invoiceMap[taskA.invoiceId] ?? InvoiceEntity();
        final invoiceB = invoiceMap[taskB.invoiceId] ?? InvoiceEntity();
        response = invoiceA.listDisplayName
            .toLowerCase()
            .compareTo(invoiceB.listDisplayName.toLowerCase());
        break;
      case EntityFields.state:
        final stateA =
            EntityState.valueOf(taskA.entityState) ?? EntityState.active;
        final stateB =
            EntityState.valueOf(taskB.entityState) ?? EntityState.active;
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case TaskFields.timeLog:
        response =
            taskA.timeLog.toLowerCase().compareTo(taskB.timeLog.toLowerCase());
        break;
      case EntityFields.createdAt:
        response = taskA.createdAt.compareTo(taskB.createdAt);
        break;
      case TaskFields.archivedAt:
        response = taskA.archivedAt.compareTo(taskB.archivedAt);
        break;
      case TaskFields.updatedAt:
        response = taskA.updatedAt.compareTo(taskB.updatedAt);
        break;
      case TaskFields.documents:
        response = taskA.documents.length.compareTo(taskB.documents.length);
        break;
      case TaskFields.number:
        response = taskA.number.compareTo(taskB.number);
        break;
      default:
        print('## ERROR: sort by task.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        number,
        description,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
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
    return matchesStringsValue(
      haystacks: [
        number,
        description,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName {
    return number;
  }

  @override
  double get listDisplayAmount => calculateDuration().inSeconds.toDouble();

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.duration;

  String get calculateStatusId {
    if (isInvoiced) {
      return kTaskStatusInvoiced;
    } else if (isRunning) {
      return kTaskStatusRunning;
    } else {
      return kTaskStatusLogged;
      //return (statusId ?? '').isEmpty ? kTaskStatusLogged : statusId;
    }
  }

  bool get isStopped => !isRunning;

  // ignore: unused_element
  static void _initializeBuilder(TaskEntityBuilder builder) =>
      builder..showAsRunning = false;

  static Serializer<TaskEntity> get serializer => _$taskEntitySerializer;
}
