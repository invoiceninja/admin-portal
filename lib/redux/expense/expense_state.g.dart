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
  Iterable<Object> serialize(Serializers serializers, ExpenseState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
  ExpenseState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseStateBuilder();

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
                const FullType(ExpenseEntity)
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

class _$ExpenseUIStateSerializer
    implements StructuredSerializer<ExpenseUIState> {
  @override
  final Iterable<Type> types = const [ExpenseUIState, _$ExpenseUIState];
  @override
  final String wireName = 'ExpenseUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, ExpenseUIState object,
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
            specifiedType: const FullType(ExpenseEntity)));
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
  ExpenseUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(ExpenseEntity)) as ExpenseEntity);
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

class _$ExpenseState extends ExpenseState {
  @override
  final BuiltMap<String, ExpenseEntity> map;
  @override
  final BuiltList<String> list;

  factory _$ExpenseState([void Function(ExpenseStateBuilder) updates]) =>
      (new ExpenseStateBuilder()..update(updates)).build();

  _$ExpenseState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('ExpenseState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('ExpenseState', 'list');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ExpenseStateBuilder
    implements Builder<ExpenseState, ExpenseStateBuilder> {
  _$ExpenseState _$v;

  MapBuilder<String, ExpenseEntity> _map;
  MapBuilder<String, ExpenseEntity> get map =>
      _$this._map ??= new MapBuilder<String, ExpenseEntity>();
  set map(MapBuilder<String, ExpenseEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  ExpenseStateBuilder();

  ExpenseStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExpenseState;
  }

  @override
  void update(void Function(ExpenseStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseState build() {
    _$ExpenseState _$result;
    try {
      _$result =
          _$v ?? new _$ExpenseState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ExpenseState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseUIState extends ExpenseUIState {
  @override
  final ExpenseEntity editing;
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

  factory _$ExpenseUIState([void Function(ExpenseUIStateBuilder) updates]) =>
      (new ExpenseUIStateBuilder()..update(updates)).build();

  _$ExpenseUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('ExpenseUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('ExpenseUIState', 'tabIndex');
    }
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
    return (newBuiltValueToStringHelper('ExpenseUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class ExpenseUIStateBuilder
    implements Builder<ExpenseUIState, ExpenseUIStateBuilder> {
  _$ExpenseUIState _$v;

  ExpenseEntityBuilder _editing;
  ExpenseEntityBuilder get editing =>
      _$this._editing ??= new ExpenseEntityBuilder();
  set editing(ExpenseEntityBuilder editing) => _$this._editing = editing;

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

  ExpenseUIStateBuilder();

  ExpenseUIStateBuilder get _$this {
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
  void replace(ExpenseUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExpenseUIState;
  }

  @override
  void update(void Function(ExpenseUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseUIState build() {
    _$ExpenseUIState _$result;
    try {
      _$result = _$v ??
          new _$ExpenseUIState._(
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
            'ExpenseUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
