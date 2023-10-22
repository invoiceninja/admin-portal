// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BankAccountState> _$bankAccountStateSerializer =
    new _$BankAccountStateSerializer();
Serializer<BankAccountUIState> _$bankAccountUIStateSerializer =
    new _$BankAccountUIStateSerializer();

class _$BankAccountStateSerializer
    implements StructuredSerializer<BankAccountState> {
  @override
  final Iterable<Type> types = const [BankAccountState, _$BankAccountState];
  @override
  final String wireName = 'BankAccountState';

  @override
  Iterable<Object?> serialize(Serializers serializers, BankAccountState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BankAccountEntity)
          ])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  BankAccountState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountStateBuilder();

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
                const FullType(BankAccountEntity)
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

class _$BankAccountUIStateSerializer
    implements StructuredSerializer<BankAccountUIState> {
  @override
  final Iterable<Type> types = const [BankAccountUIState, _$BankAccountUIState];
  @override
  final String wireName = 'BankAccountUIState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, BankAccountUIState object,
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
            specifiedType: const FullType(BankAccountEntity)));
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
  BankAccountUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BankAccountEntity))!
              as BankAccountEntity);
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

class _$BankAccountState extends BankAccountState {
  @override
  final BuiltMap<String, BankAccountEntity> map;
  @override
  final BuiltList<String> list;

  factory _$BankAccountState(
          [void Function(BankAccountStateBuilder)? updates]) =>
      (new BankAccountStateBuilder()..update(updates))._build();

  _$BankAccountState._({required this.map, required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'BankAccountState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, r'BankAccountState', 'list');
  }

  @override
  BankAccountState rebuild(void Function(BankAccountStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountStateBuilder toBuilder() =>
      new BankAccountStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountState && map == other.map && list == other.list;
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
    return (newBuiltValueToStringHelper(r'BankAccountState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class BankAccountStateBuilder
    implements Builder<BankAccountState, BankAccountStateBuilder> {
  _$BankAccountState? _$v;

  MapBuilder<String, BankAccountEntity>? _map;
  MapBuilder<String, BankAccountEntity> get map =>
      _$this._map ??= new MapBuilder<String, BankAccountEntity>();
  set map(MapBuilder<String, BankAccountEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  BankAccountStateBuilder();

  BankAccountStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BankAccountState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountState;
  }

  @override
  void update(void Function(BankAccountStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BankAccountState build() => _build();

  _$BankAccountState _build() {
    _$BankAccountState _$result;
    try {
      _$result =
          _$v ?? new _$BankAccountState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'BankAccountState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$BankAccountUIState extends BankAccountUIState {
  @override
  final BankAccountEntity? editing;
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

  factory _$BankAccountUIState(
          [void Function(BankAccountUIStateBuilder)? updates]) =>
      (new BankAccountUIStateBuilder()..update(updates))._build();

  _$BankAccountUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'BankAccountUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'BankAccountUIState', 'tabIndex');
  }

  @override
  BankAccountUIState rebuild(
          void Function(BankAccountUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountUIStateBuilder toBuilder() =>
      new BankAccountUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountUIState &&
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
    return (newBuiltValueToStringHelper(r'BankAccountUIState')
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

class BankAccountUIStateBuilder
    implements Builder<BankAccountUIState, BankAccountUIStateBuilder> {
  _$BankAccountUIState? _$v;

  BankAccountEntityBuilder? _editing;
  BankAccountEntityBuilder get editing =>
      _$this._editing ??= new BankAccountEntityBuilder();
  set editing(BankAccountEntityBuilder? editing) => _$this._editing = editing;

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

  BankAccountUIStateBuilder();

  BankAccountUIStateBuilder get _$this {
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
  void replace(BankAccountUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountUIState;
  }

  @override
  void update(void Function(BankAccountUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BankAccountUIState build() => _build();

  _$BankAccountUIState _build() {
    _$BankAccountUIState _$result;
    try {
      _$result = _$v ??
          new _$BankAccountUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'BankAccountUIState', 'tabIndex'),
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
            r'BankAccountUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
