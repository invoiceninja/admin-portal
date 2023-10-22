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
  Iterable<Object?> serialize(
      Serializers serializers, DocumentListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
    ];

    return result;
  }

  @override
  DocumentListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(
      Serializers serializers, DocumentItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DocumentEntity)),
    ];

    return result;
  }

  @override
  DocumentItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DocumentEntity))!
              as DocumentEntity);
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
  Iterable<Object?> serialize(Serializers serializers, DocumentEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      'is_public',
      serializers.serialize(object.isPublic,
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
    Object? value;
    value = object.parentId;
    if (value != null) {
      result
        ..add('parent_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.parentType;
    if (value != null) {
      result
        ..add('parent_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(EntityType)));
    }
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
  DocumentEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentEntityBuilder();

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
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'size':
          result.size = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'preview':
          result.preview = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'is_default':
          result.isDefault = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'is_public':
          result.isPublic = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'parent_id':
          result.parentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'parent_type':
          result.parentType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType?;
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

class _$DocumentListResponse extends DocumentListResponse {
  @override
  final BuiltList<DocumentEntity> data;

  factory _$DocumentListResponse(
          [void Function(DocumentListResponseBuilder)? updates]) =>
      (new DocumentListResponseBuilder()..update(updates))._build();

  _$DocumentListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'DocumentListResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'DocumentListResponse')
          ..add('data', data))
        .toString();
  }
}

class DocumentListResponseBuilder
    implements Builder<DocumentListResponse, DocumentListResponseBuilder> {
  _$DocumentListResponse? _$v;

  ListBuilder<DocumentEntity>? _data;
  ListBuilder<DocumentEntity> get data =>
      _$this._data ??= new ListBuilder<DocumentEntity>();
  set data(ListBuilder<DocumentEntity>? data) => _$this._data = data;

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
  void update(void Function(DocumentListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DocumentListResponse build() => _build();

  _$DocumentListResponse _build() {
    _$DocumentListResponse _$result;
    try {
      _$result = _$v ?? new _$DocumentListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DocumentListResponse', _$failedField, e.toString());
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
          [void Function(DocumentItemResponseBuilder)? updates]) =>
      (new DocumentItemResponseBuilder()..update(updates))._build();

  _$DocumentItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'DocumentItemResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'DocumentItemResponse')
          ..add('data', data))
        .toString();
  }
}

class DocumentItemResponseBuilder
    implements Builder<DocumentItemResponse, DocumentItemResponseBuilder> {
  _$DocumentItemResponse? _$v;

  DocumentEntityBuilder? _data;
  DocumentEntityBuilder get data =>
      _$this._data ??= new DocumentEntityBuilder();
  set data(DocumentEntityBuilder? data) => _$this._data = data;

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
  void update(void Function(DocumentItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DocumentItemResponse build() => _build();

  _$DocumentItemResponse _build() {
    _$DocumentItemResponse _$result;
    try {
      _$result = _$v ?? new _$DocumentItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DocumentItemResponse', _$failedField, e.toString());
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
  final Uint8List? data;
  @override
  final bool isDefault;
  @override
  final bool isPublic;
  @override
  final String? parentId;
  @override
  final EntityType? parentType;
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

  factory _$DocumentEntity([void Function(DocumentEntityBuilder)? updates]) =>
      (new DocumentEntityBuilder()..update(updates))._build();

  _$DocumentEntity._(
      {required this.name,
      required this.hash,
      required this.type,
      required this.url,
      required this.width,
      required this.height,
      required this.size,
      required this.preview,
      this.data,
      required this.isDefault,
      required this.isPublic,
      this.parentId,
      this.parentType,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'DocumentEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(hash, r'DocumentEntity', 'hash');
    BuiltValueNullFieldError.checkNotNull(type, r'DocumentEntity', 'type');
    BuiltValueNullFieldError.checkNotNull(url, r'DocumentEntity', 'url');
    BuiltValueNullFieldError.checkNotNull(width, r'DocumentEntity', 'width');
    BuiltValueNullFieldError.checkNotNull(height, r'DocumentEntity', 'height');
    BuiltValueNullFieldError.checkNotNull(size, r'DocumentEntity', 'size');
    BuiltValueNullFieldError.checkNotNull(
        preview, r'DocumentEntity', 'preview');
    BuiltValueNullFieldError.checkNotNull(
        isDefault, r'DocumentEntity', 'isDefault');
    BuiltValueNullFieldError.checkNotNull(
        isPublic, r'DocumentEntity', 'isPublic');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'DocumentEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'DocumentEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'DocumentEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'DocumentEntity', 'id');
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
        data == other.data &&
        isDefault == other.isDefault &&
        isPublic == other.isPublic &&
        parentId == other.parentId &&
        parentType == other.parentType &&
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
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, width.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, preview.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, isDefault.hashCode);
    _$hash = $jc(_$hash, isPublic.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, parentType.hashCode);
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
    return (newBuiltValueToStringHelper(r'DocumentEntity')
          ..add('name', name)
          ..add('hash', hash)
          ..add('type', type)
          ..add('url', url)
          ..add('width', width)
          ..add('height', height)
          ..add('size', size)
          ..add('preview', preview)
          ..add('data', data)
          ..add('isDefault', isDefault)
          ..add('isPublic', isPublic)
          ..add('parentId', parentId)
          ..add('parentType', parentType)
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

class DocumentEntityBuilder
    implements Builder<DocumentEntity, DocumentEntityBuilder> {
  _$DocumentEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  int? _width;
  int? get width => _$this._width;
  set width(int? width) => _$this._width = width;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  String? _preview;
  String? get preview => _$this._preview;
  set preview(String? preview) => _$this._preview = preview;

  Uint8List? _data;
  Uint8List? get data => _$this._data;
  set data(Uint8List? data) => _$this._data = data;

  bool? _isDefault;
  bool? get isDefault => _$this._isDefault;
  set isDefault(bool? isDefault) => _$this._isDefault = isDefault;

  bool? _isPublic;
  bool? get isPublic => _$this._isPublic;
  set isPublic(bool? isPublic) => _$this._isPublic = isPublic;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  EntityType? _parentType;
  EntityType? get parentType => _$this._parentType;
  set parentType(EntityType? parentType) => _$this._parentType = parentType;

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

  DocumentEntityBuilder() {
    DocumentEntity._initializeBuilder(this);
  }

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
      _data = $v.data;
      _isDefault = $v.isDefault;
      _isPublic = $v.isPublic;
      _parentId = $v.parentId;
      _parentType = $v.parentType;
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
  void replace(DocumentEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocumentEntity;
  }

  @override
  void update(void Function(DocumentEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DocumentEntity build() => _build();

  _$DocumentEntity _build() {
    final _$result = _$v ??
        new _$DocumentEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'DocumentEntity', 'name'),
            hash: BuiltValueNullFieldError.checkNotNull(
                hash, r'DocumentEntity', 'hash'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'DocumentEntity', 'type'),
            url: BuiltValueNullFieldError.checkNotNull(
                url, r'DocumentEntity', 'url'),
            width: BuiltValueNullFieldError.checkNotNull(
                width, r'DocumentEntity', 'width'),
            height: BuiltValueNullFieldError.checkNotNull(
                height, r'DocumentEntity', 'height'),
            size: BuiltValueNullFieldError.checkNotNull(
                size, r'DocumentEntity', 'size'),
            preview: BuiltValueNullFieldError.checkNotNull(
                preview, r'DocumentEntity', 'preview'),
            data: data,
            isDefault: BuiltValueNullFieldError.checkNotNull(
                isDefault, r'DocumentEntity', 'isDefault'),
            isPublic: BuiltValueNullFieldError.checkNotNull(
                isPublic, r'DocumentEntity', 'isPublic'),
            parentId: parentId,
            parentType: parentType,
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'DocumentEntity', 'createdAt'),
            updatedAt:
                BuiltValueNullFieldError.checkNotNull(updatedAt, r'DocumentEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'DocumentEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(id, r'DocumentEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
