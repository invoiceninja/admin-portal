// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BankAccountListResponse> _$bankAccountListResponseSerializer =
    new _$BankAccountListResponseSerializer();
Serializer<BankAccountItemResponse> _$bankAccountItemResponseSerializer =
    new _$BankAccountItemResponseSerializer();
Serializer<BankAccountEntity> _$bankAccountEntitySerializer =
    new _$BankAccountEntitySerializer();

class _$BankAccountListResponseSerializer
    implements StructuredSerializer<BankAccountListResponse> {
  @override
  final Iterable<Type> types = const [
    BankAccountListResponse,
    _$BankAccountListResponse
  ];
  @override
  final String wireName = 'BankAccountListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, BankAccountListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(BankAccountEntity)])),
    ];

    return result;
  }

  @override
  BankAccountListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BankAccountEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$BankAccountItemResponseSerializer
    implements StructuredSerializer<BankAccountItemResponse> {
  @override
  final Iterable<Type> types = const [
    BankAccountItemResponse,
    _$BankAccountItemResponse
  ];
  @override
  final String wireName = 'BankAccountItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, BankAccountItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(BankAccountEntity)),
    ];

    return result;
  }

  @override
  BankAccountItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BankAccountEntity))
              as BankAccountEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$BankAccountEntitySerializer
    implements StructuredSerializer<BankAccountEntity> {
  @override
  final Iterable<Type> types = const [BankAccountEntity, _$BankAccountEntity];
  @override
  final String wireName = 'BankAccountEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, BankAccountEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
    Object value;
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
  BankAccountEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
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

class _$BankAccountListResponse extends BankAccountListResponse {
  @override
  final BuiltList<BankAccountEntity> data;

  factory _$BankAccountListResponse(
          [void Function(BankAccountListResponseBuilder) updates]) =>
      (new BankAccountListResponseBuilder()..update(updates)).build();

  _$BankAccountListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'BankAccountListResponse', 'data');
  }

  @override
  BankAccountListResponse rebuild(
          void Function(BankAccountListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountListResponseBuilder toBuilder() =>
      new BankAccountListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BankAccountListResponse')
          ..add('data', data))
        .toString();
  }
}

class BankAccountListResponseBuilder
    implements
        Builder<BankAccountListResponse, BankAccountListResponseBuilder> {
  _$BankAccountListResponse _$v;

  ListBuilder<BankAccountEntity> _data;
  ListBuilder<BankAccountEntity> get data =>
      _$this._data ??= new ListBuilder<BankAccountEntity>();
  set data(ListBuilder<BankAccountEntity> data) => _$this._data = data;

  BankAccountListResponseBuilder();

  BankAccountListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BankAccountListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountListResponse;
  }

  @override
  void update(void Function(BankAccountListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BankAccountListResponse build() {
    _$BankAccountListResponse _$result;
    try {
      _$result = _$v ?? new _$BankAccountListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BankAccountListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$BankAccountItemResponse extends BankAccountItemResponse {
  @override
  final BankAccountEntity data;

  factory _$BankAccountItemResponse(
          [void Function(BankAccountItemResponseBuilder) updates]) =>
      (new BankAccountItemResponseBuilder()..update(updates)).build();

  _$BankAccountItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'BankAccountItemResponse', 'data');
  }

  @override
  BankAccountItemResponse rebuild(
          void Function(BankAccountItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountItemResponseBuilder toBuilder() =>
      new BankAccountItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BankAccountItemResponse')
          ..add('data', data))
        .toString();
  }
}

class BankAccountItemResponseBuilder
    implements
        Builder<BankAccountItemResponse, BankAccountItemResponseBuilder> {
  _$BankAccountItemResponse _$v;

  BankAccountEntityBuilder _data;
  BankAccountEntityBuilder get data =>
      _$this._data ??= new BankAccountEntityBuilder();
  set data(BankAccountEntityBuilder data) => _$this._data = data;

  BankAccountItemResponseBuilder();

  BankAccountItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BankAccountItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountItemResponse;
  }

  @override
  void update(void Function(BankAccountItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BankAccountItemResponse build() {
    _$BankAccountItemResponse _$result;
    try {
      _$result = _$v ?? new _$BankAccountItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BankAccountItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$BankAccountEntity extends BankAccountEntity {
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

  factory _$BankAccountEntity(
          [void Function(BankAccountEntityBuilder) updates]) =>
      (new BankAccountEntityBuilder()..update(updates)).build();

  _$BankAccountEntity._(
      {this.name,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'BankAccountEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'BankAccountEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'BankAccountEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'BankAccountEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'BankAccountEntity', 'id');
  }

  @override
  BankAccountEntity rebuild(void Function(BankAccountEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountEntityBuilder toBuilder() =>
      new BankAccountEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountEntity &&
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
                            $jc($jc($jc(0, name.hashCode), isChanged.hashCode),
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
    return (newBuiltValueToStringHelper('BankAccountEntity')
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

class BankAccountEntityBuilder
    implements Builder<BankAccountEntity, BankAccountEntityBuilder> {
  _$BankAccountEntity _$v;

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

  BankAccountEntityBuilder();

  BankAccountEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(BankAccountEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountEntity;
  }

  @override
  void update(void Function(BankAccountEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BankAccountEntity build() {
    final _$result = _$v ??
        new _$BankAccountEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'BankAccountEntity', 'name'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, 'BankAccountEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, 'BankAccountEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(
                archivedAt, 'BankAccountEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'BankAccountEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
