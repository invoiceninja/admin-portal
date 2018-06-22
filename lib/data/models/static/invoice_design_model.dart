import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_design_model.g.dart';

abstract class InvoiceDesignListResponse implements Built<InvoiceDesignListResponse, InvoiceDesignListResponseBuilder> {

  BuiltList<InvoiceDesignEntity> get data;

  InvoiceDesignListResponse._();
  factory InvoiceDesignListResponse([updates(InvoiceDesignListResponseBuilder b)]) = _$InvoiceDesignListResponse;
  static Serializer<InvoiceDesignListResponse> get serializer => _$invoiceDesignListResponseSerializer;
}

abstract class InvoiceDesignItemResponse implements Built<InvoiceDesignItemResponse, InvoiceDesignItemResponseBuilder> {

  InvoiceDesignEntity get data;

  InvoiceDesignItemResponse._();
  factory InvoiceDesignItemResponse([updates(InvoiceDesignItemResponseBuilder b)]) = _$InvoiceDesignItemResponse;
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
      name: '',
      javascript: '',
      pdfmake: '',
    );
  }


  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'javascript')
  String get javascript;

  @BuiltValueField(wireName: 'pdfmake')
  String get pdfmake;
 
  InvoiceDesignEntity._();
  static Serializer<InvoiceDesignEntity> get serializer => _$invoiceDesignEntitySerializer;
}

