// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_gateway_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompanyGatewayListResponse> _$companyGatewayListResponseSerializer =
    new _$CompanyGatewayListResponseSerializer();
Serializer<CompanyGatewayItemResponse> _$companyGatewayItemResponseSerializer =
    new _$CompanyGatewayItemResponseSerializer();
Serializer<CompanyGatewayEntity> _$companyGatewayEntitySerializer =
    new _$CompanyGatewayEntitySerializer();
Serializer<FeesAndLimitsSettings> _$feesAndLimitsSettingsSerializer =
    new _$FeesAndLimitsSettingsSerializer();

class _$CompanyGatewayListResponseSerializer
    implements StructuredSerializer<CompanyGatewayListResponse> {
  @override
  final Iterable<Type> types = const [
    CompanyGatewayListResponse,
    _$CompanyGatewayListResponse
  ];
  @override
  final String wireName = 'CompanyGatewayListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CompanyGatewayListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(CompanyGatewayEntity)])),
    ];

    return result;
  }

  @override
  CompanyGatewayListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyGatewayListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CompanyGatewayEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyGatewayItemResponseSerializer
    implements StructuredSerializer<CompanyGatewayItemResponse> {
  @override
  final Iterable<Type> types = const [
    CompanyGatewayItemResponse,
    _$CompanyGatewayItemResponse
  ];
  @override
  final String wireName = 'CompanyGatewayItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CompanyGatewayItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CompanyGatewayEntity)),
    ];

    return result;
  }

  @override
  CompanyGatewayItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyGatewayItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CompanyGatewayEntity))
              as CompanyGatewayEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyGatewayEntitySerializer
    implements StructuredSerializer<CompanyGatewayEntity> {
  @override
  final Iterable<Type> types = const [
    CompanyGatewayEntity,
    _$CompanyGatewayEntity
  ];
  @override
  final String wireName = 'CompanyGatewayEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CompanyGatewayEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'gateway_key',
      serializers.serialize(object.gatewayId,
          specifiedType: const FullType(String)),
      'accepted_credit_cards',
      serializers.serialize(object.acceptedCreditCards,
          specifiedType: const FullType(int)),
      'require_shipping_address',
      serializers.serialize(object.requireShippingAddress,
          specifiedType: const FullType(bool)),
      'require_billing_address',
      serializers.serialize(object.requireBillingAddress,
          specifiedType: const FullType(bool)),
      'require_client_name',
      serializers.serialize(object.requireClientName,
          specifiedType: const FullType(bool)),
      'require_client_phone',
      serializers.serialize(object.requireClientPhone,
          specifiedType: const FullType(bool)),
      'require_contact_name',
      serializers.serialize(object.requireContactName,
          specifiedType: const FullType(bool)),
      'require_contact_email',
      serializers.serialize(object.requireContactEmail,
          specifiedType: const FullType(bool)),
      'require_cvv',
      serializers.serialize(object.requireCvv,
          specifiedType: const FullType(bool)),
      'update_details',
      serializers.serialize(object.updateDetails,
          specifiedType: const FullType(bool)),
      'fees_and_limits',
      serializers.serialize(object.feesAndLimitsMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(FeesAndLimitsSettings)
          ])),
      'system_logs',
      serializers.serialize(object.systemLogs,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SystemLogEntity)])),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'config',
      serializers.serialize(object.config,
          specifiedType: const FullType(String)),
      'token_billing',
      serializers.serialize(object.tokenBilling,
          specifiedType: const FullType(String)),
      'test_mode',
      serializers.serialize(object.isTestMode,
          specifiedType: const FullType(bool)),
      'label',
      serializers.serialize(object.label,
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
    Object value;
    value = object.loadedAt;
    if (value != null) {
      result
        ..add('loadedAt')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.requirePostalCode;
    if (value != null) {
      result
        ..add('require_postal_code')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
  CompanyGatewayEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyGatewayEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'loadedAt':
          result.loadedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'gateway_key':
          result.gatewayId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accepted_credit_cards':
          result.acceptedCreditCards = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'require_shipping_address':
          result.requireShippingAddress = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_billing_address':
          result.requireBillingAddress = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_client_name':
          result.requireClientName = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_postal_code':
          result.requirePostalCode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_client_phone':
          result.requireClientPhone = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_contact_name':
          result.requireContactName = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_contact_email':
          result.requireContactEmail = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_cvv':
          result.requireCvv = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'update_details':
          result.updateDetails = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'fees_and_limits':
          result.feesAndLimitsMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(FeesAndLimitsSettings)
              ])));
          break;
        case 'system_logs':
          result.systemLogs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SystemLogEntity)]))
              as BuiltList<Object>);
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
        case 'config':
          result.config = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token_billing':
          result.tokenBilling = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'test_mode':
          result.isTestMode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'label':
          result.label = serializers.deserialize(value,
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

class _$FeesAndLimitsSettingsSerializer
    implements StructuredSerializer<FeesAndLimitsSettings> {
  @override
  final Iterable<Type> types = const [
    FeesAndLimitsSettings,
    _$FeesAndLimitsSettings
  ];
  @override
  final String wireName = 'FeesAndLimitsSettings';

  @override
  Iterable<Object> serialize(
      Serializers serializers, FeesAndLimitsSettings object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'min_limit',
      serializers.serialize(object.minLimit,
          specifiedType: const FullType(double)),
      'max_limit',
      serializers.serialize(object.maxLimit,
          specifiedType: const FullType(double)),
      'fee_amount',
      serializers.serialize(object.feeAmount,
          specifiedType: const FullType(double)),
      'fee_percent',
      serializers.serialize(object.feePercent,
          specifiedType: const FullType(double)),
      'fee_cap',
      serializers.serialize(object.feeCap,
          specifiedType: const FullType(double)),
      'fee_tax_rate1',
      serializers.serialize(object.taxRate1,
          specifiedType: const FullType(double)),
      'fee_tax_name1',
      serializers.serialize(object.taxName1,
          specifiedType: const FullType(String)),
      'fee_tax_rate2',
      serializers.serialize(object.taxRate2,
          specifiedType: const FullType(double)),
      'fee_tax_name2',
      serializers.serialize(object.taxName2,
          specifiedType: const FullType(String)),
      'fee_tax_rate3',
      serializers.serialize(object.taxRate3,
          specifiedType: const FullType(double)),
      'fee_tax_name3',
      serializers.serialize(object.taxName3,
          specifiedType: const FullType(String)),
      'adjust_fee_percent',
      serializers.serialize(object.adjustFeePercent,
          specifiedType: const FullType(bool)),
      'is_enabled',
      serializers.serialize(object.isEnabled,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  FeesAndLimitsSettings deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeesAndLimitsSettingsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'min_limit':
          result.minLimit = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'max_limit':
          result.maxLimit = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fee_amount':
          result.feeAmount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fee_percent':
          result.feePercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fee_cap':
          result.feeCap = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fee_tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fee_tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fee_tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fee_tax_name2':
          result.taxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fee_tax_rate3':
          result.taxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fee_tax_name3':
          result.taxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'adjust_fee_percent':
          result.adjustFeePercent = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_enabled':
          result.isEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyGatewayListResponse extends CompanyGatewayListResponse {
  @override
  final BuiltList<CompanyGatewayEntity> data;

  factory _$CompanyGatewayListResponse(
          [void Function(CompanyGatewayListResponseBuilder) updates]) =>
      (new CompanyGatewayListResponseBuilder()..update(updates)).build();

  _$CompanyGatewayListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'CompanyGatewayListResponse', 'data');
  }

  @override
  CompanyGatewayListResponse rebuild(
          void Function(CompanyGatewayListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyGatewayListResponseBuilder toBuilder() =>
      new CompanyGatewayListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyGatewayListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyGatewayListResponse')
          ..add('data', data))
        .toString();
  }
}

class CompanyGatewayListResponseBuilder
    implements
        Builder<CompanyGatewayListResponse, CompanyGatewayListResponseBuilder> {
  _$CompanyGatewayListResponse _$v;

  ListBuilder<CompanyGatewayEntity> _data;
  ListBuilder<CompanyGatewayEntity> get data =>
      _$this._data ??= new ListBuilder<CompanyGatewayEntity>();
  set data(ListBuilder<CompanyGatewayEntity> data) => _$this._data = data;

  CompanyGatewayListResponseBuilder();

  CompanyGatewayListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyGatewayListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompanyGatewayListResponse;
  }

  @override
  void update(void Function(CompanyGatewayListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyGatewayListResponse build() {
    _$CompanyGatewayListResponse _$result;
    try {
      _$result = _$v ?? new _$CompanyGatewayListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyGatewayListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CompanyGatewayItemResponse extends CompanyGatewayItemResponse {
  @override
  final CompanyGatewayEntity data;

  factory _$CompanyGatewayItemResponse(
          [void Function(CompanyGatewayItemResponseBuilder) updates]) =>
      (new CompanyGatewayItemResponseBuilder()..update(updates)).build();

  _$CompanyGatewayItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'CompanyGatewayItemResponse', 'data');
  }

  @override
  CompanyGatewayItemResponse rebuild(
          void Function(CompanyGatewayItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyGatewayItemResponseBuilder toBuilder() =>
      new CompanyGatewayItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyGatewayItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyGatewayItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CompanyGatewayItemResponseBuilder
    implements
        Builder<CompanyGatewayItemResponse, CompanyGatewayItemResponseBuilder> {
  _$CompanyGatewayItemResponse _$v;

  CompanyGatewayEntityBuilder _data;
  CompanyGatewayEntityBuilder get data =>
      _$this._data ??= new CompanyGatewayEntityBuilder();
  set data(CompanyGatewayEntityBuilder data) => _$this._data = data;

  CompanyGatewayItemResponseBuilder();

  CompanyGatewayItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyGatewayItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompanyGatewayItemResponse;
  }

  @override
  void update(void Function(CompanyGatewayItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyGatewayItemResponse build() {
    _$CompanyGatewayItemResponse _$result;
    try {
      _$result = _$v ?? new _$CompanyGatewayItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyGatewayItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CompanyGatewayEntity extends CompanyGatewayEntity {
  @override
  final int loadedAt;
  @override
  final String gatewayId;
  @override
  final int acceptedCreditCards;
  @override
  final bool requireShippingAddress;
  @override
  final bool requireBillingAddress;
  @override
  final bool requireClientName;
  @override
  final bool requirePostalCode;
  @override
  final bool requireClientPhone;
  @override
  final bool requireContactName;
  @override
  final bool requireContactEmail;
  @override
  final bool requireCvv;
  @override
  final bool updateDetails;
  @override
  final BuiltMap<String, FeesAndLimitsSettings> feesAndLimitsMap;
  @override
  final BuiltList<SystemLogEntity> systemLogs;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final String config;
  @override
  final String tokenBilling;
  @override
  final bool isTestMode;
  @override
  final String label;
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

  factory _$CompanyGatewayEntity(
          [void Function(CompanyGatewayEntityBuilder) updates]) =>
      (new CompanyGatewayEntityBuilder()..update(updates)).build();

  _$CompanyGatewayEntity._(
      {this.loadedAt,
      this.gatewayId,
      this.acceptedCreditCards,
      this.requireShippingAddress,
      this.requireBillingAddress,
      this.requireClientName,
      this.requirePostalCode,
      this.requireClientPhone,
      this.requireContactName,
      this.requireContactEmail,
      this.requireCvv,
      this.updateDetails,
      this.feesAndLimitsMap,
      this.systemLogs,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.config,
      this.tokenBilling,
      this.isTestMode,
      this.label,
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
    BuiltValueNullFieldError.checkNotNull(
        gatewayId, 'CompanyGatewayEntity', 'gatewayId');
    BuiltValueNullFieldError.checkNotNull(
        acceptedCreditCards, 'CompanyGatewayEntity', 'acceptedCreditCards');
    BuiltValueNullFieldError.checkNotNull(requireShippingAddress,
        'CompanyGatewayEntity', 'requireShippingAddress');
    BuiltValueNullFieldError.checkNotNull(
        requireBillingAddress, 'CompanyGatewayEntity', 'requireBillingAddress');
    BuiltValueNullFieldError.checkNotNull(
        requireClientName, 'CompanyGatewayEntity', 'requireClientName');
    BuiltValueNullFieldError.checkNotNull(
        requireClientPhone, 'CompanyGatewayEntity', 'requireClientPhone');
    BuiltValueNullFieldError.checkNotNull(
        requireContactName, 'CompanyGatewayEntity', 'requireContactName');
    BuiltValueNullFieldError.checkNotNull(
        requireContactEmail, 'CompanyGatewayEntity', 'requireContactEmail');
    BuiltValueNullFieldError.checkNotNull(
        requireCvv, 'CompanyGatewayEntity', 'requireCvv');
    BuiltValueNullFieldError.checkNotNull(
        updateDetails, 'CompanyGatewayEntity', 'updateDetails');
    BuiltValueNullFieldError.checkNotNull(
        feesAndLimitsMap, 'CompanyGatewayEntity', 'feesAndLimitsMap');
    BuiltValueNullFieldError.checkNotNull(
        systemLogs, 'CompanyGatewayEntity', 'systemLogs');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, 'CompanyGatewayEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, 'CompanyGatewayEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, 'CompanyGatewayEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, 'CompanyGatewayEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        config, 'CompanyGatewayEntity', 'config');
    BuiltValueNullFieldError.checkNotNull(
        tokenBilling, 'CompanyGatewayEntity', 'tokenBilling');
    BuiltValueNullFieldError.checkNotNull(
        isTestMode, 'CompanyGatewayEntity', 'isTestMode');
    BuiltValueNullFieldError.checkNotNull(
        label, 'CompanyGatewayEntity', 'label');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'CompanyGatewayEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'CompanyGatewayEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'CompanyGatewayEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'CompanyGatewayEntity', 'id');
  }

  @override
  CompanyGatewayEntity rebuild(
          void Function(CompanyGatewayEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyGatewayEntityBuilder toBuilder() =>
      new CompanyGatewayEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyGatewayEntity &&
        gatewayId == other.gatewayId &&
        acceptedCreditCards == other.acceptedCreditCards &&
        requireShippingAddress == other.requireShippingAddress &&
        requireBillingAddress == other.requireBillingAddress &&
        requireClientName == other.requireClientName &&
        requirePostalCode == other.requirePostalCode &&
        requireClientPhone == other.requireClientPhone &&
        requireContactName == other.requireContactName &&
        requireContactEmail == other.requireContactEmail &&
        requireCvv == other.requireCvv &&
        updateDetails == other.updateDetails &&
        feesAndLimitsMap == other.feesAndLimitsMap &&
        systemLogs == other.systemLogs &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        config == other.config &&
        tokenBilling == other.tokenBilling &&
        isTestMode == other.isTestMode &&
        label == other.label &&
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
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, gatewayId.hashCode), acceptedCreditCards.hashCode), requireShippingAddress.hashCode), requireBillingAddress.hashCode), requireClientName.hashCode), requirePostalCode.hashCode), requireClientPhone.hashCode), requireContactName.hashCode), requireContactEmail.hashCode), requireCvv.hashCode), updateDetails.hashCode),
                                                                                feesAndLimitsMap.hashCode),
                                                                            systemLogs.hashCode),
                                                                        customValue1.hashCode),
                                                                    customValue2.hashCode),
                                                                customValue3.hashCode),
                                                            customValue4.hashCode),
                                                        config.hashCode),
                                                    tokenBilling.hashCode),
                                                isTestMode.hashCode),
                                            label.hashCode),
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
    return (newBuiltValueToStringHelper('CompanyGatewayEntity')
          ..add('loadedAt', loadedAt)
          ..add('gatewayId', gatewayId)
          ..add('acceptedCreditCards', acceptedCreditCards)
          ..add('requireShippingAddress', requireShippingAddress)
          ..add('requireBillingAddress', requireBillingAddress)
          ..add('requireClientName', requireClientName)
          ..add('requirePostalCode', requirePostalCode)
          ..add('requireClientPhone', requireClientPhone)
          ..add('requireContactName', requireContactName)
          ..add('requireContactEmail', requireContactEmail)
          ..add('requireCvv', requireCvv)
          ..add('updateDetails', updateDetails)
          ..add('feesAndLimitsMap', feesAndLimitsMap)
          ..add('systemLogs', systemLogs)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('config', config)
          ..add('tokenBilling', tokenBilling)
          ..add('isTestMode', isTestMode)
          ..add('label', label)
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

class CompanyGatewayEntityBuilder
    implements Builder<CompanyGatewayEntity, CompanyGatewayEntityBuilder> {
  _$CompanyGatewayEntity _$v;

  int _loadedAt;
  int get loadedAt => _$this._loadedAt;
  set loadedAt(int loadedAt) => _$this._loadedAt = loadedAt;

  String _gatewayId;
  String get gatewayId => _$this._gatewayId;
  set gatewayId(String gatewayId) => _$this._gatewayId = gatewayId;

  int _acceptedCreditCards;
  int get acceptedCreditCards => _$this._acceptedCreditCards;
  set acceptedCreditCards(int acceptedCreditCards) =>
      _$this._acceptedCreditCards = acceptedCreditCards;

  bool _requireShippingAddress;
  bool get requireShippingAddress => _$this._requireShippingAddress;
  set requireShippingAddress(bool requireShippingAddress) =>
      _$this._requireShippingAddress = requireShippingAddress;

  bool _requireBillingAddress;
  bool get requireBillingAddress => _$this._requireBillingAddress;
  set requireBillingAddress(bool requireBillingAddress) =>
      _$this._requireBillingAddress = requireBillingAddress;

  bool _requireClientName;
  bool get requireClientName => _$this._requireClientName;
  set requireClientName(bool requireClientName) =>
      _$this._requireClientName = requireClientName;

  bool _requirePostalCode;
  bool get requirePostalCode => _$this._requirePostalCode;
  set requirePostalCode(bool requirePostalCode) =>
      _$this._requirePostalCode = requirePostalCode;

  bool _requireClientPhone;
  bool get requireClientPhone => _$this._requireClientPhone;
  set requireClientPhone(bool requireClientPhone) =>
      _$this._requireClientPhone = requireClientPhone;

  bool _requireContactName;
  bool get requireContactName => _$this._requireContactName;
  set requireContactName(bool requireContactName) =>
      _$this._requireContactName = requireContactName;

  bool _requireContactEmail;
  bool get requireContactEmail => _$this._requireContactEmail;
  set requireContactEmail(bool requireContactEmail) =>
      _$this._requireContactEmail = requireContactEmail;

  bool _requireCvv;
  bool get requireCvv => _$this._requireCvv;
  set requireCvv(bool requireCvv) => _$this._requireCvv = requireCvv;

  bool _updateDetails;
  bool get updateDetails => _$this._updateDetails;
  set updateDetails(bool updateDetails) =>
      _$this._updateDetails = updateDetails;

  MapBuilder<String, FeesAndLimitsSettings> _feesAndLimitsMap;
  MapBuilder<String, FeesAndLimitsSettings> get feesAndLimitsMap =>
      _$this._feesAndLimitsMap ??=
          new MapBuilder<String, FeesAndLimitsSettings>();
  set feesAndLimitsMap(
          MapBuilder<String, FeesAndLimitsSettings> feesAndLimitsMap) =>
      _$this._feesAndLimitsMap = feesAndLimitsMap;

  ListBuilder<SystemLogEntity> _systemLogs;
  ListBuilder<SystemLogEntity> get systemLogs =>
      _$this._systemLogs ??= new ListBuilder<SystemLogEntity>();
  set systemLogs(ListBuilder<SystemLogEntity> systemLogs) =>
      _$this._systemLogs = systemLogs;

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

  String _config;
  String get config => _$this._config;
  set config(String config) => _$this._config = config;

  String _tokenBilling;
  String get tokenBilling => _$this._tokenBilling;
  set tokenBilling(String tokenBilling) => _$this._tokenBilling = tokenBilling;

  bool _isTestMode;
  bool get isTestMode => _$this._isTestMode;
  set isTestMode(bool isTestMode) => _$this._isTestMode = isTestMode;

  String _label;
  String get label => _$this._label;
  set label(String label) => _$this._label = label;

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

  CompanyGatewayEntityBuilder();

  CompanyGatewayEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loadedAt = $v.loadedAt;
      _gatewayId = $v.gatewayId;
      _acceptedCreditCards = $v.acceptedCreditCards;
      _requireShippingAddress = $v.requireShippingAddress;
      _requireBillingAddress = $v.requireBillingAddress;
      _requireClientName = $v.requireClientName;
      _requirePostalCode = $v.requirePostalCode;
      _requireClientPhone = $v.requireClientPhone;
      _requireContactName = $v.requireContactName;
      _requireContactEmail = $v.requireContactEmail;
      _requireCvv = $v.requireCvv;
      _updateDetails = $v.updateDetails;
      _feesAndLimitsMap = $v.feesAndLimitsMap.toBuilder();
      _systemLogs = $v.systemLogs.toBuilder();
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _config = $v.config;
      _tokenBilling = $v.tokenBilling;
      _isTestMode = $v.isTestMode;
      _label = $v.label;
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
  void replace(CompanyGatewayEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompanyGatewayEntity;
  }

  @override
  void update(void Function(CompanyGatewayEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyGatewayEntity build() {
    _$CompanyGatewayEntity _$result;
    try {
      _$result = _$v ??
          new _$CompanyGatewayEntity._(
              loadedAt: loadedAt,
              gatewayId: BuiltValueNullFieldError.checkNotNull(
                  gatewayId, 'CompanyGatewayEntity', 'gatewayId'),
              acceptedCreditCards: BuiltValueNullFieldError.checkNotNull(
                  acceptedCreditCards, 'CompanyGatewayEntity', 'acceptedCreditCards'),
              requireShippingAddress: BuiltValueNullFieldError.checkNotNull(
                  requireShippingAddress, 'CompanyGatewayEntity', 'requireShippingAddress'),
              requireBillingAddress: BuiltValueNullFieldError.checkNotNull(
                  requireBillingAddress, 'CompanyGatewayEntity', 'requireBillingAddress'),
              requireClientName: BuiltValueNullFieldError.checkNotNull(
                  requireClientName, 'CompanyGatewayEntity', 'requireClientName'),
              requirePostalCode: requirePostalCode,
              requireClientPhone: BuiltValueNullFieldError.checkNotNull(
                  requireClientPhone, 'CompanyGatewayEntity', 'requireClientPhone'),
              requireContactName: BuiltValueNullFieldError.checkNotNull(
                  requireContactName, 'CompanyGatewayEntity', 'requireContactName'),
              requireContactEmail: BuiltValueNullFieldError.checkNotNull(requireContactEmail, 'CompanyGatewayEntity', 'requireContactEmail'),
              requireCvv: BuiltValueNullFieldError.checkNotNull(requireCvv, 'CompanyGatewayEntity', 'requireCvv'),
              updateDetails: BuiltValueNullFieldError.checkNotNull(updateDetails, 'CompanyGatewayEntity', 'updateDetails'),
              feesAndLimitsMap: feesAndLimitsMap.build(),
              systemLogs: systemLogs.build(),
              customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, 'CompanyGatewayEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, 'CompanyGatewayEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, 'CompanyGatewayEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, 'CompanyGatewayEntity', 'customValue4'),
              config: BuiltValueNullFieldError.checkNotNull(config, 'CompanyGatewayEntity', 'config'),
              tokenBilling: BuiltValueNullFieldError.checkNotNull(tokenBilling, 'CompanyGatewayEntity', 'tokenBilling'),
              isTestMode: BuiltValueNullFieldError.checkNotNull(isTestMode, 'CompanyGatewayEntity', 'isTestMode'),
              label: BuiltValueNullFieldError.checkNotNull(label, 'CompanyGatewayEntity', 'label'),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, 'CompanyGatewayEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, 'CompanyGatewayEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, 'CompanyGatewayEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              idempotencyKey: idempotencyKey,
              id: BuiltValueNullFieldError.checkNotNull(id, 'CompanyGatewayEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'feesAndLimitsMap';
        feesAndLimitsMap.build();
        _$failedField = 'systemLogs';
        systemLogs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyGatewayEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$FeesAndLimitsSettings extends FeesAndLimitsSettings {
  @override
  final double minLimit;
  @override
  final double maxLimit;
  @override
  final double feeAmount;
  @override
  final double feePercent;
  @override
  final double feeCap;
  @override
  final double taxRate1;
  @override
  final String taxName1;
  @override
  final double taxRate2;
  @override
  final String taxName2;
  @override
  final double taxRate3;
  @override
  final String taxName3;
  @override
  final bool adjustFeePercent;
  @override
  final bool isEnabled;

  factory _$FeesAndLimitsSettings(
          [void Function(FeesAndLimitsSettingsBuilder) updates]) =>
      (new FeesAndLimitsSettingsBuilder()..update(updates)).build();

  _$FeesAndLimitsSettings._(
      {this.minLimit,
      this.maxLimit,
      this.feeAmount,
      this.feePercent,
      this.feeCap,
      this.taxRate1,
      this.taxName1,
      this.taxRate2,
      this.taxName2,
      this.taxRate3,
      this.taxName3,
      this.adjustFeePercent,
      this.isEnabled})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        minLimit, 'FeesAndLimitsSettings', 'minLimit');
    BuiltValueNullFieldError.checkNotNull(
        maxLimit, 'FeesAndLimitsSettings', 'maxLimit');
    BuiltValueNullFieldError.checkNotNull(
        feeAmount, 'FeesAndLimitsSettings', 'feeAmount');
    BuiltValueNullFieldError.checkNotNull(
        feePercent, 'FeesAndLimitsSettings', 'feePercent');
    BuiltValueNullFieldError.checkNotNull(
        feeCap, 'FeesAndLimitsSettings', 'feeCap');
    BuiltValueNullFieldError.checkNotNull(
        taxRate1, 'FeesAndLimitsSettings', 'taxRate1');
    BuiltValueNullFieldError.checkNotNull(
        taxName1, 'FeesAndLimitsSettings', 'taxName1');
    BuiltValueNullFieldError.checkNotNull(
        taxRate2, 'FeesAndLimitsSettings', 'taxRate2');
    BuiltValueNullFieldError.checkNotNull(
        taxName2, 'FeesAndLimitsSettings', 'taxName2');
    BuiltValueNullFieldError.checkNotNull(
        taxRate3, 'FeesAndLimitsSettings', 'taxRate3');
    BuiltValueNullFieldError.checkNotNull(
        taxName3, 'FeesAndLimitsSettings', 'taxName3');
    BuiltValueNullFieldError.checkNotNull(
        adjustFeePercent, 'FeesAndLimitsSettings', 'adjustFeePercent');
    BuiltValueNullFieldError.checkNotNull(
        isEnabled, 'FeesAndLimitsSettings', 'isEnabled');
  }

  @override
  FeesAndLimitsSettings rebuild(
          void Function(FeesAndLimitsSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeesAndLimitsSettingsBuilder toBuilder() =>
      new FeesAndLimitsSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeesAndLimitsSettings &&
        minLimit == other.minLimit &&
        maxLimit == other.maxLimit &&
        feeAmount == other.feeAmount &&
        feePercent == other.feePercent &&
        feeCap == other.feeCap &&
        taxRate1 == other.taxRate1 &&
        taxName1 == other.taxName1 &&
        taxRate2 == other.taxRate2 &&
        taxName2 == other.taxName2 &&
        taxRate3 == other.taxRate3 &&
        taxName3 == other.taxName3 &&
        adjustFeePercent == other.adjustFeePercent &&
        isEnabled == other.isEnabled;
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
                                                $jc($jc(0, minLimit.hashCode),
                                                    maxLimit.hashCode),
                                                feeAmount.hashCode),
                                            feePercent.hashCode),
                                        feeCap.hashCode),
                                    taxRate1.hashCode),
                                taxName1.hashCode),
                            taxRate2.hashCode),
                        taxName2.hashCode),
                    taxRate3.hashCode),
                taxName3.hashCode),
            adjustFeePercent.hashCode),
        isEnabled.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeesAndLimitsSettings')
          ..add('minLimit', minLimit)
          ..add('maxLimit', maxLimit)
          ..add('feeAmount', feeAmount)
          ..add('feePercent', feePercent)
          ..add('feeCap', feeCap)
          ..add('taxRate1', taxRate1)
          ..add('taxName1', taxName1)
          ..add('taxRate2', taxRate2)
          ..add('taxName2', taxName2)
          ..add('taxRate3', taxRate3)
          ..add('taxName3', taxName3)
          ..add('adjustFeePercent', adjustFeePercent)
          ..add('isEnabled', isEnabled))
        .toString();
  }
}

