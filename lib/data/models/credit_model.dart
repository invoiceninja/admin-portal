// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'credit_model.g.dart';

abstract class CreditListResponse
    implements Built<CreditListResponse, CreditListResponseBuilder> {
  factory CreditListResponse([void updates(CreditListResponseBuilder b)]) =
      _$CreditListResponse;

  CreditListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<InvoiceEntity> get data;

  static Serializer<CreditListResponse> get serializer =>
      _$creditListResponseSerializer;
}

abstract class CreditItemResponse
    implements Built<CreditItemResponse, CreditItemResponseBuilder> {
  factory CreditItemResponse([void updates(CreditItemResponseBuilder b)]) =
      _$CreditItemResponse;

  CreditItemResponse._();

  @override
  @memoized
  int get hashCode;

  InvoiceEntity get data;

  static Serializer<CreditItemResponse> get serializer =>
      _$creditItemResponseSerializer;
}

class CreditFields {
  static const String total = 'total';
  static const String amount = 'amount';
  static const String balance = 'balance';
  static const String remaining = 'remaining';
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String status = 'status';
  static const String statusId = 'status_id';
  static const String number = 'number';
  static const String discount = 'discount';
  static const String poNumber = 'po_number';
  static const String date = 'date';
  static const String validUntil = 'valid_until';
  static const String lastSentDate = 'last_sent_date';
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
  static const String project = 'project';
  static const String vendor = 'vendor';
  static const String contactName = 'contact_name';
  static const String contactEmail = 'contact_email';
  static const String clientCity = 'client_city';
  static const String clientState = 'client_state';
  static const String clientPostalCode = 'client_postal_code';
  static const String clientCountry = 'client_country';
}
