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
  Iterable<Object?> serialize(Serializers serializers, TaskListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TaskEntity)])),
    ];

    return result;
  }

  @override
  TaskListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaskEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(Serializers serializers, TaskItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TaskEntity)),
    ];

    return result;
  }

  @override
  TaskItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskEntity))! as TaskEntity);
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
  Iterable<Object?> serialize(Serializers serializers, TaskTime object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'isBillable',
      serializers.serialize(object.isBillable,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.startDate;
    if (value != null) {
      result
        ..add('startDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.endDate;
    if (value != null) {
      result
        ..add('endDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  TaskTime deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskTimeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isBillable':
          result.isBillable = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
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
  Iterable<Object?> serialize(Serializers serializers, TaskEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
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
    Object? value;
    value = object.statusOrder;
    if (value != null) {
      result
        ..add('status_order')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TaskEntity deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'rate':
          result.rate = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'time_log':
          result.timeLog = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status_id':
          result.statusId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status_order':
          result.statusOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
          [void Function(TaskListResponseBuilder)? updates]) =>
      (new TaskListResponseBuilder()..update(updates))._build();

  _$TaskListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'TaskListResponse', 'data');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaskListResponse')..add('data', data))
        .toString();
  }
}

class TaskListResponseBuilder
    implements Builder<TaskListResponse, TaskListResponseBuilder> {
  _$TaskListResponse? _$v;

  ListBuilder<TaskEntity>? _data;
  ListBuilder<TaskEntity> get data =>
      _$this._data ??= new ListBuilder<TaskEntity>();
  set data(ListBuilder<TaskEntity>? data) => _$this._data = data;

  TaskListResponseBuilder();

  TaskListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskListResponse;
  }

  @override
  void update(void Function(TaskListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskListResponse build() => _build();

  _$TaskListResponse _build() {
    _$TaskListResponse _$result;
    try {
      _$result = _$v ?? new _$TaskListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaskListResponse', _$failedField, e.toString());
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
          [void Function(TaskItemResponseBuilder)? updates]) =>
      (new TaskItemResponseBuilder()..update(updates))._build();

  _$TaskItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'TaskItemResponse', 'data');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaskItemResponse')..add('data', data))
        .toString();
  }
}

class TaskItemResponseBuilder
    implements Builder<TaskItemResponse, TaskItemResponseBuilder> {
  _$TaskItemResponse? _$v;

  TaskEntityBuilder? _data;
  TaskEntityBuilder get data => _$this._data ??= new TaskEntityBuilder();
  set data(TaskEntityBuilder? data) => _$this._data = data;

  TaskItemResponseBuilder();

  TaskItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskItemResponse;
  }

  @override
  void update(void Function(TaskItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskItemResponse build() => _build();

  _$TaskItemResponse _build() {
    _$TaskItemResponse _$result;
    try {
      _$result = _$v ?? new _$TaskItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaskItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaskTime extends TaskTime {
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String description;
  @override
  final bool isBillable;

  factory _$TaskTime([void Function(TaskTimeBuilder)? updates]) =>
      (new TaskTimeBuilder()..update(updates))._build();

  _$TaskTime._(
      {this.startDate,
      this.endDate,
      required this.description,
      required this.isBillable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        description, r'TaskTime', 'description');
    BuiltValueNullFieldError.checkNotNull(
        isBillable, r'TaskTime', 'isBillable');
  }

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
        endDate == other.endDate &&
        description == other.description &&
        isBillable == other.isBillable;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isBillable.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaskTime')
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('description', description)
          ..add('isBillable', isBillable))
        .toString();
  }
}

class TaskTimeBuilder implements Builder<TaskTime, TaskTimeBuilder> {
  _$TaskTime? _$v;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isBillable;
  bool? get isBillable => _$this._isBillable;
  set isBillable(bool? isBillable) => _$this._isBillable = isBillable;

  TaskTimeBuilder();

  TaskTimeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _description = $v.description;
      _isBillable = $v.isBillable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskTime other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskTime;
  }

  @override
  void update(void Function(TaskTimeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskTime build() => _build();

  _$TaskTime _build() {
    final _$result = _$v ??
        new _$TaskTime._(
            startDate: startDate,
            endDate: endDate,
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'TaskTime', 'description'),
            isBillable: BuiltValueNullFieldError.checkNotNull(
                isBillable, r'TaskTime', 'isBillable'));
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
  final int? statusOrder;
  @override
  final BuiltList<DocumentEntity> documents;
  @override
  final bool? isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool? isDeleted;
  @override
  final String? createdUserId;
  @override
  final String? assignedUserId;
  @override
  final String id;

  factory _$TaskEntity([void Function(TaskEntityBuilder)? updates]) =>
      (new TaskEntityBuilder()..update(updates))._build();

  _$TaskEntity._(
      {required this.description,
      required this.number,
      required this.invoiceId,
      required this.clientId,
      required this.rate,
      required this.projectId,
      required this.timeLog,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
      required this.statusId,
      this.statusOrder,
      required this.documents,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        description, r'TaskEntity', 'description');
    BuiltValueNullFieldError.checkNotNull(number, r'TaskEntity', 'number');
    BuiltValueNullFieldError.checkNotNull(
        invoiceId, r'TaskEntity', 'invoiceId');
    BuiltValueNullFieldError.checkNotNull(clientId, r'TaskEntity', 'clientId');
    BuiltValueNullFieldError.checkNotNull(rate, r'TaskEntity', 'rate');
    BuiltValueNullFieldError.checkNotNull(
        projectId, r'TaskEntity', 'projectId');
    BuiltValueNullFieldError.checkNotNull(timeLog, r'TaskEntity', 'timeLog');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'TaskEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'TaskEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'TaskEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'TaskEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(statusId, r'TaskEntity', 'statusId');
    BuiltValueNullFieldError.checkNotNull(
        documents, r'TaskEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'TaskEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'TaskEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'TaskEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'TaskEntity', 'id');
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
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, rate.hashCode);
    _$hash = $jc(_$hash, projectId.hashCode);
    _$hash = $jc(_$hash, timeLog.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, statusId.hashCode);
    _$hash = $jc(_$hash, statusOrder.hashCode);
    _$hash = $jc(_$hash, documents.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaskEntity')
          ..add('description', description)
          ..add('number', number)
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
  _$TaskEntity? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  String? _invoiceId;
  String? get invoiceId => _$this._invoiceId;
  set invoiceId(String? invoiceId) => _$this._invoiceId = invoiceId;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  double? _rate;
  double? get rate => _$this._rate;
  set rate(double? rate) => _$this._rate = rate;

  String? _projectId;
  String? get projectId => _$this._projectId;
  set projectId(String? projectId) => _$this._projectId = projectId;

  String? _timeLog;
  String? get timeLog => _$this._timeLog;
  set timeLog(String? timeLog) => _$this._timeLog = timeLog;

  String? _customValue1;
  String? get customValue1 => _$this._customValue1;
  set customValue1(String? customValue1) => _$this._customValue1 = customValue1;

  String? _customValue2;
  String? get customValue2 => _$this._customValue2;
  set customValue2(String? customValue2) => _$this._customValue2 = customValue2;

  String? _customValue3;
  String? get customValue3 => _$this._customValue3;
  set customValue3(String? customValue3) => _$this._customValue3 = customValue3;

  String? _customValue4;
  String? get customValue4 => _$this._customValue4;
  set customValue4(String? customValue4) => _$this._customValue4 = customValue4;

  String? _statusId;
  String? get statusId => _$this._statusId;
  set statusId(String? statusId) => _$this._statusId = statusId;

  int? _statusOrder;
  int? get statusOrder => _$this._statusOrder;
  set statusOrder(int? statusOrder) => _$this._statusOrder = statusOrder;

  ListBuilder<DocumentEntity>? _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity>? documents) =>
      _$this._documents = documents;

  bool? _isChanged;
  bool? get isChanged => _$this._isChanged;
  set isChanged(bool? isChanged) => _$this._isChanged = isChanged;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  int? _archivedAt;
  int? get archivedAt => _$this._archivedAt;
  set archivedAt(int? archivedAt) => _$this._archivedAt = archivedAt;

  bool? _isDeleted;
  bool? get isDeleted => _$this._isDeleted;
  set isDeleted(bool? isDeleted) => _$this._isDeleted = isDeleted;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  String? _assignedUserId;
  String? get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String? assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  TaskEntityBuilder();

  TaskEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _number = $v.number;
      _invoiceId = $v.invoiceId;
      _clientId = $v.clientId;
      _rate = $v.rate;
      _projectId = $v.projectId;
      _timeLog = $v.timeLog;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _statusId = $v.statusId;
      _statusOrder = $v.statusOrder;
      _documents = $v.documents.toBuilder();
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskEntity;
  }

  @override
  void update(void Function(TaskEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskEntity build() => _build();

  _$TaskEntity _build() {
    _$TaskEntity _$result;
    try {
      _$result = _$v ??
          new _$TaskEntity._(
              description: BuiltValueNullFieldError.checkNotNull(
                  description, r'TaskEntity', 'description'),
              number: BuiltValueNullFieldError.checkNotNull(
                  number, r'TaskEntity', 'number'),
              invoiceId: BuiltValueNullFieldError.checkNotNull(
                  invoiceId, r'TaskEntity', 'invoiceId'),
              clientId: BuiltValueNullFieldError.checkNotNull(
                  clientId, r'TaskEntity', 'clientId'),
              rate: BuiltValueNullFieldError.checkNotNull(
                  rate, r'TaskEntity', 'rate'),
              projectId: BuiltValueNullFieldError.checkNotNull(
                  projectId, r'TaskEntity', 'projectId'),
              timeLog: BuiltValueNullFieldError.checkNotNull(
                  timeLog, r'TaskEntity', 'timeLog'),
              customValue1: BuiltValueNullFieldError.checkNotNull(
                  customValue1, r'TaskEntity', 'customValue1'),
              customValue2:
                  BuiltValueNullFieldError.checkNotNull(customValue2, r'TaskEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'TaskEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'TaskEntity', 'customValue4'),
              statusId: BuiltValueNullFieldError.checkNotNull(statusId, r'TaskEntity', 'statusId'),
              statusOrder: statusOrder,
              documents: documents.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'TaskEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'TaskEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'TaskEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, r'TaskEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'documents';
        documents.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaskEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
