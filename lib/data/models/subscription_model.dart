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
  // STARTER: fields - do not remove comment
}

abstract class SubscriptionEntity extends Object
    with BaseEntity
    implements Built<SubscriptionEntity, SubscriptionEntityBuilder> {
  // STARTER: properties - do not remove comment

  factory SubscriptionEntity({String id, AppState state}) {
    return _$SubscriptionEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      // STARTER: constructor - do not remove comment
    );
  }

  SubscriptionEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType => EntityType.subscription;

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
