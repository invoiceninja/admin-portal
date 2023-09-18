// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductListResponse> _$productListResponseSerializer =
    new _$ProductListResponseSerializer();
Serializer<ProductItemResponse> _$productItemResponseSerializer =
    new _$ProductItemResponseSerializer();
Serializer<ProductEntity> _$productEntitySerializer =
    new _$ProductEntitySerializer();

class _$ProductListResponseSerializer
    implements StructuredSerializer<ProductListResponse> {
  @override
  final Iterable<Type> types = const [
    ProductListResponse,
    _$ProductListResponse
  ];
  @override
  final String wireName = 'ProductListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ProductListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ProductEntity)])),
    ];

    return result;
  }

  @override
  ProductListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProductEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ProductItemResponseSerializer
    implements StructuredSerializer<ProductItemResponse> {
  @override
  final Iterable<Type> types = const [
    ProductItemResponse,
    _$ProductItemResponse
  ];
  @override
  final String wireName = 'ProductItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ProductItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ProductEntity)),
    ];

    return result;
  }

  @override
  ProductItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProductEntity))! as ProductEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$ProductEntitySerializer implements StructuredSerializer<ProductEntity> {
  @override
  final Iterable<Type> types = const [ProductEntity, _$ProductEntity];
  @override
  final String wireName = 'ProductEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProductEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'product_key',
      serializers.serialize(object.productKey,
          specifiedType: const FullType(String)),
      'notes',
      serializers.serialize(object.notes,
          specifiedType: const FullType(String)),
      'cost',
      serializers.serialize(object.cost, specifiedType: const FullType(double)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'quantity',
      serializers.serialize(object.quantity,
          specifiedType: const FullType(double)),
      'tax_name1',
      serializers.serialize(object.taxName1,
          specifiedType: const FullType(String)),
      'tax_rate1',
      serializers.serialize(object.taxRate1,
          specifiedType: const FullType(double)),
      'tax_name2',
      serializers.serialize(object.taxName2,
          specifiedType: const FullType(String)),
      'tax_rate2',
      serializers.serialize(object.taxRate2,
          specifiedType: const FullType(double)),
      'tax_name3',
      serializers.serialize(object.taxName3,
          specifiedType: const FullType(String)),
      'tax_rate3',
      serializers.serialize(object.taxRate3,
          specifiedType: const FullType(double)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'in_stock_quantity',
      serializers.serialize(object.stockQuantity,
          specifiedType: const FullType(int)),
      'stock_notification_threshold',
      serializers.serialize(object.stockNotificationThreshold,
          specifiedType: const FullType(int)),
      'stock_notification',
      serializers.serialize(object.stockNotification,
          specifiedType: const FullType(bool)),
      'product_image',
      serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)),
      'max_quantity',
      serializers.serialize(object.maxQuantity,
          specifiedType: const FullType(int)),
      'tax_id',
      serializers.serialize(object.taxCategoryId,
          specifiedType: const FullType(String)),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProductEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'product_key':
          result.productKey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'cost':
          result.cost = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name2':
          result.taxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name3':
          result.taxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate3':
          result.taxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'in_stock_quantity':
          result.stockQuantity = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'stock_notification_threshold':
          result.stockNotificationThreshold = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'stock_notification':
          result.stockNotification = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'product_image':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'max_quantity':
          result.maxQuantity = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'tax_id':
          result.taxCategoryId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductListResponse extends ProductListResponse {
  @override
  final BuiltList<ProductEntity> data;

  factory _$ProductListResponse(
          [void Function(ProductListResponseBuilder)? updates]) =>
      (new ProductListResponseBuilder()..update(updates))._build();

  _$ProductListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'ProductListResponse', 'data');
  }

  @override
  ProductListResponse rebuild(
          void Function(ProductListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductListResponseBuilder toBuilder() =>
      new ProductListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductListResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductListResponse')
          ..add('data', data))
        .toString();
  }
}

