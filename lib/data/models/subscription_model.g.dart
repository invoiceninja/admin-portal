// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubscriptionListResponse> _$subscriptionListResponseSerializer =
    new _$SubscriptionListResponseSerializer();
Serializer<SubscriptionItemResponse> _$subscriptionItemResponseSerializer =
    new _$SubscriptionItemResponseSerializer();
Serializer<SubscriptionEntity> _$subscriptionEntitySerializer =
    new _$SubscriptionEntitySerializer();

class _$SubscriptionListResponseSerializer
    implements StructuredSerializer<SubscriptionListResponse> {
  @override
  final Iterable<Type> types = const [
    SubscriptionListResponse,
    _$SubscriptionListResponse
  ];
  @override
  final String wireName = 'SubscriptionListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, SubscriptionListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SubscriptionEntity)])),
    ];

    return result;
  }

  @override
  SubscriptionListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SubscriptionEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SubscriptionItemResponseSerializer
    implements StructuredSerializer<SubscriptionItemResponse> {
  @override
  final Iterable<Type> types = const [
    SubscriptionItemResponse,
    _$SubscriptionItemResponse
  ];
  @override
  final String wireName = 'SubscriptionItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, SubscriptionItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(SubscriptionEntity)),
    ];

    return result;
  }

  @override
  SubscriptionItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubscriptionEntity))
              as SubscriptionEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$SubscriptionEntitySerializer
    implements StructuredSerializer<SubscriptionEntity> {
  @override
  final Iterable<Type> types = const [SubscriptionEntity, _$SubscriptionEntity];
  @override
  final String wireName = 'SubscriptionEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, SubscriptionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'group_id',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
      'product_ids',
      serializers.serialize(object.productIds,
          specifiedType: const FullType(String)),
      'recurring_product_ids',
      serializers.serialize(object.recurringProductIds,
          specifiedType: const FullType(String)),
      'frequency_id',
      serializers.serialize(object.frequencyId,
          specifiedType: const FullType(String)),
      'auto_bill',
      serializers.serialize(object.autoBill,
          specifiedType: const FullType(String)),
      'promo_code',
      serializers.serialize(object.promoCode,
          specifiedType: const FullType(String)),
      'promo_discount',
      serializers.serialize(object.promoDiscount,
          specifiedType: const FullType(double)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'is_amount_discount',
      serializers.serialize(object.isAmountDiscount,
          specifiedType: const FullType(bool)),
      'allow_cancellation',
      serializers.serialize(object.allowCancellation,
          specifiedType: const FullType(bool)),
      'per_seat_enabled',
      serializers.serialize(object.perSeatEnabled,
          specifiedType: const FullType(bool)),
      'max_seats_limit',
      serializers.serialize(object.maxSeatsLimit,
          specifiedType: const FullType(int)),
      'trial_enabled',
      serializers.serialize(object.trialEnabled,
          specifiedType: const FullType(bool)),
      'trial_duration',
      serializers.serialize(object.trialDuration,
          specifiedType: const FullType(int)),
      'allow_query_overrides',
      serializers.serialize(object.allowQueryOverrides,
          specifiedType: const FullType(bool)),
      'allow_plan_changes',
      serializers.serialize(object.allowPlanChanges,
          specifiedType: const FullType(bool)),
      'plan_map',
      serializers.serialize(object.planMap,
          specifiedType: const FullType(String)),
      'refund_period',
      serializers.serialize(object.refundPeriod,
          specifiedType: const FullType(int)),
      'webhook_configuration',
      serializers.serialize(object.webhookConfiguration,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'purchase_page',
      serializers.serialize(object.purchasePage,
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
  SubscriptionEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'group_id':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'product_ids':
          result.productIds = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'recurring_product_ids':
          result.recurringProductIds = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'frequency_id':
          result.frequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'auto_bill':
          result.autoBill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'promo_code':
          result.promoCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'promo_discount':
          result.promoDiscount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'is_amount_discount':
          result.isAmountDiscount = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'allow_cancellation':
          result.allowCancellation = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'per_seat_enabled':
          result.perSeatEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'max_seats_limit':
          result.maxSeatsLimit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'trial_enabled':
          result.trialEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'trial_duration':
          result.trialDuration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'allow_query_overrides':
          result.allowQueryOverrides = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'allow_plan_changes':
          result.allowPlanChanges = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'plan_map':
          result.planMap = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'refund_period':
          result.refundPeriod = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'webhook_configuration':
          result.webhookConfiguration.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'purchase_page':
          result.purchasePage = serializers.deserialize(value,
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

class _$SubscriptionListResponse extends SubscriptionListResponse {
  @override
  final BuiltList<SubscriptionEntity> data;

  factory _$SubscriptionListResponse(
          [void Function(SubscriptionListResponseBuilder) updates]) =>
      (new SubscriptionListResponseBuilder()..update(updates)).build();

  _$SubscriptionListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SubscriptionListResponse', 'data');
    }
  }

  @override
  SubscriptionListResponse rebuild(
          void Function(SubscriptionListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionListResponseBuilder toBuilder() =>
      new SubscriptionListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubscriptionListResponse')
          ..add('data', data))
        .toString();
  }
}

class SubscriptionListResponseBuilder
    implements
        Builder<SubscriptionListResponse, SubscriptionListResponseBuilder> {
  _$SubscriptionListResponse _$v;

  ListBuilder<SubscriptionEntity> _data;
  ListBuilder<SubscriptionEntity> get data =>
      _$this._data ??= new ListBuilder<SubscriptionEntity>();
  set data(ListBuilder<SubscriptionEntity> data) => _$this._data = data;

  SubscriptionListResponseBuilder();

  SubscriptionListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubscriptionListResponse;
  }

  @override
  void update(void Function(SubscriptionListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubscriptionListResponse build() {
    _$SubscriptionListResponse _$result;
    try {
      _$result = _$v ?? new _$SubscriptionListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubscriptionListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubscriptionItemResponse extends SubscriptionItemResponse {
  @override
  final SubscriptionEntity data;

  factory _$SubscriptionItemResponse(
          [void Function(SubscriptionItemResponseBuilder) updates]) =>
      (new SubscriptionItemResponseBuilder()..update(updates)).build();

  _$SubscriptionItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SubscriptionItemResponse', 'data');
    }
  }

  @override
  SubscriptionItemResponse rebuild(
          void Function(SubscriptionItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionItemResponseBuilder toBuilder() =>
      new SubscriptionItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubscriptionItemResponse')
          ..add('data', data))
        .toString();
  }
}

class SubscriptionItemResponseBuilder
    implements
        Builder<SubscriptionItemResponse, SubscriptionItemResponseBuilder> {
  _$SubscriptionItemResponse _$v;

  SubscriptionEntityBuilder _data;
  SubscriptionEntityBuilder get data =>
      _$this._data ??= new SubscriptionEntityBuilder();
  set data(SubscriptionEntityBuilder data) => _$this._data = data;

  SubscriptionItemResponseBuilder();

  SubscriptionItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubscriptionItemResponse;
  }

  @override
  void update(void Function(SubscriptionItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubscriptionItemResponse build() {
    _$SubscriptionItemResponse _$result;
    try {
      _$result = _$v ?? new _$SubscriptionItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubscriptionItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubscriptionEntity extends SubscriptionEntity {
  @override
  final String groupId;
  @override
  final String productIds;
  @override
  final String recurringProductIds;
  @override
  final String frequencyId;
  @override
  final String autoBill;
  @override
  final String promoCode;
  @override
  final double promoDiscount;
  @override
  final double price;
  @override
  final bool isAmountDiscount;
  @override
  final bool allowCancellation;
  @override
  final bool perSeatEnabled;
  @override
  final int maxSeatsLimit;
  @override
  final bool trialEnabled;
  @override
  final int trialDuration;
  @override
  final bool allowQueryOverrides;
  @override
  final bool allowPlanChanges;
  @override
  final String planMap;
  @override
  final int refundPeriod;
  @override
  final BuiltMap<String, String> webhookConfiguration;
  @override
  final String purchasePage;
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

  factory _$SubscriptionEntity(
          [void Function(SubscriptionEntityBuilder) updates]) =>
      (new SubscriptionEntityBuilder()..update(updates)).build();

  _$SubscriptionEntity._(
      {this.groupId,
      this.productIds,
      this.recurringProductIds,
      this.frequencyId,
      this.autoBill,
      this.promoCode,
      this.promoDiscount,
      this.price,
      this.isAmountDiscount,
      this.allowCancellation,
      this.perSeatEnabled,
      this.maxSeatsLimit,
      this.trialEnabled,
      this.trialDuration,
      this.allowQueryOverrides,
      this.allowPlanChanges,
      this.planMap,
      this.refundPeriod,
      this.webhookConfiguration,
      this.purchasePage,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (groupId == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'groupId');
    }
    if (productIds == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'productIds');
    }
    if (recurringProductIds == null) {
      throw new BuiltValueNullFieldError(
          'SubscriptionEntity', 'recurringProductIds');
    }
    if (frequencyId == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'frequencyId');
    }
    if (autoBill == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'autoBill');
    }
    if (promoCode == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'promoCode');
    }
    if (promoDiscount == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'promoDiscount');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'price');
    }
    if (isAmountDiscount == null) {
      throw new BuiltValueNullFieldError(
          'SubscriptionEntity', 'isAmountDiscount');
    }
    if (allowCancellation == null) {
      throw new BuiltValueNullFieldError(
          'SubscriptionEntity', 'allowCancellation');
    }
    if (perSeatEnabled == null) {
      throw new BuiltValueNullFieldError(
          'SubscriptionEntity', 'perSeatEnabled');
    }
    if (maxSeatsLimit == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'maxSeatsLimit');
    }
    if (trialEnabled == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'trialEnabled');
    }
    if (trialDuration == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'trialDuration');
    }
    if (allowQueryOverrides == null) {
      throw new BuiltValueNullFieldError(
          'SubscriptionEntity', 'allowQueryOverrides');
    }
    if (allowPlanChanges == null) {
      throw new BuiltValueNullFieldError(
          'SubscriptionEntity', 'allowPlanChanges');
    }
    if (planMap == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'planMap');
    }
    if (refundPeriod == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'refundPeriod');
    }
    if (webhookConfiguration == null) {
      throw new BuiltValueNullFieldError(
          'SubscriptionEntity', 'webhookConfiguration');
    }
    if (purchasePage == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'purchasePage');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'id');
    }
  }

  @override
  SubscriptionEntity rebuild(
          void Function(SubscriptionEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionEntityBuilder toBuilder() =>
      new SubscriptionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionEntity &&
        groupId == other.groupId &&
        productIds == other.productIds &&
        recurringProductIds == other.recurringProductIds &&
        frequencyId == other.frequencyId &&
        autoBill == other.autoBill &&
        promoCode == other.promoCode &&
        promoDiscount == other.promoDiscount &&
        price == other.price &&
        isAmountDiscount == other.isAmountDiscount &&
        allowCancellation == other.allowCancellation &&
        perSeatEnabled == other.perSeatEnabled &&
        maxSeatsLimit == other.maxSeatsLimit &&
        trialEnabled == other.trialEnabled &&
        trialDuration == other.trialDuration &&
        allowQueryOverrides == other.allowQueryOverrides &&
        allowPlanChanges == other.allowPlanChanges &&
        planMap == other.planMap &&
        refundPeriod == other.refundPeriod &&
        webhookConfiguration == other.webhookConfiguration &&
        purchasePage == other.purchasePage &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, groupId.hashCode), productIds.hashCode), recurringProductIds.hashCode), frequencyId.hashCode), autoBill.hashCode), promoCode.hashCode), promoDiscount.hashCode), price.hashCode), isAmountDiscount.hashCode),
                                                                                allowCancellation.hashCode),
                                                                            perSeatEnabled.hashCode),
                                                                        maxSeatsLimit.hashCode),
                                                                    trialEnabled.hashCode),
                                                                trialDuration.hashCode),
                                                            allowQueryOverrides.hashCode),
                                                        allowPlanChanges.hashCode),
                                                    planMap.hashCode),
                                                refundPeriod.hashCode),
                                            webhookConfiguration.hashCode),
                                        purchasePage.hashCode),
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
    return (newBuiltValueToStringHelper('SubscriptionEntity')
          ..add('groupId', groupId)
          ..add('productIds', productIds)
          ..add('recurringProductIds', recurringProductIds)
          ..add('frequencyId', frequencyId)
          ..add('autoBill', autoBill)
          ..add('promoCode', promoCode)
          ..add('promoDiscount', promoDiscount)
          ..add('price', price)
          ..add('isAmountDiscount', isAmountDiscount)
          ..add('allowCancellation', allowCancellation)
          ..add('perSeatEnabled', perSeatEnabled)
          ..add('maxSeatsLimit', maxSeatsLimit)
          ..add('trialEnabled', trialEnabled)
          ..add('trialDuration', trialDuration)
          ..add('allowQueryOverrides', allowQueryOverrides)
          ..add('allowPlanChanges', allowPlanChanges)
          ..add('planMap', planMap)
          ..add('refundPeriod', refundPeriod)
          ..add('webhookConfiguration', webhookConfiguration)
          ..add('purchasePage', purchasePage)
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

class SubscriptionEntityBuilder
    implements Builder<SubscriptionEntity, SubscriptionEntityBuilder> {
  _$SubscriptionEntity _$v;

  String _groupId;
  String get groupId => _$this._groupId;
  set groupId(String groupId) => _$this._groupId = groupId;

  String _productIds;
  String get productIds => _$this._productIds;
  set productIds(String productIds) => _$this._productIds = productIds;

  String _recurringProductIds;
  String get recurringProductIds => _$this._recurringProductIds;
  set recurringProductIds(String recurringProductIds) =>
      _$this._recurringProductIds = recurringProductIds;

  String _frequencyId;
  String get frequencyId => _$this._frequencyId;
  set frequencyId(String frequencyId) => _$this._frequencyId = frequencyId;

  String _autoBill;
  String get autoBill => _$this._autoBill;
  set autoBill(String autoBill) => _$this._autoBill = autoBill;

  String _promoCode;
  String get promoCode => _$this._promoCode;
  set promoCode(String promoCode) => _$this._promoCode = promoCode;

  double _promoDiscount;
  double get promoDiscount => _$this._promoDiscount;
  set promoDiscount(double promoDiscount) =>
      _$this._promoDiscount = promoDiscount;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  bool _isAmountDiscount;
  bool get isAmountDiscount => _$this._isAmountDiscount;
  set isAmountDiscount(bool isAmountDiscount) =>
      _$this._isAmountDiscount = isAmountDiscount;

  bool _allowCancellation;
  bool get allowCancellation => _$this._allowCancellation;
  set allowCancellation(bool allowCancellation) =>
      _$this._allowCancellation = allowCancellation;

  bool _perSeatEnabled;
  bool get perSeatEnabled => _$this._perSeatEnabled;
  set perSeatEnabled(bool perSeatEnabled) =>
      _$this._perSeatEnabled = perSeatEnabled;

  int _maxSeatsLimit;
  int get maxSeatsLimit => _$this._maxSeatsLimit;
  set maxSeatsLimit(int maxSeatsLimit) => _$this._maxSeatsLimit = maxSeatsLimit;

  bool _trialEnabled;
  bool get trialEnabled => _$this._trialEnabled;
  set trialEnabled(bool trialEnabled) => _$this._trialEnabled = trialEnabled;

  int _trialDuration;
  int get trialDuration => _$this._trialDuration;
  set trialDuration(int trialDuration) => _$this._trialDuration = trialDuration;

  bool _allowQueryOverrides;
  bool get allowQueryOverrides => _$this._allowQueryOverrides;
  set allowQueryOverrides(bool allowQueryOverrides) =>
      _$this._allowQueryOverrides = allowQueryOverrides;

  bool _allowPlanChanges;
  bool get allowPlanChanges => _$this._allowPlanChanges;
  set allowPlanChanges(bool allowPlanChanges) =>
      _$this._allowPlanChanges = allowPlanChanges;

  String _planMap;
  String get planMap => _$this._planMap;
  set planMap(String planMap) => _$this._planMap = planMap;

  int _refundPeriod;
  int get refundPeriod => _$this._refundPeriod;
  set refundPeriod(int refundPeriod) => _$this._refundPeriod = refundPeriod;

  MapBuilder<String, String> _webhookConfiguration;
  MapBuilder<String, String> get webhookConfiguration =>
      _$this._webhookConfiguration ??= new MapBuilder<String, String>();
  set webhookConfiguration(MapBuilder<String, String> webhookConfiguration) =>
      _$this._webhookConfiguration = webhookConfiguration;

  String _purchasePage;
  String get purchasePage => _$this._purchasePage;
  set purchasePage(String purchasePage) => _$this._purchasePage = purchasePage;

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

  SubscriptionEntityBuilder();

  SubscriptionEntityBuilder get _$this {
    if (_$v != null) {
      _groupId = _$v.groupId;
      _productIds = _$v.productIds;
      _recurringProductIds = _$v.recurringProductIds;
      _frequencyId = _$v.frequencyId;
      _autoBill = _$v.autoBill;
      _promoCode = _$v.promoCode;
      _promoDiscount = _$v.promoDiscount;
      _price = _$v.price;
      _isAmountDiscount = _$v.isAmountDiscount;
      _allowCancellation = _$v.allowCancellation;
      _perSeatEnabled = _$v.perSeatEnabled;
      _maxSeatsLimit = _$v.maxSeatsLimit;
      _trialEnabled = _$v.trialEnabled;
      _trialDuration = _$v.trialDuration;
      _allowQueryOverrides = _$v.allowQueryOverrides;
      _allowPlanChanges = _$v.allowPlanChanges;
      _planMap = _$v.planMap;
      _refundPeriod = _$v.refundPeriod;
      _webhookConfiguration = _$v.webhookConfiguration?.toBuilder();
      _purchasePage = _$v.purchasePage;
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
  void replace(SubscriptionEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubscriptionEntity;
  }

  @override
  void update(void Function(SubscriptionEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubscriptionEntity build() {
    _$SubscriptionEntity _$result;
    try {
      _$result = _$v ??
          new _$SubscriptionEntity._(
              groupId: groupId,
              productIds: productIds,
              recurringProductIds: recurringProductIds,
              frequencyId: frequencyId,
              autoBill: autoBill,
              promoCode: promoCode,
              promoDiscount: promoDiscount,
              price: price,
              isAmountDiscount: isAmountDiscount,
              allowCancellation: allowCancellation,
              perSeatEnabled: perSeatEnabled,
              maxSeatsLimit: maxSeatsLimit,
              trialEnabled: trialEnabled,
              trialDuration: trialDuration,
              allowQueryOverrides: allowQueryOverrides,
              allowPlanChanges: allowPlanChanges,
              planMap: planMap,
              refundPeriod: refundPeriod,
              webhookConfiguration: webhookConfiguration.build(),
              purchasePage: purchasePage,
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
        _$failedField = 'webhookConfiguration';
        webhookConfiguration.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubscriptionEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
