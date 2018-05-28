import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product.g.dart';

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

abstract class ProductEntity implements Built<ProductEntity, ProductEntityBuilder> {

  int get id;

  @BuiltValueField(wireName: 'product_key')
  String get productKey;
  String get notes;
  double get cost;

  //@JsonKey(name: 'tax_name1')
  //String taxName1;
  //@JsonKey(name: 'tax_rate1')
  //double taxRate1;
  //@JsonKey(name: 'tax_name2')
  //String taxName2;
  //@JsonKey(name: 'tax_rate2')
  //double taxRate2;
  //@JsonKey(name: 'updated_at')
  //int updatedAt;
  //@JsonKey(name: 'archived_at')
  //int archivedAt;
  //@JsonKey(name: 'custom_value1')
  //String customValue1;
  //@JsonKey(name: 'custom_value2')
  //String customValue2;
  //@JsonKey(name: 'is_deleted')
  //bool isDeleted;


  factory ProductEntity() {
    return _$ProductEntity._(
      id: 0,
      productKey: '',
      notes: '',
      cost: 0.0,
    );
  }

  ProductEntity._();
  //factory ProductEntity([updates(ProductEntityBuilder b)]) = _$ProductEntity;
  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
