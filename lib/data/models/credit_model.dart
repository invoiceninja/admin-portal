import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

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
  static const String creditDate = 'creditDate';
  static const String creditNumber = 'creditNumber';
  static const String privateNotes = 'privateNotes';
  static const String publicNotes = 'publicNotes';
  static const String clientId = 'clientId';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}
