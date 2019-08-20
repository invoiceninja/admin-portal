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
              const [const FullType(int), const FullType(ExpenseEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];
    if (object.lastUpdated != null) {
      result
        ..add('lastUpdated')
        ..add(serializers.serialize(object.lastUpdated,
            specifiedType: const FullType(int)));
    }
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
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(ExpenseEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<dynamic>);
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
      'selectedId',
      serializers.serialize(object.selectedId,
          specifiedType: const FullType(int)),
      'listUIState',
      serializers.serialize(object.listUIState,
          specifiedType: const FullType(ListUIState)),
    ];
    if (object.editing != null) {
      result
        ..add('editing')
        ..add(serializers.serialize(object.editing,
            specifiedType: const FullType(ExpenseEntity)));
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
        case 'selectedId':
          result.selectedId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'listUIState':
          result.listUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ListUIState)) as ListUIState);
          break;
      }
    }

    return result.build();
  }
}

class _$ExpenseState extends ExpenseState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, ExpenseEntity> map;
  @override
  final BuiltList<int> list;

  factory _$ExpenseState([void Function(ExpenseStateBuilder) updates]) =>
      (new ExpenseStateBuilder()..update(updates)).build();

  _$ExpenseState._({this.lastUpdated, this.map, this.list}) : super._() {
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
    return other is ExpenseState &&
        lastUpdated == other.lastUpdated &&
        map == other.map &&
        list == other.list;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, lastUpdated.hashCode), map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ExpenseStateBuilder
    implements Builder<ExpenseState, ExpenseStateBuilder> {
  _$ExpenseState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, ExpenseEntity> _map;
  MapBuilder<int, ExpenseEntity> get map =>
      _$this._map ??= new MapBuilder<int, ExpenseEntity>();
  set map(MapBuilder<int, ExpenseEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  ExpenseStateBuilder();

  ExpenseStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
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
      _$result = _$v ??
          new _$ExpenseState._(
              lastUpdated: lastUpdated, map: map.build(), list: list.build());
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
  final int selectedId;
  @override
  final ListUIState listUIState;
  @override
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;

  factory _$ExpenseUIState([void Function(ExpenseUIStateBuilder) updates]) =>
      (new ExpenseUIStateBuilder()..update(updates)).build();

  _$ExpenseUIState._(
      {this.editing,
      this.selectedId,
      this.listUIState,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('ExpenseUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('ExpenseUIState', 'listUIState');
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
        selectedId == other.selectedId &&
        listUIState == other.listUIState &&
        saveCompleter == other.saveCompleter &&
        cancelCompleter == other.cancelCompleter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, editing.hashCode), selectedId.hashCode),
                listUIState.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseUIState')
          ..add('editing', editing)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState)
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

  int _selectedId;
  int get selectedId => _$this._selectedId;
  set selectedId(int selectedId) => _$this._selectedId = selectedId;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

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
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
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
              selectedId: selectedId,
              listUIState: listUIState.build(),
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
