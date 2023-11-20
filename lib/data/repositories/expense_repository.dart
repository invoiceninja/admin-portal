// Dart imports:
import 'dart:convert';
import 'dart:core';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class ExpenseRepository {
  const ExpenseRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ExpenseEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/expenses/$entityId', credentials.token);

    final ExpenseItemResponse expenseResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[ExpenseItemResponse.serializer, response]);

    return expenseResponse.data;
  }

  Future<BuiltList<ExpenseEntity>> loadList(Credentials credentials, int page,
      int createdAt, bool filterDeleted) async {
    final url = credentials.url+
        '/expenses?per_page=$kMaxRecordsPerPage&page=$page&created_at=$createdAt';

    /* Server is incorrect if client isn't set
    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }
    */

    final dynamic response = await webClient.get(url, credentials.token);

    final ExpenseListResponse expenseResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[ExpenseListResponse.serializer, response]);

    return expenseResponse.data;
  }

  Future<List<ExpenseEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url =
        credentials.url+ '/expenses/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final ExpenseListResponse expenseResponse =
        serializers.deserializeWith(ExpenseListResponse.serializer, response)!;

    return expenseResponse.data.toList();
  }

  Future<ExpenseEntity> saveData(
      Credentials credentials, ExpenseEntity expense) async {
    final data = serializers.serializeWith(ExpenseEntity.serializer, expense);
    dynamic response;

    if (expense.isNew) {
      response = await webClient.post(
          credentials.url+ '/expenses', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url+ '/expenses/${expense.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ExpenseItemResponse expenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response)!;

    return expenseResponse.data;
  }

  Future<ExpenseEntity> uploadDocuments(
      Credentials credentials,
      BaseEntity entity,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/expenses/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: multipartFiles);

    final ExpenseItemResponse expenseResponse =
        serializers.deserializeWith(ExpenseItemResponse.serializer, response)!;

    return expenseResponse.data;
  }
}
