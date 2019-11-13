import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/mock/mock_expenses.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ExpenseRepository {
  const ExpenseRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ExpenseEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/expenses/$entityId', credentials.token);

    final ExpenseItemResponse expenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response);

    return expenseResponse.data;
  }

  Future<BuiltList<ExpenseEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/expenses?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    dynamic response;

    if (Config.DEMO_MODE) {
      response = json.decode(kMockExpenses);
    } else {
      response = await webClient.get(url, credentials.token);
    }

    final ExpenseListResponse expenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response);

    return expenseResponse.data;
  }

  Future<List<ExpenseEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    dynamic response;

    switch (action) {
      case EntityAction.restore:
      case EntityAction.archive:
      case EntityAction.delete:
        var url = credentials.url + '/expenses/bulk?include=activities';
        if (action != null) {
          url += '&action=' + action.toString();
        }
        response = await webClient.post(url, credentials.token,
            data: json.encode(ids));
        break;
      default:
        // Might have other actions in the future
        break;
    }

    final ExpenseListResponse expenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response);

    return expenseResponse.data.toList();
  }

  Future<ExpenseEntity> saveData(Credentials credentials, ExpenseEntity expense,
      [EntityAction action]) async {
    final data = serializers.serializeWith(ExpenseEntity.serializer, expense);
    dynamic response;

    if (expense.isNew) {
      response = await webClient.post(
          credentials.url + '/expenses', credentials.token,
          data: json.encode(data));
    } else {
      var url = credentials.url + '/expenses/' + expense.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ExpenseItemResponse expenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response);

    return expenseResponse.data;
  }
}
