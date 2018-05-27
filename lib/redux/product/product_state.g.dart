// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_state.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<ProductState> _$productStateSerializer =
    new _$ProductStateSerializer();

class _$ProductStateSerializer implements StructuredSerializer<ProductState> {
  @override
  final Iterable<Type> types = const [ProductState, _$ProductState];
  @override
  final String wireName = 'ProductState';

  @override
  Iterable serialize(Serializers serializers, ProductState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'lastUpdated',
      serializers.serialize(object.lastUpdated,
          specifiedType: const FullType(int)),
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(ProductEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  ProductState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ProductStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(ProductEntity)
              ])) as BuiltMap);
          break;
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ProductState extends ProductState {
  @override
  final bool isLoading;
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, ProductEntity> map;
  @override
  final BuiltList<int> list;

  factory _$ProductState([void updates(ProductStateBuilder b)]) =>
      (new ProductStateBuilder()..update(updates)).build();

  _$ProductState._({this.isLoading, this.lastUpdated, this.map, this.list})
      : super._() {
    if (isLoading == null)
      throw new BuiltValueNullFieldError('ProductState', 'isLoading');
    if (lastUpdated == null)
      throw new BuiltValueNullFieldError('ProductState', 'lastUpdated');
    if (map == null) throw new BuiltValueNullFieldError('ProductState', 'map');
    if (list == null)
      throw new BuiltValueNullFieldError('ProductState', 'list');
  }

  @override
  ProductState rebuild(void updates(ProductStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductStateBuilder toBuilder() => new ProductStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ProductState) return false;
    return isLoading == other.isLoading &&
        lastUpdated == other.lastUpdated &&
        map == other.map &&
        list == other.list;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, isLoading.hashCode), lastUpdated.hashCode),
            map.hashCode),
        list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductState')
          ..add('isLoading', isLoading)
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ProductStateBuilder
    implements Builder<ProductState, ProductStateBuilder> {
  _$ProductState _$v;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, ProductEntity> _map;
  MapBuilder<int, ProductEntity> get map =>
      _$this._map ??= new MapBuilder<int, ProductEntity>();
  set map(MapBuilder<int, ProductEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  ProductStateBuilder();

  ProductStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ProductState;
  }

  @override
  void update(void updates(ProductStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductState build() {
    _$ProductState _$result;
    try {
      _$result = _$v ??
          new _$ProductState._(
              isLoading: isLoading,
              lastUpdated: lastUpdated,
              map: map.build(),
              list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProductState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
