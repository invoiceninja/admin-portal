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
  Iterable<Object> serialize(Serializers serializers, TokenListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TokenEntity)])),
    ];

    return result;
  }

  @override
  TokenListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TokenEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(Serializers serializers, TokenItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TokenEntity)),
    ];

    return result;
  }

  @override
  TokenItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(TokenEntity)) as TokenEntity);
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
  Iterable<Object> serialize(Serializers serializers, TokenEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
  TokenEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'is_system':
          result.isSystem = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$TokenListResponse extends TokenListResponse {
  @override
  final BuiltList<TokenEntity> data;

  factory _$TokenListResponse(
          [void Function(TokenListResponseBuilder) updates]) =>
      (new TokenListResponseBuilder()..update(updates)).build();

  _$TokenListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TokenListResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TokenListResponse')..add('data', data))
        .toString();
  }
}

class TokenListResponseBuilder
    implements Builder<TokenListResponse, TokenListResponseBuilder> {
  _$TokenListResponse _$v;

  ListBuilder<TokenEntity> _data;
  ListBuilder<TokenEntity> get data =>
      _$this._data ??= new ListBuilder<TokenEntity>();
  set data(ListBuilder<TokenEntity> data) => _$this._data = data;

  TokenListResponseBuilder();

  TokenListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TokenListResponse;
  }

  @override
  void update(void Function(TokenListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TokenListResponse build() {
    _$TokenListResponse _$result;
    try {
      _$result = _$v ?? new _$TokenListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TokenListResponse', _$failedField, e.toString());
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
          [void Function(TokenItemResponseBuilder) updates]) =>
      (new TokenItemResponseBuilder()..update(updates)).build();

  _$TokenItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TokenItemResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TokenItemResponse')..add('data', data))
        .toString();
  }
}

class TokenItemResponseBuilder
    implements Builder<TokenItemResponse, TokenItemResponseBuilder> {
  _$TokenItemResponse _$v;

  TokenEntityBuilder _data;
  TokenEntityBuilder get data => _$this._data ??= new TokenEntityBuilder();
  set data(TokenEntityBuilder data) => _$this._data = data;

  TokenItemResponseBuilder();

  TokenItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TokenItemResponse;
  }

  @override
  void update(void Function(TokenItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TokenItemResponse build() {
    _$TokenItemResponse _$result;
    try {
      _$result = _$v ?? new _$TokenItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TokenItemResponse', _$failedField, e.toString());
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

  factory _$TokenEntity([void Function(TokenEntityBuilder) updates]) =>
      (new TokenEntityBuilder()..update(updates)).build();

  _$TokenEntity._(
      {this.isSystem,
      this.token,
      this.name,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (isSystem == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'isSystem');
    }
    if (token == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'token');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'name');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'id');
    }
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
                                        $jc($jc(0, isSystem.hashCode),
                                            token.hashCode),
                                        name.hashCode),
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
    return (newBuiltValueToStringHelper('TokenEntity')
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
  _$TokenEntity _$v;

  bool _isSystem;
  bool get isSystem => _$this._isSystem;
  set isSystem(bool isSystem) => _$this._isSystem = isSystem;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

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

  TokenEntityBuilder();

  TokenEntityBuilder get _$this {
    if (_$v != null) {
      _isSystem = _$v.isSystem;
      _token = _$v.token;
      _name = _$v.name;
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
  void replace(TokenEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TokenEntity;
  }

  @override
  void update(void Function(TokenEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TokenEntity build() {
    final _$result = _$v ??
        new _$TokenEntity._(
            isSystem: isSystem,
            token: token,
            name: name,
            isChanged: isChanged,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
