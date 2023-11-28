// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class RecurringExpenseRepository {
  const RecurringExpenseRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ExpenseEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/recurring_expenses/$entityId?show_dates=true',
        credentials.token);

    final ExpenseItemResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response)!;

    return recurringExpenseResponse.data;
  }

  Future<BuiltList<ExpenseEntity>> loadList(Credentials credentials) async {
    final String url = credentials.url+ '/recurring_expenses?';
    final dynamic response = await webClient.get(url, credentials.token);

    final ExpenseListResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response)!;

    return recurringExpenseResponse.data;
  }

  Future<List<ExpenseEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/recurring_expenses/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final ExpenseListResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response)!;

    return recurringExpenseResponse.data.toList();
  }

  Future<ExpenseEntity> saveData(
      Credentials credentials, ExpenseEntity recurringExpense,
      {EntityAction? action}) async {
    final data =
        serializers.serializeWith(ExpenseEntity.serializer, recurringExpense);
    dynamic response;
    String url;

    if (recurringExpense.isNew) {
      url = credentials.url+ '/recurring_expenses?show_dates=true';
    } else {
      url =
          '${credentials.url}/recurring_expenses/${recurringExpense.id}?show_dates=true';
    }

    if (action == EntityAction.start) {
      url += '&start=true';
    } else if (action == EntityAction.stop) {
      url += '&stop=true';
    }

    if (recurringExpense.isNew) {
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ExpenseItemResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response)!;

    return recurringExpenseResponse.data;
  }

  Future<ExpenseEntity> uploadDocument(
      Credentials credentials,
      BaseEntity entity,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/recurring_expenses/${entity.id}/upload',
        credentials.token,
        data: fields,
        multipartFiles: multipartFiles);

    final ExpenseItemResponse expenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response)!;

    return expenseResponse.data;
  }
}
