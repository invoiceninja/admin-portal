import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_status_model.g.dart';

abstract class InvoiceStatusListResponse implements Built<InvoiceStatusListResponse, InvoiceStatusListResponseBuilder> {

  BuiltList<InvoiceStatusEntity> get data;

  InvoiceStatusListResponse._();
  factory InvoiceStatusListResponse([updates(InvoiceStatusListResponseBuilder b)]) = _$InvoiceStatusListResponse;
  static Serializer<InvoiceStatusListResponse> get serializer => _$invoiceStatusListResponseSerializer;
}

abstract class InvoiceStatusItemResponse implements Built<InvoiceStatusItemResponse, InvoiceStatusItemResponseBuilder> {

  InvoiceStatusEntity get data;

  InvoiceStatusItemResponse._();
  factory InvoiceStatusItemResponse([updates(InvoiceStatusItemResponseBuilder b)]) = _$InvoiceStatusItemResponse;
  static Serializer<InvoiceStatusItemResponse> get serializer => _$invoiceStatusItemResponseSerializer;
}

class InvoiceStatusFields {
  static const String name = 'name';
  
}

abstract class InvoiceStatusEntity implements Built<InvoiceStatusEntity, InvoiceStatusEntityBuilder> {

  factory InvoiceStatusEntity() {
    return _$InvoiceStatusEntity._(
      id: 0,
      name: '',
    );
  }

  int get id;
  String get name;

  InvoiceStatusEntity._();
  static Serializer<InvoiceStatusEntity> get serializer => _$invoiceStatusEntitySerializer;
}

