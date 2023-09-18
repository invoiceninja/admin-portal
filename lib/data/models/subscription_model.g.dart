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
Serializer<WebhookConfigurationEntity> _$webhookConfigurationEntitySerializer =
    new _$WebhookConfigurationEntitySerializer();

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
  Iterable<Object?> serialize(
      Serializers serializers, SubscriptionListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SubscriptionEntity)])),
    ];

    return result;
  }

  @override
  SubscriptionListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SubscriptionEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(
      Serializers serializers, SubscriptionItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(SubscriptionEntity)),
    ];

    return result;
  }

  @override
  SubscriptionItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubscriptionEntity))!
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
  Iterable<Object?> serialize(
      Serializers serializers, SubscriptionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'group_id',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
      'product_ids',
      serializers.serialize(object.productIds,
          specifiedType: const FullType(String)),
      'recurring_product_ids',
      serializers.serialize(object.recurringProductIds,
          specifiedType: const FullType(String)),
      'optional_product_ids',
      serializers.serialize(object.optionalProductIds,
          specifiedType: const FullType(String)),
      'optional_recurring_product_ids',
      serializers.serialize(object.optionalRecurringProductIds,
          specifiedType: const FullType(String)),
      'registration_required',
      serializers.serialize(object.registrationRequired,
          specifiedType: const FullType(bool)),
      'use_inventory_management',
      serializers.serialize(object.useInventoryManagement,
          specifiedType: const FullType(bool)),
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
      'refund_period',
      serializers.serialize(object.refundPeriod,
          specifiedType: const FullType(int)),
      'webhook_configuration',
      serializers.serialize(object.webhookConfiguration,
          specifiedType: const FullType(WebhookConfigurationEntity)),
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
    Object? value;
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
  SubscriptionEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionEntityBuilder();

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
        case 'group_id':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'product_ids':
          result.productIds = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'recurring_product_ids':
          result.recurringProductIds = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'optional_product_ids':
          result.optionalProductIds = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'optional_recurring_product_ids':
          result.optionalRecurringProductIds = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'registration_required':
          result.registrationRequired = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'use_inventory_management':
          result.useInventoryManagement = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'frequency_id':
          result.frequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'auto_bill':
          result.autoBill = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'promo_code':
          result.promoCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'promo_discount':
          result.promoDiscount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'is_amount_discount':
          result.isAmountDiscount = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'allow_cancellation':
          result.allowCancellation = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'per_seat_enabled':
          result.perSeatEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'max_seats_limit':
          result.maxSeatsLimit = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'trial_enabled':
          result.trialEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'trial_duration':
          result.trialDuration = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'allow_query_overrides':
          result.allowQueryOverrides = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'allow_plan_changes':
          result.allowPlanChanges = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'refund_period':
          result.refundPeriod = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'webhook_configuration':
          result.webhookConfiguration.replace(serializers.deserialize(value,
                  specifiedType: const FullType(WebhookConfigurationEntity))!
              as WebhookConfigurationEntity);
          break;
        case 'purchase_page':
          result.purchasePage = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$WebhookConfigurationEntitySerializer
    implements StructuredSerializer<WebhookConfigurationEntity> {
  @override
  final Iterable<Type> types = const [
    WebhookConfigurationEntity,
    _$WebhookConfigurationEntity
  ];
  @override
  final String wireName = 'WebhookConfigurationEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WebhookConfigurationEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'return_url',
      serializers.serialize(object.returnUrl,
          specifiedType: const FullType(String)),
      'post_purchase_url',
      serializers.serialize(object.postPurchaseUrl,
          specifiedType: const FullType(String)),
      'post_purchase_rest_method',
      serializers.serialize(object.postPurchaseRestMethod,
          specifiedType: const FullType(String)),
      'post_purchase_headers',
      serializers.serialize(object.postPurchaseHeaders,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'post_purchase_body',
      serializers.serialize(object.postPurchaseBody,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WebhookConfigurationEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookConfigurationEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'return_url':
          result.returnUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'post_purchase_url':
          result.postPurchaseUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'post_purchase_rest_method':
          result.postPurchaseRestMethod = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'post_purchase_headers':
          result.postPurchaseHeaders.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'post_purchase_body':
          result.postPurchaseBody = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
          [void Function(SubscriptionListResponseBuilder)? updates]) =>
      (new SubscriptionListResponseBuilder()..update(updates))._build();

  _$SubscriptionListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'SubscriptionListResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'SubscriptionListResponse')
          ..add('data', data))
        .toString();
  }
}

