// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScheduleListResponse> _$scheduleListResponseSerializer =
    new _$ScheduleListResponseSerializer();
Serializer<ScheduleItemResponse> _$scheduleItemResponseSerializer =
    new _$ScheduleItemResponseSerializer();
Serializer<ScheduleEntity> _$scheduleEntitySerializer =
    new _$ScheduleEntitySerializer();
Serializer<ScheduleParameters> _$scheduleParametersSerializer =
    new _$ScheduleParametersSerializer();

class _$ScheduleListResponseSerializer
    implements StructuredSerializer<ScheduleListResponse> {
  @override
  final Iterable<Type> types = const [
    ScheduleListResponse,
    _$ScheduleListResponse
  ];
  @override
  final String wireName = 'ScheduleListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ScheduleListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ScheduleEntity)])),
    ];

    return result;
  }

  @override
  ScheduleListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ScheduleEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleItemResponseSerializer
    implements StructuredSerializer<ScheduleItemResponse> {
  @override
  final Iterable<Type> types = const [
    ScheduleItemResponse,
    _$ScheduleItemResponse
  ];
  @override
  final String wireName = 'ScheduleItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ScheduleItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ScheduleEntity)),
    ];

    return result;
  }

  @override
  ScheduleItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ScheduleEntity))!
              as ScheduleEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleEntitySerializer
    implements StructuredSerializer<ScheduleEntity> {
  @override
  final Iterable<Type> types = const [ScheduleEntity, _$ScheduleEntity];
  @override
  final String wireName = 'ScheduleEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, ScheduleEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'frequency_id',
      serializers.serialize(object.frequencyId,
          specifiedType: const FullType(String)),
      'next_run',
      serializers.serialize(object.nextRun,
          specifiedType: const FullType(String)),
      'template',
      serializers.serialize(object.template,
          specifiedType: const FullType(String)),
      'is_paused',
      serializers.serialize(object.isPaused,
          specifiedType: const FullType(bool)),
      'remaining_cycles',
      serializers.serialize(object.remainingCycles,
          specifiedType: const FullType(int)),
      'parameters',
      serializers.serialize(object.parameters,
          specifiedType: const FullType(ScheduleParameters)),
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
  ScheduleEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'frequency_id':
          result.frequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'next_run':
          result.nextRun = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'template':
          result.template = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'is_paused':
          result.isPaused = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'remaining_cycles':
          result.remainingCycles = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'parameters':
          result.parameters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ScheduleParameters))!
              as ScheduleParameters);
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

