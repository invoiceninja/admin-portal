// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PurchaseOrderState> _$purchaseOrderStateSerializer =
    new _$PurchaseOrderStateSerializer();
Serializer<PurchaseOrderUIState> _$purchaseOrderUIStateSerializer =
    new _$PurchaseOrderUIStateSerializer();

class _$PurchaseOrderStateSerializer
    implements StructuredSerializer<PurchaseOrderState> {
  @override
  final Iterable<Type> types = const [PurchaseOrderState, _$PurchaseOrderState];
  @override
  final String wireName = 'PurchaseOrderState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, PurchaseOrderState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
  PurchaseOrderState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PurchaseOrderStateBuilder();

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
                const FullType(InvoiceEntity)
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

class _$PurchaseOrderUIStateSerializer
    implements StructuredSerializer<PurchaseOrderUIState> {
  @override
  final Iterable<Type> types = const [
    PurchaseOrderUIState,
    _$PurchaseOrderUIState
  ];
  @override
  final String wireName = 'PurchaseOrderUIState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, PurchaseOrderUIState object,
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
            specifiedType: const FullType(InvoiceEntity)));
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
  PurchaseOrderUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PurchaseOrderUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceEntity))! as InvoiceEntity);
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

class _$PurchaseOrderState extends PurchaseOrderState {
  @override
  final BuiltMap<String, InvoiceEntity> map;
  @override
  final BuiltList<String> list;

  factory _$PurchaseOrderState(
          [void Function(PurchaseOrderStateBuilder)? updates]) =>
      (new PurchaseOrderStateBuilder()..update(updates))._build();

  _$PurchaseOrderState._({required this.map, required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'PurchaseOrderState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, r'PurchaseOrderState', 'list');
  }

  @override
  PurchaseOrderState rebuild(
          void Function(PurchaseOrderStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PurchaseOrderStateBuilder toBuilder() =>
      new PurchaseOrderStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PurchaseOrderState &&
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
    return (newBuiltValueToStringHelper(r'PurchaseOrderState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class PurchaseOrderStateBuilder
    implements Builder<PurchaseOrderState, PurchaseOrderStateBuilder> {
  _$PurchaseOrderState? _$v;

  MapBuilder<String, InvoiceEntity>? _map;
  MapBuilder<String, InvoiceEntity> get map =>
      _$this._map ??= new MapBuilder<String, InvoiceEntity>();
  set map(MapBuilder<String, InvoiceEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  PurchaseOrderStateBuilder();

  PurchaseOrderStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PurchaseOrderState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PurchaseOrderState;
  }

  @override
  void update(void Function(PurchaseOrderStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PurchaseOrderState build() => _build();

  _$PurchaseOrderState _build() {
    _$PurchaseOrderState _$result;
    try {
      _$result = _$v ??
          new _$PurchaseOrderState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PurchaseOrderState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PurchaseOrderUIState extends PurchaseOrderUIState {
  @override
  final InvoiceEntity? editing;
  @override
  final int? editingItemIndex;
  @override
  final String? historyActivityId;
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

  factory _$PurchaseOrderUIState(
          [void Function(PurchaseOrderUIStateBuilder)? updates]) =>
      (new PurchaseOrderUIStateBuilder()..update(updates))._build();

  _$PurchaseOrderUIState._(
      {this.editing,
      this.editingItemIndex,
      this.historyActivityId,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'PurchaseOrderUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'PurchaseOrderUIState', 'tabIndex');
  }

  @override
  PurchaseOrderUIState rebuild(
          void Function(PurchaseOrderUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PurchaseOrderUIStateBuilder toBuilder() =>
      new PurchaseOrderUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PurchaseOrderUIState &&
        editing == other.editing &&
        editingItemIndex == other.editingItemIndex &&
        historyActivityId == other.historyActivityId &&
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
    _$hash = $jc(_$hash, editingItemIndex.hashCode);
    _$hash = $jc(_$hash, historyActivityId.hashCode);
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
    return (newBuiltValueToStringHelper(r'PurchaseOrderUIState')
          ..add('editing', editing)
          ..add('editingItemIndex', editingItemIndex)
          ..add('historyActivityId', historyActivityId)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('forceSelected', forceSelected)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class PurchaseOrderUIStateBuilder
    implements Builder<PurchaseOrderUIState, PurchaseOrderUIStateBuilder> {
  _$PurchaseOrderUIState? _$v;

  InvoiceEntityBuilder? _editing;
  InvoiceEntityBuilder get editing =>
      _$this._editing ??= new InvoiceEntityBuilder();
  set editing(InvoiceEntityBuilder? editing) => _$this._editing = editing;

  int? _editingItemIndex;
  int? get editingItemIndex => _$this._editingItemIndex;
  set editingItemIndex(int? editingItemIndex) =>
      _$this._editingItemIndex = editingItemIndex;

  String? _historyActivityId;
  String? get historyActivityId => _$this._historyActivityId;
  set historyActivityId(String? historyActivityId) =>
      _$this._historyActivityId = historyActivityId;

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

  PurchaseOrderUIStateBuilder();

  PurchaseOrderUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _editing = $v.editing?.toBuilder();
      _editingItemIndex = $v.editingItemIndex;
      _historyActivityId = $v.historyActivityId;
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
  void replace(PurchaseOrderUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PurchaseOrderUIState;
  }

  @override
  void update(void Function(PurchaseOrderUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PurchaseOrderUIState build() => _build();

  _$PurchaseOrderUIState _build() {
    _$PurchaseOrderUIState _$result;
    try {
      _$result = _$v ??
          new _$PurchaseOrderUIState._(
              editing: _editing?.build(),
              editingItemIndex: editingItemIndex,
              historyActivityId: historyActivityId,
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'PurchaseOrderUIState', 'tabIndex'),
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
            r'PurchaseOrderUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
