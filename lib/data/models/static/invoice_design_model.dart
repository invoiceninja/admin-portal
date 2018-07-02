import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_design_model.g.dart';

abstract class InvoiceDesignListResponse implements Built<InvoiceDesignListResponse, InvoiceDesignListResponseBuilder> {

  factory InvoiceDesignListResponse([void updates(InvoiceDesignListResponseBuilder b)]) = _$InvoiceDesignListResponse;
  InvoiceDesignListResponse._();

  BuiltList<InvoiceDesignEntity> get data;

  static Serializer<InvoiceDesignListResponse> get serializer => _$invoiceDesignListResponseSerializer;
}

abstract class InvoiceDesignItemResponse implements Built<InvoiceDesignItemResponse, InvoiceDesignItemResponseBuilder> {

  factory InvoiceDesignItemResponse([void updates(InvoiceDesignItemResponseBuilder b)]) = _$InvoiceDesignItemResponse;
  InvoiceDesignItemResponse._();

  InvoiceDesignEntity get data;

  static Serializer<InvoiceDesignItemResponse> get serializer => _$invoiceDesignItemResponseSerializer;
}

class InvoiceDesignFields {
  static const String name = 'name';
  static const String javascript = 'javascript';
  static const String pdfmake = 'pdfmake';
  
}

abstract class InvoiceDesignEntity implements Built<InvoiceDesignEntity, InvoiceDesignEntityBuilder> {

  factory InvoiceDesignEntity() {
    return _$InvoiceDesignEntity._(
      id: 0,
      name: '',
      javascript: '',
      pdfmake: '',
    );
  }
  InvoiceDesignEntity._();


  int get id;
  String get name;
  String get javascript;
  String get pdfmake;
 
  static Serializer<InvoiceDesignEntity> get serializer => _$invoiceDesignEntitySerializer;
}

