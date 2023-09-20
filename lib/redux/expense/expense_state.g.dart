// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ExpenseState> _$expenseStateSerializer =
    new _$ExpenseStateSerializer();
Serializer<ExpenseUIState> _$expenseUIStateSerializer =
    new _$ExpenseUIStateSerializer();

class _$ExpenseStateSerializer implements StructuredSerializer<ExpenseState> {
  @override
  final Iterable<Type> types = const [ExpenseState, _$ExpenseState];
  @override
  final String wireName = 'ExpenseState';

  @override
  Iterable<Object?> serialize(Serializers serializers, ExpenseState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(ExpenseEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  ExpenseState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseStateBuilder();

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
                const FullType(ExpenseEntity)
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

class _$ExpenseUIStateSerializer
    implements StructuredSerializer<ExpenseUIState> {
  @override
  final Iterable<Type> types = const [ExpenseUIState, _$ExpenseUIState];
  @override
  final String wireName = 'ExpenseUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, ExpenseUIState object,
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
            specifiedType: const FullType(ExpenseEntity)));
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
  ExpenseUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(ExpenseEntity))! as ExpenseEntity);
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

class _$ExpenseState extends ExpenseState {
  @override
  final BuiltMap<String, ExpenseEntity> map;
  @override
  final BuiltList<String> list;

  factory _$ExpenseState([void Function(ExpenseStateBuilder)? updates]) =>
      (new ExpenseStateBuilder()..update(updates))._build();

  _$ExpenseState._({required this.map, required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'ExpenseState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, r'ExpenseState', 'list');
  }

  @override
  ExpenseState rebuild(void Function(ExpenseStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseStateBuilder toBuilder() => new ExpenseStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseState && map == other.map && list == other.list;
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
    return (newBuiltValueToStringHelper(r'ExpenseState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ExpenseStateBuilder
    implements Builder<ExpenseState, ExpenseStateBuilder> {
  _$ExpenseState? _$v;

  MapBuilder<String, ExpenseEntity>? _map;
  MapBuilder<String, ExpenseEntity> get map =>
      _$this._map ??= new MapBuilder<String, ExpenseEntity>();
  set map(MapBuilder<String, ExpenseEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  ExpenseStateBuilder();

  ExpenseStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseState;
  }

  @override
  void update(void Function(ExpenseStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpenseState build() => _build();

  _$ExpenseState _build() {
    _$ExpenseState _$result;
    try {
      _$result =
          _$v ?? new _$ExpenseState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ExpenseState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseUIState extends ExpenseUIState {
  @override
  final ExpenseEntity? editing;
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

  factory _$ExpenseUIState([void Function(ExpenseUIStateBuilder)? updates]) =>
      (new ExpenseUIStateBuilder()..update(updates))._build();

  _$ExpenseUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'ExpenseUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'ExpenseUIState', 'tabIndex');
  }

  @override
  ExpenseUIState rebuild(void Function(ExpenseUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseUIStateBuilder toBuilder() =>
      new ExpenseUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseUIState &&
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
    return (newBuiltValueToStringHelper(r'ExpenseUIState')
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

class ExpenseUIStateBuilder
    implements Builder<ExpenseUIState, ExpenseUIStateBuilder> {
  _$ExpenseUIState? _$v;

  ExpenseEntityBuilder? _editing;
  ExpenseEntityBuilder get editing =>
      _$this._editing ??= new ExpenseEntityBuilder();
  set editing(ExpenseEntityBuilder? editing) => _$this._editing = editing;

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

  ExpenseUIStateBuilder();

  ExpenseUIStateBuilder get _$this {
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
  void replace(ExpenseUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseUIState;
  }

  @override
  void update(void Function(ExpenseUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpenseUIState build() => _build();

  _$ExpenseUIState _build() {
    _$ExpenseUIState _$result;
    try {
      _$result = _$v ??
          new _$ExpenseUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'ExpenseUIState', 'tabIndex'),
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
            r'ExpenseUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