class FeesAndLimitsSettingsBuilder
    implements Builder<FeesAndLimitsSettings, FeesAndLimitsSettingsBuilder> {
  _$FeesAndLimitsSettings _$v;

  double _minLimit;
  double get minLimit => _$this._minLimit;
  set minLimit(double minLimit) => _$this._minLimit = minLimit;

  double _maxLimit;
  double get maxLimit => _$this._maxLimit;
  set maxLimit(double maxLimit) => _$this._maxLimit = maxLimit;

  double _feeAmount;
  double get feeAmount => _$this._feeAmount;
  set feeAmount(double feeAmount) => _$this._feeAmount = feeAmount;

  double _feePercent;
  double get feePercent => _$this._feePercent;
  set feePercent(double feePercent) => _$this._feePercent = feePercent;

  double _feeCap;
  double get feeCap => _$this._feeCap;
  set feeCap(double feeCap) => _$this._feeCap = feeCap;

  double _taxRate1;
  double get taxRate1 => _$this._taxRate1;
  set taxRate1(double taxRate1) => _$this._taxRate1 = taxRate1;

  String _taxName1;
  String get taxName1 => _$this._taxName1;
  set taxName1(String taxName1) => _$this._taxName1 = taxName1;

  double _taxRate2;
  double get taxRate2 => _$this._taxRate2;
  set taxRate2(double taxRate2) => _$this._taxRate2 = taxRate2;

  String _taxName2;
  String get taxName2 => _$this._taxName2;
  set taxName2(String taxName2) => _$this._taxName2 = taxName2;

  double _taxRate3;
  double get taxRate3 => _$this._taxRate3;
  set taxRate3(double taxRate3) => _$this._taxRate3 = taxRate3;

  String _taxName3;
  String get taxName3 => _$this._taxName3;
  set taxName3(String taxName3) => _$this._taxName3 = taxName3;

  bool _adjustFeePercent;
  bool get adjustFeePercent => _$this._adjustFeePercent;
  set adjustFeePercent(bool adjustFeePercent) =>
      _$this._adjustFeePercent = adjustFeePercent;

  bool _isEnabled;
  bool get isEnabled => _$this._isEnabled;
  set isEnabled(bool isEnabled) => _$this._isEnabled = isEnabled;

  FeesAndLimitsSettingsBuilder() {
    FeesAndLimitsSettings._initializeBuilder(this);
  }

  FeesAndLimitsSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _minLimit = $v.minLimit;
      _maxLimit = $v.maxLimit;
      _feeAmount = $v.feeAmount;
      _feePercent = $v.feePercent;
      _feeCap = $v.feeCap;
      _taxRate1 = $v.taxRate1;
      _taxName1 = $v.taxName1;
      _taxRate2 = $v.taxRate2;
      _taxName2 = $v.taxName2;
      _taxRate3 = $v.taxRate3;
      _taxName3 = $v.taxName3;
      _adjustFeePercent = $v.adjustFeePercent;
      _isEnabled = $v.isEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeesAndLimitsSettings other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FeesAndLimitsSettings;
  }

  @override
  void update(void Function(FeesAndLimitsSettingsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FeesAndLimitsSettings build() {
    final _$result = _$v ??
        new _$FeesAndLimitsSettings._(
            minLimit: BuiltValueNullFieldError.checkNotNull(
                minLimit, 'FeesAndLimitsSettings', 'minLimit'),
            maxLimit: BuiltValueNullFieldError.checkNotNull(
                maxLimit, 'FeesAndLimitsSettings', 'maxLimit'),
            feeAmount: BuiltValueNullFieldError.checkNotNull(
                feeAmount, 'FeesAndLimitsSettings', 'feeAmount'),
            feePercent: BuiltValueNullFieldError.checkNotNull(
                feePercent, 'FeesAndLimitsSettings', 'feePercent'),
            feeCap: BuiltValueNullFieldError.checkNotNull(
                feeCap, 'FeesAndLimitsSettings', 'feeCap'),
            taxRate1: BuiltValueNullFieldError.checkNotNull(
                taxRate1, 'FeesAndLimitsSettings', 'taxRate1'),
            taxName1: BuiltValueNullFieldError.checkNotNull(
                taxName1, 'FeesAndLimitsSettings', 'taxName1'),
            taxRate2: BuiltValueNullFieldError.checkNotNull(
                taxRate2, 'FeesAndLimitsSettings', 'taxRate2'),
            taxName2:
                BuiltValueNullFieldError.checkNotNull(taxName2, 'FeesAndLimitsSettings', 'taxName2'),
            taxRate3: BuiltValueNullFieldError.checkNotNull(taxRate3, 'FeesAndLimitsSettings', 'taxRate3'),
            taxName3: BuiltValueNullFieldError.checkNotNull(taxName3, 'FeesAndLimitsSettings', 'taxName3'),
            adjustFeePercent: BuiltValueNullFieldError.checkNotNull(adjustFeePercent, 'FeesAndLimitsSettings', 'adjustFeePercent'),
            isEnabled: BuiltValueNullFieldError.checkNotNull(isEnabled, 'FeesAndLimitsSettings', 'isEnabled'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
