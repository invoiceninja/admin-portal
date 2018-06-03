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

abstract class ProductEntity implements Built<ProductEntity, ProductEntityBuilder> {

  @nullable
  int get id;

  @nullable
  @BuiltValueField(wireName: 'product_key')
  String get productKey;

  @nullable
  String get notes;

  @nullable
  double get cost;

  @nullable
  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;

  @nullable
  @BuiltValueField(wireName: 'is_deleted')
  bool get isDeleted;

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
      return productA.productKey.compareTo(productB.productKey);
    } else {
      return response;
    }
  }

  bool isActive() {
    return this.archivedAt == null;
  }

  bool isArchived() {
    return this.archivedAt != null && ! isDeleted;
  }

  bool matchesStates(BuiltList<EntityState> states) {
    if (states.length == 0) {
      return true;
    }

    if (states.contains(EntityState.active) && isActive()) {
      return true;
    }

    if (states.contains(EntityState.archived) && isArchived()) {
      return true;
    }

    if (states.contains(EntityState.deleted) && isDeleted) {
      return true;
    }

    return false;
  }

  ProductEntity._();
  factory ProductEntity([updates(ProductEntityBuilder b)]) = _$ProductEntity;
  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
