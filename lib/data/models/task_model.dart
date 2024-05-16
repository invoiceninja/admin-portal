// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
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
  static const String date = 'date';
  static const String assignedTo = 'assigned_to';
  static const String createdBy = 'created_by';
  static const String amount = 'amount';
}

abstract class TaskTime implements Built<TaskTime, TaskTimeBuilder> {
  factory TaskTime({
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    bool? isBillable,
  }) {
    return _$TaskTime._(
      startDate: startDate ??
          DateTime.fromMillisecondsSinceEpoch(
              (DateTime.now().millisecondsSinceEpoch / 1000).floor() * 1000,
              isUtc: true),
      endDate: endDate,
      description: description ?? '',
      isBillable: isBillable ?? true,
    );
  }

  TaskTime._();

  @override
  @memoized
  int get hashCode;

  DateTime? get startDate;

  DateTime? get endDate;

  String get description;

  bool get isBillable;

  Duration get duration => (endDate ?? DateTime.now()).difference(startDate!);

  List<dynamic> get asList {
    final startTime = startDate != null
        ? (startDate!.millisecondsSinceEpoch / 1000).floor()
        : 0;
    var endTime =
        endDate != null ? (endDate!.millisecondsSinceEpoch / 1000).floor() : 0;

    final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
    final company = store.state.company;

    // Handle the end time being before the start time
    if (!company.showTaskEndDate && endTime != 0) {
      const oneDay = 24 * 60 * 60;
      if (endTime < startTime) {
        endTime += oneDay;
      } else if (endTime - startTime > oneDay) {
        endTime -= oneDay;
      }
    }

    return <dynamic>[startTime, endTime, description, isBillable];
  }

  TaskTime get stop => rebuild((b) => b..endDate = DateTime.now().toUtc());

  bool equalTo(TaskTime taskTime) =>
      startDate == taskTime.startDate && endDate == taskTime.endDate;

  bool get isRunning => endDate == null;

  bool get isEmpty =>
      startDate == null && endDate == null && description.isEmpty;

  Map<String, Duration> getParts() {
    final localStartDate = startDate!.toLocal();
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
    if (date.isEmpty) {
      return this;
    }

    final dateTime = DateTime.tryParse(date) ?? DateTime.now();
    final now = DateTime.now();

    return TaskTime(
      startDate: DateTime(
        dateTime.toLocal().year,
        dateTime.toLocal().month,
        dateTime.toLocal().day,
        startDate?.toLocal().hour ?? now.hour,
        startDate?.toLocal().minute ?? now.minute,
        startDate?.toLocal().second ?? now.second,
      ).toUtc(),
      endDate: syncDates && endDate != null
          ? DateTime(
              dateTime.toLocal().year,
              dateTime.toLocal().month,
              dateTime.toLocal().day,
              endDate!.toLocal().hour,
              endDate!.toLocal().minute,
              endDate!.toLocal().second,
            )
          : endDate,
      description: description,
      isBillable: isBillable,
    );
  }

  TaskTime copyWithEndDate(String date) {
    if (date.isEmpty) {
      return this;
    }

    final dateTime = DateTime.tryParse(date) ?? DateTime.now();
    final now = DateTime.now();

    return TaskTime(
      startDate: startDate,
      endDate: DateTime(
        dateTime.toLocal().year,
        dateTime.toLocal().month,
        dateTime.toLocal().day,
        endDate?.toLocal().hour ?? now.hour,
        endDate?.toLocal().minute ?? now.minute,
        endDate?.toLocal().second ?? now.second,
      ).toUtc(),
      description: description,
      isBillable: isBillable,
    );
  }

  TaskTime copyWithStartTime(DateTime dateTime) {
    final now = DateTime.now();

    return TaskTime(
      startDate: DateTime(
        startDate?.toLocal().year ?? now.year,
        startDate?.toLocal().month ?? now.month,
        startDate?.toLocal().day ?? now.day,
        dateTime.toLocal().hour,
        dateTime.toLocal().minute,
        dateTime.toLocal().second,
      ).toUtc(),
      endDate: endDate,
      description: description,
      isBillable: isBillable,
    );
  }

  TaskTime copyWithEndTime(DateTime dateTime) {
    final now = DateTime.now();
    return TaskTime(
      startDate: startDate,
      endDate: DateTime(
        endDate?.toLocal().year ?? startDate?.toLocal().year ?? now.year,
        endDate?.toLocal().month ?? startDate?.toLocal().month ?? now.month,
        endDate?.toLocal().day ?? startDate?.toLocal().day ?? now.day,
        dateTime.toLocal().hour,
        dateTime.toLocal().minute,
        dateTime.toLocal().second,
      ).toUtc(),
      description: description,
      isBillable: isBillable,
    );
  }

