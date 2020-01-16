import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

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
  static const String price = 'price';
  static const String quantity = 'quantity';
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';
  static const String customValue3 = 'customValue3';
  static const String customValue4 = 'customValue4';
}

abstract class ProductEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ProductEntity, ProductEntityBuilder> {
  factory ProductEntity({String id, AppState state}) {
    return _$ProductEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      productKey: '',
      notes: '',
      cost: 0,
      price: 0,
      quantity: (state?.company?.defaultQuantity ?? true) ? 1 : 0,
      taxName1: '',
      taxRate1: 0,
      taxName2: '',
      taxRate2: 0,
      taxName3: '',
      taxRate3: 0,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  ProductEntity._();

  ProductEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.product;
  }

  @BuiltValueField(wireName: 'product_key')
  String get productKey;

  String get notes;

  double get cost;

  double get price;

  double get quantity;

  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @BuiltValueField(wireName: 'tax_name3')
  String get taxName3;

  @BuiltValueField(wireName: 'tax_rate3')
  double get taxRate3;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @nullable
  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @override
  String get listDisplayName {
    return productKey;
  }

  @override
  double get listDisplayAmount => cost;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  int compareTo(ProductEntity product,
      [String sortField, bool sortAscending = true]) {
    int response = 0;
    final ProductEntity productA = sortAscending ? this : product;
    final ProductEntity productB = sortAscending ? product : this;

    switch (sortField) {
      case ProductFields.price:
        response = productA.price.compareTo(productB.price);
        break;
      case ProductFields.cost:
        response = productA.cost.compareTo(productB.cost);
        break;
      case ProductFields.updatedAt:
        response = productA.updatedAt.compareTo(productB.updatedAt);
        break;
      case ProductFields.notes:
        response = productA.notes
            .toLowerCase()
            .compareTo(productB.notes.toLowerCase());
        break;
      case ProductFields.customValue1:
        response = productA.customValue1
            .toLowerCase()
            .compareTo(productB.customValue1.toLowerCase());
        break;
      case ProductFields.customValue2:
        response = productA.customValue2
            .toLowerCase()
            .compareTo(productB.customValue2.toLowerCase());
        break;
      case ProductFields.customValue3:
        response = productA.customValue3
            .toLowerCase()
            .compareTo(productB.customValue3.toLowerCase());
        break;
      case ProductFields.customValue4:
        response = productA.customValue4
            .toLowerCase()
            .compareTo(productB.customValue4.toLowerCase());
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
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (productKey.toLowerCase().contains(filter)) {
      return true;
    } else if (notes.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue4.isNotEmpty &&
        customValue4.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();
    if (notes.toLowerCase().contains(filter)) {
      return notes;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return customValue2;
    }
    return null;
  }

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (!multiselect && includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany.canCreate(EntityType.invoice) && !isDeleted) {
        actions.add(EntityAction.newInvoice);
      }
    }

    if (userCompany.canCreate(EntityType.product) && !multiselect) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
