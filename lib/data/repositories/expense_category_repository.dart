// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ExpenseCategoryRepository {
  const ExpenseCategoryRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ExpenseCategoryEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/expense_categories/$entityId', credentials.token);

    final ExpenseCategoryItemResponse expenseCategoryResponse = serializers
        .deserializeWith(ExpenseCategoryItemResponse.serializer, response)!;

    return expenseCategoryResponse.data;
  }

  Future<BuiltList<ExpenseCategoryEntity>> loadList(
      Credentials credentials) async {
    final String url = credentials.url+ '/expense_categories?';
    final dynamic response = await webClient.get(url, credentials.token);

    final ExpenseCategoryListResponse expenseCategoryResponse = serializers
        .deserializeWith(ExpenseCategoryListResponse.serializer, response)!;

    return expenseCategoryResponse.data;
  }

  Future<List<ExpenseCategoryEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/expense_categories/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final ExpenseCategoryListResponse expenseCategoryResponse = serializers
        .deserializeWith(ExpenseCategoryListResponse.serializer, response)!;

    return expenseCategoryResponse.data.toList();
  }

  Future<ExpenseCategoryEntity> saveData(
      Credentials credentials, ExpenseCategoryEntity expenseCategory) async {
    final data = serializers.serializeWith(
        ExpenseCategoryEntity.serializer, expenseCategory);
    dynamic response;

    if (expenseCategory.isNew) {
      response = await webClient.post(
          credentials.url+ '/expense_categories', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/expense_categories/${expenseCategory.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ExpenseCategoryItemResponse expenseCategoryResponse = serializers
        .deserializeWith(ExpenseCategoryItemResponse.serializer, response)!;

    return expenseCategoryResponse.data;
  }
}
