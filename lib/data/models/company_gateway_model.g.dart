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
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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
      'gateway',
      serializers.serialize(object.gateway,
          specifiedType: const FullType(GatewayEntity)),
      'gateway_key',
      serializers.serialize(object.gatewayId,
          specifiedType: const FullType(String)),
      'accepted_credit_cards',
      serializers.serialize(object.acceptedCreditCards,
          specifiedType: const FullType(int)),
      'show_billing_address',
      serializers.serialize(object.showBillingAddress,
          specifiedType: const FullType(bool)),
      'show_shipping_address',
      serializers.serialize(object.showShippingAddress,
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
    if (object.autobill != null) {
      result
        ..add('autobill')
        ..add(serializers.serialize(object.autobill,
            specifiedType: const FullType(String)));
    }
    if (object.label != null) {
      result
        ..add('label')
        ..add(serializers.serialize(object.label,
            specifiedType: const FullType(String)));
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
  CompanyGatewayEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyGatewayEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'gateway':
          result.gateway.replace(serializers.deserialize(value,
              specifiedType: const FullType(GatewayEntity)) as GatewayEntity);
          break;
        case 'gateway_key':
          result.gatewayId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accepted_credit_cards':
          result.acceptedCreditCards = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'show_billing_address':
          result.showBillingAddress = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_shipping_address':
          result.showShippingAddress = serializers.deserialize(value,
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
        case 'autobill':
          result.autobill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
      final dynamic value = iterator.current;
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
    if (data == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayListResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyGatewayListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
    if (data == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayItemResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyGatewayItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
  final GatewayEntity gateway;
  @override
  final String gatewayId;
  @override
  final int acceptedCreditCards;
  @override
  final bool showBillingAddress;
  @override
  final bool showShippingAddress;
  @override
  final bool updateDetails;
  @override
  final BuiltMap<String, FeesAndLimitsSettings> feesAndLimitsMap;
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
  final String autobill;
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
  final String id;

  factory _$CompanyGatewayEntity(
          [void Function(CompanyGatewayEntityBuilder) updates]) =>
      (new CompanyGatewayEntityBuilder()..update(updates)).build();

  _$CompanyGatewayEntity._(
      {this.gateway,
      this.gatewayId,
      this.acceptedCreditCards,
      this.showBillingAddress,
      this.showShippingAddress,
      this.updateDetails,
      this.feesAndLimitsMap,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.config,
      this.autobill,
      this.label,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (gateway == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayEntity', 'gateway');
    }
    if (gatewayId == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayEntity', 'gatewayId');
    }
    if (acceptedCreditCards == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'acceptedCreditCards');
    }
    if (showBillingAddress == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'showBillingAddress');
    }
    if (showShippingAddress == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'showShippingAddress');
    }
    if (updateDetails == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'updateDetails');
    }
    if (feesAndLimitsMap == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'feesAndLimitsMap');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyGatewayEntity', 'customValue4');
    }
    if (config == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayEntity', 'config');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('CompanyGatewayEntity', 'id');
    }
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
        gateway == other.gateway &&
        gatewayId == other.gatewayId &&
        acceptedCreditCards == other.acceptedCreditCards &&
        showBillingAddress == other.showBillingAddress &&
        showShippingAddress == other.showShippingAddress &&
        updateDetails == other.updateDetails &&
        feesAndLimitsMap == other.feesAndLimitsMap &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        config == other.config &&
        autobill == other.autobill &&
        label == other.label &&
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
                                                                            $jc($jc($jc($jc(0, gateway.hashCode), gatewayId.hashCode), acceptedCreditCards.hashCode),
                                                                                showBillingAddress.hashCode),
                                                                            showShippingAddress.hashCode),
                                                                        updateDetails.hashCode),
                                                                    feesAndLimitsMap.hashCode),
                                                                customValue1.hashCode),
                                                            customValue2.hashCode),
                                                        customValue3.hashCode),
                                                    customValue4.hashCode),
                                                config.hashCode),
                                            autobill.hashCode),
                                        label.hashCode),
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
    return (newBuiltValueToStringHelper('CompanyGatewayEntity')
          ..add('gateway', gateway)
          ..add('gatewayId', gatewayId)
          ..add('acceptedCreditCards', acceptedCreditCards)
          ..add('showBillingAddress', showBillingAddress)
          ..add('showShippingAddress', showShippingAddress)
          ..add('updateDetails', updateDetails)
          ..add('feesAndLimitsMap', feesAndLimitsMap)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('config', config)
          ..add('autobill', autobill)
          ..add('label', label)
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

class CompanyGatewayEntityBuilder
    implements Builder<CompanyGatewayEntity, CompanyGatewayEntityBuilder> {
  _$CompanyGatewayEntity _$v;

  GatewayEntityBuilder _gateway;
  GatewayEntityBuilder get gateway =>
      _$this._gateway ??= new GatewayEntityBuilder();
  set gateway(GatewayEntityBuilder gateway) => _$this._gateway = gateway;

  String _gatewayId;
  String get gatewayId => _$this._gatewayId;
  set gatewayId(String gatewayId) => _$this._gatewayId = gatewayId;

  int _acceptedCreditCards;
  int get acceptedCreditCards => _$this._acceptedCreditCards;
  set acceptedCreditCards(int acceptedCreditCards) =>
      _$this._acceptedCreditCards = acceptedCreditCards;

  bool _showBillingAddress;
  bool get showBillingAddress => _$this._showBillingAddress;
  set showBillingAddress(bool showBillingAddress) =>
      _$this._showBillingAddress = showBillingAddress;

  bool _showShippingAddress;
  bool get showShippingAddress => _$this._showShippingAddress;
  set showShippingAddress(bool showShippingAddress) =>
      _$this._showShippingAddress = showShippingAddress;

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

  String _autobill;
  String get autobill => _$this._autobill;
  set autobill(String autobill) => _$this._autobill = autobill;

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

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  CompanyGatewayEntityBuilder();

  CompanyGatewayEntityBuilder get _$this {
    if (_$v != null) {
      _gateway = _$v.gateway?.toBuilder();
      _gatewayId = _$v.gatewayId;
      _acceptedCreditCards = _$v.acceptedCreditCards;
      _showBillingAddress = _$v.showBillingAddress;
      _showShippingAddress = _$v.showShippingAddress;
      _updateDetails = _$v.updateDetails;
      _feesAndLimitsMap = _$v.feesAndLimitsMap?.toBuilder();
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _config = _$v.config;
      _autobill = _$v.autobill;
      _label = _$v.label;
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
  void replace(CompanyGatewayEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              gateway: gateway.build(),
              gatewayId: gatewayId,
              acceptedCreditCards: acceptedCreditCards,
              showBillingAddress: showBillingAddress,
              showShippingAddress: showShippingAddress,
              updateDetails: updateDetails,
              feesAndLimitsMap: feesAndLimitsMap.build(),
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              config: config,
              autobill: autobill,
              label: label,
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
        _$failedField = 'gateway';
        gateway.build();

        _$failedField = 'feesAndLimitsMap';
        feesAndLimitsMap.build();
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
      this.adjustFeePercent})
      : super._() {
    if (minLimit == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'minLimit');
    }
    if (maxLimit == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'maxLimit');
    }
    if (feeAmount == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'feeAmount');
    }
    if (feePercent == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'feePercent');
    }
    if (feeCap == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'feeCap');
    }
    if (taxRate1 == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'taxRate1');
    }
    if (taxName1 == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'taxName1');
    }
    if (taxRate2 == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'taxRate2');
    }
    if (taxName2 == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'taxName2');
    }
    if (taxRate3 == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'taxRate3');
    }
    if (taxName3 == null) {
      throw new BuiltValueNullFieldError('FeesAndLimitsSettings', 'taxName3');
    }
    if (adjustFeePercent == null) {
      throw new BuiltValueNullFieldError(
          'FeesAndLimitsSettings', 'adjustFeePercent');
    }
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
        adjustFeePercent == other.adjustFeePercent;
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
        adjustFeePercent.hashCode));
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
          ..add('adjustFeePercent', adjustFeePercent))
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

  FeesAndLimitsSettingsBuilder();

  FeesAndLimitsSettingsBuilder get _$this {
    if (_$v != null) {
      _minLimit = _$v.minLimit;
      _maxLimit = _$v.maxLimit;
      _feeAmount = _$v.feeAmount;
      _feePercent = _$v.feePercent;
      _feeCap = _$v.feeCap;
      _taxRate1 = _$v.taxRate1;
      _taxName1 = _$v.taxName1;
      _taxRate2 = _$v.taxRate2;
      _taxName2 = _$v.taxName2;
      _taxRate3 = _$v.taxRate3;
      _taxName3 = _$v.taxName3;
      _adjustFeePercent = _$v.adjustFeePercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeesAndLimitsSettings other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
            minLimit: minLimit,
            maxLimit: maxLimit,
            feeAmount: feeAmount,
            feePercent: feePercent,
            feeCap: feeCap,
            taxRate1: taxRate1,
            taxName1: taxName1,
            taxRate2: taxRate2,
            taxName2: taxName2,
            taxRate3: taxRate3,
            taxName3: taxName3,
            adjustFeePercent: adjustFeePercent);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
