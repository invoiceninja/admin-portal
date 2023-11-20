import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class BankAccountRepository {
  const BankAccountRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<BankAccountEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/bank_integrations/$entityId', credentials.token);

    final BankAccountItemResponse bankAccountResponse = serializers
        .deserializeWith(BankAccountItemResponse.serializer, response)!;

    return bankAccountResponse.data;
  }

  Future<BuiltList<BankAccountEntity>> loadList(Credentials credentials) async {
    final String url = credentials.url+ '/bank_integrations?';
    final dynamic response = await webClient.get(url, credentials.token);

    final BankAccountListResponse bankAccountResponse = serializers
        .deserializeWith(BankAccountListResponse.serializer, response)!;

    return bankAccountResponse.data;
  }

  Future<List<BankAccountEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/bank_integrations/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final BankAccountListResponse bankAccountResponse = serializers
        .deserializeWith(BankAccountListResponse.serializer, response)!;

    return bankAccountResponse.data.toList();
  }

  Future<BankAccountEntity> saveData(
      Credentials credentials, BankAccountEntity bankAccount) async {
    final data =
        serializers.serializeWith(BankAccountEntity.serializer, bankAccount);
    dynamic response;

    if (bankAccount.isNew) {
      response = await webClient.post(
          credentials.url+ '/bank_integrations', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/bank_integrations/${bankAccount.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final BankAccountItemResponse bankAccountResponse = serializers
        .deserializeWith(BankAccountItemResponse.serializer, response)!;

    return bankAccountResponse.data;
  }
}
