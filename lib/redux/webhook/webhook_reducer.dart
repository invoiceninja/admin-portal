// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';

EntityUIState webhookUIReducer(WebhookUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(webhookListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewWebhook>((completer, action) => true),
  TypedReducer<bool?, ViewWebhookList>((completer, action) => false),
  TypedReducer<bool?, FilterWebhooksByState>((completer, action) => false),
  TypedReducer<bool?, FilterWebhooks>((completer, action) => false),
  TypedReducer<bool?, FilterWebhooksByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterWebhooksByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterWebhooksByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterWebhooksByCustom4>((completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveWebhooksSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteWebhooksSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.webhook ? action.entityId : selectedId),
  TypedReducer<String?, ViewWebhook>(
      (String? selectedId, dynamic action) => action.webhookId),
  TypedReducer<String?, AddWebhookSuccess>(
      (String? selectedId, dynamic action) => action.webhook.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortWebhooks>((selectedId, action) => ''),
  TypedReducer<String?, FilterWebhooks>((selectedId, action) => ''),
  TypedReducer<String?, FilterWebhooksByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterWebhooksByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterWebhooksByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterWebhooksByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterWebhooksByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.webhook
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<WebhookEntity?>([
  TypedReducer<WebhookEntity?, SaveWebhookSuccess>(_updateEditing),
  TypedReducer<WebhookEntity?, AddWebhookSuccess>(_updateEditing),
  TypedReducer<WebhookEntity?, RestoreWebhooksSuccess>((webhooks, action) {
    return action.webhooks[0];
  }),
  TypedReducer<WebhookEntity?, ArchiveWebhooksSuccess>((webhooks, action) {
    return action.webhooks[0];
  }),
  TypedReducer<WebhookEntity?, DeleteWebhooksSuccess>((webhooks, action) {
    return action.webhooks[0];
  }),
  TypedReducer<WebhookEntity?, EditWebhook>(_updateEditing),
  TypedReducer<WebhookEntity?, UpdateWebhook>((webhook, action) {
    return action.webhook.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<WebhookEntity?, DiscardChanges>(_clearEditing),
]);

WebhookEntity _clearEditing(WebhookEntity? webhook, dynamic action) {
  return WebhookEntity();
}

WebhookEntity? _updateEditing(WebhookEntity? webhook, dynamic action) {
  return action.webhook;
}

final webhookListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortWebhooks>(_sortWebhooks),
  TypedReducer<ListUIState, FilterWebhooksByState>(_filterWebhooksByState),
  TypedReducer<ListUIState, FilterWebhooks>(_filterWebhooks),
  TypedReducer<ListUIState, FilterWebhooksByCustom1>(_filterWebhooksByCustom1),
  TypedReducer<ListUIState, FilterWebhooksByCustom2>(_filterWebhooksByCustom2),
  TypedReducer<ListUIState, StartWebhookMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToWebhookMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromWebhookMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearWebhookMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewWebhookList>(_viewWebhookList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewWebhookList(
    ListUIState webhookListState, ViewWebhookList action) {
  return webhookListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterWebhooksByCustom1(
    ListUIState webhookListState, FilterWebhooksByCustom1 action) {
  if (webhookListState.custom1Filters.contains(action.value)) {
    return webhookListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return webhookListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterWebhooksByCustom2(
    ListUIState webhookListState, FilterWebhooksByCustom2 action) {
  if (webhookListState.custom2Filters.contains(action.value)) {
    return webhookListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return webhookListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterWebhooksByState(
    ListUIState webhookListState, FilterWebhooksByState action) {
  if (webhookListState.stateFilters.contains(action.state)) {
    return webhookListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return webhookListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterWebhooks(
    ListUIState webhookListState, FilterWebhooks action) {
  return webhookListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : webhookListState.filterClearedAt);
}

ListUIState _sortWebhooks(ListUIState webhookListState, SortWebhooks action) {
  return webhookListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartWebhookMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToWebhookMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromWebhookMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearWebhookMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final webhooksReducer = combineReducers<WebhookState>([
  TypedReducer<WebhookState, SaveWebhookSuccess>(_updateWebhook),
  TypedReducer<WebhookState, AddWebhookSuccess>(_addWebhook),
  TypedReducer<WebhookState, LoadWebhooksSuccess>(_setLoadedWebhooks),
  TypedReducer<WebhookState, LoadWebhookSuccess>(_setLoadedWebhook),
  TypedReducer<WebhookState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<WebhookState, ArchiveWebhooksSuccess>(_archiveWebhookSuccess),
  TypedReducer<WebhookState, DeleteWebhooksSuccess>(_deleteWebhookSuccess),
  TypedReducer<WebhookState, RestoreWebhooksSuccess>(_restoreWebhookSuccess),
]);

WebhookState _archiveWebhookSuccess(
    WebhookState webhookState, ArchiveWebhooksSuccess action) {
  return webhookState.rebuild((b) {
    for (final webhook in action.webhooks) {
      b.map[webhook.id] = webhook;
    }
  });
}

WebhookState _deleteWebhookSuccess(
    WebhookState webhookState, DeleteWebhooksSuccess action) {
  return webhookState.rebuild((b) {
    for (final webhook in action.webhooks) {
      b.map[webhook.id] = webhook;
    }
  });
}

WebhookState _restoreWebhookSuccess(
    WebhookState webhookState, RestoreWebhooksSuccess action) {
  return webhookState.rebuild((b) {
    for (final webhook in action.webhooks) {
      b.map[webhook.id] = webhook;
    }
  });
}

WebhookState _addWebhook(WebhookState webhookState, AddWebhookSuccess action) {
  return webhookState.rebuild((b) => b
    ..map[action.webhook.id] = action.webhook
    ..list.add(action.webhook.id));
}

WebhookState _updateWebhook(
    WebhookState webhookState, SaveWebhookSuccess action) {
  return webhookState
      .rebuild((b) => b..map[action.webhook.id] = action.webhook);
}

WebhookState _setLoadedWebhook(
    WebhookState webhookState, LoadWebhookSuccess action) {
  return webhookState
      .rebuild((b) => b..map[action.webhook.id] = action.webhook);
}

WebhookState _setLoadedWebhooks(
        WebhookState webhookState, LoadWebhooksSuccess action) =>
    webhookState.loadWebhooks(action.webhooks);

WebhookState _setLoadedCompany(
    WebhookState webhookState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return webhookState.loadWebhooks(company.webhooks);
}
