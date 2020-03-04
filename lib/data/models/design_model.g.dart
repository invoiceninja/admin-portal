// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DesignListResponse> _$designListResponseSerializer =
    new _$DesignListResponseSerializer();
Serializer<DesignItemResponse> _$designItemResponseSerializer =
    new _$DesignItemResponseSerializer();
Serializer<DesignEntity> _$designEntitySerializer =
    new _$DesignEntitySerializer();

class _$DesignListResponseSerializer
    implements StructuredSerializer<DesignListResponse> {
  @override
  final Iterable<Type> types = const [DesignListResponse, _$DesignListResponse];
  @override
  final String wireName = 'DesignListResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, DesignListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(DesignEntity)])),
    ];

    return result;
  }

  @override
  DesignListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DesignListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DesignEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DesignItemResponseSerializer
    implements StructuredSerializer<DesignItemResponse> {
  @override
  final Iterable<Type> types = const [DesignItemResponse, _$DesignItemResponse];
  @override
  final String wireName = 'DesignItemResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, DesignItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DesignEntity)),
    ];

    return result;
  }

  @override
  DesignItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DesignItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(DesignEntity)) as DesignEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DesignEntitySerializer implements StructuredSerializer<DesignEntity> {
  @override
  final Iterable<Type> types = const [DesignEntity, _$DesignEntity];
  @override
  final String wireName = 'DesignEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, DesignEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'design',
      serializers.serialize(object.design,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'is_custom',
      serializers.serialize(object.isCustom,
          specifiedType: const FullType(bool)),
    ];
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
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
    if (object.subEntityType != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(object.subEntityType,
            specifiedType: const FullType(EntityType)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  DesignEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DesignEntityBuilder();

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
        case 'design':
          result.design.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'is_custom':
          result.isCustom = serializers.deserialize(value,
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
        case 'entity_type':
          result.subEntityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
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

class _$DesignListResponse extends DesignListResponse {
  @override
  final BuiltList<DesignEntity> data;

  factory _$DesignListResponse(
          [void Function(DesignListResponseBuilder) updates]) =>
      (new DesignListResponseBuilder()..update(updates)).build();

  _$DesignListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DesignListResponse', 'data');
    }
  }

  @override
  DesignListResponse rebuild(
          void Function(DesignListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DesignListResponseBuilder toBuilder() =>
      new DesignListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DesignListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DesignListResponse')
          ..add('data', data))
        .toString();
  }
}

class DesignListResponseBuilder
    implements Builder<DesignListResponse, DesignListResponseBuilder> {
  _$DesignListResponse _$v;

  ListBuilder<DesignEntity> _data;
  ListBuilder<DesignEntity> get data =>
      _$this._data ??= new ListBuilder<DesignEntity>();
  set data(ListBuilder<DesignEntity> data) => _$this._data = data;

  DesignListResponseBuilder();

  DesignListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DesignListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DesignListResponse;
  }

  @override
  void update(void Function(DesignListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DesignListResponse build() {
    _$DesignListResponse _$result;
    try {
      _$result = _$v ?? new _$DesignListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DesignListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DesignItemResponse extends DesignItemResponse {
  @override
  final DesignEntity data;

  factory _$DesignItemResponse(
          [void Function(DesignItemResponseBuilder) updates]) =>
      (new DesignItemResponseBuilder()..update(updates)).build();

  _$DesignItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DesignItemResponse', 'data');
    }
  }

  @override
  DesignItemResponse rebuild(
          void Function(DesignItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DesignItemResponseBuilder toBuilder() =>
      new DesignItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DesignItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DesignItemResponse')
          ..add('data', data))
        .toString();
  }
}

class DesignItemResponseBuilder
    implements Builder<DesignItemResponse, DesignItemResponseBuilder> {
  _$DesignItemResponse _$v;

  DesignEntityBuilder _data;
  DesignEntityBuilder get data => _$this._data ??= new DesignEntityBuilder();
  set data(DesignEntityBuilder data) => _$this._data = data;

  DesignItemResponseBuilder();

  DesignItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DesignItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DesignItemResponse;
  }

  @override
  void update(void Function(DesignItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DesignItemResponse build() {
    _$DesignItemResponse _$result;
    try {
      _$result = _$v ?? new _$DesignItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DesignItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DesignEntity extends DesignEntity {
  @override
  final String name;
  @override
  final BuiltMap<String, String> design;
  @override
  final bool isCustom;
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
  final EntityType subEntityType;
  @override
  final String id;

  factory _$DesignEntity([void Function(DesignEntityBuilder) updates]) =>
      (new DesignEntityBuilder()..update(updates)).build();

  _$DesignEntity._(
      {this.name,
      this.design,
      this.isCustom,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.subEntityType,
      this.id})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('DesignEntity', 'name');
    }
    if (design == null) {
      throw new BuiltValueNullFieldError('DesignEntity', 'design');
    }
    if (isCustom == null) {
      throw new BuiltValueNullFieldError('DesignEntity', 'isCustom');
    }
  }

  @override
  DesignEntity rebuild(void Function(DesignEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DesignEntityBuilder toBuilder() => new DesignEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DesignEntity &&
        name == other.name &&
        design == other.design &&
        isCustom == other.isCustom &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        subEntityType == other.subEntityType &&
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
                                            $jc($jc(0, name.hashCode),
                                                design.hashCode),
                                            isCustom.hashCode),
                                        isChanged.hashCode),
                                    createdAt.hashCode),
                                updatedAt.hashCode),
                            archivedAt.hashCode),
                        isDeleted.hashCode),
                    createdUserId.hashCode),
                assignedUserId.hashCode),
            subEntityType.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DesignEntity')
          ..add('name', name)
          ..add('design', design)
          ..add('isCustom', isCustom)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('subEntityType', subEntityType)
          ..add('id', id))
        .toString();
  }
}

class DesignEntityBuilder
    implements Builder<DesignEntity, DesignEntityBuilder> {
  _$DesignEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  MapBuilder<String, String> _design;
  MapBuilder<String, String> get design =>
      _$this._design ??= new MapBuilder<String, String>();
  set design(MapBuilder<String, String> design) => _$this._design = design;

  bool _isCustom;
  bool get isCustom => _$this._isCustom;
  set isCustom(bool isCustom) => _$this._isCustom = isCustom;

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

  EntityType _subEntityType;
  EntityType get subEntityType => _$this._subEntityType;
  set subEntityType(EntityType subEntityType) =>
      _$this._subEntityType = subEntityType;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DesignEntityBuilder();

  DesignEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _design = _$v.design?.toBuilder();
      _isCustom = _$v.isCustom;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _subEntityType = _$v.subEntityType;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DesignEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DesignEntity;
  }

  @override
  void update(void Function(DesignEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DesignEntity build() {
    _$DesignEntity _$result;
    try {
      _$result = _$v ??
          new _$DesignEntity._(
              name: name,
              design: design.build(),
              isCustom: isCustom,
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              subEntityType: subEntityType,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'design';
        design.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DesignEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
