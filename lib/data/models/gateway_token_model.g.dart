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
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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
    if (object.companyGateway != null) {
      result
        ..add('company_gateway')
        ..add(serializers.serialize(object.companyGateway,
            specifiedType: const FullType(CompanyGatewayEntity)));
    }
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
  GatewayTokenEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GatewayTokenEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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
        case 'company_gateway':
          result.companyGateway.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CompanyGatewayEntity))
              as CompanyGatewayEntity);
          break;
        case 'gateway_type_id':
          result.gatewayTypeId = serializers.deserialize(value,
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
        case 'id':
          result.id = serializers.deserialize(value,
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
    if (data == null) {
      throw new BuiltValueNullFieldError('GatewayTokenListResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayTokenListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
    if (data == null) {
      throw new BuiltValueNullFieldError('GatewayTokenItemResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayTokenItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
  final CompanyGatewayEntity companyGateway;
  @override
  final String gatewayTypeId;
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
  final String id;

  factory _$GatewayTokenEntity(
          [void Function(GatewayTokenEntityBuilder) updates]) =>
      (new GatewayTokenEntityBuilder()..update(updates)).build();

  _$GatewayTokenEntity._(
      {this.token,
      this.customerReference,
      this.companyGatewayId,
      this.companyGateway,
      this.gatewayTypeId,
      this.isDefault,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (token == null) {
      throw new BuiltValueNullFieldError('GatewayTokenEntity', 'token');
    }
    if (customerReference == null) {
      throw new BuiltValueNullFieldError(
          'GatewayTokenEntity', 'customerReference');
    }
    if (companyGatewayId == null) {
      throw new BuiltValueNullFieldError(
          'GatewayTokenEntity', 'companyGatewayId');
    }
    if (gatewayTypeId == null) {
      throw new BuiltValueNullFieldError('GatewayTokenEntity', 'gatewayTypeId');
    }
    if (isDefault == null) {
      throw new BuiltValueNullFieldError('GatewayTokenEntity', 'isDefault');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('GatewayTokenEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('GatewayTokenEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('GatewayTokenEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('GatewayTokenEntity', 'id');
    }
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
        companyGateway == other.companyGateway &&
        gatewayTypeId == other.gatewayTypeId &&
        isDefault == other.isDefault &&
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
                                                companyGateway.hashCode),
                                            gatewayTypeId.hashCode),
                                        isDefault.hashCode),
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
          ..add('companyGateway', companyGateway)
          ..add('gatewayTypeId', gatewayTypeId)
          ..add('isDefault', isDefault)
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

  CompanyGatewayEntityBuilder _companyGateway;
  CompanyGatewayEntityBuilder get companyGateway =>
      _$this._companyGateway ??= new CompanyGatewayEntityBuilder();
  set companyGateway(CompanyGatewayEntityBuilder companyGateway) =>
      _$this._companyGateway = companyGateway;

  String _gatewayTypeId;
  String get gatewayTypeId => _$this._gatewayTypeId;
  set gatewayTypeId(String gatewayTypeId) =>
      _$this._gatewayTypeId = gatewayTypeId;

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

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  GatewayTokenEntityBuilder();

  GatewayTokenEntityBuilder get _$this {
    if (_$v != null) {
      _token = _$v.token;
      _customerReference = _$v.customerReference;
      _companyGatewayId = _$v.companyGatewayId;
      _companyGateway = _$v.companyGateway?.toBuilder();
      _gatewayTypeId = _$v.gatewayTypeId;
      _isDefault = _$v.isDefault;
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
  void replace(GatewayTokenEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              token: token,
              customerReference: customerReference,
              companyGatewayId: companyGatewayId,
              companyGateway: _companyGateway?.build(),
              gatewayTypeId: gatewayTypeId,
              isDefault: isDefault,
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'companyGateway';
        _companyGateway?.build();
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
