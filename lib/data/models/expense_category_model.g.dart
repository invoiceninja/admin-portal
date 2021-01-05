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
  Iterable<Object> serialize(
      Serializers serializers, ExpenseCategoryListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ExpenseCategoryEntity)])),
    ];

    return result;
  }

  @override
  ExpenseCategoryListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseCategoryListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseCategoryEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(
      Serializers serializers, ExpenseCategoryItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ExpenseCategoryEntity)),
    ];

    return result;
  }

  @override
  ExpenseCategoryItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseCategoryItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExpenseCategoryEntity))
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
  Iterable<Object> serialize(
      Serializers serializers, ExpenseCategoryEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
  ExpenseCategoryEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseCategoryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
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

class _$ExpenseCategoryListResponse extends ExpenseCategoryListResponse {
  @override
  final BuiltList<ExpenseCategoryEntity> data;

  factory _$ExpenseCategoryListResponse(
          [void Function(ExpenseCategoryListResponseBuilder) updates]) =>
      (new ExpenseCategoryListResponseBuilder()..update(updates)).build();

  _$ExpenseCategoryListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryListResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseCategoryListResponse')
          ..add('data', data))
        .toString();
  }
}

class ExpenseCategoryListResponseBuilder
    implements
        Builder<ExpenseCategoryListResponse,
            ExpenseCategoryListResponseBuilder> {
  _$ExpenseCategoryListResponse _$v;

  ListBuilder<ExpenseCategoryEntity> _data;
  ListBuilder<ExpenseCategoryEntity> get data =>
      _$this._data ??= new ListBuilder<ExpenseCategoryEntity>();
  set data(ListBuilder<ExpenseCategoryEntity> data) => _$this._data = data;

  ExpenseCategoryListResponseBuilder();

  ExpenseCategoryListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseCategoryListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExpenseCategoryListResponse;
  }

  @override
  void update(void Function(ExpenseCategoryListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseCategoryListResponse build() {
    _$ExpenseCategoryListResponse _$result;
    try {
      _$result = _$v ?? new _$ExpenseCategoryListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ExpenseCategoryListResponse', _$failedField, e.toString());
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
          [void Function(ExpenseCategoryItemResponseBuilder) updates]) =>
      (new ExpenseCategoryItemResponseBuilder()..update(updates)).build();

  _$ExpenseCategoryItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryItemResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseCategoryItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ExpenseCategoryItemResponseBuilder
    implements
        Builder<ExpenseCategoryItemResponse,
            ExpenseCategoryItemResponseBuilder> {
  _$ExpenseCategoryItemResponse _$v;

  ExpenseCategoryEntityBuilder _data;
  ExpenseCategoryEntityBuilder get data =>
      _$this._data ??= new ExpenseCategoryEntityBuilder();
  set data(ExpenseCategoryEntityBuilder data) => _$this._data = data;

  ExpenseCategoryItemResponseBuilder();

  ExpenseCategoryItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseCategoryItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExpenseCategoryItemResponse;
  }

  @override
  void update(void Function(ExpenseCategoryItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseCategoryItemResponse build() {
    _$ExpenseCategoryItemResponse _$result;
    try {
      _$result = _$v ?? new _$ExpenseCategoryItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ExpenseCategoryItemResponse', _$failedField, e.toString());
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

  factory _$ExpenseCategoryEntity(
          [void Function(ExpenseCategoryEntityBuilder) updates]) =>
      (new ExpenseCategoryEntityBuilder()..update(updates)).build();

  _$ExpenseCategoryEntity._(
      {this.name,
      this.color,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryEntity', 'name');
    }
    if (color == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryEntity', 'color');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('ExpenseCategoryEntity', 'id');
    }
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
                                $jc($jc($jc(0, name.hashCode), color.hashCode),
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
    return (newBuiltValueToStringHelper('ExpenseCategoryEntity')
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
  _$ExpenseCategoryEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

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

  ExpenseCategoryEntityBuilder() {
    ExpenseCategoryEntity._initializeBuilder(this);
  }

  ExpenseCategoryEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _color = _$v.color;
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
  void replace(ExpenseCategoryEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExpenseCategoryEntity;
  }

  @override
  void update(void Function(ExpenseCategoryEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseCategoryEntity build() {
    final _$result = _$v ??
        new _$ExpenseCategoryEntity._(
            name: name,
            color: color,
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
