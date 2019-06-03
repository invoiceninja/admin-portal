import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ExpenseRepository {
  const ExpenseRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ExpenseEntity> loadItem(
      CompanyEntity company, AuthState auth, int entityId) async {
    final dynamic response =
        await webClient.get('${auth.url}/expenses/$entityId', company.token);

    final ExpenseItemResponse expenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response);

    return expenseResponse.data;
  }

  Future<BuiltList<ExpenseEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/expenses?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final ExpenseListResponse expenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response);

    return expenseResponse.data;
  }

  Future<ExpenseEntity> saveData(
      CompanyEntity company, AuthState auth, ExpenseEntity expense,
      [EntityAction action]) async {
    final data = serializers.serializeWith(ExpenseEntity.serializer, expense);
    dynamic response;

    if (expense.isNew) {
      response = await webClient.post(
          auth.url + '/expenses', company.token, json.encode(data));
    } else {
      var url = auth.url + '/expenses/' + expense.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final ExpenseItemResponse expenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response);

    return expenseResponse.data;
  }
}
