// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'product_model.g.dart';

abstract class ProductListResponse
    implements Built<ProductListResponse, ProductListResponseBuilder> {
  factory ProductListResponse([void updates(ProductListResponseBuilder b)]) =
      _$ProductListResponse;

  ProductListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<ProductEntity> get data;

  static Serializer<ProductListResponse> get serializer =>
      _$productListResponseSerializer;
}

abstract class ProductItemResponse
    implements Built<ProductItemResponse, ProductItemResponseBuilder> {
  factory ProductItemResponse([void updates(ProductItemResponseBuilder b)]) =
      _$ProductItemResponse;

  ProductItemResponse._();

  @override
  @memoized
  int get hashCode;

  ProductEntity get data;

  static Serializer<ProductItemResponse> get serializer =>
      _$productItemResponseSerializer;
}

class ProductFields {
  static const String productKey = 'product_key';
  static const String description = 'description';
  static const String cost = 'cost';
  static const String price = 'price';
  static const String quantity = 'quantity';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String documents = 'documents';
  static const String taxRate1 = 'tax_rate1';
  static const String taxName1 = 'tax_name1';
  static const String taxRate2 = 'tax_rate2';
  static const String taxName2 = 'tax_name2';
  static const String taxRate3 = 'tax_rate3';
  static const String taxName3 = 'tax_name3';
  static const String stockQuantity = 'stock_quantity';
  static const String notificationThreshold = 'notification_threshold';
  static const String taxCategoryId = 'tax_category_id';
  static const String taxCategory = 'tax_category';
}

abstract class ProductEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ProductEntity, ProductEntityBuilder> {
  factory ProductEntity({String? id, AppState? state}) {
    return _$ProductEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      productKey: '',
      notes: '',
      cost: 0,
      price: 0,
      quantity: 1,
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
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
      stockQuantity: 0,
      stockNotificationThreshold: 0,
      stockNotification: true,
      imageUrl: '',
      maxQuantity: 0,
      taxCategoryId: kTaxCategoryPhysical,
      documents: BuiltList<DocumentEntity>(),
    );
  }

  ProductEntity._();

  @override
  @memoized
  int get hashCode;

  ProductEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..documents.clear()
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

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @BuiltValueField(wireName: 'in_stock_quantity')
  int get stockQuantity;

  @BuiltValueField(wireName: 'stock_notification_threshold')
  int get stockNotificationThreshold;

  @BuiltValueField(wireName: 'stock_notification')
  bool get stockNotification;

  @BuiltValueField(wireName: 'product_image')
  String get imageUrl;

  @BuiltValueField(wireName: 'max_quantity')
  int get maxQuantity;

  @BuiltValueField(wireName: 'tax_id')
  String get taxCategoryId;

  BuiltList<DocumentEntity> get documents;

  @override
  String get listDisplayName {
    return productKey;
  }

  @override
  double get listDisplayAmount => price;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  int compareTo(
    ProductEntity? product, [
    String? sortField,
    bool sortAscending = true,
    BuiltMap<String, UserEntity>? userMap,
  ]) {
    int response = 0;
    final ProductEntity? productA = sortAscending ? this : product;
    final ProductEntity? productB = sortAscending ? product : this;

    switch (sortField) {
      case ProductFields.productKey:
        response = productA!.productKey
            .toLowerCase()
            .compareTo(productB!.productKey.toLowerCase());
        break;
      case ProductFields.price:
        response = productA!.price.compareTo(productB!.price);
        break;
      case ProductFields.cost:
        response = productA!.cost.compareTo(productB!.cost);
        break;
      case ProductFields.quantity:
        response = productA!.quantity.compareTo(productB!.quantity);
        break;
      case ProductFields.updatedAt:
        response = productA!.updatedAt.compareTo(productB!.updatedAt);
        break;
      case EntityFields.createdAt:
        response = productA!.createdAt.compareTo(productB!.createdAt);
        break;
      case ProductFields.archivedAt:
        response = productA!.archivedAt.compareTo(productB!.archivedAt);
        break;
      case ProductFields.description:
        response = productA!.notes
            .toLowerCase()
            .compareTo(productB!.notes.toLowerCase());
        break;
      case EntityFields.assignedTo:
        final userA = userMap![productA!.assignedUserId] ?? UserEntity();
        final userB = userMap[productB!.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap![productA!.createdUserId] ?? UserEntity();
        final userB = userMap[productB!.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.state:
        final stateA = EntityState.valueOf(productA!.entityState);
        final stateB = EntityState.valueOf(productB!.entityState);
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case ProductFields.customValue1:
        response = productA!.customValue1
            .toLowerCase()
            .compareTo(productB!.customValue1.toLowerCase());
        break;
      case ProductFields.customValue2:
        response = productA!.customValue2
            .toLowerCase()
            .compareTo(productB!.customValue2.toLowerCase());
        break;
      case ProductFields.customValue3:
        response = productA!.customValue3
            .toLowerCase()
            .compareTo(productB!.customValue3.toLowerCase());
        break;
      case ProductFields.customValue4:
        response = productA!.customValue4
            .toLowerCase()
            .compareTo(productB!.customValue4.toLowerCase());
        break;
      case ProductFields.documents:
        response =
            productA!.documents.length.compareTo(productB!.documents.length);
        break;
      default:
        print('## ERROR: sort by product.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      response = productA!.price.compareTo(productB!.price);
    }

    return response;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        productKey,
        notes,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        notes,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted!) {
      if (!multiselect && includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany!.canCreate(EntityType.invoice) && !isDeleted!) {
        actions.add(EntityAction.newInvoice);
      }

      if (userCompany.canCreate(EntityType.purchaseOrder) && !isDeleted!) {
        actions.add(EntityAction.newPurchaseOrder);
      }

      final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
      final company = store.state.company;

      if (company.calculateTaxes) {
        actions.add(EntityAction.setTaxCategory);
      }
    }

    if (userCompany!.canCreate(EntityType.product) && !multiselect) {
      actions.add(EntityAction.clone);
    }

    if (!isDeleted! && multiselect) {
      actions.add(EntityAction.documents);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  // ignore: unused_element
  static void _initializeBuilder(ProductEntityBuilder builder) => builder
    ..stockQuantity = 0
    ..stockNotification = true
    ..stockNotificationThreshold = 0
    ..imageUrl = ''
    ..maxQuantity = 0
    ..taxCategoryId = kTaxCategoryPhysical;

  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