  TaskTime copyWithDuration(Duration duration) {
    final start = startDate ?? DateTime.now().subtract(duration);
    return TaskTime(
      startDate: start,
      endDate: start.add(duration),
      description: description,
      isBillable: isBillable,
    );
  }

  double calculateAmount(double taskRate) =>
      taskRate * round(duration.inSeconds / 3600, 3);

  static Serializer<TaskTime> get serializer => _$taskTimeSerializer;
}

abstract class TaskEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<TaskEntity, TaskEntityBuilder> {
  factory TaskEntity({
    String? id,
    AppState? state,
    ClientEntity? client,
    UserEntity? user,
    ProjectEntity? project,
  }) {
    final isRunning = state?.company.autoStartTasks ?? false;

    return _$TaskEntity._(
      id: id ?? BaseEntity.nextId,
      number: '',
      isChanged: false,
      description: '',
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
          state?.taskStatusState.map ?? BuiltMap<String, TaskStatusEntity>())!,
      documents: BuiltList<DocumentEntity>(),
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
    ..documents.clear());

  TaskEntity toggle() => isRunning ? stop() : start();

  TaskEntity start() => addTaskTime(TaskTime());

  TaskEntity stop() {
    final times = getTaskTimes();
    final taskTime = times.last.stop;

    return updateTaskTime(taskTime, times.length - 1);
  }

  bool get isInvoiced => invoiceId.isNotEmpty;

  @override
  EntityType get entityType {
    return EntityType.task;
  }

  String get description;

  String get number;

  bool get areTimesValid {
    final times = getTaskTimes();
    DateTime? lastDateTime = DateTime(2000);
    int countRunning = 0;
    bool isValid = true;

    times.forEach((time) {
      final startDate = time.startDate;
      final endDate = time.endDate;

      if (time.isRunning) {
        countRunning++;

        if (startDate!.isBefore(lastDateTime!)) {
          isValid = false;
        }
      } else {
        if (startDate!.isBefore(lastDateTime!) || startDate.isAfter(endDate!)) {
          isValid = false;
        }
        if (endDate!.isBefore(startDate) || endDate.isBefore(lastDateTime!)) {
          isValid = false;
        }
        lastDateTime = lastDateTime!.isAfter(endDate) ? lastDateTime : endDate;
      }
    });

    return isValid && countRunning <= 1;
  }

  List get getInvalidTimeIndices {
    final times = getTaskTimes();
    DateTime? lastDateTime = DateTime(2000);

    final indices = <int>[];
    int counter = 0;

    times.forEach((time) {
      final startDate = time.startDate;
      final endDate = time.endDate;

      if (time.isRunning) {
        if (startDate!.isBefore(lastDateTime!)) {
          indices.add(counter);
        }
      } else {
        if (startDate!.isBefore(lastDateTime!) || startDate.isAfter(endDate!)) {
          indices.add(counter);
        }
        if (endDate!.isBefore(startDate) || endDate.isBefore(lastDateTime!)) {
          indices.add(counter);
        }
        lastDateTime = lastDateTime!.isAfter(endDate) ? lastDateTime : endDate;
      }

      counter++;
    });

    return indices;
  }

  bool get isRunning {
    final taskTimes = getTaskTimes();

    if (taskTimes.isEmpty) {
      return false;
    }

    return taskTimes.any((taskTime) => taskTime.isRunning);
  }

  bool isBetween(String? startDate, String? endDate) {
    final taskTimes = getTaskTimes();

    if (taskTimes.isEmpty) {
      return false;
    }

    final taskStartDate =
        convertDateTimeToSqlDate(taskTimes.first.startDate!.toLocal());
    if (startDate!.compareTo(taskStartDate) <= 0 &&
        endDate!.compareTo(taskStartDate) >= 0) {
      return true;
    }

    final completedTimes = taskTimes.where((element) => !element.isRunning);

    if (completedTimes.isNotEmpty) {
      final lastTaskTime = completedTimes.last;
      final taskEndDate =
          convertDateTimeToSqlDate(lastTaskTime.endDate!.toLocal());

      if (startDate.compareTo(taskEndDate) <= 0 &&
          endDate!.compareTo(taskEndDate) >= 0) {
        return true;
      }
    }

    return false;
  }

