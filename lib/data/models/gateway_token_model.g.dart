// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gateway_token_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GatewayTokenListResponse> _$gatewayTokenListResponseSerializer =
    new _$GatewayTokenListResponseSerializer();
Serializer<GatewayTokenItemResponse> _$gatewayTokenItemResponseSerializer =
    new _$GatewayTokenItemResponseSerializer();
Serializer<GatewayTokenEntity> _$gatewayTokenEntitySerializer =
    new _$GatewayTokenEntitySerializer();
Serializer<GatewayTokenMetaEntity> _$gatewayTokenMetaEntitySerializer =
    new _$GatewayTokenMetaEntitySerializer();

class _$GatewayTokenListResponseSerializer
    implements StructuredSerializer<GatewayTokenListResponse> {
  @override
  final Iterable<Type> types = const [
    GatewayTokenListResponse,
    _$GatewayTokenListResponse
  ];
  @override
  final String wireName = 'GatewayTokenListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, GatewayTokenListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GatewayTokenEntity)])),
    ];

    return result;
  }

  @override
  GatewayTokenListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GatewayTokenListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GatewayTokenEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$GatewayTokenItemResponseSerializer
    implements StructuredSerializer<GatewayTokenItemResponse> {
  @override
  final Iterable<Type> types = const [
    GatewayTokenItemResponse,
    _$GatewayTokenItemResponse
  ];
  @override
  final String wireName = 'GatewayTokenItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, GatewayTokenItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(GatewayTokenEntity)),
    ];

    return result;
  }

  @override
  GatewayTokenItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GatewayTokenItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GatewayTokenEntity))
              as GatewayTokenEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$GatewayTokenEntitySerializer
    implements StructuredSerializer<GatewayTokenEntity> {
  @override
  final Iterable<Type> types = const [GatewayTokenEntity, _$GatewayTokenEntity];
  @override
  final String wireName = 'GatewayTokenEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, GatewayTokenEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'gateway_customer_reference',
      serializers.serialize(object.customerReference,
          specifiedType: const FullType(String)),
      'company_gateway_id',
      serializers.serialize(object.companyGatewayId,
          specifiedType: const FullType(String)),
      'gateway_type_id',
      serializers.serialize(object.gatewayTypeId,
          specifiedType: const FullType(String)),
      'is_default',
      serializers.serialize(object.isDefault,
          specifiedType: const FullType(bool)),
      'meta',
      serializers.serialize(object.meta,
          specifiedType: const FullType(GatewayTokenMetaEntity)),
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
  GatewayTokenEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GatewayTokenEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gateway_customer_reference':
          result.customerReference = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_gateway_id':
          result.companyGatewayId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gateway_type_id':
          result.gatewayTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_default':
          result.isDefault = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'meta':
          result.meta.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GatewayTokenMetaEntity))
              as GatewayTokenMetaEntity);
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

