// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TokenListResponse> _$tokenListResponseSerializer =
    new _$TokenListResponseSerializer();
Serializer<TokenItemResponse> _$tokenItemResponseSerializer =
    new _$TokenItemResponseSerializer();
Serializer<TokenEntity> _$tokenEntitySerializer = new _$TokenEntitySerializer();

class _$TokenListResponseSerializer
    implements StructuredSerializer<TokenListResponse> {
  @override
  final Iterable<Type> types = const [TokenListResponse, _$TokenListResponse];
  @override
  final String wireName = 'TokenListResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, TokenListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TokenEntity)])),
    ];

    return result;
  }

  @override
  TokenListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TokenEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$TokenItemResponseSerializer
    implements StructuredSerializer<TokenItemResponse> {
  @override
  final Iterable<Type> types = const [TokenItemResponse, _$TokenItemResponse];
  @override
  final String wireName = 'TokenItemResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, TokenItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TokenEntity)),
    ];

    return result;
  }

  @override
  TokenItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(TokenEntity))! as TokenEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$TokenEntitySerializer implements StructuredSerializer<TokenEntity> {
  @override
  final Iterable<Type> types = const [TokenEntity, _$TokenEntity];
  @override
  final String wireName = 'TokenEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, TokenEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'is_system',
      serializers.serialize(object.isSystem,
          specifiedType: const FullType(bool)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
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
  TokenEntity deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'is_system':
          result.isSystem = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$TokenListResponse extends TokenListResponse {
  @override
  final BuiltList<TokenEntity> data;

  factory _$TokenListResponse(
          [void Function(TokenListResponseBuilder)? updates]) =>
      (new TokenListResponseBuilder()..update(updates))._build();

  _$TokenListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'TokenListResponse', 'data');
  }

  @override
  TokenListResponse rebuild(void Function(TokenListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenListResponseBuilder toBuilder() =>
      new TokenListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'TokenListResponse')
          ..add('data', data))
        .toString();
  }
}

class TokenListResponseBuilder
    implements Builder<TokenListResponse, TokenListResponseBuilder> {
  _$TokenListResponse? _$v;

  ListBuilder<TokenEntity>? _data;
  ListBuilder<TokenEntity> get data =>
      _$this._data ??= new ListBuilder<TokenEntity>();
  set data(ListBuilder<TokenEntity>? data) => _$this._data = data;

  TokenListResponseBuilder();

  TokenListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TokenListResponse;
  }

  @override
  void update(void Function(TokenListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenListResponse build() => _build();

  _$TokenListResponse _build() {
    _$TokenListResponse _$result;
    try {
      _$result = _$v ?? new _$TokenListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TokenListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TokenItemResponse extends TokenItemResponse {
  @override
  final TokenEntity data;

  factory _$TokenItemResponse(
          [void Function(TokenItemResponseBuilder)? updates]) =>
      (new TokenItemResponseBuilder()..update(updates))._build();

  _$TokenItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'TokenItemResponse', 'data');
  }

  @override
  TokenItemResponse rebuild(void Function(TokenItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenItemResponseBuilder toBuilder() =>
      new TokenItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'TokenItemResponse')
          ..add('data', data))
        .toString();
  }
}

class TokenItemResponseBuilder
    implements Builder<TokenItemResponse, TokenItemResponseBuilder> {
  _$TokenItemResponse? _$v;

  TokenEntityBuilder? _data;
  TokenEntityBuilder get data => _$this._data ??= new TokenEntityBuilder();
  set data(TokenEntityBuilder? data) => _$this._data = data;

  TokenItemResponseBuilder();

  TokenItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TokenItemResponse;
  }

  @override
  void update(void Function(TokenItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenItemResponse build() => _build();

  _$TokenItemResponse _build() {
    _$TokenItemResponse _$result;
    try {
      _$result = _$v ?? new _$TokenItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TokenItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TokenEntity extends TokenEntity {
  @override
  final bool isSystem;
  @override
  final String token;
  @override
  final String name;
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

  factory _$TokenEntity([void Function(TokenEntityBuilder)? updates]) =>
      (new TokenEntityBuilder()..update(updates))._build();

  _$TokenEntity._(
      {required this.isSystem,
      required this.token,
      required this.name,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isSystem, r'TokenEntity', 'isSystem');
    BuiltValueNullFieldError.checkNotNull(token, r'TokenEntity', 'token');
    BuiltValueNullFieldError.checkNotNull(name, r'TokenEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'TokenEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'TokenEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'TokenEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'TokenEntity', 'id');
  }

  @override
  TokenEntity rebuild(void Function(TokenEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenEntityBuilder toBuilder() => new TokenEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenEntity &&
        isSystem == other.isSystem &&
        token == other.token &&
        name == other.name &&
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
    _$hash = $jc(_$hash, isSystem.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
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
    return (newBuiltValueToStringHelper(r'TokenEntity')
          ..add('isSystem', isSystem)
          ..add('token', token)
          ..add('name', name)
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

class TokenEntityBuilder implements Builder<TokenEntity, TokenEntityBuilder> {
  _$TokenEntity? _$v;

  bool? _isSystem;
  bool? get isSystem => _$this._isSystem;
  set isSystem(bool? isSystem) => _$this._isSystem = isSystem;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

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

  TokenEntityBuilder();

  TokenEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSystem = $v.isSystem;
      _token = $v.token;
      _name = $v.name;
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
  void replace(TokenEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TokenEntity;
  }

  @override
  void update(void Function(TokenEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenEntity build() => _build();

  _$TokenEntity _build() {
    final _$result = _$v ??
        new _$TokenEntity._(
            isSystem: BuiltValueNullFieldError.checkNotNull(
                isSystem, r'TokenEntity', 'isSystem'),
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'TokenEntity', 'token'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'TokenEntity', 'name'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'TokenEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'TokenEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(
                archivedAt, r'TokenEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'TokenEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
