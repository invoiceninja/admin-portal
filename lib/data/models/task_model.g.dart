// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaskListResponse> _$taskListResponseSerializer =
    new _$TaskListResponseSerializer();
Serializer<TaskItemResponse> _$taskItemResponseSerializer =
    new _$TaskItemResponseSerializer();
Serializer<TaskTime> _$taskTimeSerializer = new _$TaskTimeSerializer();
Serializer<TaskEntity> _$taskEntitySerializer = new _$TaskEntitySerializer();

class _$TaskListResponseSerializer
    implements StructuredSerializer<TaskListResponse> {
  @override
  final Iterable<Type> types = const [TaskListResponse, _$TaskListResponse];
  @override
  final String wireName = 'TaskListResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, TaskListResponse object,
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
  TaskListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
                      BuiltList, const [const FullType(TaskEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(Serializers serializers, TaskItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TaskEntity)),
    ];

    return result;
  }

  @override
  TaskItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
  Iterable<Object> serialize(Serializers serializers, TaskTime object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.startDate != null) {
      result
        ..add('startDate')
        ..add(serializers.serialize(object.startDate,
            specifiedType: const FullType(DateTime)));
    }
    if (object.endDate != null) {
      result
        ..add('endDate')
        ..add(serializers.serialize(object.endDate,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  TaskTime deserialize(Serializers serializers, Iterable<Object> serialized,
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
  Iterable<Object> serialize(Serializers serializers, TaskEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(int)),
      'invoice_id',
      serializers.serialize(object.invoiceId,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'rate',
      serializers.serialize(object.rate, specifiedType: const FullType(double)),
      'project_id',
      serializers.serialize(object.projectId,
          specifiedType: const FullType(String)),
      'time_log',
      serializers.serialize(object.timeLog,
          specifiedType: const FullType(String)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'status_id',
      serializers.serialize(object.statusId,
          specifiedType: const FullType(String)),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    if (object.statusOrder != null) {
      result
        ..add('status_order')
        ..add(serializers.serialize(object.statusOrder,
            specifiedType: const FullType(int)));
    }
    if (object.showAsRunning != null) {
      result
        ..add('showAsRunning')
        ..add(serializers.serialize(object.showAsRunning,
            specifiedType: const FullType(bool)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.createdUserId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.createdUserId,
            specifiedType: const FullType(String)));
    }
    if (object.assignedUserId != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(object.assignedUserId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TaskEntity deserialize(Serializers serializers, Iterable<Object> serialized,
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
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rate':
          result.rate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'time_log':
          result.timeLog = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_id':
          result.statusId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_order':
          result.statusOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))
              as BuiltList<Object>);
          break;
        case 'showAsRunning':
          result.showAsRunning = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
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

  factory _$TaskListResponse(
          [void Function(TaskListResponseBuilder) updates]) =>
      (new TaskListResponseBuilder()..update(updates)).build();

  _$TaskListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TaskListResponse', 'data');
    }
  }

  @override
  TaskListResponse rebuild(void Function(TaskListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskListResponseBuilder toBuilder() =>
      new TaskListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
  void update(void Function(TaskListResponseBuilder) updates) {
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

  factory _$TaskItemResponse(
          [void Function(TaskItemResponseBuilder) updates]) =>
      (new TaskItemResponseBuilder()..update(updates)).build();

  _$TaskItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TaskItemResponse', 'data');
    }
  }

  @override
  TaskItemResponse rebuild(void Function(TaskItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskItemResponseBuilder toBuilder() =>
      new TaskItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
  void update(void Function(TaskItemResponseBuilder) updates) {
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

  factory _$TaskTime([void Function(TaskTimeBuilder) updates]) =>
      (new TaskTimeBuilder()..update(updates)).build();

  _$TaskTime._({this.startDate, this.endDate}) : super._();

  @override
  TaskTime rebuild(void Function(TaskTimeBuilder) updates) =>
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??=
        $jf($jc($jc(0, startDate.hashCode), endDate.hashCode));
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
  void update(void Function(TaskTimeBuilder) updates) {
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
  final String number;
  @override
  final int duration;
  @override
  final String invoiceId;
  @override
  final String clientId;
  @override
  final double rate;
  @override
  final String projectId;
  @override
  final String timeLog;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final String statusId;
  @override
  final int statusOrder;
  @override
  final BuiltList<DocumentEntity> documents;
  @override
  final bool showAsRunning;
  @override
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final String createdUserId;
  @override
  final String assignedUserId;
  @override
  final String id;

  factory _$TaskEntity([void Function(TaskEntityBuilder) updates]) =>
      (new TaskEntityBuilder()..update(updates)).build();

  _$TaskEntity._(
      {this.description,
      this.number,
      this.duration,
      this.invoiceId,
      this.clientId,
      this.rate,
      this.projectId,
      this.timeLog,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.statusId,
      this.statusOrder,
      this.documents,
      this.showAsRunning,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (description == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'description');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'number');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'duration');
    }
    if (invoiceId == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'invoiceId');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'clientId');
    }
    if (rate == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'rate');
    }
    if (projectId == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'projectId');
    }
    if (timeLog == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'timeLog');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'customValue4');
    }
    if (statusId == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'statusId');
    }
    if (documents == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'documents');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'id');
    }
  }

  @override
  TaskEntity rebuild(void Function(TaskEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskEntityBuilder toBuilder() => new TaskEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskEntity &&
        description == other.description &&
        number == other.number &&
        duration == other.duration &&
        invoiceId == other.invoiceId &&
        clientId == other.clientId &&
        rate == other.rate &&
        projectId == other.projectId &&
        timeLog == other.timeLog &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        statusId == other.statusId &&
        statusOrder == other.statusOrder &&
        documents == other.documents &&
        showAsRunning == other.showAsRunning &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
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
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc(0, description.hashCode), number.hashCode), duration.hashCode), invoiceId.hashCode), clientId.hashCode),
                                                                                rate.hashCode),
                                                                            projectId.hashCode),
                                                                        timeLog.hashCode),
                                                                    customValue1.hashCode),
                                                                customValue2.hashCode),
                                                            customValue3.hashCode),
                                                        customValue4.hashCode),
                                                    statusId.hashCode),
                                                statusOrder.hashCode),
                                            documents.hashCode),
                                        showAsRunning.hashCode),
                                    isChanged.hashCode),
                                createdAt.hashCode),
                            updatedAt.hashCode),
                        archivedAt.hashCode),
                    isDeleted.hashCode),
                createdUserId.hashCode),
            assignedUserId.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskEntity')
          ..add('description', description)
          ..add('number', number)
          ..add('duration', duration)
          ..add('invoiceId', invoiceId)
          ..add('clientId', clientId)
          ..add('rate', rate)
          ..add('projectId', projectId)
          ..add('timeLog', timeLog)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('statusId', statusId)
          ..add('statusOrder', statusOrder)
          ..add('documents', documents)
          ..add('showAsRunning', showAsRunning)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('id', id))
        .toString();
  }
}

