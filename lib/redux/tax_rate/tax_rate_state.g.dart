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
  Iterable<Object?> serialize(Serializers serializers, TaxRateState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
  TaxRateState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxRateStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TaxRateEntity)
              ]))!);
          break;
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(Serializers serializers, TaxRateUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'listUIState',
      serializers.serialize(object.listUIState,
          specifiedType: const FullType(ListUIState)),
      'tabIndex',
      serializers.serialize(object.tabIndex,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.editing;
    if (value != null) {
      result
        ..add('editing')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(TaxRateEntity)));
    }
    value = object.selectedId;
    if (value != null) {
      result
        ..add('selectedId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.forceSelected;
    if (value != null) {
      result
        ..add('forceSelected')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  TaxRateUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxRateUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxRateEntity))! as TaxRateEntity);
          break;
        case 'listUIState':
          result.listUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ListUIState))! as ListUIState);
          break;
        case 'selectedId':
          result.selectedId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'forceSelected':
          result.forceSelected = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'tabIndex':
          result.tabIndex = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
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

  factory _$TaxRateState([void Function(TaxRateStateBuilder)? updates]) =>
      (new TaxRateStateBuilder()..update(updates))._build();

  _$TaxRateState._({required this.map, required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'TaxRateState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, r'TaxRateState', 'list');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, map.hashCode);
    _$hash = $jc(_$hash, list.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxRateState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TaxRateStateBuilder
    implements Builder<TaxRateState, TaxRateStateBuilder> {
  _$TaxRateState? _$v;

  MapBuilder<String, TaxRateEntity>? _map;
  MapBuilder<String, TaxRateEntity> get map =>
      _$this._map ??= new MapBuilder<String, TaxRateEntity>();
  set map(MapBuilder<String, TaxRateEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  TaxRateStateBuilder();

  TaxRateStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxRateState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaxRateState;
  }

  @override
  void update(void Function(TaxRateStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxRateState build() => _build();

  _$TaxRateState _build() {
    _$TaxRateState _$result;
    try {
      _$result =
          _$v ?? new _$TaxRateState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaxRateState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaxRateUIState extends TaxRateUIState {
  @override
  final TaxRateEntity? editing;
  @override
  final ListUIState listUIState;
  @override
  final String? selectedId;
  @override
  final bool? forceSelected;
  @override
  final int tabIndex;
  @override
  final Completer<SelectableEntity>? saveCompleter;
  @override
  final Completer<Null>? cancelCompleter;

  factory _$TaxRateUIState([void Function(TaxRateUIStateBuilder)? updates]) =>
      (new TaxRateUIStateBuilder()..update(updates))._build();

  _$TaxRateUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'TaxRateUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'TaxRateUIState', 'tabIndex');
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
        forceSelected == other.forceSelected &&
        tabIndex == other.tabIndex &&
        saveCompleter == other.saveCompleter &&
        cancelCompleter == other.cancelCompleter;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, editing.hashCode);
    _$hash = $jc(_$hash, listUIState.hashCode);
    _$hash = $jc(_$hash, selectedId.hashCode);
    _$hash = $jc(_$hash, forceSelected.hashCode);
    _$hash = $jc(_$hash, tabIndex.hashCode);
    _$hash = $jc(_$hash, saveCompleter.hashCode);
    _$hash = $jc(_$hash, cancelCompleter.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxRateUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('forceSelected', forceSelected)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class TaxRateUIStateBuilder
    implements Builder<TaxRateUIState, TaxRateUIStateBuilder> {
  _$TaxRateUIState? _$v;

  TaxRateEntityBuilder? _editing;
  TaxRateEntityBuilder get editing =>
      _$this._editing ??= new TaxRateEntityBuilder();
  set editing(TaxRateEntityBuilder? editing) => _$this._editing = editing;

  ListUIStateBuilder? _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder? listUIState) =>
      _$this._listUIState = listUIState;

  String? _selectedId;
  String? get selectedId => _$this._selectedId;
  set selectedId(String? selectedId) => _$this._selectedId = selectedId;

  bool? _forceSelected;
  bool? get forceSelected => _$this._forceSelected;
  set forceSelected(bool? forceSelected) =>
      _$this._forceSelected = forceSelected;

  int? _tabIndex;
  int? get tabIndex => _$this._tabIndex;
  set tabIndex(int? tabIndex) => _$this._tabIndex = tabIndex;

  Completer<SelectableEntity>? _saveCompleter;
  Completer<SelectableEntity>? get saveCompleter => _$this._saveCompleter;
  set saveCompleter(Completer<SelectableEntity>? saveCompleter) =>
      _$this._saveCompleter = saveCompleter;

  Completer<Null>? _cancelCompleter;
  Completer<Null>? get cancelCompleter => _$this._cancelCompleter;
  set cancelCompleter(Completer<Null>? cancelCompleter) =>
      _$this._cancelCompleter = cancelCompleter;

  TaxRateUIStateBuilder();

  TaxRateUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _editing = $v.editing?.toBuilder();
      _listUIState = $v.listUIState.toBuilder();
      _selectedId = $v.selectedId;
      _forceSelected = $v.forceSelected;
      _tabIndex = $v.tabIndex;
      _saveCompleter = $v.saveCompleter;
      _cancelCompleter = $v.cancelCompleter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxRateUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaxRateUIState;
  }

  @override
  void update(void Function(TaxRateUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxRateUIState build() => _build();

  _$TaxRateUIState _build() {
    _$TaxRateUIState _$result;
    try {
      _$result = _$v ??
          new _$TaxRateUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'TaxRateUIState', 'tabIndex'),
              saveCompleter: saveCompleter,
              cancelCompleter: cancelCompleter);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();
        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaxRateUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
