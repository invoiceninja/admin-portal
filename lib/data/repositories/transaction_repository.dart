import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class TransactionRepository {
  const TransactionRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TransactionEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/bank_transactions/$entityId', credentials.token);

    final TransactionItemResponse transactionResponse = serializers
        .deserializeWith(TransactionItemResponse.serializer, response)!;

    return transactionResponse.data;
  }

  Future<BuiltList<TransactionEntity>> loadList(
      Credentials credentials, int page, int createdAt) async {
    final String url = credentials.url+
        '/bank_transactions?per_page=$kMaxRecordsPerPage&page=$page&created_at=$createdAt';
    final dynamic response = await webClient.get(url, credentials.token);

    final TransactionListResponse transactionResponse = serializers
        .deserializeWith(TransactionListResponse.serializer, response)!;

    return transactionResponse.data;
  }

  Future<List<TransactionEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/bank_transactions/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final TransactionListResponse transactionResponse = serializers
        .deserializeWith(TransactionListResponse.serializer, response)!;

    return transactionResponse.data.toList();
  }

  Future<TransactionEntity> convertToPayment(Credentials credentials,
      String? transactionId, List<String> invoiceIds) async {
    final url = credentials.url+ '/bank_transactions/match';
    final dynamic response = await webClient.post(
      url,
      credentials.token,
      data: json.encode(
        {
          'transactions': [
            {
              'id': transactionId,
              'invoice_ids': invoiceIds.join(','),
            }
          ],
        },
      ),
    );

    final TransactionListResponse transactionResponse = serializers
        .deserializeWith(TransactionListResponse.serializer, response)!;

    return transactionResponse.data.first;
  }

  Future<BuiltList<TransactionEntity>> convertToExpense(
    Credentials credentials,
    List<String> transactionIds,
    String vendorId,
    String categoryId,
  ) async {
    final url = credentials.url+ '/bank_transactions/match';
    final dynamic response = await webClient.post(
      url,
      credentials.token,
      data: json.encode(
        {
          'transactions': transactionIds
              .map((transactionId) => {
                    'id': transactionId,
                    if (vendorId.isNotEmpty) 'vendor_id': vendorId,
                    if (categoryId.isNotEmpty) 'ninja_category_id': categoryId,
                  })
              .toList()
        },
      ),
    );

    final TransactionListResponse transactionResponse = serializers
        .deserializeWith(TransactionListResponse.serializer, response)!;

    return transactionResponse.data;
  }

  Future<TransactionEntity> linkToPayment(
      Credentials credentials, String? transactionId, String paymentId) async {
    final url = credentials.url+ '/bank_transactions/match';
    final dynamic response = await webClient.post(
      url,
      credentials.token,
      data: json.encode(
        {
          'transactions': [
            {
              'id': transactionId,
              'payment_id': paymentId,
            }
          ],
        },
      ),
    );

    final TransactionListResponse transactionResponse = serializers
        .deserializeWith(TransactionListResponse.serializer, response)!;

    return transactionResponse.data.first;
  }

  Future<TransactionEntity> linkToExpense(
      Credentials credentials, String? transactionId, String expenseId) async {
    final url = credentials.url+ '/bank_transactions/match';
    final dynamic response = await webClient.post(
      url,
      credentials.token,
      data: json.encode(
        {
          'transactions': [
            {
              'id': transactionId,
              'expense_id': expenseId,
            }
          ],
        },
      ),
    );

    final TransactionListResponse transactionResponse = serializers
        .deserializeWith(TransactionListResponse.serializer, response)!;

    return transactionResponse.data.first;
  }

  Future<TransactionEntity> saveData(
      Credentials credentials, TransactionEntity transaction) async {
    final data =
        serializers.serializeWith(TransactionEntity.serializer, transaction);
    dynamic response;

    if (transaction.isNew) {
      response = await webClient.post(
          credentials.url+ '/bank_transactions', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/bank_transactions/${transaction.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final TransactionItemResponse transactionResponse = serializers
        .deserializeWith(TransactionItemResponse.serializer, response)!;

    return transactionResponse.data;
  }
}