class SubscriptionListResponseBuilder
    implements
        Builder<SubscriptionListResponse, SubscriptionListResponseBuilder> {
  _$SubscriptionListResponse? _$v;

  ListBuilder<SubscriptionEntity>? _data;
  ListBuilder<SubscriptionEntity> get data =>
      _$this._data ??= new ListBuilder<SubscriptionEntity>();
  set data(ListBuilder<SubscriptionEntity>? data) => _$this._data = data;

  SubscriptionListResponseBuilder();

  SubscriptionListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubscriptionListResponse;
  }

  @override
  void update(void Function(SubscriptionListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscriptionListResponse build() => _build();

  _$SubscriptionListResponse _build() {
    _$SubscriptionListResponse _$result;
    try {
      _$result = _$v ?? new _$SubscriptionListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SubscriptionListResponse', _$failedField, e.toString());
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
          [void Function(SubscriptionItemResponseBuilder)? updates]) =>
      (new SubscriptionItemResponseBuilder()..update(updates))._build();

  _$SubscriptionItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'SubscriptionItemResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'SubscriptionItemResponse')
          ..add('data', data))
        .toString();
  }
}

class SubscriptionItemResponseBuilder
    implements
        Builder<SubscriptionItemResponse, SubscriptionItemResponseBuilder> {
  _$SubscriptionItemResponse? _$v;

  SubscriptionEntityBuilder? _data;
  SubscriptionEntityBuilder get data =>
      _$this._data ??= new SubscriptionEntityBuilder();
  set data(SubscriptionEntityBuilder? data) => _$this._data = data;

  SubscriptionItemResponseBuilder();

  SubscriptionItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubscriptionItemResponse;
  }

  @override
  void update(void Function(SubscriptionItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscriptionItemResponse build() => _build();

  _$SubscriptionItemResponse _build() {
    _$SubscriptionItemResponse _$result;
    try {
      _$result = _$v ?? new _$SubscriptionItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SubscriptionItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubscriptionEntity extends SubscriptionEntity {
  @override
  final String name;
  @override
  final String groupId;
  @override
  final String productIds;
  @override
  final String recurringProductIds;
  @override
  final String optionalProductIds;
  @override
  final String optionalRecurringProductIds;
  @override
  final bool registrationRequired;
  @override
  final bool useInventoryManagement;
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
  final int refundPeriod;
  @override
  final WebhookConfigurationEntity webhookConfiguration;
  @override
  final String purchasePage;
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

  factory _$SubscriptionEntity(
          [void Function(SubscriptionEntityBuilder)? updates]) =>
      (new SubscriptionEntityBuilder()..update(updates))._build();

  _$SubscriptionEntity._(
      {required this.name,
      required this.groupId,
      required this.productIds,
      required this.recurringProductIds,
      required this.optionalProductIds,
      required this.optionalRecurringProductIds,
      required this.registrationRequired,
      required this.useInventoryManagement,
      required this.frequencyId,
      required this.autoBill,
      required this.promoCode,
      required this.promoDiscount,
      required this.price,
      required this.isAmountDiscount,
      required this.allowCancellation,
      required this.perSeatEnabled,
      required this.maxSeatsLimit,
      required this.trialEnabled,
      required this.trialDuration,
      required this.allowQueryOverrides,
      required this.allowPlanChanges,
      required this.refundPeriod,
      required this.webhookConfiguration,
      required this.purchasePage,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'SubscriptionEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        groupId, r'SubscriptionEntity', 'groupId');
    BuiltValueNullFieldError.checkNotNull(
        productIds, r'SubscriptionEntity', 'productIds');
    BuiltValueNullFieldError.checkNotNull(
        recurringProductIds, r'SubscriptionEntity', 'recurringProductIds');
    BuiltValueNullFieldError.checkNotNull(
        optionalProductIds, r'SubscriptionEntity', 'optionalProductIds');
    BuiltValueNullFieldError.checkNotNull(optionalRecurringProductIds,
        r'SubscriptionEntity', 'optionalRecurringProductIds');
    BuiltValueNullFieldError.checkNotNull(
        registrationRequired, r'SubscriptionEntity', 'registrationRequired');
    BuiltValueNullFieldError.checkNotNull(useInventoryManagement,
        r'SubscriptionEntity', 'useInventoryManagement');
    BuiltValueNullFieldError.checkNotNull(
        frequencyId, r'SubscriptionEntity', 'frequencyId');
    BuiltValueNullFieldError.checkNotNull(
        autoBill, r'SubscriptionEntity', 'autoBill');
    BuiltValueNullFieldError.checkNotNull(
        promoCode, r'SubscriptionEntity', 'promoCode');
    BuiltValueNullFieldError.checkNotNull(
        promoDiscount, r'SubscriptionEntity', 'promoDiscount');
    BuiltValueNullFieldError.checkNotNull(
        price, r'SubscriptionEntity', 'price');
    BuiltValueNullFieldError.checkNotNull(
        isAmountDiscount, r'SubscriptionEntity', 'isAmountDiscount');
    BuiltValueNullFieldError.checkNotNull(
        allowCancellation, r'SubscriptionEntity', 'allowCancellation');
    BuiltValueNullFieldError.checkNotNull(
        perSeatEnabled, r'SubscriptionEntity', 'perSeatEnabled');
    BuiltValueNullFieldError.checkNotNull(
        maxSeatsLimit, r'SubscriptionEntity', 'maxSeatsLimit');
    BuiltValueNullFieldError.checkNotNull(
        trialEnabled, r'SubscriptionEntity', 'trialEnabled');
    BuiltValueNullFieldError.checkNotNull(
        trialDuration, r'SubscriptionEntity', 'trialDuration');
    BuiltValueNullFieldError.checkNotNull(
        allowQueryOverrides, r'SubscriptionEntity', 'allowQueryOverrides');
    BuiltValueNullFieldError.checkNotNull(
        allowPlanChanges, r'SubscriptionEntity', 'allowPlanChanges');
    BuiltValueNullFieldError.checkNotNull(
        refundPeriod, r'SubscriptionEntity', 'refundPeriod');
    BuiltValueNullFieldError.checkNotNull(
        webhookConfiguration, r'SubscriptionEntity', 'webhookConfiguration');
    BuiltValueNullFieldError.checkNotNull(
        purchasePage, r'SubscriptionEntity', 'purchasePage');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'SubscriptionEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'SubscriptionEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'SubscriptionEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'SubscriptionEntity', 'id');
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
        name == other.name &&
        groupId == other.groupId &&
        productIds == other.productIds &&
        recurringProductIds == other.recurringProductIds &&
        optionalProductIds == other.optionalProductIds &&
        optionalRecurringProductIds == other.optionalRecurringProductIds &&
        registrationRequired == other.registrationRequired &&
        useInventoryManagement == other.useInventoryManagement &&
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, productIds.hashCode);
    _$hash = $jc(_$hash, recurringProductIds.hashCode);
    _$hash = $jc(_$hash, optionalProductIds.hashCode);
    _$hash = $jc(_$hash, optionalRecurringProductIds.hashCode);
    _$hash = $jc(_$hash, registrationRequired.hashCode);
    _$hash = $jc(_$hash, useInventoryManagement.hashCode);
    _$hash = $jc(_$hash, frequencyId.hashCode);
    _$hash = $jc(_$hash, autoBill.hashCode);
    _$hash = $jc(_$hash, promoCode.hashCode);
    _$hash = $jc(_$hash, promoDiscount.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, isAmountDiscount.hashCode);
    _$hash = $jc(_$hash, allowCancellation.hashCode);
    _$hash = $jc(_$hash, perSeatEnabled.hashCode);
    _$hash = $jc(_$hash, maxSeatsLimit.hashCode);
    _$hash = $jc(_$hash, trialEnabled.hashCode);
    _$hash = $jc(_$hash, trialDuration.hashCode);
    _$hash = $jc(_$hash, allowQueryOverrides.hashCode);
    _$hash = $jc(_$hash, allowPlanChanges.hashCode);
    _$hash = $jc(_$hash, refundPeriod.hashCode);
    _$hash = $jc(_$hash, webhookConfiguration.hashCode);
    _$hash = $jc(_$hash, purchasePage.hashCode);
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
    return (newBuiltValueToStringHelper(r'SubscriptionEntity')
          ..add('name', name)
          ..add('groupId', groupId)
          ..add('productIds', productIds)
          ..add('recurringProductIds', recurringProductIds)
          ..add('optionalProductIds', optionalProductIds)
          ..add('optionalRecurringProductIds', optionalRecurringProductIds)
          ..add('registrationRequired', registrationRequired)
          ..add('useInventoryManagement', useInventoryManagement)
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
  _$SubscriptionEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  String? _productIds;
  String? get productIds => _$this._productIds;
  set productIds(String? productIds) => _$this._productIds = productIds;

  String? _recurringProductIds;
  String? get recurringProductIds => _$this._recurringProductIds;
  set recurringProductIds(String? recurringProductIds) =>
      _$this._recurringProductIds = recurringProductIds;

  String? _optionalProductIds;
  String? get optionalProductIds => _$this._optionalProductIds;
  set optionalProductIds(String? optionalProductIds) =>
      _$this._optionalProductIds = optionalProductIds;

  String? _optionalRecurringProductIds;
  String? get optionalRecurringProductIds =>
      _$this._optionalRecurringProductIds;
  set optionalRecurringProductIds(String? optionalRecurringProductIds) =>
      _$this._optionalRecurringProductIds = optionalRecurringProductIds;

  bool? _registrationRequired;
  bool? get registrationRequired => _$this._registrationRequired;
  set registrationRequired(bool? registrationRequired) =>
      _$this._registrationRequired = registrationRequired;

  bool? _useInventoryManagement;
  bool? get useInventoryManagement => _$this._useInventoryManagement;
  set useInventoryManagement(bool? useInventoryManagement) =>
      _$this._useInventoryManagement = useInventoryManagement;

  String? _frequencyId;
  String? get frequencyId => _$this._frequencyId;
  set frequencyId(String? frequencyId) => _$this._frequencyId = frequencyId;

  String? _autoBill;
  String? get autoBill => _$this._autoBill;
  set autoBill(String? autoBill) => _$this._autoBill = autoBill;

  String? _promoCode;
  String? get promoCode => _$this._promoCode;
  set promoCode(String? promoCode) => _$this._promoCode = promoCode;

  double? _promoDiscount;
  double? get promoDiscount => _$this._promoDiscount;
  set promoDiscount(double? promoDiscount) =>
      _$this._promoDiscount = promoDiscount;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  bool? _isAmountDiscount;
  bool? get isAmountDiscount => _$this._isAmountDiscount;
  set isAmountDiscount(bool? isAmountDiscount) =>
      _$this._isAmountDiscount = isAmountDiscount;

  bool? _allowCancellation;
  bool? get allowCancellation => _$this._allowCancellation;
  set allowCancellation(bool? allowCancellation) =>
      _$this._allowCancellation = allowCancellation;

  bool? _perSeatEnabled;
  bool? get perSeatEnabled => _$this._perSeatEnabled;
  set perSeatEnabled(bool? perSeatEnabled) =>
      _$this._perSeatEnabled = perSeatEnabled;

  int? _maxSeatsLimit;
  int? get maxSeatsLimit => _$this._maxSeatsLimit;
  set maxSeatsLimit(int? maxSeatsLimit) =>
      _$this._maxSeatsLimit = maxSeatsLimit;

  bool? _trialEnabled;
  bool? get trialEnabled => _$this._trialEnabled;
  set trialEnabled(bool? trialEnabled) => _$this._trialEnabled = trialEnabled;

  int? _trialDuration;
  int? get trialDuration => _$this._trialDuration;
  set trialDuration(int? trialDuration) =>
      _$this._trialDuration = trialDuration;

  bool? _allowQueryOverrides;
  bool? get allowQueryOverrides => _$this._allowQueryOverrides;
  set allowQueryOverrides(bool? allowQueryOverrides) =>
      _$this._allowQueryOverrides = allowQueryOverrides;

  bool? _allowPlanChanges;
  bool? get allowPlanChanges => _$this._allowPlanChanges;
  set allowPlanChanges(bool? allowPlanChanges) =>
      _$this._allowPlanChanges = allowPlanChanges;

  int? _refundPeriod;
  int? get refundPeriod => _$this._refundPeriod;
  set refundPeriod(int? refundPeriod) => _$this._refundPeriod = refundPeriod;

  WebhookConfigurationEntityBuilder? _webhookConfiguration;
  WebhookConfigurationEntityBuilder get webhookConfiguration =>
      _$this._webhookConfiguration ??= new WebhookConfigurationEntityBuilder();
  set webhookConfiguration(
          WebhookConfigurationEntityBuilder? webhookConfiguration) =>
      _$this._webhookConfiguration = webhookConfiguration;

  String? _purchasePage;
  String? get purchasePage => _$this._purchasePage;
  set purchasePage(String? purchasePage) => _$this._purchasePage = purchasePage;

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

  SubscriptionEntityBuilder() {
    SubscriptionEntity._initializeBuilder(this);
  }

  SubscriptionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _groupId = $v.groupId;
      _productIds = $v.productIds;
      _recurringProductIds = $v.recurringProductIds;
      _optionalProductIds = $v.optionalProductIds;
      _optionalRecurringProductIds = $v.optionalRecurringProductIds;
      _registrationRequired = $v.registrationRequired;
      _useInventoryManagement = $v.useInventoryManagement;
      _frequencyId = $v.frequencyId;
      _autoBill = $v.autoBill;
      _promoCode = $v.promoCode;
      _promoDiscount = $v.promoDiscount;
      _price = $v.price;
      _isAmountDiscount = $v.isAmountDiscount;
      _allowCancellation = $v.allowCancellation;
      _perSeatEnabled = $v.perSeatEnabled;
      _maxSeatsLimit = $v.maxSeatsLimit;
      _trialEnabled = $v.trialEnabled;
      _trialDuration = $v.trialDuration;
      _allowQueryOverrides = $v.allowQueryOverrides;
      _allowPlanChanges = $v.allowPlanChanges;
      _refundPeriod = $v.refundPeriod;
      _webhookConfiguration = $v.webhookConfiguration.toBuilder();
      _purchasePage = $v.purchasePage;
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
  void replace(SubscriptionEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubscriptionEntity;
  }

  @override
  void update(void Function(SubscriptionEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscriptionEntity build() => _build();

  _$SubscriptionEntity _build() {
    _$SubscriptionEntity _$result;
    try {
      _$result = _$v ??
          new _$SubscriptionEntity._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'SubscriptionEntity', 'name'),
              groupId: BuiltValueNullFieldError.checkNotNull(
                  groupId, r'SubscriptionEntity', 'groupId'),
              productIds: BuiltValueNullFieldError.checkNotNull(
                  productIds, r'SubscriptionEntity', 'productIds'),
              recurringProductIds: BuiltValueNullFieldError.checkNotNull(
                  recurringProductIds, r'SubscriptionEntity', 'recurringProductIds'),
              optionalProductIds: BuiltValueNullFieldError.checkNotNull(
                  optionalProductIds, r'SubscriptionEntity', 'optionalProductIds'),
              optionalRecurringProductIds: BuiltValueNullFieldError.checkNotNull(
                  optionalRecurringProductIds,
                  r'SubscriptionEntity',
                  'optionalRecurringProductIds'),
              registrationRequired: BuiltValueNullFieldError.checkNotNull(
                  registrationRequired, r'SubscriptionEntity', 'registrationRequired'),
              useInventoryManagement: BuiltValueNullFieldError.checkNotNull(useInventoryManagement, r'SubscriptionEntity', 'useInventoryManagement'),
              frequencyId: BuiltValueNullFieldError.checkNotNull(frequencyId, r'SubscriptionEntity', 'frequencyId'),
              autoBill: BuiltValueNullFieldError.checkNotNull(autoBill, r'SubscriptionEntity', 'autoBill'),
              promoCode: BuiltValueNullFieldError.checkNotNull(promoCode, r'SubscriptionEntity', 'promoCode'),
              promoDiscount: BuiltValueNullFieldError.checkNotNull(promoDiscount, r'SubscriptionEntity', 'promoDiscount'),
              price: BuiltValueNullFieldError.checkNotNull(price, r'SubscriptionEntity', 'price'),
              isAmountDiscount: BuiltValueNullFieldError.checkNotNull(isAmountDiscount, r'SubscriptionEntity', 'isAmountDiscount'),
              allowCancellation: BuiltValueNullFieldError.checkNotNull(allowCancellation, r'SubscriptionEntity', 'allowCancellation'),
              perSeatEnabled: BuiltValueNullFieldError.checkNotNull(perSeatEnabled, r'SubscriptionEntity', 'perSeatEnabled'),
              maxSeatsLimit: BuiltValueNullFieldError.checkNotNull(maxSeatsLimit, r'SubscriptionEntity', 'maxSeatsLimit'),
              trialEnabled: BuiltValueNullFieldError.checkNotNull(trialEnabled, r'SubscriptionEntity', 'trialEnabled'),
              trialDuration: BuiltValueNullFieldError.checkNotNull(trialDuration, r'SubscriptionEntity', 'trialDuration'),
              allowQueryOverrides: BuiltValueNullFieldError.checkNotNull(allowQueryOverrides, r'SubscriptionEntity', 'allowQueryOverrides'),
              allowPlanChanges: BuiltValueNullFieldError.checkNotNull(allowPlanChanges, r'SubscriptionEntity', 'allowPlanChanges'),
              refundPeriod: BuiltValueNullFieldError.checkNotNull(refundPeriod, r'SubscriptionEntity', 'refundPeriod'),
              webhookConfiguration: webhookConfiguration.build(),
              purchasePage: BuiltValueNullFieldError.checkNotNull(purchasePage, r'SubscriptionEntity', 'purchasePage'),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'SubscriptionEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'SubscriptionEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'SubscriptionEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, r'SubscriptionEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'webhookConfiguration';
        webhookConfiguration.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SubscriptionEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WebhookConfigurationEntity extends WebhookConfigurationEntity {
  @override
  final String returnUrl;
  @override
  final String postPurchaseUrl;
  @override
  final String postPurchaseRestMethod;
  @override
  final BuiltMap<String, String> postPurchaseHeaders;
  @override
  final String postPurchaseBody;

  factory _$WebhookConfigurationEntity(
          [void Function(WebhookConfigurationEntityBuilder)? updates]) =>
      (new WebhookConfigurationEntityBuilder()..update(updates))._build();

  _$WebhookConfigurationEntity._(
      {required this.returnUrl,
      required this.postPurchaseUrl,
      required this.postPurchaseRestMethod,
      required this.postPurchaseHeaders,
      required this.postPurchaseBody})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        returnUrl, r'WebhookConfigurationEntity', 'returnUrl');
    BuiltValueNullFieldError.checkNotNull(
        postPurchaseUrl, r'WebhookConfigurationEntity', 'postPurchaseUrl');
    BuiltValueNullFieldError.checkNotNull(postPurchaseRestMethod,
        r'WebhookConfigurationEntity', 'postPurchaseRestMethod');
    BuiltValueNullFieldError.checkNotNull(postPurchaseHeaders,
        r'WebhookConfigurationEntity', 'postPurchaseHeaders');
    BuiltValueNullFieldError.checkNotNull(
        postPurchaseBody, r'WebhookConfigurationEntity', 'postPurchaseBody');
  }

  @override
  WebhookConfigurationEntity rebuild(
          void Function(WebhookConfigurationEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookConfigurationEntityBuilder toBuilder() =>
      new WebhookConfigurationEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookConfigurationEntity &&
        returnUrl == other.returnUrl &&
        postPurchaseUrl == other.postPurchaseUrl &&
        postPurchaseRestMethod == other.postPurchaseRestMethod &&
        postPurchaseHeaders == other.postPurchaseHeaders &&
        postPurchaseBody == other.postPurchaseBody;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, returnUrl.hashCode);
    _$hash = $jc(_$hash, postPurchaseUrl.hashCode);
    _$hash = $jc(_$hash, postPurchaseRestMethod.hashCode);
    _$hash = $jc(_$hash, postPurchaseHeaders.hashCode);
    _$hash = $jc(_$hash, postPurchaseBody.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebhookConfigurationEntity')
          ..add('returnUrl', returnUrl)
          ..add('postPurchaseUrl', postPurchaseUrl)
          ..add('postPurchaseRestMethod', postPurchaseRestMethod)
          ..add('postPurchaseHeaders', postPurchaseHeaders)
          ..add('postPurchaseBody', postPurchaseBody))
        .toString();
  }
}

class WebhookConfigurationEntityBuilder
    implements
        Builder<WebhookConfigurationEntity, WebhookConfigurationEntityBuilder> {
  _$WebhookConfigurationEntity? _$v;

  String? _returnUrl;
  String? get returnUrl => _$this._returnUrl;
  set returnUrl(String? returnUrl) => _$this._returnUrl = returnUrl;

  String? _postPurchaseUrl;
  String? get postPurchaseUrl => _$this._postPurchaseUrl;
  set postPurchaseUrl(String? postPurchaseUrl) =>
      _$this._postPurchaseUrl = postPurchaseUrl;

  String? _postPurchaseRestMethod;
  String? get postPurchaseRestMethod => _$this._postPurchaseRestMethod;
  set postPurchaseRestMethod(String? postPurchaseRestMethod) =>
      _$this._postPurchaseRestMethod = postPurchaseRestMethod;

  MapBuilder<String, String>? _postPurchaseHeaders;
  MapBuilder<String, String> get postPurchaseHeaders =>
      _$this._postPurchaseHeaders ??= new MapBuilder<String, String>();
  set postPurchaseHeaders(MapBuilder<String, String>? postPurchaseHeaders) =>
      _$this._postPurchaseHeaders = postPurchaseHeaders;

  String? _postPurchaseBody;
  String? get postPurchaseBody => _$this._postPurchaseBody;
  set postPurchaseBody(String? postPurchaseBody) =>
      _$this._postPurchaseBody = postPurchaseBody;

  WebhookConfigurationEntityBuilder() {
    WebhookConfigurationEntity._initializeBuilder(this);
  }

  WebhookConfigurationEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _returnUrl = $v.returnUrl;
      _postPurchaseUrl = $v.postPurchaseUrl;
      _postPurchaseRestMethod = $v.postPurchaseRestMethod;
      _postPurchaseHeaders = $v.postPurchaseHeaders.toBuilder();
      _postPurchaseBody = $v.postPurchaseBody;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookConfigurationEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WebhookConfigurationEntity;
  }

  @override
  void update(void Function(WebhookConfigurationEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebhookConfigurationEntity build() => _build();

  _$WebhookConfigurationEntity _build() {
    _$WebhookConfigurationEntity _$result;
    try {
      _$result = _$v ??
          new _$WebhookConfigurationEntity._(
              returnUrl: BuiltValueNullFieldError.checkNotNull(
                  returnUrl, r'WebhookConfigurationEntity', 'returnUrl'),
              postPurchaseUrl: BuiltValueNullFieldError.checkNotNull(
                  postPurchaseUrl,
                  r'WebhookConfigurationEntity',
                  'postPurchaseUrl'),
              postPurchaseRestMethod: BuiltValueNullFieldError.checkNotNull(
                  postPurchaseRestMethod,
                  r'WebhookConfigurationEntity',
                  'postPurchaseRestMethod'),
              postPurchaseHeaders: postPurchaseHeaders.build(),
              postPurchaseBody: BuiltValueNullFieldError.checkNotNull(
                  postPurchaseBody,
                  r'WebhookConfigurationEntity',
                  'postPurchaseBody'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'postPurchaseHeaders';
        postPurchaseHeaders.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WebhookConfigurationEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
