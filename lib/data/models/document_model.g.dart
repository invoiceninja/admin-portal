// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DocumentListResponse> _$documentListResponseSerializer =
    new _$DocumentListResponseSerializer();
Serializer<DocumentItemResponse> _$documentItemResponseSerializer =
    new _$DocumentItemResponseSerializer();
Serializer<DocumentEntity> _$documentEntitySerializer =
    new _$DocumentEntitySerializer();

class _$DocumentListResponseSerializer
    implements StructuredSerializer<DocumentListResponse> {
  @override
  final Iterable<Type> types = const [
    DocumentListResponse,
    _$DocumentListResponse
  ];
  @override
  final String wireName = 'DocumentListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DocumentListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
    ];

    return result;
  }

  @override
  DocumentListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DocumentItemResponseSerializer
    implements StructuredSerializer<DocumentItemResponse> {
  @override
  final Iterable<Type> types = const [
    DocumentItemResponse,
    _$DocumentItemResponse
  ];
  @override
  final String wireName = 'DocumentItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DocumentItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DocumentEntity)),
    ];

    return result;
  }

  @override
  DocumentItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(DocumentEntity)) as DocumentEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DocumentEntitySerializer
    implements StructuredSerializer<DocumentEntity> {
  @override
  final Iterable<Type> types = const [DocumentEntity, _$DocumentEntity];
  @override
  final String wireName = 'DocumentEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, DocumentEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'hash',
      serializers.serialize(object.hash, specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'width',
      serializers.serialize(object.width, specifiedType: const FullType(int)),
      'height',
      serializers.serialize(object.height, specifiedType: const FullType(int)),
      'size',
      serializers.serialize(object.size, specifiedType: const FullType(int)),
      'preview',
      serializers.serialize(object.preview,
          specifiedType: const FullType(String)),
      'is_default',
      serializers.serialize(object.isDefault,
          specifiedType: const FullType(bool)),
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
  DocumentEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentEntityBuilder();

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
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'size':
          result.size = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'preview':
          result.preview = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_default':
          result.isDefault = serializers.deserialize(value,
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

class _$DocumentListResponse extends DocumentListResponse {
  @override
  final BuiltList<DocumentEntity> data;

  factory _$DocumentListResponse(
          [void Function(DocumentListResponseBuilder) updates]) =>
      (new DocumentListResponseBuilder()..update(updates)).build();

  _$DocumentListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'DocumentListResponse', 'data');
  }

  @override
  DocumentListResponse rebuild(
          void Function(DocumentListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DocumentListResponseBuilder toBuilder() =>
      new DocumentListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocumentListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DocumentListResponse')
          ..add('data', data))
        .toString();
  }
}

class DocumentListResponseBuilder
    implements Builder<DocumentListResponse, DocumentListResponseBuilder> {
  _$DocumentListResponse _$v;

  ListBuilder<DocumentEntity> _data;
  ListBuilder<DocumentEntity> get data =>
      _$this._data ??= new ListBuilder<DocumentEntity>();
  set data(ListBuilder<DocumentEntity> data) => _$this._data = data;

  DocumentListResponseBuilder();

  DocumentListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocumentListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocumentListResponse;
  }

  @override
  void update(void Function(DocumentListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DocumentListResponse build() {
    _$DocumentListResponse _$result;
    try {
      _$result = _$v ?? new _$DocumentListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DocumentListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DocumentItemResponse extends DocumentItemResponse {
  @override
  final DocumentEntity data;

  factory _$DocumentItemResponse(
          [void Function(DocumentItemResponseBuilder) updates]) =>
      (new DocumentItemResponseBuilder()..update(updates)).build();

  _$DocumentItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'DocumentItemResponse', 'data');
  }

  @override
  DocumentItemResponse rebuild(
          void Function(DocumentItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DocumentItemResponseBuilder toBuilder() =>
      new DocumentItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocumentItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DocumentItemResponse')
          ..add('data', data))
        .toString();
  }
}

class DocumentItemResponseBuilder
    implements Builder<DocumentItemResponse, DocumentItemResponseBuilder> {
  _$DocumentItemResponse _$v;

  DocumentEntityBuilder _data;
  DocumentEntityBuilder get data =>
      _$this._data ??= new DocumentEntityBuilder();
  set data(DocumentEntityBuilder data) => _$this._data = data;

  DocumentItemResponseBuilder();

  DocumentItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocumentItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocumentItemResponse;
  }

  @override
  void update(void Function(DocumentItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DocumentItemResponse build() {
    _$DocumentItemResponse _$result;
    try {
      _$result = _$v ?? new _$DocumentItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DocumentItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DocumentEntity extends DocumentEntity {
  @override
  final String name;
  @override
  final String hash;
  @override
  final String type;
  @override
  final String url;
  @override
  final int width;
  @override
  final int height;
  @override
  final int size;
  @override
  final String preview;
  @override
  final bool isDefault;
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

  factory _$DocumentEntity([void Function(DocumentEntityBuilder) updates]) =>
      (new DocumentEntityBuilder()..update(updates)).build();

  _$DocumentEntity._(
      {this.name,
      this.hash,
      this.type,
      this.url,
      this.width,
      this.height,
      this.size,
      this.preview,
      this.isDefault,
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
    BuiltValueNullFieldError.checkNotNull(name, 'DocumentEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(hash, 'DocumentEntity', 'hash');
    BuiltValueNullFieldError.checkNotNull(type, 'DocumentEntity', 'type');
    BuiltValueNullFieldError.checkNotNull(url, 'DocumentEntity', 'url');
    BuiltValueNullFieldError.checkNotNull(width, 'DocumentEntity', 'width');
    BuiltValueNullFieldError.checkNotNull(height, 'DocumentEntity', 'height');
    BuiltValueNullFieldError.checkNotNull(size, 'DocumentEntity', 'size');
    BuiltValueNullFieldError.checkNotNull(preview, 'DocumentEntity', 'preview');
    BuiltValueNullFieldError.checkNotNull(
        isDefault, 'DocumentEntity', 'isDefault');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'DocumentEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'DocumentEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'DocumentEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'DocumentEntity', 'id');
  }

  @override
  DocumentEntity rebuild(void Function(DocumentEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DocumentEntityBuilder toBuilder() =>
      new DocumentEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocumentEntity &&
        name == other.name &&
        hash == other.hash &&
        type == other.type &&
        url == other.url &&
        width == other.width &&
        height == other.height &&
        size == other.size &&
        preview == other.preview &&
        isDefault == other.isDefault &&
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
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(0,
                                                                            name.hashCode),
                                                                        hash.hashCode),
                                                                    type.hashCode),
                                                                url.hashCode),
                                                            width.hashCode),
                                                        height.hashCode),
                                                    size.hashCode),
                                                preview.hashCode),
                                            isDefault.hashCode),
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
    return (newBuiltValueToStringHelper('DocumentEntity')
          ..add('name', name)
          ..add('hash', hash)
          ..add('type', type)
          ..add('url', url)
          ..add('width', width)
          ..add('height', height)
          ..add('size', size)
          ..add('preview', preview)
          ..add('isDefault', isDefault)
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

class DocumentEntityBuilder
    implements Builder<DocumentEntity, DocumentEntityBuilder> {
  _$DocumentEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _hash;
  String get hash => _$this._hash;
  set hash(String hash) => _$this._hash = hash;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  int _size;
  int get size => _$this._size;
  set size(int size) => _$this._size = size;

  String _preview;
  String get preview => _$this._preview;
  set preview(String preview) => _$this._preview = preview;

  bool _isDefault;
  bool get isDefault => _$this._isDefault;
  set isDefault(bool isDefault) => _$this._isDefault = isDefault;

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

  DocumentEntityBuilder();

  DocumentEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _hash = $v.hash;
      _type = $v.type;
      _url = $v.url;
      _width = $v.width;
      _height = $v.height;
      _size = $v.size;
      _preview = $v.preview;
      _isDefault = $v.isDefault;
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
  void replace(DocumentEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocumentEntity;
  }

  @override
  void update(void Function(DocumentEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DocumentEntity build() {
    final _$result = _$v ??
        new _$DocumentEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'DocumentEntity', 'name'),
            hash: BuiltValueNullFieldError.checkNotNull(
                hash, 'DocumentEntity', 'hash'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, 'DocumentEntity', 'type'),
            url: BuiltValueNullFieldError.checkNotNull(
                url, 'DocumentEntity', 'url'),
            width: BuiltValueNullFieldError.checkNotNull(
                width, 'DocumentEntity', 'width'),
            height: BuiltValueNullFieldError.checkNotNull(
                height, 'DocumentEntity', 'height'),
            size: BuiltValueNullFieldError.checkNotNull(
                size, 'DocumentEntity', 'size'),
            preview: BuiltValueNullFieldError.checkNotNull(
                preview, 'DocumentEntity', 'preview'),
            isDefault: BuiltValueNullFieldError.checkNotNull(
                isDefault, 'DocumentEntity', 'isDefault'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, 'DocumentEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, 'DocumentEntity', 'updatedAt'),
            archivedAt:
                BuiltValueNullFieldError.checkNotNull(archivedAt, 'DocumentEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            idempotencyKey: idempotencyKey,
            id: BuiltValueNullFieldError.checkNotNull(id, 'DocumentEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
