// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InvoiceState> _$invoiceStateSerializer =
    new _$InvoiceStateSerializer();
Serializer<InvoiceUIState> _$invoiceUIStateSerializer =
    new _$InvoiceUIStateSerializer();

class _$InvoiceStateSerializer implements StructuredSerializer<InvoiceState> {
  @override
  final Iterable<Type> types = const [InvoiceState, _$InvoiceState];
  @override
  final String wireName = 'InvoiceState';

  @override
  Iterable<Object> serialize(Serializers serializers, InvoiceState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(InvoiceEntity)])),
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
  InvoiceState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceStateBuilder();

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
                const FullType(InvoiceEntity)
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

class _$InvoiceUIStateSerializer
    implements StructuredSerializer<InvoiceUIState> {
  @override
  final Iterable<Type> types = const [InvoiceUIState, _$InvoiceUIState];
  @override
  final String wireName = 'InvoiceUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, InvoiceUIState object,
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
            specifiedType: const FullType(InvoiceEntity)));
    }
    if (object.editingItem != null) {
      result
        ..add('editingItem')
        ..add(serializers.serialize(object.editingItem,
            specifiedType: const FullType(InvoiceItemEntity)));
    }
    return result;
  }

  @override
  InvoiceUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceUIStateBuilder();

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
        case 'editingItem':
          result.editingItem.replace(serializers.deserialize(value,
                  specifiedType: const FullType(InvoiceItemEntity))
              as InvoiceItemEntity);
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

class _$InvoiceState extends InvoiceState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, InvoiceEntity> map;
  @override
  final BuiltList<int> list;

  factory _$InvoiceState([void Function(InvoiceStateBuilder) updates]) =>
      (new InvoiceStateBuilder()..update(updates)).build();

  _$InvoiceState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('InvoiceState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('InvoiceState', 'list');
    }
  }

  @override
  InvoiceState rebuild(void Function(InvoiceStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceStateBuilder toBuilder() => new InvoiceStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceState &&
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
    return (newBuiltValueToStringHelper('InvoiceState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class InvoiceStateBuilder
    implements Builder<InvoiceState, InvoiceStateBuilder> {
  _$InvoiceState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, InvoiceEntity> _map;
  MapBuilder<int, InvoiceEntity> get map =>
      _$this._map ??= new MapBuilder<int, InvoiceEntity>();
  set map(MapBuilder<int, InvoiceEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  InvoiceStateBuilder();

  InvoiceStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceState;
  }

  @override
  void update(void Function(InvoiceStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceState build() {
    _$InvoiceState _$result;
    try {
      _$result = _$v ??
          new _$InvoiceState._(
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
            'InvoiceState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceUIState extends InvoiceUIState {
  @override
  final InvoiceEntity editing;
  @override
  final InvoiceItemEntity editingItem;
  @override
  final int selectedId;
  @override
  final ListUIState listUIState;
  @override
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;

  factory _$InvoiceUIState([void Function(InvoiceUIStateBuilder) updates]) =>
      (new InvoiceUIStateBuilder()..update(updates)).build();

  _$InvoiceUIState._(
      {this.editing,
      this.editingItem,
      this.selectedId,
      this.listUIState,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('InvoiceUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('InvoiceUIState', 'listUIState');
    }
  }

  @override
  InvoiceUIState rebuild(void Function(InvoiceUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceUIStateBuilder toBuilder() =>
      new InvoiceUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceUIState &&
        editing == other.editing &&
        editingItem == other.editingItem &&
        selectedId == other.selectedId &&
        listUIState == other.listUIState &&
        saveCompleter == other.saveCompleter &&
        cancelCompleter == other.cancelCompleter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, editing.hashCode), editingItem.hashCode),
                    selectedId.hashCode),
                listUIState.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceUIState')
          ..add('editing', editing)
          ..add('editingItem', editingItem)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class InvoiceUIStateBuilder
    implements Builder<InvoiceUIState, InvoiceUIStateBuilder> {
  _$InvoiceUIState _$v;

  InvoiceEntityBuilder _editing;
  InvoiceEntityBuilder get editing =>
      _$this._editing ??= new InvoiceEntityBuilder();
  set editing(InvoiceEntityBuilder editing) => _$this._editing = editing;

  InvoiceItemEntityBuilder _editingItem;
  InvoiceItemEntityBuilder get editingItem =>
      _$this._editingItem ??= new InvoiceItemEntityBuilder();
  set editingItem(InvoiceItemEntityBuilder editingItem) =>
      _$this._editingItem = editingItem;

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

  InvoiceUIStateBuilder();

  InvoiceUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingItem = _$v.editingItem?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
      _saveCompleter = _$v.saveCompleter;
      _cancelCompleter = _$v.cancelCompleter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceUIState;
  }

  @override
  void update(void Function(InvoiceUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceUIState build() {
    _$InvoiceUIState _$result;
    try {
      _$result = _$v ??
          new _$InvoiceUIState._(
              editing: _editing?.build(),
              editingItem: _editingItem?.build(),
              selectedId: selectedId,
              listUIState: listUIState.build(),
              saveCompleter: saveCompleter,
              cancelCompleter: cancelCompleter);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();
        _$failedField = 'editingItem';
        _editingItem?.build();

        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
