// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_invoice_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RecurringInvoiceState> _$recurringInvoiceStateSerializer =
    new _$RecurringInvoiceStateSerializer();
Serializer<RecurringInvoiceUIState> _$recurringInvoiceUIStateSerializer =
    new _$RecurringInvoiceUIStateSerializer();

class _$RecurringInvoiceStateSerializer
    implements StructuredSerializer<RecurringInvoiceState> {
  @override
  final Iterable<Type> types = const [
    RecurringInvoiceState,
    _$RecurringInvoiceState
  ];
  @override
  final String wireName = 'RecurringInvoiceState';

  @override
  Iterable<Object> serialize(
      Serializers serializers, RecurringInvoiceState object,
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

    return result;
  }

  @override
  RecurringInvoiceState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecurringInvoiceStateBuilder();

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

class _$RecurringInvoiceUIStateSerializer
    implements StructuredSerializer<RecurringInvoiceUIState> {
  @override
  final Iterable<Type> types = const [
    RecurringInvoiceUIState,
    _$RecurringInvoiceUIState
  ];
  @override
  final String wireName = 'RecurringInvoiceUIState';

  @override
  Iterable<Object> serialize(
      Serializers serializers, RecurringInvoiceUIState object,
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
  RecurringInvoiceUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecurringInvoiceUIStateBuilder();

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
        case 'tabIndex':
          result.tabIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$RecurringInvoiceState extends RecurringInvoiceState {
  @override
  final BuiltMap<String, InvoiceEntity> map;
  @override
  final BuiltList<String> list;

  factory _$RecurringInvoiceState(
          [void Function(RecurringInvoiceStateBuilder) updates]) =>
      (new RecurringInvoiceStateBuilder()..update(updates)).build();

  _$RecurringInvoiceState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('RecurringInvoiceState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('RecurringInvoiceState', 'list');
    }
  }

  @override
  RecurringInvoiceState rebuild(
          void Function(RecurringInvoiceStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecurringInvoiceStateBuilder toBuilder() =>
      new RecurringInvoiceStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecurringInvoiceState &&
        map == other.map &&
        list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RecurringInvoiceState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class RecurringInvoiceStateBuilder
    implements Builder<RecurringInvoiceState, RecurringInvoiceStateBuilder> {
  _$RecurringInvoiceState _$v;

  MapBuilder<String, InvoiceEntity> _map;
  MapBuilder<String, InvoiceEntity> get map =>
      _$this._map ??= new MapBuilder<String, InvoiceEntity>();
  set map(MapBuilder<String, InvoiceEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  RecurringInvoiceStateBuilder();

  RecurringInvoiceStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecurringInvoiceState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RecurringInvoiceState;
  }

  @override
  void update(void Function(RecurringInvoiceStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RecurringInvoiceState build() {
    _$RecurringInvoiceState _$result;
    try {
      _$result = _$v ??
          new _$RecurringInvoiceState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'RecurringInvoiceState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$RecurringInvoiceUIState extends RecurringInvoiceUIState {
  @override
  final InvoiceEntity editing;
  @override
  final int editingItemIndex;
  @override
  final String historyActivityId;
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

  factory _$RecurringInvoiceUIState(
          [void Function(RecurringInvoiceUIStateBuilder) updates]) =>
      (new RecurringInvoiceUIStateBuilder()..update(updates)).build();

  _$RecurringInvoiceUIState._(
      {this.editing,
      this.editingItemIndex,
      this.historyActivityId,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError(
          'RecurringInvoiceUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('RecurringInvoiceUIState', 'tabIndex');
    }
  }

  @override
  RecurringInvoiceUIState rebuild(
          void Function(RecurringInvoiceUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecurringInvoiceUIStateBuilder toBuilder() =>
      new RecurringInvoiceUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecurringInvoiceUIState &&
        editing == other.editing &&
        editingItemIndex == other.editingItemIndex &&
        historyActivityId == other.historyActivityId &&
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
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, editing.hashCode),
                                editingItemIndex.hashCode),
                            historyActivityId.hashCode),
                        listUIState.hashCode),
                    selectedId.hashCode),
                tabIndex.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RecurringInvoiceUIState')
          ..add('editing', editing)
          ..add('editingItemIndex', editingItemIndex)
          ..add('historyActivityId', historyActivityId)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class RecurringInvoiceUIStateBuilder
    implements
        Builder<RecurringInvoiceUIState, RecurringInvoiceUIStateBuilder> {
  _$RecurringInvoiceUIState _$v;

  InvoiceEntityBuilder _editing;
  InvoiceEntityBuilder get editing =>
      _$this._editing ??= new InvoiceEntityBuilder();
  set editing(InvoiceEntityBuilder editing) => _$this._editing = editing;

  int _editingItemIndex;
  int get editingItemIndex => _$this._editingItemIndex;
  set editingItemIndex(int editingItemIndex) =>
      _$this._editingItemIndex = editingItemIndex;

  String _historyActivityId;
  String get historyActivityId => _$this._historyActivityId;
  set historyActivityId(String historyActivityId) =>
      _$this._historyActivityId = historyActivityId;

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

  RecurringInvoiceUIStateBuilder();

  RecurringInvoiceUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingItemIndex = _$v.editingItemIndex;
      _historyActivityId = _$v.historyActivityId;
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
  void replace(RecurringInvoiceUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RecurringInvoiceUIState;
  }

  @override
  void update(void Function(RecurringInvoiceUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RecurringInvoiceUIState build() {
    _$RecurringInvoiceUIState _$result;
    try {
      _$result = _$v ??
          new _$RecurringInvoiceUIState._(
              editing: _editing?.build(),
              editingItemIndex: editingItemIndex,
              historyActivityId: historyActivityId,
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
            'RecurringInvoiceUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
