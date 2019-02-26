// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<TaskListResponse> _$taskListResponseSerializer =
    new _$TaskListResponseSerializer();
Serializer<TaskItemResponse> _$taskItemResponseSerializer =
    new _$TaskItemResponseSerializer();
Serializer<TaskTime> _$taskTimeSerializer = new _$TaskTimeSerializer();
Serializer<TaskEntity> _$taskEntitySerializer = new _$TaskEntitySerializer();
Serializer<TaskStatusEntity> _$taskStatusEntitySerializer =
    new _$TaskStatusEntitySerializer();

class _$TaskListResponseSerializer
    implements StructuredSerializer<TaskListResponse> {
  @override
  final Iterable<Type> types = const [TaskListResponse, _$TaskListResponse];
  @override
  final String wireName = 'TaskListResponse';

  @override
  Iterable serialize(Serializers serializers, TaskListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TaskEntity)])),
    ];

    return result;
  }

  @override
  TaskListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(TaskEntity)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$TaskItemResponseSerializer
    implements StructuredSerializer<TaskItemResponse> {
  @override
  final Iterable<Type> types = const [TaskItemResponse, _$TaskItemResponse];
  @override
  final String wireName = 'TaskItemResponse';

  @override
  Iterable serialize(Serializers serializers, TaskItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TaskEntity)),
    ];

    return result;
  }

  @override
  TaskItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskEntity)) as TaskEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$TaskTimeSerializer implements StructuredSerializer<TaskTime> {
  @override
  final Iterable<Type> types = const [TaskTime, _$TaskTime];
  @override
  final String wireName = 'TaskTime';

  @override
  Iterable serialize(Serializers serializers, TaskTime object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'startDate',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(DateTime)),
    ];
    if (object.endDate != null) {
      result
        ..add('endDate')
        ..add(serializers.serialize(object.endDate,
            specifiedType: const FullType(DateTime)));
    }

    return result;
  }

  @override
  TaskTime deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskTimeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$TaskEntitySerializer implements StructuredSerializer<TaskEntity> {
  @override
  final Iterable<Type> types = const [TaskEntity, _$TaskEntity];
  @override
  final String wireName = 'TaskEntity';

  @override
  Iterable serialize(Serializers serializers, TaskEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(int)),
      'time_log',
      serializers.serialize(object.timeLog,
          specifiedType: const FullType(String)),
      'is_running',
      serializers.serialize(object.isRunning,
          specifiedType: const FullType(bool)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
    ];
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(int)));
    }
    if (object.clientId != null) {
      result
        ..add('client_id')
        ..add(serializers.serialize(object.clientId,
            specifiedType: const FullType(int)));
    }
    if (object.projectId != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(object.projectId,
            specifiedType: const FullType(int)));
    }
    if (object.taskStatusId != null) {
      result
        ..add('task_status_id')
        ..add(serializers.serialize(object.taskStatusId,
            specifiedType: const FullType(int)));
    }
    if (object.taskStatusSortOrder != null) {
      result
        ..add('task_status_sort_order')
        ..add(serializers.serialize(object.taskStatusSortOrder,
            specifiedType: const FullType(int)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.isOwner != null) {
      result
        ..add('is_owner')
        ..add(serializers.serialize(object.isOwner,
            specifiedType: const FullType(bool)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  TaskEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'time_log':
          result.timeLog = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_running':
          result.isRunning = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'task_status_id':
          result.taskStatusId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'task_status_sort_order':
          result.taskStatusSortOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$TaskStatusEntitySerializer
    implements StructuredSerializer<TaskStatusEntity> {
  @override
  final Iterable<Type> types = const [TaskStatusEntity, _$TaskStatusEntity];
  @override
  final String wireName = 'TaskStatusEntity';

  @override
  Iterable serialize(Serializers serializers, TaskStatusEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'sort_order',
      serializers.serialize(object.sortOrder,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TaskStatusEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskStatusEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sort_order':
          result.sortOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TaskListResponse extends TaskListResponse {
  @override
  final BuiltList<TaskEntity> data;

  factory _$TaskListResponse([void updates(TaskListResponseBuilder b)]) =>
      (new TaskListResponseBuilder()..update(updates)).build();

  _$TaskListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TaskListResponse', 'data');
    }
  }

  @override
  TaskListResponse rebuild(void updates(TaskListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskListResponseBuilder toBuilder() =>
      new TaskListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskListResponse')..add('data', data))
        .toString();
  }
}

class TaskListResponseBuilder
    implements Builder<TaskListResponse, TaskListResponseBuilder> {
  _$TaskListResponse _$v;

  ListBuilder<TaskEntity> _data;
  ListBuilder<TaskEntity> get data =>
      _$this._data ??= new ListBuilder<TaskEntity>();
  set data(ListBuilder<TaskEntity> data) => _$this._data = data;

  TaskListResponseBuilder();

  TaskListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskListResponse;
  }

  @override
  void update(void updates(TaskListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskListResponse build() {
    _$TaskListResponse _$result;
    try {
      _$result = _$v ?? new _$TaskListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaskListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaskItemResponse extends TaskItemResponse {
  @override
  final TaskEntity data;

  factory _$TaskItemResponse([void updates(TaskItemResponseBuilder b)]) =>
      (new TaskItemResponseBuilder()..update(updates)).build();

  _$TaskItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TaskItemResponse', 'data');
    }
  }

  @override
  TaskItemResponse rebuild(void updates(TaskItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskItemResponseBuilder toBuilder() =>
      new TaskItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskItemResponse')..add('data', data))
        .toString();
  }
}

class TaskItemResponseBuilder
    implements Builder<TaskItemResponse, TaskItemResponseBuilder> {
  _$TaskItemResponse _$v;

  TaskEntityBuilder _data;
  TaskEntityBuilder get data => _$this._data ??= new TaskEntityBuilder();
  set data(TaskEntityBuilder data) => _$this._data = data;

  TaskItemResponseBuilder();

  TaskItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskItemResponse;
  }

  @override
  void update(void updates(TaskItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskItemResponse build() {
    _$TaskItemResponse _$result;
    try {
      _$result = _$v ?? new _$TaskItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaskItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaskTime extends TaskTime {
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  factory _$TaskTime([void updates(TaskTimeBuilder b)]) =>
      (new TaskTimeBuilder()..update(updates)).build();

  _$TaskTime._({this.startDate, this.endDate}) : super._() {
    if (startDate == null) {
      throw new BuiltValueNullFieldError('TaskTime', 'startDate');
    }
  }

  @override
  TaskTime rebuild(void updates(TaskTimeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskTimeBuilder toBuilder() => new TaskTimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskTime &&
        startDate == other.startDate &&
        endDate == other.endDate;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, startDate.hashCode), endDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskTime')
          ..add('startDate', startDate)
          ..add('endDate', endDate))
        .toString();
  }
}

class TaskTimeBuilder implements Builder<TaskTime, TaskTimeBuilder> {
  _$TaskTime _$v;

  DateTime _startDate;
  DateTime get startDate => _$this._startDate;
  set startDate(DateTime startDate) => _$this._startDate = startDate;

  DateTime _endDate;
  DateTime get endDate => _$this._endDate;
  set endDate(DateTime endDate) => _$this._endDate = endDate;

  TaskTimeBuilder();

  TaskTimeBuilder get _$this {
    if (_$v != null) {
      _startDate = _$v.startDate;
      _endDate = _$v.endDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskTime other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskTime;
  }

  @override
  void update(void updates(TaskTimeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskTime build() {
    final _$result =
        _$v ?? new _$TaskTime._(startDate: startDate, endDate: endDate);
    replace(_$result);
    return _$result;
  }
}

class _$TaskEntity extends TaskEntity {
  @override
  final String description;
  @override
  final int duration;
  @override
  final int invoiceId;
  @override
  final int clientId;
  @override
  final int projectId;
  @override
  final String timeLog;
  @override
  final bool isRunning;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final int taskStatusId;
  @override
  final int taskStatusSortOrder;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final bool isOwner;
  @override
  final int id;

  factory _$TaskEntity([void updates(TaskEntityBuilder b)]) =>
      (new TaskEntityBuilder()..update(updates)).build();

  _$TaskEntity._(
      {this.description,
      this.duration,
      this.invoiceId,
      this.clientId,
      this.projectId,
      this.timeLog,
      this.isRunning,
      this.customValue1,
      this.customValue2,
      this.taskStatusId,
      this.taskStatusSortOrder,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (description == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'description');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'duration');
    }
    if (timeLog == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'timeLog');
    }
    if (isRunning == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'isRunning');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'customValue2');
    }
  }

  @override
  TaskEntity rebuild(void updates(TaskEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskEntityBuilder toBuilder() => new TaskEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskEntity &&
        description == other.description &&
        duration == other.duration &&
        invoiceId == other.invoiceId &&
        clientId == other.clientId &&
        projectId == other.projectId &&
        timeLog == other.timeLog &&
        isRunning == other.isRunning &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        taskStatusId == other.taskStatusId &&
        taskStatusSortOrder == other.taskStatusSortOrder &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        isOwner == other.isOwner &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        0,
                                                                        description
                                                                            .hashCode),
                                                                    duration
                                                                        .hashCode),
                                                                invoiceId
                                                                    .hashCode),
                                                            clientId.hashCode),
                                                        projectId.hashCode),
                                                    timeLog.hashCode),
                                                isRunning.hashCode),
                                            customValue1.hashCode),
                                        customValue2.hashCode),
                                    taskStatusId.hashCode),
                                taskStatusSortOrder.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskEntity')
          ..add('description', description)
          ..add('duration', duration)
          ..add('invoiceId', invoiceId)
          ..add('clientId', clientId)
          ..add('projectId', projectId)
          ..add('timeLog', timeLog)
          ..add('isRunning', isRunning)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('taskStatusId', taskStatusId)
          ..add('taskStatusSortOrder', taskStatusSortOrder)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
          ..add('id', id))
        .toString();
  }
}

class TaskEntityBuilder implements Builder<TaskEntity, TaskEntityBuilder> {
  _$TaskEntity _$v;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  int _duration;
  int get duration => _$this._duration;
  set duration(int duration) => _$this._duration = duration;

  int _invoiceId;
  int get invoiceId => _$this._invoiceId;
  set invoiceId(int invoiceId) => _$this._invoiceId = invoiceId;

  int _clientId;
  int get clientId => _$this._clientId;
  set clientId(int clientId) => _$this._clientId = clientId;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  String _timeLog;
  String get timeLog => _$this._timeLog;
  set timeLog(String timeLog) => _$this._timeLog = timeLog;

  bool _isRunning;
  bool get isRunning => _$this._isRunning;
  set isRunning(bool isRunning) => _$this._isRunning = isRunning;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  int _taskStatusId;
  int get taskStatusId => _$this._taskStatusId;
  set taskStatusId(int taskStatusId) => _$this._taskStatusId = taskStatusId;

  int _taskStatusSortOrder;
  int get taskStatusSortOrder => _$this._taskStatusSortOrder;
  set taskStatusSortOrder(int taskStatusSortOrder) =>
      _$this._taskStatusSortOrder = taskStatusSortOrder;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  TaskEntityBuilder();

  TaskEntityBuilder get _$this {
    if (_$v != null) {
      _description = _$v.description;
      _duration = _$v.duration;
      _invoiceId = _$v.invoiceId;
      _clientId = _$v.clientId;
      _projectId = _$v.projectId;
      _timeLog = _$v.timeLog;
      _isRunning = _$v.isRunning;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _taskStatusId = _$v.taskStatusId;
      _taskStatusSortOrder = _$v.taskStatusSortOrder;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _isOwner = _$v.isOwner;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskEntity;
  }

  @override
  void update(void updates(TaskEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskEntity build() {
    final _$result = _$v ??
        new _$TaskEntity._(
            description: description,
            duration: duration,
            invoiceId: invoiceId,
            clientId: clientId,
            projectId: projectId,
            timeLog: timeLog,
            isRunning: isRunning,
            customValue1: customValue1,
            customValue2: customValue2,
            taskStatusId: taskStatusId,
            taskStatusSortOrder: taskStatusSortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            isOwner: isOwner,
            id: id);
    replace(_$result);
    return _$result;
  }
}

class _$TaskStatusEntity extends TaskStatusEntity {
  @override
  final int sortOrder;
  @override
  final int id;
  @override
  final String name;

  factory _$TaskStatusEntity([void updates(TaskStatusEntityBuilder b)]) =>
      (new TaskStatusEntityBuilder()..update(updates)).build();

  _$TaskStatusEntity._({this.sortOrder, this.id, this.name}) : super._() {
    if (sortOrder == null) {
      throw new BuiltValueNullFieldError('TaskStatusEntity', 'sortOrder');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('TaskStatusEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TaskStatusEntity', 'name');
    }
  }

  @override
  TaskStatusEntity rebuild(void updates(TaskStatusEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskStatusEntityBuilder toBuilder() =>
      new TaskStatusEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskStatusEntity &&
        sortOrder == other.sortOrder &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, sortOrder.hashCode), id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskStatusEntity')
          ..add('sortOrder', sortOrder)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class TaskStatusEntityBuilder
    implements Builder<TaskStatusEntity, TaskStatusEntityBuilder> {
  _$TaskStatusEntity _$v;

  int _sortOrder;
  int get sortOrder => _$this._sortOrder;
  set sortOrder(int sortOrder) => _$this._sortOrder = sortOrder;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  TaskStatusEntityBuilder();

  TaskStatusEntityBuilder get _$this {
    if (_$v != null) {
      _sortOrder = _$v.sortOrder;
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskStatusEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskStatusEntity;
  }

  @override
  void update(void updates(TaskStatusEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskStatusEntity build() {
    final _$result = _$v ??
        new _$TaskStatusEntity._(sortOrder: sortOrder, id: id, name: name);
    replace(_$result);
    return _$result;
  }
}
