import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'invoice_status_model.g.dart';

abstract class InvoiceStatusListResponse implements Built<InvoiceStatusListResponse, InvoiceStatusListResponseBuilder> {

  factory InvoiceStatusListResponse([void updates(InvoiceStatusListResponseBuilder b)]) = _$InvoiceStatusListResponse;
  InvoiceStatusListResponse._();

  BuiltList<InvoiceStatusEntity> get data;

  static Serializer<InvoiceStatusListResponse> get serializer => _$invoiceStatusListResponseSerializer;
}

abstract class InvoiceStatusItemResponse implements Built<InvoiceStatusItemResponse, InvoiceStatusItemResponseBuilder> {

  factory InvoiceStatusItemResponse([void updates(InvoiceStatusItemResponseBuilder b)]) = _$InvoiceStatusItemResponse;
  InvoiceStatusItemResponse._();

  InvoiceStatusEntity get data;

  static Serializer<InvoiceStatusItemResponse> get serializer => _$invoiceStatusItemResponseSerializer;
}

class InvoiceStatusFields {
  static const String name = 'name';
  
}

abstract class InvoiceStatusEntity extends Object
    with EntityStatus
    implements Built<InvoiceStatusEntity, InvoiceStatusEntityBuilder> {

  factory InvoiceStatusEntity() {
    return _$InvoiceStatusEntity._(
      id: 0,
      name: '',
    );
  }

  InvoiceStatusEntity._();

  static Serializer<InvoiceStatusEntity> get serializer =>
      _$invoiceStatusEntitySerializer;
}

