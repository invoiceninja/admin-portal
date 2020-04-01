// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CreditState> _$creditStateSerializer = new _$CreditStateSerializer();
Serializer<CreditUIState> _$creditUIStateSerializer =
    new _$CreditUIStateSerializer();

class _$CreditStateSerializer implements StructuredSerializer<CreditState> {
  @override
  final Iterable<Type> types = const [CreditState, _$CreditState];
  @override
  final String wireName = 'CreditState';

  @override
  Iterable<Object> serialize(Serializers serializers, CreditState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(InvoiceEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
  CreditState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditStateBuilder();

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
                const FullType(String),
                const FullType(InvoiceEntity)
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

class _$CreditUIStateSerializer implements StructuredSerializer<CreditUIState> {
  @override
  final Iterable<Type> types = const [CreditUIState, _$CreditUIState];
  @override
  final String wireName = 'CreditUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, CreditUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'listUIState',
      serializers.serialize(object.listUIState,
          specifiedType: const FullType(ListUIState)),
    ];
    if (object.editing != null) {
      result
        ..add('editing')
        ..add(serializers.serialize(object.editing,
            specifiedType: const FullType(InvoiceEntity)));
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
  CreditUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceEntity)) as InvoiceEntity);
          break;
        case 'listUIState':
          result.listUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ListUIState)) as ListUIState);
          break;
        case 'selectedId':
          result.selectedId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CreditState extends CreditState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<String, InvoiceEntity> map;
  @override
  final BuiltList<String> list;

  factory _$CreditState([void Function(CreditStateBuilder) updates]) =>
      (new CreditStateBuilder()..update(updates)).build();

  _$CreditState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('CreditState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('CreditState', 'list');
    }
  }

  @override
  CreditState rebuild(void Function(CreditStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreditStateBuilder toBuilder() => new CreditStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreditState &&
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
    return (newBuiltValueToStringHelper('CreditState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class CreditStateBuilder implements Builder<CreditState, CreditStateBuilder> {
  _$CreditState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<String, InvoiceEntity> _map;
  MapBuilder<String, InvoiceEntity> get map =>
      _$this._map ??= new MapBuilder<String, InvoiceEntity>();
  set map(MapBuilder<String, InvoiceEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  CreditStateBuilder();

  CreditStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreditState;
  }

  @override
  void update(void Function(CreditStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CreditState build() {
    _$CreditState _$result;
    try {
      _$result = _$v ??
          new _$CreditState._(
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
            'CreditState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CreditUIState extends CreditUIState {
  @override
  final InvoiceEntity editing;
  @override
  final int editingItemIndex;
  @override
  final ListUIState listUIState;
  @override
  final String selectedId;
  @override
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;

  factory _$CreditUIState([void Function(CreditUIStateBuilder) updates]) =>
      (new CreditUIStateBuilder()..update(updates)).build();

  _$CreditUIState._(
      {this.editing,
      this.editingItemIndex,
      this.listUIState,
      this.selectedId,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('CreditUIState', 'listUIState');
    }
  }

  @override
  CreditUIState rebuild(void Function(CreditUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreditUIStateBuilder toBuilder() => new CreditUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreditUIState &&
        editing == other.editing &&
        editingItemIndex == other.editingItemIndex &&
        listUIState == other.listUIState &&
        selectedId == other.selectedId &&
        saveCompleter == other.saveCompleter &&
        cancelCompleter == other.cancelCompleter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, editing.hashCode), editingItemIndex.hashCode),
                    listUIState.hashCode),
                selectedId.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreditUIState')
          ..add('editing', editing)
          ..add('editingItemIndex', editingItemIndex)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class CreditUIStateBuilder
    implements Builder<CreditUIState, CreditUIStateBuilder> {
  _$CreditUIState _$v;

  InvoiceEntityBuilder _editing;
  InvoiceEntityBuilder get editing =>
      _$this._editing ??= new InvoiceEntityBuilder();
  set editing(InvoiceEntityBuilder editing) => _$this._editing = editing;

  int _editingItemIndex;
  int get editingItemIndex => _$this._editingItemIndex;
  set editingItemIndex(int editingItemIndex) =>
      _$this._editingItemIndex = editingItemIndex;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  String _selectedId;
  String get selectedId => _$this._selectedId;
  set selectedId(String selectedId) => _$this._selectedId = selectedId;

  Completer<SelectableEntity> _saveCompleter;
  Completer<SelectableEntity> get saveCompleter => _$this._saveCompleter;
  set saveCompleter(Completer<SelectableEntity> saveCompleter) =>
      _$this._saveCompleter = saveCompleter;

  Completer<Null> _cancelCompleter;
  Completer<Null> get cancelCompleter => _$this._cancelCompleter;
  set cancelCompleter(Completer<Null> cancelCompleter) =>
      _$this._cancelCompleter = cancelCompleter;

  CreditUIStateBuilder();

  CreditUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingItemIndex = _$v.editingItemIndex;
      _listUIState = _$v.listUIState?.toBuilder();
      _selectedId = _$v.selectedId;
      _saveCompleter = _$v.saveCompleter;
      _cancelCompleter = _$v.cancelCompleter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreditUIState;
  }

  @override
  void update(void Function(CreditUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CreditUIState build() {
    _$CreditUIState _$result;
    try {
      _$result = _$v ??
          new _$CreditUIState._(
              editing: _editing?.build(),
              editingItemIndex: editingItemIndex,
              listUIState: listUIState.build(),
              selectedId: selectedId,
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
            'CreditUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