class TaskEntityBuilder implements Builder<TaskEntity, TaskEntityBuilder> {
  _$TaskEntity _$v;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  int _duration;
  int get duration => _$this._duration;
  set duration(int duration) => _$this._duration = duration;

  String _invoiceId;
  String get invoiceId => _$this._invoiceId;
  set invoiceId(String invoiceId) => _$this._invoiceId = invoiceId;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  double _rate;
  double get rate => _$this._rate;
  set rate(double rate) => _$this._rate = rate;

  String _projectId;
  String get projectId => _$this._projectId;
  set projectId(String projectId) => _$this._projectId = projectId;

  String _timeLog;
  String get timeLog => _$this._timeLog;
  set timeLog(String timeLog) => _$this._timeLog = timeLog;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  String _statusId;
  String get statusId => _$this._statusId;
  set statusId(String statusId) => _$this._statusId = statusId;

  int _statusOrder;
  int get statusOrder => _$this._statusOrder;
  set statusOrder(int statusOrder) => _$this._statusOrder = statusOrder;

  ListBuilder<DocumentEntity> _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity> documents) =>
      _$this._documents = documents;

  bool _showAsRunning;
  bool get showAsRunning => _$this._showAsRunning;
  set showAsRunning(bool showAsRunning) =>
      _$this._showAsRunning = showAsRunning;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

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

  String _createdUserId;
  String get createdUserId => _$this._createdUserId;
  set createdUserId(String createdUserId) =>
      _$this._createdUserId = createdUserId;

  String _assignedUserId;
  String get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  TaskEntityBuilder() {
    TaskEntity._initializeBuilder(this);
  }

  TaskEntityBuilder get _$this {
    if (_$v != null) {
      _description = _$v.description;
      _number = _$v.number;
      _duration = _$v.duration;
      _invoiceId = _$v.invoiceId;
      _clientId = _$v.clientId;
      _rate = _$v.rate;
      _projectId = _$v.projectId;
      _timeLog = _$v.timeLog;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _statusId = _$v.statusId;
      _statusOrder = _$v.statusOrder;
      _documents = _$v.documents?.toBuilder();
      _showAsRunning = _$v.showAsRunning;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
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
  void update(void Function(TaskEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskEntity build() {
    _$TaskEntity _$result;
    try {
      _$result = _$v ??
          new _$TaskEntity._(
              description: description,
              number: number,
              duration: duration,
              invoiceId: invoiceId,
              clientId: clientId,
              rate: rate,
              projectId: projectId,
              timeLog: timeLog,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              statusId: statusId,
              statusOrder: statusOrder,
              documents: documents.build(),
              showAsRunning: showAsRunning,
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'documents';
        documents.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaskEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
