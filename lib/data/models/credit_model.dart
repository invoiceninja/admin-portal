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
  static const String amount = 'amount';
  static const String balance = 'balance';
  static const String clientId = 'clientId';
  static const String client = 'client';
  static const String statusId = 'statusId';
  static const String number = 'number';
  static const String discount = 'discount';
  static const String poNumber = 'poNumber';
  static const String date = 'date';
  static const String appliedDate = 'appliedDate';
  static const String terms = 'terms';
  static const String footer = 'invoiceFooter';
  static const String partial = 'partial';
  static const String partialDueDate = 'partialDueDate';
  static const String publicNotes = 'publicNotes';
  static const String privateNotes = 'privateNotes';
  static const String invoiceTypeId = 'invoiceTypeId';
  static const String isRecurring = 'isRecurring';
  static const String frequencyId = 'frequencyId';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';

  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';
  static const String customValue3 = 'customValue3';
  static const String customValue4 = 'customValue4';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}