  int? get startTimestamp {
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

  int? get endTimestamp {
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

    // TODO remove this, it shouldn't be needed
    return last[1].round();
  }

  List<TaskTime> getTaskTimes({bool sort = true}) {
    final List<TaskTime> details = [];

    if (timeLog.isEmpty) {
      return details;
    }

    final List<dynamic> log = jsonDecode(timeLog);
    log.forEach((dynamic detail) {
      int? startDate;
      int? endDate;
      final taskItem = detail as List<dynamic>;

      if (taskItem[0] == false || taskItem[0] == null) {
        startDate = 0;
      } else {
        startDate = taskItem[0].round();
      }

      if (taskItem[1] == false || taskItem[1] == null) {
        endDate = 0;
      } else {
        endDate = taskItem[1].round();
      }

      final taskTime = TaskTime(
        startDate: convertTimestampToDate(startDate).toUtc(),
        endDate:
            (endDate ?? 0) > 0 ? convertTimestampToDate(endDate).toUtc() : null,
        description: taskItem.length >= 3 ? taskItem[2] : '',
        isBillable: taskItem.length >= 4 ? taskItem[3] : true,
      );

      details.add(taskTime);
    });

    if (sort) {
      details
          .sort((timeA, timeB) => timeA.startDate!.compareTo(timeB.startDate!));
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

  Duration calculateDuration({bool onlyBillable = false}) {
    int seconds = 0;

    getTaskTimes().forEach((taskTime) {
      if (!onlyBillable || taskTime.isBillable) {
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

  @BuiltValueField(wireName: 'status_order')
  int? get statusOrder;

  BuiltList<DocumentEntity> get documents;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    final isLocked = userCompany!.company.invoiceTaskLock && isInvoiced;

    if (!isDeleted!) {
      if (includeEdit &&
          userCompany.canEditEntity(this) &&
          !isLocked &&
          !isDeleted! &&
          !multiselect) {
        actions.add(EntityAction.edit);
      }

      if (!isInvoiced) {
        if (isRunning) {
          actions.add(EntityAction.stop);
        } else {
          if (calculateDuration().inSeconds > 0) {
            actions.add(EntityAction.resume);
          } else {
            actions.add(EntityAction.start);
          }
        }
      }

      if (!isInvoiced && !isRunning) {
        if (userCompany.canCreate(EntityType.invoice)) {
          actions.add(EntityAction.invoiceTask);
          if (clientId.isNotEmpty) {
            actions.add(EntityAction.addToInvoice);
          }
        }
      }
    }

    if (!multiselect && isOld) {
      if (userCompany.canCreate(EntityType.task)) {
        actions.add(EntityAction.clone);
      }
    }

    if (!isDeleted! && !multiselect && isOld) {
      if (userCompany.canEditEntity(this)) {
        actions.add(EntityAction.changeStatus);
      }
    }

    if (!isDeleted! && multiselect) {
      actions.add(EntityAction.documents);
    }

    if (!isDeleted!) {
      final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
      if (hasDesignTemplatesForEntityType(
          store.state.designState.map, entityType)) {
        actions.add(EntityAction.runTemplate);
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
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, TaskStatusEntity> taskStatusMap,
  ) {
    int response = 0;
    final TaskEntity taskA = sortAscending ? this : task;
    final TaskEntity taskB = sortAscending ? task : this;

    switch (sortField) {
      case TaskFields.duration:
      case TaskFields.amount:
        response =
            taskA.calculateDuration().compareTo(taskB.calculateDuration());
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
        response = removeDiacritics(clientA.listDisplayName)
            .toLowerCase()
            .compareTo(removeDiacritics(clientB.listDisplayName).toLowerCase());
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
        final stateA = EntityState.valueOf(taskA.entityState);
        final stateB = EntityState.valueOf(taskB.entityState);
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case TaskFields.date:
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
        response = compareNatural(taskA.number, taskB.number);
        break;
      case TaskFields.createdBy:
        final userA = userMap[taskA.createdUserId] ?? UserEntity();
        final userB = userMap[taskB.createdUserId] ?? UserEntity();
        response = userA.fullName
            .toLowerCase()
            .compareTo(userB.fullName.toLowerCase());
        break;
      case TaskFields.assignedTo:
        final userA = userMap[taskA.assignedUserId] ?? UserEntity();
        final userB = userMap[taskB.assignedUserId] ?? UserEntity();
        response = userA.fullName
            .toLowerCase()
            .compareTo(userB.fullName.toLowerCase());
        break;
      case TaskFields.status:
        final taskAStatus = taskA.isRunning
            ? -1
            : taskA.isInvoiced
                ? 999999
                : (taskStatusMap[taskA.statusId]?.statusOrder ?? 0);
        final taskBStatus = taskB.isRunning
            ? -1
            : taskB.isInvoiced
                ? 999999
                : (taskStatusMap[taskB.statusId]?.statusOrder ?? 0);
        response = taskAStatus.compareTo(taskBStatus);
        break;
      default:
        print('## ERROR: sort by task.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      response = task.number.toLowerCase().compareTo(number.toLowerCase());
    }

    return response;
  }

  @override
  bool matchesFilter(String? filter) {
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
      } else if (status.id == statusId) {
        return !isInvoiced;
      }
    }

    return false;
  }

  @override
  String? matchesFilterValue(String? filter) {
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
  String get listDisplayName => number;

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
  //static void _initializeBuilder(TaskEntityBuilder builder) =>
  //    builder..;

  static Serializer<TaskEntity> get serializer => _$taskEntitySerializer;
}
