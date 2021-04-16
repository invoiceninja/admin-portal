// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductState> _$productStateSerializer =
    new _$ProductStateSerializer();
Serializer<ProductUIState> _$productUIStateSerializer =
    new _$ProductUIStateSerializer();

class _$ProductStateSerializer implements StructuredSerializer<ProductState> {
  @override
  final Iterable<Type> types = const [ProductState, _$ProductState];
  @override
  final String wireName = 'ProductState';

  @override
  Iterable<Object> serialize(Serializers serializers, ProductState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(ProductEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  ProductState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(ProductEntity)
              ])));
          break;
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$ProductUIStateSerializer
    implements StructuredSerializer<ProductUIState> {
  @override
  final Iterable<Type> types = const [ProductUIState, _$ProductUIState];
  @override
  final String wireName = 'ProductUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, ProductUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'listUIState',
      serializers.serialize(object.listUIState,
          specifiedType: const FullType(ListUIState)),
      'tabIndex',
      serializers.serialize(object.tabIndex,
          specifiedType: const FullType(int)),
    ];
    if (object.editing != null) {
      result
        ..add('editing')
        ..add(serializers.serialize(object.editing,
            specifiedType: const FullType(ProductEntity)));
    }
    if (object.selectedId != null) {
      result
        ..add('selectedId')
        ..add(serializers.serialize(object.selectedId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProductUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProductEntity)) as ProductEntity);
          break;
        case 'listUIState':
          result.listUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ListUIState)) as ListUIState);
          break;
        case 'selectedId':
          result.selectedId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tabIndex':
          result.tabIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductState extends ProductState {
  @override
  final BuiltMap<String, ProductEntity> map;
  @override
  final BuiltList<String> list;

  factory _$ProductState([void Function(ProductStateBuilder) updates]) =>
      (new ProductStateBuilder()..update(updates)).build();

  _$ProductState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('ProductState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('ProductState', 'list');
    }
  }

  @override
  ProductState rebuild(void Function(ProductStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductStateBuilder toBuilder() => new ProductStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ProductStateBuilder
    implements Builder<ProductState, ProductStateBuilder> {
  _$ProductState _$v;

  MapBuilder<String, ProductEntity> _map;
  MapBuilder<String, ProductEntity> get map =>
      _$this._map ??= new MapBuilder<String, ProductEntity>();
  set map(MapBuilder<String, ProductEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  ProductStateBuilder();

  ProductStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProductState;
  }

  @override
  void update(void Function(ProductStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductState build() {
    _$ProductState _$result;
    try {
      _$result =
          _$v ?? new _$ProductState._(map: map.build(), list: list.build());
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

class _$ProductUIState extends ProductUIState {
  @override
  final ProductEntity editing;
  @override
  final ListUIState listUIState;
  @override
  final String selectedId;
  @override
  final int tabIndex;
  @override
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;

  factory _$ProductUIState([void Function(ProductUIStateBuilder) updates]) =>
      (new ProductUIStateBuilder()..update(updates)).build();

  _$ProductUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('ProductUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('ProductUIState', 'tabIndex');
    }
  }

  @override
  ProductUIState rebuild(void Function(ProductUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductUIStateBuilder toBuilder() =>
      new ProductUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductUIState &&
        editing == other.editing &&
        listUIState == other.listUIState &&
        selectedId == other.selectedId &&
        tabIndex == other.tabIndex &&
        saveCompleter == other.saveCompleter &&
        cancelCompleter == other.cancelCompleter;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, editing.hashCode), listUIState.hashCode),
                    selectedId.hashCode),
                tabIndex.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class ProductUIStateBuilder
    implements Builder<ProductUIState, ProductUIStateBuilder> {
  _$ProductUIState _$v;

  ProductEntityBuilder _editing;
  ProductEntityBuilder get editing =>
      _$this._editing ??= new ProductEntityBuilder();
  set editing(ProductEntityBuilder editing) => _$this._editing = editing;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  String _selectedId;
  String get selectedId => _$this._selectedId;
  set selectedId(String selectedId) => _$this._selectedId = selectedId;

  int _tabIndex;
  int get tabIndex => _$this._tabIndex;
  set tabIndex(int tabIndex) => _$this._tabIndex = tabIndex;

  Completer<SelectableEntity> _saveCompleter;
  Completer<SelectableEntity> get saveCompleter => _$this._saveCompleter;
  set saveCompleter(Completer<SelectableEntity> saveCompleter) =>
      _$this._saveCompleter = saveCompleter;

  Completer<Null> _cancelCompleter;
  Completer<Null> get cancelCompleter => _$this._cancelCompleter;
  set cancelCompleter(Completer<Null> cancelCompleter) =>
      _$this._cancelCompleter = cancelCompleter;

  ProductUIStateBuilder();

  ProductUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _listUIState = _$v.listUIState?.toBuilder();
      _selectedId = _$v.selectedId;
      _tabIndex = _$v.tabIndex;
      _saveCompleter = _$v.saveCompleter;
      _cancelCompleter = _$v.cancelCompleter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProductUIState;
  }

  @override
  void update(void Function(ProductUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductUIState build() {
    _$ProductUIState _$result;
    try {
      _$result = _$v ??
          new _$ProductUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              tabIndex: tabIndex,
              saveCompleter: saveCompleter,
              cancelCompleter: cancelCompleter);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();
        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProductUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
