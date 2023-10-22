// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownSubscriptionList = memo5(
    (BuiltMap<String, SubscriptionEntity> subscriptionMap,
            BuiltList<String> subscriptionList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            String clientId) =>
        dropdownSubscriptionsSelector(
            subscriptionMap, subscriptionList, staticState, userMap, clientId));

List<String> dropdownSubscriptionsSelector(
    BuiltMap<String, SubscriptionEntity> subscriptionMap,
    BuiltList<String> subscriptionList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    String clientId) {
  final list = subscriptionList.where((subscriptionId) {
    final subscription = subscriptionMap[subscriptionId]!;
    /*
    if (clientId != null && clientId > 0 && subscription.clientId != clientId) {
      return false;
    }
    */
    return subscription.isActive;
  }).toList();

  list.sort((subscriptionAId, subscriptionBId) {
    final subscriptionA = subscriptionMap[subscriptionAId]!;
    final subscriptionB = subscriptionMap[subscriptionBId];
    return subscriptionA.compareTo(
        subscriptionB, SubscriptionFields.createdAt, true);
  });

  return list;
}

var memoizedFilteredSubscriptionList = memo4((SelectionState selectionState,
        BuiltMap<String?, SubscriptionEntity?> subscriptionMap,
        BuiltList<String> subscriptionList,
        ListUIState subscriptionListState) =>
    filteredSubscriptionsSelector(
      selectionState,
      subscriptionMap,
      subscriptionList,
      subscriptionListState,
    ));

List<String> filteredSubscriptionsSelector(
    SelectionState selectionState,
    BuiltMap<String?, SubscriptionEntity?> subscriptionMap,
    BuiltList<String> subscriptionList,
    ListUIState subscriptionListState) {
  final filterEntityId = selectionState.filterEntityId;
  //final filterEntityType = selectionState.filterEntityType;

  final list = subscriptionList.where((subscriptionId) {
    final subscription = subscriptionMap[subscriptionId]!;
    if (subscription.id == selectionState.selectedId) {
      return true;
    }

    if (filterEntityId != null && subscription.id != filterEntityId) {
      return false;
    } else {}

    if (!subscription.matchesStates(subscriptionListState.stateFilters)) {
      return false;
    }
    return subscription.matchesFilter(subscriptionListState.filter);
  }).toList();

  list.sort((subscriptionAId, subscriptionBId) {
    final subscriptionA = subscriptionMap[subscriptionAId]!;
    final subscriptionB = subscriptionMap[subscriptionBId];
    return subscriptionA.compareTo(subscriptionB,
        subscriptionListState.sortField, subscriptionListState.sortAscending);
  });

  return list;
}
