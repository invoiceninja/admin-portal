// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_rate_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaxRateState> _$taxRateStateSerializer =
    new _$TaxRateStateSerializer();
Serializer<TaxRateUIState> _$taxRateUIStateSerializer =
    new _$TaxRateUIStateSerializer();

class _$TaxRateStateSerializer implements StructuredSerializer<TaxRateState> {
  @override
  final Iterable<Type> types = const [TaxRateState, _$TaxRateState];
  @override
  final String wireName = 'TaxRateState';

  @override
  Iterable<Object> serialize(Serializers serializers, TaxRateState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(TaxRateEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  TaxRateState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxRateStateBuilder();

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
                const FullType(TaxRateEntity)
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

class _$TaxRateUIStateSerializer
    implements StructuredSerializer<TaxRateUIState> {
  @override
  final Iterable<Type> types = const [TaxRateUIState, _$TaxRateUIState];
  @override
  final String wireName = 'TaxRateUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, TaxRateUIState object,
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
            specifiedType: const FullType(TaxRateEntity)));
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
  TaxRateUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxRateUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxRateEntity)) as TaxRateEntity);
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

class _$TaxRateState extends TaxRateState {
  @override
  final BuiltMap<String, TaxRateEntity> map;
  @override
  final BuiltList<String> list;

  factory _$TaxRateState([void Function(TaxRateStateBuilder) updates]) =>
      (new TaxRateStateBuilder()..update(updates)).build();

  _$TaxRateState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('TaxRateState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('TaxRateState', 'list');
    }
  }

  @override
  TaxRateState rebuild(void Function(TaxRateStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxRateStateBuilder toBuilder() => new TaxRateStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxRateState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaxRateState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TaxRateStateBuilder
    implements Builder<TaxRateState, TaxRateStateBuilder> {
  _$TaxRateState _$v;

  MapBuilder<String, TaxRateEntity> _map;
  MapBuilder<String, TaxRateEntity> get map =>
      _$this._map ??= new MapBuilder<String, TaxRateEntity>();
  set map(MapBuilder<String, TaxRateEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  TaxRateStateBuilder();

  TaxRateStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxRateState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaxRateState;
  }

  @override
  void update(void Function(TaxRateStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaxRateState build() {
    _$TaxRateState _$result;
    try {
      _$result =
          _$v ?? new _$TaxRateState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaxRateState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaxRateUIState extends TaxRateUIState {
  @override
  final TaxRateEntity editing;
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

  factory _$TaxRateUIState([void Function(TaxRateUIStateBuilder) updates]) =>
      (new TaxRateUIStateBuilder()..update(updates)).build();

  _$TaxRateUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('TaxRateUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('TaxRateUIState', 'tabIndex');
    }
  }

  @override
  TaxRateUIState rebuild(void Function(TaxRateUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxRateUIStateBuilder toBuilder() =>
      new TaxRateUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxRateUIState &&
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
    return (newBuiltValueToStringHelper('TaxRateUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class TaxRateUIStateBuilder
    implements Builder<TaxRateUIState, TaxRateUIStateBuilder> {
  _$TaxRateUIState _$v;

  TaxRateEntityBuilder _editing;
  TaxRateEntityBuilder get editing =>
      _$this._editing ??= new TaxRateEntityBuilder();
  set editing(TaxRateEntityBuilder editing) => _$this._editing = editing;

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

  TaxRateUIStateBuilder();

  TaxRateUIStateBuilder get _$this {
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
  void replace(TaxRateUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaxRateUIState;
  }

  @override
  void update(void Function(TaxRateUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaxRateUIState build() {
    _$TaxRateUIState _$result;
    try {
      _$result = _$v ??
          new _$TaxRateUIState._(
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
            'TaxRateUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
