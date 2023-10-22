// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'subscription_model.g.dart';

abstract class SubscriptionListResponse
    implements
        Built<SubscriptionListResponse, SubscriptionListResponseBuilder> {
  factory SubscriptionListResponse(
          [void updates(SubscriptionListResponseBuilder b)]) =
      _$SubscriptionListResponse;

  SubscriptionListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<SubscriptionEntity> get data;

  static Serializer<SubscriptionListResponse> get serializer =>
      _$subscriptionListResponseSerializer;
}

abstract class SubscriptionItemResponse
    implements
        Built<SubscriptionItemResponse, SubscriptionItemResponseBuilder> {
  factory SubscriptionItemResponse(
          [void updates(SubscriptionItemResponseBuilder b)]) =
      _$SubscriptionItemResponse;

  SubscriptionItemResponse._();

  @override
  @memoized
  int get hashCode;

  SubscriptionEntity get data;

  static Serializer<SubscriptionItemResponse> get serializer =>
      _$subscriptionItemResponseSerializer;
}

class SubscriptionFields {
  static const String name = 'name';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

abstract class SubscriptionEntity extends Object
    with BaseEntity
    implements Built<SubscriptionEntity, SubscriptionEntityBuilder> {
  // STARTER: properties - do not remove comment

  factory SubscriptionEntity({String? id, AppState? state}) {
    return _$SubscriptionEntity._(
      id: id ?? BaseEntity.nextId,
      name: '',
      isChanged: false,
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
      allowCancellation: false,
      allowPlanChanges: false,
      allowQueryOverrides: false,
      autoBill: '',
      frequencyId: '',
      groupId: '',
      isAmountDiscount: true,
      price: 0,
      maxSeatsLimit: 0,
      perSeatEnabled: false,
      productIds: '',
      promoCode: '',
      promoDiscount: 0,
      purchasePage: '',
      recurringProductIds: '',
      refundPeriod: 0,
      trialDuration: 0,
      trialEnabled: false,
      optionalProductIds: '',
      optionalRecurringProductIds: '',
      registrationRequired: false,
      useInventoryManagement: false,
      webhookConfiguration: WebhookConfigurationEntity(),
    );
  }

  SubscriptionEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType => EntityType.paymentLink;

  String get name;

  @BuiltValueField(wireName: 'group_id')
  String get groupId;

  @BuiltValueField(wireName: 'product_ids')
  String get productIds;

  @BuiltValueField(wireName: 'recurring_product_ids')
  String get recurringProductIds;

  @BuiltValueField(wireName: 'optional_product_ids')
  String get optionalProductIds;

  @BuiltValueField(wireName: 'optional_recurring_product_ids')
  String get optionalRecurringProductIds;

  @BuiltValueField(wireName: 'registration_required')
  bool get registrationRequired;

  @BuiltValueField(wireName: 'use_inventory_management')
  bool get useInventoryManagement;

  @BuiltValueField(wireName: 'frequency_id')
  String get frequencyId;

  @BuiltValueField(wireName: 'auto_bill')
  String get autoBill;

  @BuiltValueField(wireName: 'promo_code')
  String get promoCode;

  @BuiltValueField(wireName: 'promo_discount')
  double get promoDiscount;

  double get price;

  @BuiltValueField(wireName: 'is_amount_discount')
  bool get isAmountDiscount;

  @BuiltValueField(wireName: 'allow_cancellation')
  bool get allowCancellation;

  @BuiltValueField(wireName: 'per_seat_enabled')
  bool get perSeatEnabled;

  @BuiltValueField(wireName: 'max_seats_limit')
  int get maxSeatsLimit;

  @BuiltValueField(wireName: 'trial_enabled')
  bool get trialEnabled;

  @BuiltValueField(wireName: 'trial_duration')
  int get trialDuration;

  @BuiltValueField(wireName: 'allow_query_overrides')
  bool get allowQueryOverrides;

  @BuiltValueField(wireName: 'allow_plan_changes')
  bool get allowPlanChanges;

  @BuiltValueField(wireName: 'refund_period')
  int get refundPeriod;

  @BuiltValueField(wireName: 'webhook_configuration')
  WebhookConfigurationEntity get webhookConfiguration;

  @BuiltValueField(wireName: 'purchase_page')
  String get purchasePage;

  String get displayName => id;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted!) {
      if (!multiselect && includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(
      SubscriptionEntity? subscription, String sortField, bool sortAscending) {
    int response = 0;
    final subscriptionA = sortAscending ? this : subscription;
    final subscriptionB = sortAscending ? subscription : this;

    switch (sortField) {
      case SubscriptionFields.name:
        response = subscriptionA!.displayName
            .toLowerCase()
            .compareTo(subscriptionB!.displayName.toLowerCase());
        break;
      case SubscriptionFields.createdAt:
        response = subscriptionA!.createdAt.compareTo(subscriptionB!.createdAt);
        break;
      case SubscriptionFields.updatedAt:
        response = subscriptionA!.updatedAt.compareTo(subscriptionB!.updatedAt);
        break;
      default:
        print('## ERROR: sort by subscription.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return subscriptionA!.createdAt.compareTo(subscriptionB!.createdAt);
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        name,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        name,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => name;

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType? get listDisplayAmountType => null;

  // ignore: unused_element
  static void _initializeBuilder(SubscriptionEntityBuilder builder) => builder
    ..optionalProductIds = ''
    ..optionalRecurringProductIds = ''
    ..registrationRequired = false
    ..useInventoryManagement = false;

  static Serializer<SubscriptionEntity> get serializer =>
      _$subscriptionEntitySerializer;
}

abstract class WebhookConfigurationEntity
    implements
        Built<WebhookConfigurationEntity, WebhookConfigurationEntityBuilder> {
  factory WebhookConfigurationEntity() {
    return _$WebhookConfigurationEntity._(
      postPurchaseBody: '',
      postPurchaseHeaders: BuiltMap<String, String>(),
      postPurchaseRestMethod: '',
      postPurchaseUrl: '',
      returnUrl: '',
    );
  }

  WebhookConfigurationEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'return_url')
  String get returnUrl;

  @BuiltValueField(wireName: 'post_purchase_url')
  String get postPurchaseUrl;

  @BuiltValueField(wireName: 'post_purchase_rest_method')
  String get postPurchaseRestMethod;

  @BuiltValueField(wireName: 'post_purchase_headers')
  BuiltMap<String, String> get postPurchaseHeaders;

  // TODO remove this field
  @BuiltValueField(wireName: 'post_purchase_body')
  String get postPurchaseBody;

  // ignore: unused_element
  static void _initializeBuilder(WebhookConfigurationEntityBuilder builder) =>
      builder
        ..returnUrl = ''
        ..postPurchaseBody = ''
        ..postPurchaseHeaders.replace(BuiltMap<String, String>())
        ..postPurchaseRestMethod = ''
        ..postPurchaseUrl = '';

  static Serializer<WebhookConfigurationEntity> get serializer =>
      _$webhookConfigurationEntitySerializer;
}
