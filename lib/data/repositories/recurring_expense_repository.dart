import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class RecurringExpenseRepository {
  const RecurringExpenseRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ExpenseEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/recurring_expenses/$entityId', credentials.token);

    final ExpenseItemResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response);

    return recurringExpenseResponse.data;
  }

  Future<BuiltList<ExpenseEntity>> loadList(Credentials credentials) async {
    final String url = credentials.url + '/recurring_expenses?';
    final dynamic response = await webClient.get(url, credentials.token);

    final ExpenseListResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response);

    return recurringExpenseResponse.data;
  }

  Future<List<ExpenseEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/recurring_expenses/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final ExpenseListResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response);

    return recurringExpenseResponse.data.toList();
  }

  Future<ExpenseEntity> saveData(
      Credentials credentials, ExpenseEntity recurringExpense) async {
    final data =
        serializers.serializeWith(ExpenseEntity.serializer, recurringExpense);
    dynamic response;

    if (recurringExpense.isNew) {
      response = await webClient.post(
          credentials.url + '/recurring_expenses', credentials.token,
          data: json.encode(data));
    } else {
      final url =
          '${credentials.url}/recurring_expenses/${recurringExpense.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ExpenseItemResponse recurringExpenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response);

    return recurringExpenseResponse.data;
  }
}