class _$GatewayTokenMetaEntitySerializer
    implements StructuredSerializer<GatewayTokenMetaEntity> {
  @override
  final Iterable<Type> types = const [
    GatewayTokenMetaEntity,
    _$GatewayTokenMetaEntity
  ];
  @override
  final String wireName = 'GatewayTokenMetaEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, GatewayTokenMetaEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.last4;
    if (value != null) {
      result
        ..add('last4')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.expMonth;
    if (value != null) {
      result
        ..add('exp_month')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.expYear;
    if (value != null) {
      result
        ..add('exp_year')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GatewayTokenMetaEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GatewayTokenMetaEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last4':
          result.last4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'exp_month':
          result.expMonth = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'exp_year':
          result.expYear = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GatewayTokenListResponse extends GatewayTokenListResponse {
  @override
  final BuiltList<GatewayTokenEntity> data;

  factory _$GatewayTokenListResponse(
          [void Function(GatewayTokenListResponseBuilder) updates]) =>
      (new GatewayTokenListResponseBuilder()..update(updates)).build();

  _$GatewayTokenListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'GatewayTokenListResponse', 'data');
  }

  @override
  GatewayTokenListResponse rebuild(
          void Function(GatewayTokenListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GatewayTokenListResponseBuilder toBuilder() =>
      new GatewayTokenListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GatewayTokenListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GatewayTokenListResponse')
          ..add('data', data))
        .toString();
  }
}

class GatewayTokenListResponseBuilder
    implements
        Builder<GatewayTokenListResponse, GatewayTokenListResponseBuilder> {
  _$GatewayTokenListResponse _$v;

  ListBuilder<GatewayTokenEntity> _data;
  ListBuilder<GatewayTokenEntity> get data =>
      _$this._data ??= new ListBuilder<GatewayTokenEntity>();
  set data(ListBuilder<GatewayTokenEntity> data) => _$this._data = data;

  GatewayTokenListResponseBuilder();

  GatewayTokenListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayTokenListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GatewayTokenListResponse;
  }

  @override
  void update(void Function(GatewayTokenListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GatewayTokenListResponse build() {
    _$GatewayTokenListResponse _$result;
    try {
      _$result = _$v ?? new _$GatewayTokenListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GatewayTokenListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GatewayTokenItemResponse extends GatewayTokenItemResponse {
  @override
  final GatewayTokenEntity data;

  factory _$GatewayTokenItemResponse(
          [void Function(GatewayTokenItemResponseBuilder) updates]) =>
      (new GatewayTokenItemResponseBuilder()..update(updates)).build();

  _$GatewayTokenItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'GatewayTokenItemResponse', 'data');
  }

  @override
  GatewayTokenItemResponse rebuild(
          void Function(GatewayTokenItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GatewayTokenItemResponseBuilder toBuilder() =>
      new GatewayTokenItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GatewayTokenItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GatewayTokenItemResponse')
          ..add('data', data))
        .toString();
  }
}

class GatewayTokenItemResponseBuilder
    implements
        Builder<GatewayTokenItemResponse, GatewayTokenItemResponseBuilder> {
  _$GatewayTokenItemResponse _$v;

  GatewayTokenEntityBuilder _data;
  GatewayTokenEntityBuilder get data =>
      _$this._data ??= new GatewayTokenEntityBuilder();
  set data(GatewayTokenEntityBuilder data) => _$this._data = data;

  GatewayTokenItemResponseBuilder();

  GatewayTokenItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayTokenItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GatewayTokenItemResponse;
  }

  @override
  void update(void Function(GatewayTokenItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GatewayTokenItemResponse build() {
    _$GatewayTokenItemResponse _$result;
    try {
      _$result = _$v ?? new _$GatewayTokenItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GatewayTokenItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GatewayTokenEntity extends GatewayTokenEntity {
  @override
  final String token;
  @override
  final String customerReference;
  @override
  final String companyGatewayId;
  @override
  final String gatewayTypeId;
  @override
  final bool isDefault;
  @override
  final GatewayTokenMetaEntity meta;
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

  factory _$GatewayTokenEntity(
          [void Function(GatewayTokenEntityBuilder) updates]) =>
      (new GatewayTokenEntityBuilder()..update(updates)).build();

  _$GatewayTokenEntity._(
      {this.token,
      this.customerReference,
      this.companyGatewayId,
      this.gatewayTypeId,
      this.isDefault,
      this.meta,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(token, 'GatewayTokenEntity', 'token');
    BuiltValueNullFieldError.checkNotNull(
        customerReference, 'GatewayTokenEntity', 'customerReference');
    BuiltValueNullFieldError.checkNotNull(
        companyGatewayId, 'GatewayTokenEntity', 'companyGatewayId');
    BuiltValueNullFieldError.checkNotNull(
        gatewayTypeId, 'GatewayTokenEntity', 'gatewayTypeId');
    BuiltValueNullFieldError.checkNotNull(
        isDefault, 'GatewayTokenEntity', 'isDefault');
    BuiltValueNullFieldError.checkNotNull(meta, 'GatewayTokenEntity', 'meta');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GatewayTokenEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'GatewayTokenEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'GatewayTokenEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'GatewayTokenEntity', 'id');
  }

  @override
  GatewayTokenEntity rebuild(
          void Function(GatewayTokenEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GatewayTokenEntityBuilder toBuilder() =>
      new GatewayTokenEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GatewayTokenEntity &&
        token == other.token &&
        customerReference == other.customerReference &&
        companyGatewayId == other.companyGatewayId &&
        gatewayTypeId == other.gatewayTypeId &&
        isDefault == other.isDefault &&
        meta == other.meta &&
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
                                                        $jc(0, token.hashCode),
                                                        customerReference
                                                            .hashCode),
                                                    companyGatewayId.hashCode),
                                                gatewayTypeId.hashCode),
                                            isDefault.hashCode),
                                        meta.hashCode),
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
    return (newBuiltValueToStringHelper('GatewayTokenEntity')
          ..add('token', token)
          ..add('customerReference', customerReference)
          ..add('companyGatewayId', companyGatewayId)
          ..add('gatewayTypeId', gatewayTypeId)
          ..add('isDefault', isDefault)
          ..add('meta', meta)
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

class GatewayTokenEntityBuilder
    implements Builder<GatewayTokenEntity, GatewayTokenEntityBuilder> {
  _$GatewayTokenEntity _$v;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  String _customerReference;
  String get customerReference => _$this._customerReference;
  set customerReference(String customerReference) =>
      _$this._customerReference = customerReference;

  String _companyGatewayId;
  String get companyGatewayId => _$this._companyGatewayId;
  set companyGatewayId(String companyGatewayId) =>
      _$this._companyGatewayId = companyGatewayId;

  String _gatewayTypeId;
  String get gatewayTypeId => _$this._gatewayTypeId;
  set gatewayTypeId(String gatewayTypeId) =>
      _$this._gatewayTypeId = gatewayTypeId;

  bool _isDefault;
  bool get isDefault => _$this._isDefault;
  set isDefault(bool isDefault) => _$this._isDefault = isDefault;

  GatewayTokenMetaEntityBuilder _meta;
  GatewayTokenMetaEntityBuilder get meta =>
      _$this._meta ??= new GatewayTokenMetaEntityBuilder();
  set meta(GatewayTokenMetaEntityBuilder meta) => _$this._meta = meta;

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

  GatewayTokenEntityBuilder();

  GatewayTokenEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _customerReference = $v.customerReference;
      _companyGatewayId = $v.companyGatewayId;
      _gatewayTypeId = $v.gatewayTypeId;
      _isDefault = $v.isDefault;
      _meta = $v.meta.toBuilder();
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
  void replace(GatewayTokenEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GatewayTokenEntity;
  }

  @override
  void update(void Function(GatewayTokenEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GatewayTokenEntity build() {
    _$GatewayTokenEntity _$result;
    try {
      _$result = _$v ??
          new _$GatewayTokenEntity._(
              token: BuiltValueNullFieldError.checkNotNull(
                  token, 'GatewayTokenEntity', 'token'),
              customerReference: BuiltValueNullFieldError.checkNotNull(
                  customerReference, 'GatewayTokenEntity', 'customerReference'),
              companyGatewayId: BuiltValueNullFieldError.checkNotNull(
                  companyGatewayId, 'GatewayTokenEntity', 'companyGatewayId'),
              gatewayTypeId: BuiltValueNullFieldError.checkNotNull(
                  gatewayTypeId, 'GatewayTokenEntity', 'gatewayTypeId'),
              isDefault: BuiltValueNullFieldError.checkNotNull(
                  isDefault, 'GatewayTokenEntity', 'isDefault'),
              meta: meta.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, 'GatewayTokenEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, 'GatewayTokenEntity', 'updatedAt'),
              archivedAt:
                  BuiltValueNullFieldError.checkNotNull(archivedAt, 'GatewayTokenEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, 'GatewayTokenEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'meta';
        meta.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GatewayTokenEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GatewayTokenMetaEntity extends GatewayTokenMetaEntity {
  @override
  final String brand;
  @override
  final String last4;
  @override
  final int type;
  @override
  final String expMonth;
  @override
  final String expYear;

  factory _$GatewayTokenMetaEntity(
          [void Function(GatewayTokenMetaEntityBuilder) updates]) =>
      (new GatewayTokenMetaEntityBuilder()..update(updates)).build();

  _$GatewayTokenMetaEntity._(
      {this.brand, this.last4, this.type, this.expMonth, this.expYear})
      : super._();

  @override
  GatewayTokenMetaEntity rebuild(
          void Function(GatewayTokenMetaEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GatewayTokenMetaEntityBuilder toBuilder() =>
      new GatewayTokenMetaEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GatewayTokenMetaEntity &&
        brand == other.brand &&
        last4 == other.last4 &&
        type == other.type &&
        expMonth == other.expMonth &&
        expYear == other.expYear;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc($jc($jc(0, brand.hashCode), last4.hashCode), type.hashCode),
            expMonth.hashCode),
        expYear.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GatewayTokenMetaEntity')
          ..add('brand', brand)
          ..add('last4', last4)
          ..add('type', type)
          ..add('expMonth', expMonth)
          ..add('expYear', expYear))
        .toString();
  }
}

class GatewayTokenMetaEntityBuilder
    implements Builder<GatewayTokenMetaEntity, GatewayTokenMetaEntityBuilder> {
  _$GatewayTokenMetaEntity _$v;

  String _brand;
  String get brand => _$this._brand;
  set brand(String brand) => _$this._brand = brand;

  String _last4;
  String get last4 => _$this._last4;
  set last4(String last4) => _$this._last4 = last4;

  int _type;
  int get type => _$this._type;
  set type(int type) => _$this._type = type;

  String _expMonth;
  String get expMonth => _$this._expMonth;
  set expMonth(String expMonth) => _$this._expMonth = expMonth;

  String _expYear;
  String get expYear => _$this._expYear;
  set expYear(String expYear) => _$this._expYear = expYear;

  GatewayTokenMetaEntityBuilder();

  GatewayTokenMetaEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _brand = $v.brand;
      _last4 = $v.last4;
      _type = $v.type;
      _expMonth = $v.expMonth;
      _expYear = $v.expYear;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayTokenMetaEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GatewayTokenMetaEntity;
  }

  @override
  void update(void Function(GatewayTokenMetaEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GatewayTokenMetaEntity build() {
    final _$result = _$v ??
        new _$GatewayTokenMetaEntity._(
            brand: brand,
            last4: last4,
            type: type,
            expMonth: expMonth,
            expYear: expYear);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
