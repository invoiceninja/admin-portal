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
  Iterable<Object> serialize(
      Serializers serializers, ProductListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ProductEntity)])),
    ];

    return result;
  }

  @override
  ProductListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProductEntity)]))
              as BuiltList<dynamic>);
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
  Iterable<Object> serialize(
      Serializers serializers, ProductItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ProductEntity)),
    ];

    return result;
  }

  @override
  ProductItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProductEntity)) as ProductEntity);
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
  Iterable<Object> serialize(Serializers serializers, ProductEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'product_key',
      serializers.serialize(object.productKey,
          specifiedType: const FullType(String)),
      'notes',
      serializers.serialize(object.notes,
          specifiedType: const FullType(String)),
      'cost',
      serializers.serialize(object.cost, specifiedType: const FullType(double)),
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
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
    ];
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.isOwner != null) {
      result
        ..add('is_owner')
        ..add(serializers.serialize(object.isOwner,
            specifiedType: const FullType(bool)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProductEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'product_key':
          result.productKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cost':
          result.cost = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name2':
          result.taxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
          [void Function(ProductListResponseBuilder) updates]) =>
      (new ProductListResponseBuilder()..update(updates)).build();

  _$ProductListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ProductListResponse', 'data');
    }
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

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductListResponse')
          ..add('data', data))
        .toString();
  }
}

class ProductListResponseBuilder
    implements Builder<ProductListResponse, ProductListResponseBuilder> {
  _$ProductListResponse _$v;

  ListBuilder<ProductEntity> _data;
  ListBuilder<ProductEntity> get data =>
      _$this._data ??= new ListBuilder<ProductEntity>();
  set data(ListBuilder<ProductEntity> data) => _$this._data = data;

  ProductListResponseBuilder();

  ProductListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProductListResponse;
  }

  @override
  void update(void Function(ProductListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductListResponse build() {
    _$ProductListResponse _$result;
    try {
      _$result = _$v ?? new _$ProductListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProductListResponse', _$failedField, e.toString());
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
          [void Function(ProductItemResponseBuilder) updates]) =>
      (new ProductItemResponseBuilder()..update(updates)).build();

  _$ProductItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ProductItemResponse', 'data');
    }
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

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ProductItemResponseBuilder
    implements Builder<ProductItemResponse, ProductItemResponseBuilder> {
  _$ProductItemResponse _$v;

  ProductEntityBuilder _data;
  ProductEntityBuilder get data => _$this._data ??= new ProductEntityBuilder();
  set data(ProductEntityBuilder data) => _$this._data = data;

  ProductItemResponseBuilder();

  ProductItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProductItemResponse;
  }

  @override
  void update(void Function(ProductItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductItemResponse build() {
    _$ProductItemResponse _$result;
    try {
      _$result = _$v ?? new _$ProductItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProductItemResponse', _$failedField, e.toString());
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
  final String customValue1;
  @override
  final String customValue2;
  @override
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final bool isOwner;
  @override
  final String id;

  factory _$ProductEntity([void Function(ProductEntityBuilder) updates]) =>
      (new ProductEntityBuilder()..update(updates)).build();

  _$ProductEntity._(
      {this.productKey,
      this.notes,
      this.cost,
      this.quantity,
      this.taxName1,
      this.taxRate1,
      this.taxName2,
      this.taxRate2,
      this.customValue1,
      this.customValue2,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (productKey == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'productKey');
    }
    if (notes == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'notes');
    }
    if (cost == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'cost');
    }
    if (quantity == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'quantity');
    }
    if (taxName1 == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'taxName1');
    }
    if (taxRate1 == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'taxRate1');
    }
    if (taxName2 == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'taxName2');
    }
    if (taxRate2 == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'taxRate2');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('ProductEntity', 'customValue2');
    }
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
        quantity == other.quantity &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxName2 == other.taxName2 &&
        taxRate2 == other.taxRate2 &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        isOwner == other.isOwner &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        0,
                                                                        productKey
                                                                            .hashCode),
                                                                    notes
                                                                        .hashCode),
                                                                cost.hashCode),
                                                            quantity.hashCode),
                                                        taxName1.hashCode),
                                                    taxRate1.hashCode),
                                                taxName2.hashCode),
                                            taxRate2.hashCode),
                                        customValue1.hashCode),
                                    customValue2.hashCode),
                                isChanged.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductEntity')
          ..add('productKey', productKey)
          ..add('notes', notes)
          ..add('cost', cost)
          ..add('quantity', quantity)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxName2', taxName2)
          ..add('taxRate2', taxRate2)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
          ..add('id', id))
        .toString();
  }
}

class ProductEntityBuilder
    implements Builder<ProductEntity, ProductEntityBuilder> {
  _$ProductEntity _$v;

  String _productKey;
  String get productKey => _$this._productKey;
  set productKey(String productKey) => _$this._productKey = productKey;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  double _cost;
  double get cost => _$this._cost;
  set cost(double cost) => _$this._cost = cost;

  double _quantity;
  double get quantity => _$this._quantity;
  set quantity(double quantity) => _$this._quantity = quantity;

  String _taxName1;
  String get taxName1 => _$this._taxName1;
  set taxName1(String taxName1) => _$this._taxName1 = taxName1;

  double _taxRate1;
  double get taxRate1 => _$this._taxRate1;
  set taxRate1(double taxRate1) => _$this._taxRate1 = taxRate1;

  String _taxName2;
  String get taxName2 => _$this._taxName2;
  set taxName2(String taxName2) => _$this._taxName2 = taxName2;

  double _taxRate2;
  double get taxRate2 => _$this._taxRate2;
  set taxRate2(double taxRate2) => _$this._taxRate2 = taxRate2;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ProductEntityBuilder();

  ProductEntityBuilder get _$this {
    if (_$v != null) {
      _productKey = _$v.productKey;
      _notes = _$v.notes;
      _cost = _$v.cost;
      _quantity = _$v.quantity;
      _taxName1 = _$v.taxName1;
      _taxRate1 = _$v.taxRate1;
      _taxName2 = _$v.taxName2;
      _taxRate2 = _$v.taxRate2;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _isOwner = _$v.isOwner;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProductEntity;
  }

  @override
  void update(void Function(ProductEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductEntity build() {
    final _$result = _$v ??
        new _$ProductEntity._(
            productKey: productKey,
            notes: notes,
            cost: cost,
            quantity: quantity,
            taxName1: taxName1,
            taxRate1: taxRate1,
            taxName2: taxName2,
            taxRate2: taxRate2,
            customValue1: customValue1,
            customValue2: customValue2,
            isChanged: isChanged,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            isOwner: isOwner,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