class _$ScheduleParametersSerializer
    implements StructuredSerializer<ScheduleParameters> {
  @override
  final Iterable<Type> types = const [ScheduleParameters, _$ScheduleParameters];
  @override
  final String wireName = 'ScheduleParameters';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ScheduleParameters object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.dateRange;
    if (value != null) {
      result
        ..add('date_range')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.showPaymentsTable;
    if (value != null) {
      result
        ..add('show_payments_table')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.showCreditsTable;
    if (value != null) {
      result
        ..add('show_credits_table')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.showAgingTable;
    if (value != null) {
      result
        ..add('show_aging_table')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.onlyClientsWithInvoices;
    if (value != null) {
      result
        ..add('only_clients_with_invoices')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clients;
    if (value != null) {
      result
        ..add('clients')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.entityType;
    if (value != null) {
      result
        ..add('entity')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.entityId;
    if (value != null) {
      result
        ..add('entity_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reportName;
    if (value != null) {
      result
        ..add('report_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ScheduleParameters deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleParametersBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'date_range':
          result.dateRange = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'show_payments_table':
          result.showPaymentsTable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'show_credits_table':
          result.showCreditsTable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'show_aging_table':
          result.showAgingTable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'only_clients_with_invoices':
          result.onlyClientsWithInvoices = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'clients':
          result.clients.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'entity':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'entity_id':
          result.entityId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'report_name':
          result.reportName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleListResponse extends ScheduleListResponse {
  @override
  final BuiltList<ScheduleEntity> data;

  factory _$ScheduleListResponse(
          [void Function(ScheduleListResponseBuilder)? updates]) =>
      (new ScheduleListResponseBuilder()..update(updates))._build();

  _$ScheduleListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'ScheduleListResponse', 'data');
  }

  @override
  ScheduleListResponse rebuild(
          void Function(ScheduleListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleListResponseBuilder toBuilder() =>
      new ScheduleListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'ScheduleListResponse')
          ..add('data', data))
        .toString();
  }
}

class ScheduleListResponseBuilder
    implements Builder<ScheduleListResponse, ScheduleListResponseBuilder> {
  _$ScheduleListResponse? _$v;

  ListBuilder<ScheduleEntity>? _data;
  ListBuilder<ScheduleEntity> get data =>
      _$this._data ??= new ListBuilder<ScheduleEntity>();
  set data(ListBuilder<ScheduleEntity>? data) => _$this._data = data;

  ScheduleListResponseBuilder();

  ScheduleListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScheduleListResponse;
  }

  @override
  void update(void Function(ScheduleListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleListResponse build() => _build();

  _$ScheduleListResponse _build() {
    _$ScheduleListResponse _$result;
    try {
      _$result = _$v ?? new _$ScheduleListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ScheduleListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ScheduleItemResponse extends ScheduleItemResponse {
  @override
  final ScheduleEntity data;

  factory _$ScheduleItemResponse(
          [void Function(ScheduleItemResponseBuilder)? updates]) =>
      (new ScheduleItemResponseBuilder()..update(updates))._build();

  _$ScheduleItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'ScheduleItemResponse', 'data');
  }

  @override
  ScheduleItemResponse rebuild(
          void Function(ScheduleItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleItemResponseBuilder toBuilder() =>
      new ScheduleItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'ScheduleItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ScheduleItemResponseBuilder
    implements Builder<ScheduleItemResponse, ScheduleItemResponseBuilder> {
  _$ScheduleItemResponse? _$v;

  ScheduleEntityBuilder? _data;
  ScheduleEntityBuilder get data =>
      _$this._data ??= new ScheduleEntityBuilder();
  set data(ScheduleEntityBuilder? data) => _$this._data = data;

  ScheduleItemResponseBuilder();

  ScheduleItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScheduleItemResponse;
  }

  @override
  void update(void Function(ScheduleItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleItemResponse build() => _build();

  _$ScheduleItemResponse _build() {
    _$ScheduleItemResponse _$result;
    try {
      _$result = _$v ?? new _$ScheduleItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ScheduleItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ScheduleEntity extends ScheduleEntity {
  @override
  final String frequencyId;
  @override
  final String nextRun;
  @override
  final String template;
  @override
  final bool isPaused;
  @override
  final int remainingCycles;
  @override
  final ScheduleParameters parameters;
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

  factory _$ScheduleEntity([void Function(ScheduleEntityBuilder)? updates]) =>
      (new ScheduleEntityBuilder()..update(updates))._build();

  _$ScheduleEntity._(
      {required this.frequencyId,
      required this.nextRun,
      required this.template,
      required this.isPaused,
      required this.remainingCycles,
      required this.parameters,
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
        frequencyId, r'ScheduleEntity', 'frequencyId');
    BuiltValueNullFieldError.checkNotNull(
        nextRun, r'ScheduleEntity', 'nextRun');
    BuiltValueNullFieldError.checkNotNull(
        template, r'ScheduleEntity', 'template');
    BuiltValueNullFieldError.checkNotNull(
        isPaused, r'ScheduleEntity', 'isPaused');
    BuiltValueNullFieldError.checkNotNull(
        remainingCycles, r'ScheduleEntity', 'remainingCycles');
    BuiltValueNullFieldError.checkNotNull(
        parameters, r'ScheduleEntity', 'parameters');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'ScheduleEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'ScheduleEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'ScheduleEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'ScheduleEntity', 'id');
  }

  @override
  ScheduleEntity rebuild(void Function(ScheduleEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleEntityBuilder toBuilder() =>
      new ScheduleEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleEntity &&
        frequencyId == other.frequencyId &&
        nextRun == other.nextRun &&
        template == other.template &&
        isPaused == other.isPaused &&
        remainingCycles == other.remainingCycles &&
        parameters == other.parameters &&
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
    _$hash = $jc(_$hash, frequencyId.hashCode);
    _$hash = $jc(_$hash, nextRun.hashCode);
    _$hash = $jc(_$hash, template.hashCode);
    _$hash = $jc(_$hash, isPaused.hashCode);
    _$hash = $jc(_$hash, remainingCycles.hashCode);
    _$hash = $jc(_$hash, parameters.hashCode);
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
    return (newBuiltValueToStringHelper(r'ScheduleEntity')
          ..add('frequencyId', frequencyId)
          ..add('nextRun', nextRun)
          ..add('template', template)
          ..add('isPaused', isPaused)
          ..add('remainingCycles', remainingCycles)
          ..add('parameters', parameters)
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

class ScheduleEntityBuilder
    implements Builder<ScheduleEntity, ScheduleEntityBuilder> {
  _$ScheduleEntity? _$v;

  String? _frequencyId;
  String? get frequencyId => _$this._frequencyId;
  set frequencyId(String? frequencyId) => _$this._frequencyId = frequencyId;

  String? _nextRun;
  String? get nextRun => _$this._nextRun;
  set nextRun(String? nextRun) => _$this._nextRun = nextRun;

  String? _template;
  String? get template => _$this._template;
  set template(String? template) => _$this._template = template;

  bool? _isPaused;
  bool? get isPaused => _$this._isPaused;
  set isPaused(bool? isPaused) => _$this._isPaused = isPaused;

  int? _remainingCycles;
  int? get remainingCycles => _$this._remainingCycles;
  set remainingCycles(int? remainingCycles) =>
      _$this._remainingCycles = remainingCycles;

  ScheduleParametersBuilder? _parameters;
  ScheduleParametersBuilder get parameters =>
      _$this._parameters ??= new ScheduleParametersBuilder();
  set parameters(ScheduleParametersBuilder? parameters) =>
      _$this._parameters = parameters;

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

  ScheduleEntityBuilder();

  ScheduleEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _frequencyId = $v.frequencyId;
      _nextRun = $v.nextRun;
      _template = $v.template;
      _isPaused = $v.isPaused;
      _remainingCycles = $v.remainingCycles;
      _parameters = $v.parameters.toBuilder();
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
  void replace(ScheduleEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScheduleEntity;
  }

  @override
  void update(void Function(ScheduleEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleEntity build() => _build();

  _$ScheduleEntity _build() {
    _$ScheduleEntity _$result;
    try {
      _$result = _$v ??
          new _$ScheduleEntity._(
              frequencyId: BuiltValueNullFieldError.checkNotNull(
                  frequencyId, r'ScheduleEntity', 'frequencyId'),
              nextRun: BuiltValueNullFieldError.checkNotNull(
                  nextRun, r'ScheduleEntity', 'nextRun'),
              template: BuiltValueNullFieldError.checkNotNull(
                  template, r'ScheduleEntity', 'template'),
              isPaused: BuiltValueNullFieldError.checkNotNull(
                  isPaused, r'ScheduleEntity', 'isPaused'),
              remainingCycles: BuiltValueNullFieldError.checkNotNull(
                  remainingCycles, r'ScheduleEntity', 'remainingCycles'),
              parameters: parameters.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'ScheduleEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, r'ScheduleEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(
                  archivedAt, r'ScheduleEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, r'ScheduleEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'parameters';
        parameters.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ScheduleEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ScheduleParameters extends ScheduleParameters {
  @override
  final String? dateRange;
  @override
  final bool? showPaymentsTable;
  @override
  final bool? showCreditsTable;
  @override
  final bool? showAgingTable;
  @override
  final bool? onlyClientsWithInvoices;
  @override
  final String? status;
  @override
  final BuiltList<String>? clients;
  @override
  final String? entityType;
  @override
  final String? entityId;
  @override
  final String? reportName;

  factory _$ScheduleParameters(
          [void Function(ScheduleParametersBuilder)? updates]) =>
      (new ScheduleParametersBuilder()..update(updates))._build();

  _$ScheduleParameters._(
      {this.dateRange,
      this.showPaymentsTable,
      this.showCreditsTable,
      this.showAgingTable,
      this.onlyClientsWithInvoices,
      this.status,
      this.clients,
      this.entityType,
      this.entityId,
      this.reportName})
      : super._();

  @override
  ScheduleParameters rebuild(
          void Function(ScheduleParametersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleParametersBuilder toBuilder() =>
      new ScheduleParametersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleParameters &&
        dateRange == other.dateRange &&
        showPaymentsTable == other.showPaymentsTable &&
        showCreditsTable == other.showCreditsTable &&
        showAgingTable == other.showAgingTable &&
        onlyClientsWithInvoices == other.onlyClientsWithInvoices &&
        status == other.status &&
        clients == other.clients &&
        entityType == other.entityType &&
        entityId == other.entityId &&
        reportName == other.reportName;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, dateRange.hashCode);
    _$hash = $jc(_$hash, showPaymentsTable.hashCode);
    _$hash = $jc(_$hash, showCreditsTable.hashCode);
    _$hash = $jc(_$hash, showAgingTable.hashCode);
    _$hash = $jc(_$hash, onlyClientsWithInvoices.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, clients.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, reportName.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScheduleParameters')
          ..add('dateRange', dateRange)
          ..add('showPaymentsTable', showPaymentsTable)
          ..add('showCreditsTable', showCreditsTable)
          ..add('showAgingTable', showAgingTable)
          ..add('onlyClientsWithInvoices', onlyClientsWithInvoices)
          ..add('status', status)
          ..add('clients', clients)
          ..add('entityType', entityType)
          ..add('entityId', entityId)
          ..add('reportName', reportName))
        .toString();
  }
}

class ScheduleParametersBuilder
    implements Builder<ScheduleParameters, ScheduleParametersBuilder> {
  _$ScheduleParameters? _$v;

  String? _dateRange;
  String? get dateRange => _$this._dateRange;
  set dateRange(String? dateRange) => _$this._dateRange = dateRange;

  bool? _showPaymentsTable;
  bool? get showPaymentsTable => _$this._showPaymentsTable;
  set showPaymentsTable(bool? showPaymentsTable) =>
      _$this._showPaymentsTable = showPaymentsTable;

  bool? _showCreditsTable;
  bool? get showCreditsTable => _$this._showCreditsTable;
  set showCreditsTable(bool? showCreditsTable) =>
      _$this._showCreditsTable = showCreditsTable;

  bool? _showAgingTable;
  bool? get showAgingTable => _$this._showAgingTable;
  set showAgingTable(bool? showAgingTable) =>
      _$this._showAgingTable = showAgingTable;

  bool? _onlyClientsWithInvoices;
  bool? get onlyClientsWithInvoices => _$this._onlyClientsWithInvoices;
  set onlyClientsWithInvoices(bool? onlyClientsWithInvoices) =>
      _$this._onlyClientsWithInvoices = onlyClientsWithInvoices;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  ListBuilder<String>? _clients;
  ListBuilder<String> get clients =>
      _$this._clients ??= new ListBuilder<String>();
  set clients(ListBuilder<String>? clients) => _$this._clients = clients;

  String? _entityType;
  String? get entityType => _$this._entityType;
  set entityType(String? entityType) => _$this._entityType = entityType;

  String? _entityId;
  String? get entityId => _$this._entityId;
  set entityId(String? entityId) => _$this._entityId = entityId;

  String? _reportName;
  String? get reportName => _$this._reportName;
  set reportName(String? reportName) => _$this._reportName = reportName;

  ScheduleParametersBuilder();

  ScheduleParametersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dateRange = $v.dateRange;
      _showPaymentsTable = $v.showPaymentsTable;
      _showCreditsTable = $v.showCreditsTable;
      _showAgingTable = $v.showAgingTable;
      _onlyClientsWithInvoices = $v.onlyClientsWithInvoices;
      _status = $v.status;
      _clients = $v.clients?.toBuilder();
      _entityType = $v.entityType;
      _entityId = $v.entityId;
      _reportName = $v.reportName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleParameters other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScheduleParameters;
  }

  @override
  void update(void Function(ScheduleParametersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleParameters build() => _build();

  _$ScheduleParameters _build() {
    _$ScheduleParameters _$result;
    try {
      _$result = _$v ??
          new _$ScheduleParameters._(
              dateRange: dateRange,
              showPaymentsTable: showPaymentsTable,
              showCreditsTable: showCreditsTable,
              showAgingTable: showAgingTable,
              onlyClientsWithInvoices: onlyClientsWithInvoices,
              status: status,
              clients: _clients?.build(),
              entityType: entityType,
              entityId: entityId,
              reportName: reportName);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'clients';
        _clients?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ScheduleParameters', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
