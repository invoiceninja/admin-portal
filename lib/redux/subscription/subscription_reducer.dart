// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState subscriptionUIReducer(SubscriptionUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(subscriptionListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewSubscription>((completer, action) => true),
  TypedReducer<bool?, ViewSubscriptionList>((completer, action) => false),
  TypedReducer<bool?, FilterSubscriptionsByState>((completer, action) => false),
  TypedReducer<bool?, FilterSubscriptions>((completer, action) => false),
  TypedReducer<bool?, FilterSubscriptionsByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterSubscriptionsByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterSubscriptionsByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterSubscriptionsByCustom4>(
      (completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateSubscriptionTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveSubscriptionsSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteSubscriptionsSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.paymentLink
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewSubscription>(
      (String? selectedId, dynamic action) => action.subscriptionId),
  TypedReducer<String?, AddSubscriptionSuccess>(
      (String? selectedId, dynamic action) => action.subscription.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortSubscriptions>((selectedId, action) => ''),
  TypedReducer<String?, FilterSubscriptions>((selectedId, action) => ''),
  TypedReducer<String?, FilterSubscriptionsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterSubscriptionsByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterSubscriptionsByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterSubscriptionsByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterSubscriptionsByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.paymentLink
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<SubscriptionEntity?>([
  TypedReducer<SubscriptionEntity?, SaveSubscriptionSuccess>(_updateEditing),
  TypedReducer<SubscriptionEntity?, AddSubscriptionSuccess>(_updateEditing),
  TypedReducer<SubscriptionEntity?, RestoreSubscriptionsSuccess>(
      (subscriptions, action) {
    return action.subscriptions[0];
  }),
  TypedReducer<SubscriptionEntity?, ArchiveSubscriptionsSuccess>(
      (subscriptions, action) {
    return action.subscriptions[0];
  }),
  TypedReducer<SubscriptionEntity?, DeleteSubscriptionsSuccess>(
      (subscriptions, action) {
    return action.subscriptions[0];
  }),
  TypedReducer<SubscriptionEntity?, EditSubscription>(_updateEditing),
  TypedReducer<SubscriptionEntity?, UpdateSubscription>((subscription, action) {
    return action.subscription.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<SubscriptionEntity?, DiscardChanges>(_clearEditing),
]);

SubscriptionEntity _clearEditing(
    SubscriptionEntity? subscription, dynamic action) {
  return SubscriptionEntity();
}

SubscriptionEntity? _updateEditing(
    SubscriptionEntity? subscription, dynamic action) {
  return action.subscription;
}

final subscriptionListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortSubscriptions>(_sortSubscriptions),
  TypedReducer<ListUIState, FilterSubscriptionsByState>(
      _filterSubscriptionsByState),
  TypedReducer<ListUIState, FilterSubscriptions>(_filterSubscriptions),
  TypedReducer<ListUIState, FilterSubscriptionsByCustom1>(
      _filterSubscriptionsByCustom1),
  TypedReducer<ListUIState, FilterSubscriptionsByCustom2>(
      _filterSubscriptionsByCustom2),
  TypedReducer<ListUIState, StartSubscriptionMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToSubscriptionMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromSubscriptionMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearSubscriptionMultiselect>(
      _clearListMultiselect),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _filterSubscriptionsByCustom1(
    ListUIState subscriptionListState, FilterSubscriptionsByCustom1 action) {
  if (subscriptionListState.custom1Filters.contains(action.value)) {
    return subscriptionListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return subscriptionListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterSubscriptionsByCustom2(
    ListUIState subscriptionListState, FilterSubscriptionsByCustom2 action) {
  if (subscriptionListState.custom2Filters.contains(action.value)) {
    return subscriptionListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return subscriptionListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterSubscriptionsByState(
    ListUIState subscriptionListState, FilterSubscriptionsByState action) {
  if (subscriptionListState.stateFilters.contains(action.state)) {
    return subscriptionListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return subscriptionListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterSubscriptions(
    ListUIState subscriptionListState, FilterSubscriptions action) {
  return subscriptionListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : subscriptionListState.filterClearedAt);
}

ListUIState _sortSubscriptions(
    ListUIState subscriptionListState, SortSubscriptions action) {
  return subscriptionListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartSubscriptionMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToSubscriptionMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromSubscriptionMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearSubscriptionMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final subscriptionsReducer = combineReducers<SubscriptionState>([
  TypedReducer<SubscriptionState, SaveSubscriptionSuccess>(_updateSubscription),
  TypedReducer<SubscriptionState, AddSubscriptionSuccess>(_addSubscription),
  TypedReducer<SubscriptionState, LoadSubscriptionsSuccess>(
      _setLoadedSubscriptions),
  TypedReducer<SubscriptionState, LoadSubscriptionSuccess>(
      _setLoadedSubscription),
  TypedReducer<SubscriptionState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<SubscriptionState, ArchiveSubscriptionsSuccess>(
      _archiveSubscriptionSuccess),
  TypedReducer<SubscriptionState, DeleteSubscriptionsSuccess>(
      _deleteSubscriptionSuccess),
  TypedReducer<SubscriptionState, RestoreSubscriptionsSuccess>(
      _restoreSubscriptionSuccess),
]);

SubscriptionState _archiveSubscriptionSuccess(
    SubscriptionState subscriptionState, ArchiveSubscriptionsSuccess action) {
  return subscriptionState.rebuild((b) {
    for (final subscription in action.subscriptions) {
      b.map[subscription.id] = subscription;
    }
  });
}

SubscriptionState _deleteSubscriptionSuccess(
    SubscriptionState subscriptionState, DeleteSubscriptionsSuccess action) {
  return subscriptionState.rebuild((b) {
    for (final subscription in action.subscriptions) {
      b.map[subscription.id] = subscription;
    }
  });
}

SubscriptionState _restoreSubscriptionSuccess(
    SubscriptionState subscriptionState, RestoreSubscriptionsSuccess action) {
  return subscriptionState.rebuild((b) {
    for (final subscription in action.subscriptions) {
      b.map[subscription.id] = subscription;
    }
  });
}

SubscriptionState _addSubscription(
    SubscriptionState subscriptionState, AddSubscriptionSuccess action) {
  return subscriptionState.rebuild((b) => b
    ..map[action.subscription.id] = action.subscription
    ..list.add(action.subscription.id));
}

SubscriptionState _updateSubscription(
    SubscriptionState subscriptionState, SaveSubscriptionSuccess action) {
  return subscriptionState
      .rebuild((b) => b..map[action.subscription.id] = action.subscription);
}

SubscriptionState _setLoadedSubscription(
    SubscriptionState subscriptionState, LoadSubscriptionSuccess action) {
  return subscriptionState
      .rebuild((b) => b..map[action.subscription.id] = action.subscription);
}

SubscriptionState _setLoadedSubscriptions(
        SubscriptionState subscriptionState, LoadSubscriptionsSuccess action) =>
    subscriptionState.loadSubscriptions(action.subscriptions);

SubscriptionState _setLoadedCompany(
    SubscriptionState subscriptionState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return subscriptionState.loadSubscriptions(company.subscriptions);
}