class ProductListResponseBuilder
    implements Builder<ProductListResponse, ProductListResponseBuilder> {
  _$ProductListResponse? _$v;

  ListBuilder<ProductEntity>? _data;
  ListBuilder<ProductEntity> get data =>
      _$this._data ??= new ListBuilder<ProductEntity>();
  set data(ListBuilder<ProductEntity>? data) => _$this._data = data;

  ProductListResponseBuilder();

  ProductListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductListResponse;
  }

  @override
  void update(void Function(ProductListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductListResponse build() => _build();

  _$ProductListResponse _build() {
    _$ProductListResponse _$result;
    try {
      _$result = _$v ?? new _$ProductListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProductListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProductItemResponse extends ProductItemResponse {
  @override
  final ProductEntity data;

  factory _$ProductItemResponse(
          [void Function(ProductItemResponseBuilder)? updates]) =>
      (new ProductItemResponseBuilder()..update(updates))._build();

  _$ProductItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'ProductItemResponse', 'data');
  }

  @override
  ProductItemResponse rebuild(
          void Function(ProductItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductItemResponseBuilder toBuilder() =>
      new ProductItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductItemResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ProductItemResponseBuilder
    implements Builder<ProductItemResponse, ProductItemResponseBuilder> {
  _$ProductItemResponse? _$v;

  ProductEntityBuilder? _data;
  ProductEntityBuilder get data => _$this._data ??= new ProductEntityBuilder();
  set data(ProductEntityBuilder? data) => _$this._data = data;

  ProductItemResponseBuilder();

  ProductItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductItemResponse;
  }

  @override
  void update(void Function(ProductItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductItemResponse build() => _build();

  _$ProductItemResponse _build() {
    _$ProductItemResponse _$result;
    try {
      _$result = _$v ?? new _$ProductItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProductItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProductEntity extends ProductEntity {
  @override
  final String productKey;
  @override
  final String notes;
  @override
  final double cost;
  @override
  final double price;
  @override
  final double quantity;
  @override
  final String taxName1;
  @override
  final double taxRate1;
  @override
  final String taxName2;
  @override
  final double taxRate2;
  @override
  final String taxName3;
  @override
  final double taxRate3;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final int stockQuantity;
  @override
  final int stockNotificationThreshold;
  @override
  final bool stockNotification;
  @override
  final String imageUrl;
  @override
  final int maxQuantity;
  @override
  final String taxCategoryId;
  @override
  final BuiltList<DocumentEntity> documents;
  @override
  final bool? isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool? isDeleted;
  @override
  final String? createdUserId;
  @override
  final String? assignedUserId;
  @override
  final String id;

  factory _$ProductEntity([void Function(ProductEntityBuilder)? updates]) =>
      (new ProductEntityBuilder()..update(updates))._build();

  _$ProductEntity._(
      {required this.productKey,
      required this.notes,
      required this.cost,
      required this.price,
      required this.quantity,
      required this.taxName1,
      required this.taxRate1,
      required this.taxName2,
      required this.taxRate2,
      required this.taxName3,
      required this.taxRate3,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
      required this.stockQuantity,
      required this.stockNotificationThreshold,
      required this.stockNotification,
      required this.imageUrl,
      required this.maxQuantity,
      required this.taxCategoryId,
      required this.documents,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        productKey, r'ProductEntity', 'productKey');
    BuiltValueNullFieldError.checkNotNull(notes, r'ProductEntity', 'notes');
    BuiltValueNullFieldError.checkNotNull(cost, r'ProductEntity', 'cost');
    BuiltValueNullFieldError.checkNotNull(price, r'ProductEntity', 'price');
    BuiltValueNullFieldError.checkNotNull(
        quantity, r'ProductEntity', 'quantity');
    BuiltValueNullFieldError.checkNotNull(
        taxName1, r'ProductEntity', 'taxName1');
    BuiltValueNullFieldError.checkNotNull(
        taxRate1, r'ProductEntity', 'taxRate1');
    BuiltValueNullFieldError.checkNotNull(
        taxName2, r'ProductEntity', 'taxName2');
    BuiltValueNullFieldError.checkNotNull(
        taxRate2, r'ProductEntity', 'taxRate2');
    BuiltValueNullFieldError.checkNotNull(
        taxName3, r'ProductEntity', 'taxName3');
    BuiltValueNullFieldError.checkNotNull(
        taxRate3, r'ProductEntity', 'taxRate3');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'ProductEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'ProductEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'ProductEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'ProductEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        stockQuantity, r'ProductEntity', 'stockQuantity');
    BuiltValueNullFieldError.checkNotNull(stockNotificationThreshold,
        r'ProductEntity', 'stockNotificationThreshold');
    BuiltValueNullFieldError.checkNotNull(
        stockNotification, r'ProductEntity', 'stockNotification');
    BuiltValueNullFieldError.checkNotNull(
        imageUrl, r'ProductEntity', 'imageUrl');
    BuiltValueNullFieldError.checkNotNull(
        maxQuantity, r'ProductEntity', 'maxQuantity');
    BuiltValueNullFieldError.checkNotNull(
        taxCategoryId, r'ProductEntity', 'taxCategoryId');
    BuiltValueNullFieldError.checkNotNull(
        documents, r'ProductEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'ProductEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'ProductEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'ProductEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'ProductEntity', 'id');
  }

  @override
  ProductEntity rebuild(void Function(ProductEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductEntityBuilder toBuilder() => new ProductEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductEntity &&
        productKey == other.productKey &&
        notes == other.notes &&
        cost == other.cost &&
        price == other.price &&
        quantity == other.quantity &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxName2 == other.taxName2 &&
        taxRate2 == other.taxRate2 &&
        taxName3 == other.taxName3 &&
        taxRate3 == other.taxRate3 &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        stockQuantity == other.stockQuantity &&
        stockNotificationThreshold == other.stockNotificationThreshold &&
        stockNotification == other.stockNotification &&
        imageUrl == other.imageUrl &&
        maxQuantity == other.maxQuantity &&
        taxCategoryId == other.taxCategoryId &&
        documents == other.documents &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, productKey.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, cost.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, taxName1.hashCode);
    _$hash = $jc(_$hash, taxRate1.hashCode);
    _$hash = $jc(_$hash, taxName2.hashCode);
    _$hash = $jc(_$hash, taxRate2.hashCode);
    _$hash = $jc(_$hash, taxName3.hashCode);
    _$hash = $jc(_$hash, taxRate3.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, stockQuantity.hashCode);
    _$hash = $jc(_$hash, stockNotificationThreshold.hashCode);
    _$hash = $jc(_$hash, stockNotification.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, maxQuantity.hashCode);
    _$hash = $jc(_$hash, taxCategoryId.hashCode);
    _$hash = $jc(_$hash, documents.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductEntity')
          ..add('productKey', productKey)
          ..add('notes', notes)
          ..add('cost', cost)
          ..add('price', price)
          ..add('quantity', quantity)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxName2', taxName2)
          ..add('taxRate2', taxRate2)
          ..add('taxName3', taxName3)
          ..add('taxRate3', taxRate3)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('stockQuantity', stockQuantity)
          ..add('stockNotificationThreshold', stockNotificationThreshold)
          ..add('stockNotification', stockNotification)
          ..add('imageUrl', imageUrl)
          ..add('maxQuantity', maxQuantity)
          ..add('taxCategoryId', taxCategoryId)
          ..add('documents', documents)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('id', id))
        .toString();
  }
}

class ProductEntityBuilder
    implements Builder<ProductEntity, ProductEntityBuilder> {
  _$ProductEntity? _$v;

  String? _productKey;
  String? get productKey => _$this._productKey;
  set productKey(String? productKey) => _$this._productKey = productKey;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  double? _cost;
  double? get cost => _$this._cost;
  set cost(double? cost) => _$this._cost = cost;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  double? _quantity;
  double? get quantity => _$this._quantity;
  set quantity(double? quantity) => _$this._quantity = quantity;

  String? _taxName1;
  String? get taxName1 => _$this._taxName1;
  set taxName1(String? taxName1) => _$this._taxName1 = taxName1;

  double? _taxRate1;
  double? get taxRate1 => _$this._taxRate1;
  set taxRate1(double? taxRate1) => _$this._taxRate1 = taxRate1;

  String? _taxName2;
  String? get taxName2 => _$this._taxName2;
  set taxName2(String? taxName2) => _$this._taxName2 = taxName2;

  double? _taxRate2;
  double? get taxRate2 => _$this._taxRate2;
  set taxRate2(double? taxRate2) => _$this._taxRate2 = taxRate2;

  String? _taxName3;
  String? get taxName3 => _$this._taxName3;
  set taxName3(String? taxName3) => _$this._taxName3 = taxName3;

  double? _taxRate3;
  double? get taxRate3 => _$this._taxRate3;
  set taxRate3(double? taxRate3) => _$this._taxRate3 = taxRate3;

  String? _customValue1;
  String? get customValue1 => _$this._customValue1;
  set customValue1(String? customValue1) => _$this._customValue1 = customValue1;

  String? _customValue2;
  String? get customValue2 => _$this._customValue2;
  set customValue2(String? customValue2) => _$this._customValue2 = customValue2;

  String? _customValue3;
  String? get customValue3 => _$this._customValue3;
  set customValue3(String? customValue3) => _$this._customValue3 = customValue3;

  String? _customValue4;
  String? get customValue4 => _$this._customValue4;
  set customValue4(String? customValue4) => _$this._customValue4 = customValue4;

  int? _stockQuantity;
  int? get stockQuantity => _$this._stockQuantity;
  set stockQuantity(int? stockQuantity) =>
      _$this._stockQuantity = stockQuantity;

  int? _stockNotificationThreshold;
  int? get stockNotificationThreshold => _$this._stockNotificationThreshold;
  set stockNotificationThreshold(int? stockNotificationThreshold) =>
      _$this._stockNotificationThreshold = stockNotificationThreshold;

  bool? _stockNotification;
  bool? get stockNotification => _$this._stockNotification;
  set stockNotification(bool? stockNotification) =>
      _$this._stockNotification = stockNotification;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _maxQuantity;
  int? get maxQuantity => _$this._maxQuantity;
  set maxQuantity(int? maxQuantity) => _$this._maxQuantity = maxQuantity;

  String? _taxCategoryId;
  String? get taxCategoryId => _$this._taxCategoryId;
  set taxCategoryId(String? taxCategoryId) =>
      _$this._taxCategoryId = taxCategoryId;

  ListBuilder<DocumentEntity>? _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity>? documents) =>
      _$this._documents = documents;

  bool? _isChanged;
  bool? get isChanged => _$this._isChanged;
  set isChanged(bool? isChanged) => _$this._isChanged = isChanged;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  int? _archivedAt;
  int? get archivedAt => _$this._archivedAt;
  set archivedAt(int? archivedAt) => _$this._archivedAt = archivedAt;

  bool? _isDeleted;
  bool? get isDeleted => _$this._isDeleted;
  set isDeleted(bool? isDeleted) => _$this._isDeleted = isDeleted;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  String? _assignedUserId;
  String? get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String? assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ProductEntityBuilder() {
    ProductEntity._initializeBuilder(this);
  }

  ProductEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productKey = $v.productKey;
      _notes = $v.notes;
      _cost = $v.cost;
      _price = $v.price;
      _quantity = $v.quantity;
      _taxName1 = $v.taxName1;
      _taxRate1 = $v.taxRate1;
      _taxName2 = $v.taxName2;
      _taxRate2 = $v.taxRate2;
      _taxName3 = $v.taxName3;
      _taxRate3 = $v.taxRate3;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _stockQuantity = $v.stockQuantity;
      _stockNotificationThreshold = $v.stockNotificationThreshold;
      _stockNotification = $v.stockNotification;
      _imageUrl = $v.imageUrl;
      _maxQuantity = $v.maxQuantity;
      _taxCategoryId = $v.taxCategoryId;
      _documents = $v.documents.toBuilder();
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductEntity;
  }

  @override
  void update(void Function(ProductEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductEntity build() => _build();

  _$ProductEntity _build() {
    _$ProductEntity _$result;
    try {
      _$result = _$v ??
          new _$ProductEntity._(
              productKey: BuiltValueNullFieldError.checkNotNull(
                  productKey, r'ProductEntity', 'productKey'),
              notes: BuiltValueNullFieldError.checkNotNull(
                  notes, r'ProductEntity', 'notes'),
              cost: BuiltValueNullFieldError.checkNotNull(
                  cost, r'ProductEntity', 'cost'),
              price: BuiltValueNullFieldError.checkNotNull(
                  price, r'ProductEntity', 'price'),
              quantity: BuiltValueNullFieldError.checkNotNull(
                  quantity, r'ProductEntity', 'quantity'),
              taxName1: BuiltValueNullFieldError.checkNotNull(
                  taxName1, r'ProductEntity', 'taxName1'),
              taxRate1: BuiltValueNullFieldError.checkNotNull(
                  taxRate1, r'ProductEntity', 'taxRate1'),
              taxName2: BuiltValueNullFieldError.checkNotNull(
                  taxName2, r'ProductEntity', 'taxName2'),
              taxRate2: BuiltValueNullFieldError.checkNotNull(
                  taxRate2, r'ProductEntity', 'taxRate2'),
              taxName3: BuiltValueNullFieldError.checkNotNull(taxName3, r'ProductEntity', 'taxName3'),
              taxRate3: BuiltValueNullFieldError.checkNotNull(taxRate3, r'ProductEntity', 'taxRate3'),
              customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, r'ProductEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, r'ProductEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'ProductEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'ProductEntity', 'customValue4'),
              stockQuantity: BuiltValueNullFieldError.checkNotNull(stockQuantity, r'ProductEntity', 'stockQuantity'),
              stockNotificationThreshold: BuiltValueNullFieldError.checkNotNull(stockNotificationThreshold, r'ProductEntity', 'stockNotificationThreshold'),
              stockNotification: BuiltValueNullFieldError.checkNotNull(stockNotification, r'ProductEntity', 'stockNotification'),
              imageUrl: BuiltValueNullFieldError.checkNotNull(imageUrl, r'ProductEntity', 'imageUrl'),
              maxQuantity: BuiltValueNullFieldError.checkNotNull(maxQuantity, r'ProductEntity', 'maxQuantity'),
              taxCategoryId: BuiltValueNullFieldError.checkNotNull(taxCategoryId, r'ProductEntity', 'taxCategoryId'),
              documents: documents.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'ProductEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'ProductEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'ProductEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, r'ProductEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'documents';
        documents.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProductEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
