import 'package:invoiceninja_flutter/data/models/subscription_model.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownSubscriptionList = memo5(
    (BuiltMap<String, SubscriptionEntity> subscriptionMap, BuiltList<String> subscriptionList,
                StaticState staticState,
                BuiltMap<String, UserEntity> userMap,
            String clientId) =>
        dropdownSubscriptionsSelector(subscriptionMap, subscriptionList, staticState, userMap, clientId));

List<String> dropdownSubscriptionsSelector(BuiltMap<String, SubscriptionEntity> subscriptionMap,
    BuiltList<String> subscriptionList, 
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,    
    String clientId) {
  final list = subscriptionList.where((subscriptionId) {
    final subscription = subscriptionMap[subscriptionId];
    /*
    if (clientId != null && clientId > 0 && subscription.clientId != clientId) {
      return false;
    }
    */
    return subscription.isActive;
  }).toList();

  list.sort((subscriptionAId, subscriptionBId) {
    final subscriptionA = subscriptionMap[subscriptionAId];
    final subscriptionB = subscriptionMap[subscriptionBId];
    return subscriptionA.compareTo(subscriptionB, SubscriptionFields.name, true);
  });

  return list;
}

var memoizedFilteredSubscriptionList = memo7((
        String filterEntityId,
        EntityType filterEntityType,
        BuiltMap<String, SubscriptionEntity> subscriptionMap,
        BuiltList<String> subscriptionList,
        StaticState staticState,
        BuiltMap<String, UserEntity> userMap, 
        ListUIState subscriptionListState) =>
    filteredSubscriptionsSelector(filterEntityId, filterEntityType, subscriptionMap, subscriptionList, staticState, userMap, subscriptionListState));

List<String> filteredSubscriptionsSelector(
    String filterEntityId,
    EntityType filterEntityType,
    BuiltMap<String, SubscriptionEntity> subscriptionMap,
    BuiltList<String> subscriptionList, 
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    ListUIState subscriptionListState) {
  final list = subscriptionList.where((subscriptionId) {
    final subscription = subscriptionMap[subscriptionId];
    if (filterEntityId != null && subscription.id != filterEntityId) {
      return false;
    } else {

    }

    if (!subscription.matchesStates(subscriptionListState.stateFilters)) {
      return false;
    }
    if (subscriptionListState.custom1Filters.isNotEmpty &&
        !subscriptionListState.custom1Filters.contains(subscription.customValue1)) {
      return false;
    }
    if (subscriptionListState.custom2Filters.isNotEmpty &&
        !subscriptionListState.custom2Filters.contains(subscription.customValue2)) {
      return false;
    }
    return subscription.matchesFilter(subscriptionListState.filter);
  }).toList();

  list.sort((subscriptionAId, subscriptionBId) {
    return subscriptionMap[subscriptionAId].compareTo(
      subscription: subscriptionMap[subscriptionBId],
      sortField: subscriptionListState.sortField,
      sortAscending: subscriptionListState.sortAscending,
    );
  });


  return list;
}

bool hasSubscriptionChanges(
        SubscriptionEntity subscription, BuiltMap<String, SubscriptionEntity> subscriptionMap) =>
    subscription.isNew ? subscription.isChanged : subscription != subscriptionMap[subscription.id];
