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
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'path',
      serializers.serialize(object.path, specifiedType: const FullType(String)),
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
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(String)));
    }
    if (object.expenseId != null) {
      result
        ..add('expense_id')
        ..add(serializers.serialize(object.expenseId,
            specifiedType: const FullType(String)));
    }
    if (object.customValue1 != null) {
      result
        ..add('custom_value1')
        ..add(serializers.serialize(object.customValue1,
            specifiedType: const FullType(String)));
    }
    if (object.customValue2 != null) {
      result
        ..add('custom_value2')
        ..add(serializers.serialize(object.customValue2,
            specifiedType: const FullType(String)));
    }
    if (object.customValue3 != null) {
      result
        ..add('custom_value3')
        ..add(serializers.serialize(object.customValue3,
            specifiedType: const FullType(String)));
    }
    if (object.customValue4 != null) {
      result
        ..add('custom_value4')
        ..add(serializers.serialize(object.customValue4,
            specifiedType: const FullType(String)));
    }
    if (object.projectId != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(object.projectId,
            specifiedType: const FullType(String)));
    }
    if (object.vendorId != null) {
      result
        ..add('vendor_id')
        ..add(serializers.serialize(object.vendorId,
            specifiedType: const FullType(String)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
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
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'path':
          result.path = serializers.deserialize(value,
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
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expense_id':
          result.expenseId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_default':
          result.isDefault = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor_id':
          result.vendorId = serializers.deserialize(value,
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

class _$DocumentListResponse extends DocumentListResponse {
  @override
  final BuiltList<DocumentEntity> data;

  factory _$DocumentListResponse(
          [void Function(DocumentListResponseBuilder) updates]) =>
      (new DocumentListResponseBuilder()..update(updates)).build();

  _$DocumentListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DocumentListResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocumentListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
    if (data == null) {
      throw new BuiltValueNullFieldError('DocumentItemResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocumentItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
  final String type;
  @override
  final String path;
  @override
  final int width;
  @override
  final int height;
  @override
  final int size;
  @override
  final String preview;
  @override
  final String invoiceId;
  @override
  final String expenseId;
  @override
  final bool isDefault;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final String projectId;
  @override
  final String vendorId;
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

  factory _$DocumentEntity([void Function(DocumentEntityBuilder) updates]) =>
      (new DocumentEntityBuilder()..update(updates)).build();

  _$DocumentEntity._(
      {this.name,
      this.type,
      this.path,
      this.width,
      this.height,
      this.size,
      this.preview,
      this.invoiceId,
      this.expenseId,
      this.isDefault,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.projectId,
      this.vendorId,
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
      throw new BuiltValueNullFieldError('DocumentEntity', 'name');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'type');
    }
    if (path == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'path');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'width');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'height');
    }
    if (size == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'size');
    }
    if (preview == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'preview');
    }
    if (isDefault == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'isDefault');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'createdAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('DocumentEntity', 'id');
    }
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
        type == other.type &&
        path == other.path &&
        width == other.width &&
        height == other.height &&
        size == other.size &&
        preview == other.preview &&
        invoiceId == other.invoiceId &&
        expenseId == other.expenseId &&
        isDefault == other.isDefault &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        projectId == other.projectId &&
        vendorId == other.vendorId &&
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
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc(0, name.hashCode), type.hashCode), path.hashCode), width.hashCode), height.hashCode),
                                                                                size.hashCode),
                                                                            preview.hashCode),
                                                                        invoiceId.hashCode),
                                                                    expenseId.hashCode),
                                                                isDefault.hashCode),
                                                            customValue1.hashCode),
                                                        customValue2.hashCode),
                                                    customValue3.hashCode),
                                                customValue4.hashCode),
                                            projectId.hashCode),
                                        vendorId.hashCode),
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
    return (newBuiltValueToStringHelper('DocumentEntity')
          ..add('name', name)
          ..add('type', type)
          ..add('path', path)
          ..add('width', width)
          ..add('height', height)
          ..add('size', size)
          ..add('preview', preview)
          ..add('invoiceId', invoiceId)
          ..add('expenseId', expenseId)
          ..add('isDefault', isDefault)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('projectId', projectId)
          ..add('vendorId', vendorId)
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
  _$DocumentEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _path;
  String get path => _$this._path;
  set path(String path) => _$this._path = path;

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

  String _invoiceId;
  String get invoiceId => _$this._invoiceId;
  set invoiceId(String invoiceId) => _$this._invoiceId = invoiceId;

  String _expenseId;
  String get expenseId => _$this._expenseId;
  set expenseId(String expenseId) => _$this._expenseId = expenseId;

  bool _isDefault;
  bool get isDefault => _$this._isDefault;
  set isDefault(bool isDefault) => _$this._isDefault = isDefault;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  String _projectId;
  String get projectId => _$this._projectId;
  set projectId(String projectId) => _$this._projectId = projectId;

  String _vendorId;
  String get vendorId => _$this._vendorId;
  set vendorId(String vendorId) => _$this._vendorId = vendorId;

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

  DocumentEntityBuilder();

  DocumentEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _type = _$v.type;
      _path = _$v.path;
      _width = _$v.width;
      _height = _$v.height;
      _size = _$v.size;
      _preview = _$v.preview;
      _invoiceId = _$v.invoiceId;
      _expenseId = _$v.expenseId;
      _isDefault = _$v.isDefault;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _projectId = _$v.projectId;
      _vendorId = _$v.vendorId;
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
  void replace(DocumentEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
            name: name,
            type: type,
            path: path,
            width: width,
            height: height,
            size: size,
            preview: preview,
            invoiceId: invoiceId,
            expenseId: expenseId,
            isDefault: isDefault,
            customValue1: customValue1,
            customValue2: customValue2,
            customValue3: customValue3,
            customValue4: customValue4,
            projectId: projectId,
            vendorId: vendorId,
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
