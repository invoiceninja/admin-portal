import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

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

  @nullable
  @BuiltValueField(wireName: 'product_key')
  String get productKey;

  @nullable
  String get notes;

  @nullable
  double get cost;

  @nullable
  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @nullable
  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @nullable
  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @nullable
  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

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
  factory ProductEntity([updates(ProductEntityBuilder b)]) = _$ProductEntity;
  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
