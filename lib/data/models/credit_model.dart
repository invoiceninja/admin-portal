import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'credit_model.g.dart';

abstract class CreditListResponse
    implements Built<CreditListResponse, CreditListResponseBuilder> {
  factory CreditListResponse([void updates(CreditListResponseBuilder b)]) =
      _$CreditListResponse;

  CreditListResponse._();

  BuiltList<InvoiceEntity> get data;

  static Serializer<CreditListResponse> get serializer =>
      _$creditListResponseSerializer;
}

abstract class CreditItemResponse
    implements Built<CreditItemResponse, CreditItemResponseBuilder> {
  factory CreditItemResponse([void updates(CreditItemResponseBuilder b)]) =
      _$CreditItemResponse;

  CreditItemResponse._();

  InvoiceEntity get data;

  static Serializer<CreditItemResponse> get serializer =>
      _$creditItemResponseSerializer;
}

class CreditFields {
  static const String amount = 'credit_total';
  static const String balance = 'balance_due';
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String statusId = 'status_id';
  static const String creditNumber = 'credit_number';
  static const String discount = 'discount';
  static const String poNumber = 'po_number';
  static const String date = 'credit_date';
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
}
