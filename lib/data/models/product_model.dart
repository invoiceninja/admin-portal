import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/models/invoice_model.dart';

part 'product_model.g.dart';

abstract class ProductListResponse
    implements Built<ProductListResponse, ProductListResponseBuilder> {
  factory ProductListResponse([void updates(ProductListResponseBuilder b)]) =
      _$ProductListResponse;
  ProductListResponse._();

  BuiltList<ProductEntity> get data;

  static Serializer<ProductListResponse> get serializer =>
      _$productListResponseSerializer;
}

abstract class ProductItemResponse
    implements Built<ProductItemResponse, ProductItemResponseBuilder> {
  factory ProductItemResponse([void updates(ProductItemResponseBuilder b)]) =
      _$ProductItemResponse;
  ProductItemResponse._();

  ProductEntity get data;

  static Serializer<ProductItemResponse> get serializer =>
      _$productItemResponseSerializer;
}

class ProductFields {
  static const String productKey = 'productKey';
  static const String notes = 'notes';
  static const String cost = 'cost';
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';
}

abstract class ProductEntity extends Object
    with BaseEntity, ConvertToInvoiceItem
    implements Built<ProductEntity, ProductEntityBuilder> {
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
  ProductEntity._();

  @override
  EntityType get entityType {
    return EntityType.product;
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

  @override
  String get listDisplayName {
    return productKey;
  }

  @override
  double get listDisplayAmount => cost;

  @override
  InvoiceItemEntity get asInvoiceItem {
    return InvoiceItemEntity().rebuild((b) => b
      ..productKey = productKey
      ..notes = notes
      ..cost = cost
      ..qty = 1.0
      ..customValue1 = customValue1
      ..customValue2 = customValue2
      ..taxName1 = taxName1
      ..taxRate1 = taxRate1
      ..taxName2 = taxName2
      ..taxRate2 = taxRate2);
  }

  int compareTo(ProductEntity product,
      [String sortField, bool sortAscending = true]) {
    int response = 0;
    final ProductEntity productA = sortAscending ? this : product;
    final ProductEntity productB = sortAscending ? product : this;

    switch (sortField) {
      case ProductFields.cost:
        response = productA.cost.compareTo(productB.cost);
        break;
      case ProductFields.updatedAt:
        response = productA.updatedAt.compareTo(productB.updatedAt);
        break;
    }

    if (response == 0) {
      return productA.productKey
          .toLowerCase()
          .compareTo(productB.productKey.toLowerCase());
    } else {
      return response;
    }
  }

  @override
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    search = search.toLowerCase();

    if (productKey.toLowerCase().contains(search)) {
      return true;
    } else if (notes.toLowerCase().contains(search)) {
      return true;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(search)) {
      return true;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(search)) {
      return true;
    }

    return false;
  }

  @override
  String matchesSearchValue(String search) {
    if (search == null || search.isEmpty) {
      return null;
    }

    search = search.toLowerCase();
    if (notes.toLowerCase().contains(search)) {
      return notes;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(search)) {
      return customValue1;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(search)) {
      return customValue2;
    }
    return null;
  }

  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
