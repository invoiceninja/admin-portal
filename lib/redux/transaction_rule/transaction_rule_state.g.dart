// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_rule_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TransactionRuleState> _$transactionRuleStateSerializer =
    new _$TransactionRuleStateSerializer();
Serializer<TransactionRuleUIState> _$transactionRuleUIStateSerializer =
    new _$TransactionRuleUIStateSerializer();

class _$TransactionRuleStateSerializer
    implements StructuredSerializer<TransactionRuleState> {
  @override
  final Iterable<Type> types = const [
    TransactionRuleState,
    _$TransactionRuleState
  ];
  @override
  final String wireName = 'TransactionRuleState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TransactionRuleState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(TransactionRuleEntity)
          ])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  TransactionRuleState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionRuleStateBuilder();

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
                const FullType(TransactionRuleEntity)
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

class _$TransactionRuleUIStateSerializer
    implements StructuredSerializer<TransactionRuleUIState> {
  @override
  final Iterable<Type> types = const [
    TransactionRuleUIState,
    _$TransactionRuleUIState
  ];
  @override
  final String wireName = 'TransactionRuleUIState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TransactionRuleUIState object,
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
            specifiedType: const FullType(TransactionRuleEntity)));
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
  TransactionRuleUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionRuleUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TransactionRuleEntity))!
              as TransactionRuleEntity);
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

class _$TransactionRuleState extends TransactionRuleState {
  @override
  final BuiltMap<String, TransactionRuleEntity> map;
  @override
  final BuiltList<String> list;

  factory _$TransactionRuleState(
          [void Function(TransactionRuleStateBuilder)? updates]) =>
      (new TransactionRuleStateBuilder()..update(updates))._build();

  _$TransactionRuleState._({required this.map, required this.list})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'TransactionRuleState', 'map');
    BuiltValueNullFieldError.checkNotNull(
        list, r'TransactionRuleState', 'list');
  }

  @override
  TransactionRuleState rebuild(
          void Function(TransactionRuleStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionRuleStateBuilder toBuilder() =>
      new TransactionRuleStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionRuleState &&
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
    return (newBuiltValueToStringHelper(r'TransactionRuleState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TransactionRuleStateBuilder
    implements Builder<TransactionRuleState, TransactionRuleStateBuilder> {
  _$TransactionRuleState? _$v;

  MapBuilder<String, TransactionRuleEntity>? _map;
  MapBuilder<String, TransactionRuleEntity> get map =>
      _$this._map ??= new MapBuilder<String, TransactionRuleEntity>();
  set map(MapBuilder<String, TransactionRuleEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  TransactionRuleStateBuilder();

  TransactionRuleStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionRuleState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionRuleState;
  }

  @override
  void update(void Function(TransactionRuleStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionRuleState build() => _build();

  _$TransactionRuleState _build() {
    _$TransactionRuleState _$result;
    try {
      _$result = _$v ??
          new _$TransactionRuleState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TransactionRuleState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TransactionRuleUIState extends TransactionRuleUIState {
  @override
  final TransactionRuleEntity? editing;
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

  factory _$TransactionRuleUIState(
          [void Function(TransactionRuleUIStateBuilder)? updates]) =>
      (new TransactionRuleUIStateBuilder()..update(updates))._build();

  _$TransactionRuleUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'TransactionRuleUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'TransactionRuleUIState', 'tabIndex');
  }

  @override
  TransactionRuleUIState rebuild(
          void Function(TransactionRuleUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionRuleUIStateBuilder toBuilder() =>
      new TransactionRuleUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionRuleUIState &&
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
    return (newBuiltValueToStringHelper(r'TransactionRuleUIState')
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

class TransactionRuleUIStateBuilder
    implements Builder<TransactionRuleUIState, TransactionRuleUIStateBuilder> {
  _$TransactionRuleUIState? _$v;

  TransactionRuleEntityBuilder? _editing;
  TransactionRuleEntityBuilder get editing =>
      _$this._editing ??= new TransactionRuleEntityBuilder();
  set editing(TransactionRuleEntityBuilder? editing) =>
      _$this._editing = editing;

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

  TransactionRuleUIStateBuilder();

  TransactionRuleUIStateBuilder get _$this {
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
  void replace(TransactionRuleUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionRuleUIState;
  }

  @override
  void update(void Function(TransactionRuleUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionRuleUIState build() => _build();

  _$TransactionRuleUIState _build() {
    _$TransactionRuleUIState _$result;
    try {
      _$result = _$v ??
          new _$TransactionRuleUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'TransactionRuleUIState', 'tabIndex'),
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
            r'TransactionRuleUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
