import 'package:invoiceninja_flutter/data/models/webhook_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownWebhookList = memo3(
    (BuiltMap<String, WebhookEntity> webhookMap, BuiltList<String> webhookList,
            String clientId) =>
        dropdownWebhooksSelector(webhookMap, webhookList, clientId));

List<String> dropdownWebhooksSelector(
    BuiltMap<String, WebhookEntity> webhookMap,
    BuiltList<String> webhookList,
    String clientId) {
  final list = webhookList.where((webhookId) {
    final webhook = webhookMap[webhookId];
    /*
    if (clientId != null && clientId > 0 && webhook.clientId != clientId) {
      return false;
    }
    */
    return webhook.isActive;
  }).toList();

  list.sort((webhookAId, webhookBId) {
    final webhookA = webhookMap[webhookAId];
    final webhookB = webhookMap[webhookBId];
    return webhookA.compareTo(webhookB, WebhookFields.targetUrl, true);
  });

  return list;
}

var memoizedFilteredWebhookList = memo5((
  String filterEntityId,
  EntityType filterEntityType,
  BuiltMap<String, WebhookEntity> webhookMap,
  BuiltList<String> webhookList,
  ListUIState webhookListState,
) =>
    filteredWebhooksSelector(
      filterEntityId,
      filterEntityType,
      webhookMap,
      webhookList,
      webhookListState,
    ));

List<String> filteredWebhooksSelector(
  String filterEntityId,
  EntityType filterEntityType,
  BuiltMap<String, WebhookEntity> webhookMap,
  BuiltList<String> webhookList,
  ListUIState webhookListState,
) {
  final list = webhookList.where((webhookId) {
    final webhook = webhookMap[webhookId];
    if (filterEntityId != null && webhook.id != filterEntityId) {
      return false;
    } else {}

    if (!webhook.matchesStates(webhookListState.stateFilters)) {
      return false;
    }
    return webhook.matchesFilter(webhookListState.filter);
  }).toList();

  list.sort((webhookAId, webhookBId) {
    final webhookA = webhookMap[webhookAId];
    final webhookB = webhookMap[webhookBId];
    return webhookA.compareTo(
        webhookB, webhookListState.sortField, webhookListState.sortAscending);
  });

  return list;
}

bool hasWebhookChanges(
        WebhookEntity webhook, BuiltMap<String, WebhookEntity> webhookMap) =>
    webhook.isNew ? webhook.isChanged : webhook != webhookMap[webhook.id];
