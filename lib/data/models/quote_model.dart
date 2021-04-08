import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'quote_model.g.dart';

abstract class QuoteListResponse
    implements Built<QuoteListResponse, QuoteListResponseBuilder> {
  factory QuoteListResponse([void updates(QuoteListResponseBuilder b)]) =
      _$QuoteListResponse;

  QuoteListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<InvoiceEntity> get data;

  static Serializer<QuoteListResponse> get serializer =>
      _$quoteListResponseSerializer;
}

abstract class QuoteItemResponse
    implements Built<QuoteItemResponse, QuoteItemResponseBuilder> {
  factory QuoteItemResponse([void updates(QuoteItemResponseBuilder b)]) =
      _$QuoteItemResponse;

  QuoteItemResponse._();

  @override
  @memoized
  int get hashCode;

  InvoiceEntity get data;

  static Serializer<QuoteItemResponse> get serializer =>
      _$quoteItemResponseSerializer;
}

class QuoteFields {
  static const String total = 'total';
  static const String amount = 'amount';
  static const String balanceDue = 'balance_due';
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String status = 'status';
  static const String statusId = 'status_id';
  static const String number = 'number';
  static const String discount = 'discount';
  static const String poNumber = 'po_number';
  static const String date = 'date';
  static const String validUntil = 'valid_until';
  static const String terms = 'terms';
  static const String footer = 'footer';
  static const String partial = 'partial';
  static const String partialDueDate = 'partial_due_date';
  static const String publicNotes = 'public_notes';
  static const String privateNotes = 'private_notes';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String documents = 'documents';
  static const String taxAmount = 'tax_amount';
  static const String exchangeRate = 'exchange_rate';
  static const String isViewed = 'is_viewed';
}
