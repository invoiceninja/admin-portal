import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class TransactionRuleRepository {
  const TransactionRuleRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TransactionRuleEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/bank_transaction_rules/$entityId',
        credentials.token);

    final TransactionRuleItemResponse transactionRuleResponse = serializers
        .deserializeWith(TransactionRuleItemResponse.serializer, response)!;

    return transactionRuleResponse.data;
  }

  Future<BuiltList<TransactionRuleEntity>> loadList(
      Credentials credentials) async {
    final String url = credentials.url+ '/bnak_transaction_rules?';
    final dynamic response = await webClient.get(url, credentials.token);

    final TransactionRuleListResponse transactionRuleResponse = serializers
        .deserializeWith(TransactionRuleListResponse.serializer, response)!;

    return transactionRuleResponse.data;
  }

  Future<List<TransactionRuleEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/bank_transaction_rules/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final TransactionRuleListResponse transactionRuleResponse = serializers
        .deserializeWith(TransactionRuleListResponse.serializer, response)!;

    return transactionRuleResponse.data.toList();
  }

  Future<TransactionRuleEntity> saveData(
      Credentials credentials, TransactionRuleEntity transactionRule) async {
    final data = serializers.serializeWith(
        TransactionRuleEntity.serializer, transactionRule);
    dynamic response;

    if (transactionRule.isNew) {
      response = await webClient.post(
          credentials.url+ '/bank_transaction_rules', credentials.token,
          data: json.encode(data));
    } else {
      final url =
          '${credentials.url}/bank_transaction_rules/${transactionRule.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final TransactionRuleItemResponse transactionRuleResponse = serializers
        .deserializeWith(TransactionRuleItemResponse.serializer, response)!;

    return transactionRuleResponse.data;
  }
}
