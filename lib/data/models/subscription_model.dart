import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

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
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

abstract class SubscriptionEntity extends Object
    with BaseEntity
    implements Built<SubscriptionEntity, SubscriptionEntityBuilder> {
  // STARTER: properties - do not remove comment

  factory SubscriptionEntity({String id, AppState state}) {
    return _$SubscriptionEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
    );
  }

  SubscriptionEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType => EntityType.subscription;

  @BuiltValueField(wireName: 'group_id')
  String get groupId;

  @BuiltValueField(wireName: 'product_ids')
  String get productIds;

  @BuiltValueField(wireName: 'recurring_product_ids')
  String get recurringProductIds;

  @BuiltValueField(wireName: 'frequency_id')
  String get frequencyId;

  @BuiltValueField(wireName: 'auto_bill')
  String get autoBill;

  @BuiltValueField(wireName: 'promo_code')
  String get promoCode;

  /*
    'promo_discount' => (float)$subscription->promo_discount,
    'is_amount_discount' => (bool)$subscription->is_amount_discount,
    'allow_cancellation' => (bool)$subscription->allow_cancellation,
    'per_seat_enabled' => (bool)$subscription->per_set_enabled,
    'min_seats_limit' => (int)$subscription->min_seats_limit,
    'max_seats_limit' => (int)$subscription->max_seats_limit,
    'trial_enabled' => (bool)$subscription->trial_enabled,
    'trial_duration' => (int)$subscription->trial_duration,
    'allow_query_overrides' => (bool)$subscription->allow_query_overrides,
    'allow_plan_changes' => (bool)$subscription->allow_plan_changes,
    'plan_map' => (string)$subscription->plan_map,
    'refund_period' => (int)$subscription->refund_period,
    'webhook_configuration' => $subscription->webhook_configuration ?: $std,
    'purchase_page' => (string)route('client.subscription.purchase', $subscription->hashed_id),
  */

  String get displayName => id;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (!multiselect && includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(
      SubscriptionEntity subscription, String sortField, bool sortAscending) {
    int response = 0;
    final subscriptionA = sortAscending ? this : subscription;
    final subscriptionB = sortAscending ? subscription : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      default:
        print('## ERROR: sort by subscription.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return subscriptionA.createdAt.compareTo(subscriptionB.createdAt);
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    return null;
  }

  @override
  String get listDisplayName => null;

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  static Serializer<SubscriptionEntity> get serializer =>
      _$subscriptionEntitySerializer;
}
