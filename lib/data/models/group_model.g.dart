// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GroupListResponse> _$groupListResponseSerializer =
    new _$GroupListResponseSerializer();
Serializer<GroupItemResponse> _$groupItemResponseSerializer =
    new _$GroupItemResponseSerializer();
Serializer<GroupEntity> _$groupEntitySerializer = new _$GroupEntitySerializer();

class _$GroupListResponseSerializer
    implements StructuredSerializer<GroupListResponse> {
  @override
  final Iterable<Type> types = const [GroupListResponse, _$GroupListResponse];
  @override
  final String wireName = 'GroupListResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, GroupListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GroupEntity)])),
    ];

    return result;
  }

  @override
  GroupListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GroupEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$GroupItemResponseSerializer
    implements StructuredSerializer<GroupItemResponse> {
  @override
  final Iterable<Type> types = const [GroupItemResponse, _$GroupItemResponse];
  @override
  final String wireName = 'GroupItemResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, GroupItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(GroupEntity)),
    ];

    return result;
  }

  @override
  GroupItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupEntity)) as GroupEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$GroupEntitySerializer implements StructuredSerializer<GroupEntity> {
  @override
  final Iterable<Type> types = const [GroupEntity, _$GroupEntity];
  @override
  final String wireName = 'GroupEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, GroupEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(SettingsEntity)),
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
    value = object.idempotencyKey;
    if (value != null) {
      result
        ..add('idempotency_key')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GroupEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupEntityBuilder();

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
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
              specifiedType: const FullType(SettingsEntity)) as SettingsEntity);
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))
              as BuiltList<Object>);
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
        case 'idempotency_key':
          result.idempotencyKey = serializers.deserialize(value,
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

class _$GroupListResponse extends GroupListResponse {
  @override
  final BuiltList<GroupEntity> data;

  factory _$GroupListResponse(
          [void Function(GroupListResponseBuilder) updates]) =>
      (new GroupListResponseBuilder()..update(updates)).build();

  _$GroupListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'GroupListResponse', 'data');
  }

  @override
  GroupListResponse rebuild(void Function(GroupListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupListResponseBuilder toBuilder() =>
      new GroupListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupListResponse')..add('data', data))
        .toString();
  }
}

class GroupListResponseBuilder
    implements Builder<GroupListResponse, GroupListResponseBuilder> {
  _$GroupListResponse _$v;

  ListBuilder<GroupEntity> _data;
  ListBuilder<GroupEntity> get data =>
      _$this._data ??= new ListBuilder<GroupEntity>();
  set data(ListBuilder<GroupEntity> data) => _$this._data = data;

  GroupListResponseBuilder();

  GroupListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GroupListResponse;
  }

  @override
  void update(void Function(GroupListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupListResponse build() {
    _$GroupListResponse _$result;
    try {
      _$result = _$v ?? new _$GroupListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GroupListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GroupItemResponse extends GroupItemResponse {
  @override
  final GroupEntity data;

  factory _$GroupItemResponse(
          [void Function(GroupItemResponseBuilder) updates]) =>
      (new GroupItemResponseBuilder()..update(updates)).build();

  _$GroupItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'GroupItemResponse', 'data');
  }

  @override
  GroupItemResponse rebuild(void Function(GroupItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupItemResponseBuilder toBuilder() =>
      new GroupItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupItemResponse')..add('data', data))
        .toString();
  }
}

class GroupItemResponseBuilder
    implements Builder<GroupItemResponse, GroupItemResponseBuilder> {
  _$GroupItemResponse _$v;

  GroupEntityBuilder _data;
  GroupEntityBuilder get data => _$this._data ??= new GroupEntityBuilder();
  set data(GroupEntityBuilder data) => _$this._data = data;

  GroupItemResponseBuilder();

  GroupItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GroupItemResponse;
  }

  @override
  void update(void Function(GroupItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupItemResponse build() {
    _$GroupItemResponse _$result;
    try {
      _$result = _$v ?? new _$GroupItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GroupItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GroupEntity extends GroupEntity {
  @override
  final String name;
  @override
  final SettingsEntity settings;
  @override
  final BuiltList<DocumentEntity> documents;
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
  final String idempotencyKey;
  @override
  final String id;

  factory _$GroupEntity([void Function(GroupEntityBuilder) updates]) =>
      (new GroupEntityBuilder()..update(updates)).build();

  _$GroupEntity._(
      {this.name,
      this.settings,
      this.documents,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.idempotencyKey,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'GroupEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(settings, 'GroupEntity', 'settings');
    BuiltValueNullFieldError.checkNotNull(
        documents, 'GroupEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GroupEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'GroupEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'GroupEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'GroupEntity', 'id');
  }

  @override
  GroupEntity rebuild(void Function(GroupEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupEntityBuilder toBuilder() => new GroupEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupEntity &&
        name == other.name &&
        settings == other.settings &&
        documents == other.documents &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        idempotencyKey == other.idempotencyKey &&
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
                                            $jc($jc(0, name.hashCode),
                                                settings.hashCode),
                                            documents.hashCode),
                                        isChanged.hashCode),
                                    createdAt.hashCode),
                                updatedAt.hashCode),
                            archivedAt.hashCode),
                        isDeleted.hashCode),
                    createdUserId.hashCode),
                assignedUserId.hashCode),
            idempotencyKey.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupEntity')
          ..add('name', name)
          ..add('settings', settings)
          ..add('documents', documents)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('idempotencyKey', idempotencyKey)
          ..add('id', id))
        .toString();
  }
}

class GroupEntityBuilder implements Builder<GroupEntity, GroupEntityBuilder> {
  _$GroupEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  SettingsEntityBuilder _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder settings) => _$this._settings = settings;

  ListBuilder<DocumentEntity> _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity> documents) =>
      _$this._documents = documents;

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

  String _idempotencyKey;
  String get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  GroupEntityBuilder() {
    GroupEntity._initializeBuilder(this);
  }

  GroupEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _settings = $v.settings.toBuilder();
      _documents = $v.documents.toBuilder();
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _idempotencyKey = $v.idempotencyKey;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GroupEntity;
  }

  @override
  void update(void Function(GroupEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupEntity build() {
    _$GroupEntity _$result;
    try {
      _$result = _$v ??
          new _$GroupEntity._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'GroupEntity', 'name'),
              settings: settings.build(),
              documents: documents.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, 'GroupEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, 'GroupEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(
                  archivedAt, 'GroupEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              idempotencyKey: idempotencyKey,
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GroupEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'settings';
        settings.build();
        _$failedField = 'documents';
        documents.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GroupEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
