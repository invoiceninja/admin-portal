// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_log_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SystemLogEntity> _$systemLogEntitySerializer =
    new _$SystemLogEntitySerializer();

class _$SystemLogEntitySerializer
    implements StructuredSerializer<SystemLogEntity> {
  @override
  final Iterable<Type> types = const [SystemLogEntity, _$SystemLogEntity];
  @override
  final String wireName = 'SystemLogEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, SystemLogEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'company_id',
      serializers.serialize(object.companyId,
          specifiedType: const FullType(String)),
      'user_id',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'event_id',
      serializers.serialize(object.eventId, specifiedType: const FullType(int)),
      'category_id',
      serializers.serialize(object.categoryId,
          specifiedType: const FullType(int)),
      'type_id',
      serializers.serialize(object.typeId, specifiedType: const FullType(int)),
      'log',
      serializers.serialize(object.log, specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  SystemLogEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SystemLogEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'company_id':
          result.companyId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'event_id':
          result.eventId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'category_id':
          result.categoryId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'type_id':
          result.typeId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'log':
          result.log = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$SystemLogEntity extends SystemLogEntity {
  @override
  final String id;
  @override
  final String companyId;
  @override
  final String userId;
  @override
  final String clientId;
  @override
  final int eventId;
  @override
  final int categoryId;
  @override
  final int typeId;
  @override
  final String log;
  @override
  final int createdAt;

  factory _$SystemLogEntity([void Function(SystemLogEntityBuilder)? updates]) =>
      (new SystemLogEntityBuilder()..update(updates))._build();

  _$SystemLogEntity._(
      {required this.id,
      required this.companyId,
      required this.userId,
      required this.clientId,
      required this.eventId,
      required this.categoryId,
      required this.typeId,
      required this.log,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SystemLogEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(
        companyId, r'SystemLogEntity', 'companyId');
    BuiltValueNullFieldError.checkNotNull(userId, r'SystemLogEntity', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        clientId, r'SystemLogEntity', 'clientId');
    BuiltValueNullFieldError.checkNotNull(
        eventId, r'SystemLogEntity', 'eventId');
    BuiltValueNullFieldError.checkNotNull(
        categoryId, r'SystemLogEntity', 'categoryId');
    BuiltValueNullFieldError.checkNotNull(typeId, r'SystemLogEntity', 'typeId');
    BuiltValueNullFieldError.checkNotNull(log, r'SystemLogEntity', 'log');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'SystemLogEntity', 'createdAt');
  }

  @override
  SystemLogEntity rebuild(void Function(SystemLogEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemLogEntityBuilder toBuilder() =>
      new SystemLogEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemLogEntity &&
        id == other.id &&
        companyId == other.companyId &&
        userId == other.userId &&
        clientId == other.clientId &&
        eventId == other.eventId &&
        categoryId == other.categoryId &&
        typeId == other.typeId &&
        log == other.log &&
        createdAt == other.createdAt;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, typeId.hashCode);
    _$hash = $jc(_$hash, log.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemLogEntity')
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('userId', userId)
          ..add('clientId', clientId)
          ..add('eventId', eventId)
          ..add('categoryId', categoryId)
          ..add('typeId', typeId)
          ..add('log', log)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class SystemLogEntityBuilder
    implements Builder<SystemLogEntity, SystemLogEntityBuilder> {
  _$SystemLogEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  int? _eventId;
  int? get eventId => _$this._eventId;
  set eventId(int? eventId) => _$this._eventId = eventId;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  int? _typeId;
  int? get typeId => _$this._typeId;
  set typeId(int? typeId) => _$this._typeId = typeId;

  String? _log;
  String? get log => _$this._log;
  set log(String? log) => _$this._log = log;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  SystemLogEntityBuilder();

  SystemLogEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _companyId = $v.companyId;
      _userId = $v.userId;
      _clientId = $v.clientId;
      _eventId = $v.eventId;
      _categoryId = $v.categoryId;
      _typeId = $v.typeId;
      _log = $v.log;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemLogEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SystemLogEntity;
  }

  @override
  void update(void Function(SystemLogEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemLogEntity build() => _build();

  _$SystemLogEntity _build() {
    final _$result = _$v ??
        new _$SystemLogEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'SystemLogEntity', 'id'),
            companyId: BuiltValueNullFieldError.checkNotNull(
                companyId, r'SystemLogEntity', 'companyId'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'SystemLogEntity', 'userId'),
            clientId: BuiltValueNullFieldError.checkNotNull(
                clientId, r'SystemLogEntity', 'clientId'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'SystemLogEntity', 'eventId'),
            categoryId: BuiltValueNullFieldError.checkNotNull(
                categoryId, r'SystemLogEntity', 'categoryId'),
            typeId: BuiltValueNullFieldError.checkNotNull(
                typeId, r'SystemLogEntity', 'typeId'),
            log: BuiltValueNullFieldError.checkNotNull(
                log, r'SystemLogEntity', 'log'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'SystemLogEntity', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
