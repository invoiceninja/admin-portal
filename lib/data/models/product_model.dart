import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/models/invoice_model.dart';

part 'product_model.g.dart';

abstract class ProductListResponse implements Built<ProductListResponse, ProductListResponseBuilder> {

  BuiltList<ProductEntity> get data;

  ProductListResponse._();
  factory ProductListResponse([updates(ProductListResponseBuilder b)]) = _$ProductListResponse;
  static Serializer<ProductListResponse> get serializer => _$productListResponseSerializer;
}

abstract class ProductItemResponse implements Built<ProductItemResponse, ProductItemResponseBuilder> {

  ProductEntity get data;

  ProductItemResponse._();
  factory ProductItemResponse([updates(ProductItemResponseBuilder b)]) = _$ProductItemResponse;
  static Serializer<ProductItemResponse> get serializer => _$productItemResponseSerializer;
}

class ProductFields {
  static const String productKey = 'productKey';
  static const String notes = 'notes';
  static const String cost = 'cost';
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class ProductEntity extends Object with BaseEntity implements Built<ProductEntity, ProductEntityBuilder> {

  static int counter = 0;
  factory ProductEntity() {
    return _$ProductEntity._(
        id: --ProductEntity.counter,
        productKey: '',
        notes: '',
        cost: 0.0,
        taxName1: '',
        taxRate1: 0.0,
        taxName2: '',
        taxRate2: 0.0,
        customValue1: '',
        customValue2: '',
        updatedAt: 0,
        archivedAt: 0,
        isDeleted: false,
    );
  }

  @BuiltValueField(wireName: 'product_key')
  String get productKey;
  
  String get notes;
  
  double get cost;
  
  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;
  
  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;
  
  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;
  
  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;
  
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;
  
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  String get listDisplayName {
    return productKey;
  }

  int compareTo(ProductEntity product, String sortField, bool sortAscending) {
    int response = 0;
    ProductEntity productA = sortAscending ? this : product;
    ProductEntity productB = sortAscending ? product: this;

    switch (sortField) {
      case ProductFields.cost:
        response = productA.cost.compareTo(productB.cost);
    }

    if (response == 0) {
      return productA.productKey.toLowerCase().compareTo(productB.productKey.toLowerCase());
    } else {
      return response;
    }
  }

  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    search = search.toLowerCase();

    return productKey.toLowerCase().contains(search) || notes.toLowerCase().contains(search);
  }

  ProductEntity._();
  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
