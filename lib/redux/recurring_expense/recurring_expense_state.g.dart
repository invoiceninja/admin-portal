// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_expense_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RecurringExpenseState> _$recurringExpenseStateSerializer =
    new _$RecurringExpenseStateSerializer();
Serializer<RecurringExpenseUIState> _$recurringExpenseUIStateSerializer =
    new _$RecurringExpenseUIStateSerializer();

class _$RecurringExpenseStateSerializer
    implements StructuredSerializer<RecurringExpenseState> {
  @override
  final Iterable<Type> types = const [
    RecurringExpenseState,
    _$RecurringExpenseState
  ];
  @override
  final String wireName = 'RecurringExpenseState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, RecurringExpenseState object,
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
  RecurringExpenseState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecurringExpenseStateBuilder();

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

class _$RecurringExpenseUIStateSerializer
    implements StructuredSerializer<RecurringExpenseUIState> {
  @override
  final Iterable<Type> types = const [
    RecurringExpenseUIState,
    _$RecurringExpenseUIState
  ];
  @override
  final String wireName = 'RecurringExpenseUIState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, RecurringExpenseUIState object,
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
  RecurringExpenseUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecurringExpenseUIStateBuilder();

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

class _$RecurringExpenseState extends RecurringExpenseState {
  @override
  final BuiltMap<String, ExpenseEntity> map;
  @override
  final BuiltList<String> list;

  factory _$RecurringExpenseState(
          [void Function(RecurringExpenseStateBuilder)? updates]) =>
      (new RecurringExpenseStateBuilder()..update(updates))._build();

  _$RecurringExpenseState._({required this.map, required this.list})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'RecurringExpenseState', 'map');
    BuiltValueNullFieldError.checkNotNull(
        list, r'RecurringExpenseState', 'list');
  }

  @override
  RecurringExpenseState rebuild(
          void Function(RecurringExpenseStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecurringExpenseStateBuilder toBuilder() =>
      new RecurringExpenseStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecurringExpenseState &&
        map == other.map &&
        list == other.list;
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
    return (newBuiltValueToStringHelper(r'RecurringExpenseState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class RecurringExpenseStateBuilder
    implements Builder<RecurringExpenseState, RecurringExpenseStateBuilder> {
  _$RecurringExpenseState? _$v;

  MapBuilder<String, ExpenseEntity>? _map;
  MapBuilder<String, ExpenseEntity> get map =>
      _$this._map ??= new MapBuilder<String, ExpenseEntity>();
  set map(MapBuilder<String, ExpenseEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  RecurringExpenseStateBuilder();

  RecurringExpenseStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecurringExpenseState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RecurringExpenseState;
  }

  @override
  void update(void Function(RecurringExpenseStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecurringExpenseState build() => _build();

  _$RecurringExpenseState _build() {
    _$RecurringExpenseState _$result;
    try {
      _$result = _$v ??
          new _$RecurringExpenseState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RecurringExpenseState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$RecurringExpenseUIState extends RecurringExpenseUIState {
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

  factory _$RecurringExpenseUIState(
          [void Function(RecurringExpenseUIStateBuilder)? updates]) =>
      (new RecurringExpenseUIStateBuilder()..update(updates))._build();

  _$RecurringExpenseUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'RecurringExpenseUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'RecurringExpenseUIState', 'tabIndex');
  }

  @override
  RecurringExpenseUIState rebuild(
          void Function(RecurringExpenseUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecurringExpenseUIStateBuilder toBuilder() =>
      new RecurringExpenseUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecurringExpenseUIState &&
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
    return (newBuiltValueToStringHelper(r'RecurringExpenseUIState')
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

class RecurringExpenseUIStateBuilder
    implements
        Builder<RecurringExpenseUIState, RecurringExpenseUIStateBuilder> {
  _$RecurringExpenseUIState? _$v;

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

  RecurringExpenseUIStateBuilder();

  RecurringExpenseUIStateBuilder get _$this {
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
  void replace(RecurringExpenseUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RecurringExpenseUIState;
  }

  @override
  void update(void Function(RecurringExpenseUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecurringExpenseUIState build() => _build();

  _$RecurringExpenseUIState _build() {
    _$RecurringExpenseUIState _$result;
    try {
      _$result = _$v ??
          new _$RecurringExpenseUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'RecurringExpenseUIState', 'tabIndex'),
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
            r'RecurringExpenseUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
