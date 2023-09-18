// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ExpenseCategoryListResponse>
    _$expenseCategoryListResponseSerializer =
    new _$ExpenseCategoryListResponseSerializer();
Serializer<ExpenseCategoryItemResponse>
    _$expenseCategoryItemResponseSerializer =
    new _$ExpenseCategoryItemResponseSerializer();
Serializer<ExpenseCategoryEntity> _$expenseCategoryEntitySerializer =
    new _$ExpenseCategoryEntitySerializer();

class _$ExpenseCategoryListResponseSerializer
    implements StructuredSerializer<ExpenseCategoryListResponse> {
  @override
  final Iterable<Type> types = const [
    ExpenseCategoryListResponse,
    _$ExpenseCategoryListResponse
  ];
  @override
  final String wireName = 'ExpenseCategoryListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ExpenseCategoryListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ExpenseCategoryEntity)])),
    ];

    return result;
  }

  @override
  ExpenseCategoryListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseCategoryListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(ExpenseCategoryEntity)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ExpenseCategoryItemResponseSerializer
    implements StructuredSerializer<ExpenseCategoryItemResponse> {
  @override
  final Iterable<Type> types = const [
    ExpenseCategoryItemResponse,
    _$ExpenseCategoryItemResponse
  ];
  @override
  final String wireName = 'ExpenseCategoryItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ExpenseCategoryItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ExpenseCategoryEntity)),
    ];

    return result;
  }

  @override
  ExpenseCategoryItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseCategoryItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExpenseCategoryEntity))!
              as ExpenseCategoryEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$ExpenseCategoryEntitySerializer
    implements StructuredSerializer<ExpenseCategoryEntity> {
  @override
  final Iterable<Type> types = const [
    ExpenseCategoryEntity,
    _$ExpenseCategoryEntity
  ];
  @override
  final String wireName = 'ExpenseCategoryEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ExpenseCategoryEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'color',
      serializers.serialize(object.color,
          specifiedType: const FullType(String)),
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
  ExpenseCategoryEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseCategoryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
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

class _$ExpenseCategoryListResponse extends ExpenseCategoryListResponse {
  @override
  final BuiltList<ExpenseCategoryEntity> data;

  factory _$ExpenseCategoryListResponse(
          [void Function(ExpenseCategoryListResponseBuilder)? updates]) =>
      (new ExpenseCategoryListResponseBuilder()..update(updates))._build();

  _$ExpenseCategoryListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'ExpenseCategoryListResponse', 'data');
  }

  @override
  ExpenseCategoryListResponse rebuild(
          void Function(ExpenseCategoryListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseCategoryListResponseBuilder toBuilder() =>
      new ExpenseCategoryListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseCategoryListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'ExpenseCategoryListResponse')
          ..add('data', data))
        .toString();
  }
}

class ExpenseCategoryListResponseBuilder
    implements
        Builder<ExpenseCategoryListResponse,
            ExpenseCategoryListResponseBuilder> {
  _$ExpenseCategoryListResponse? _$v;

  ListBuilder<ExpenseCategoryEntity>? _data;
  ListBuilder<ExpenseCategoryEntity> get data =>
      _$this._data ??= new ListBuilder<ExpenseCategoryEntity>();
  set data(ListBuilder<ExpenseCategoryEntity>? data) => _$this._data = data;

  ExpenseCategoryListResponseBuilder();

  ExpenseCategoryListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseCategoryListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseCategoryListResponse;
  }

  @override
  void update(void Function(ExpenseCategoryListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpenseCategoryListResponse build() => _build();

  _$ExpenseCategoryListResponse _build() {
    _$ExpenseCategoryListResponse _$result;
    try {
      _$result = _$v ?? new _$ExpenseCategoryListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ExpenseCategoryListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseCategoryItemResponse extends ExpenseCategoryItemResponse {
  @override
  final ExpenseCategoryEntity data;

  factory _$ExpenseCategoryItemResponse(
          [void Function(ExpenseCategoryItemResponseBuilder)? updates]) =>
      (new ExpenseCategoryItemResponseBuilder()..update(updates))._build();

  _$ExpenseCategoryItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'ExpenseCategoryItemResponse', 'data');
  }

  @override
  ExpenseCategoryItemResponse rebuild(
          void Function(ExpenseCategoryItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseCategoryItemResponseBuilder toBuilder() =>
      new ExpenseCategoryItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseCategoryItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'ExpenseCategoryItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ExpenseCategoryItemResponseBuilder
    implements
        Builder<ExpenseCategoryItemResponse,
            ExpenseCategoryItemResponseBuilder> {
  _$ExpenseCategoryItemResponse? _$v;

  ExpenseCategoryEntityBuilder? _data;
  ExpenseCategoryEntityBuilder get data =>
      _$this._data ??= new ExpenseCategoryEntityBuilder();
  set data(ExpenseCategoryEntityBuilder? data) => _$this._data = data;

  ExpenseCategoryItemResponseBuilder();

  ExpenseCategoryItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseCategoryItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseCategoryItemResponse;
  }

  @override
  void update(void Function(ExpenseCategoryItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpenseCategoryItemResponse build() => _build();

  _$ExpenseCategoryItemResponse _build() {
    _$ExpenseCategoryItemResponse _$result;
    try {
      _$result = _$v ?? new _$ExpenseCategoryItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ExpenseCategoryItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseCategoryEntity extends ExpenseCategoryEntity {
  @override
  final String name;
  @override
  final String color;
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

  factory _$ExpenseCategoryEntity(
          [void Function(ExpenseCategoryEntityBuilder)? updates]) =>
      (new ExpenseCategoryEntityBuilder()..update(updates))._build();

  _$ExpenseCategoryEntity._(
      {required this.name,
      required this.color,
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
        name, r'ExpenseCategoryEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        color, r'ExpenseCategoryEntity', 'color');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'ExpenseCategoryEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'ExpenseCategoryEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'ExpenseCategoryEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'ExpenseCategoryEntity', 'id');
  }

  @override
  ExpenseCategoryEntity rebuild(
          void Function(ExpenseCategoryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseCategoryEntityBuilder toBuilder() =>
      new ExpenseCategoryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseCategoryEntity &&
        name == other.name &&
        color == other.color &&
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
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
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
    return (newBuiltValueToStringHelper(r'ExpenseCategoryEntity')
          ..add('name', name)
          ..add('color', color)
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

class ExpenseCategoryEntityBuilder
    implements Builder<ExpenseCategoryEntity, ExpenseCategoryEntityBuilder> {
  _$ExpenseCategoryEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

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

  ExpenseCategoryEntityBuilder() {
    ExpenseCategoryEntity._initializeBuilder(this);
  }

  ExpenseCategoryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _color = $v.color;
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
  void replace(ExpenseCategoryEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseCategoryEntity;
  }

  @override
  void update(void Function(ExpenseCategoryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpenseCategoryEntity build() => _build();

  _$ExpenseCategoryEntity _build() {
    final _$result = _$v ??
        new _$ExpenseCategoryEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'ExpenseCategoryEntity', 'name'),
            color: BuiltValueNullFieldError.checkNotNull(
                color, r'ExpenseCategoryEntity', 'color'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'ExpenseCategoryEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'ExpenseCategoryEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(
                archivedAt, r'ExpenseCategoryEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ExpenseCategoryEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
