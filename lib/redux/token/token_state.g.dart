// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TokenState> _$tokenStateSerializer = _$TokenStateSerializer();
Serializer<TokenUIState> _$tokenUIStateSerializer = _$TokenUIStateSerializer();

class _$TokenStateSerializer implements StructuredSerializer<TokenState> {
  @override
  final Iterable<Type> types = const [TokenState, _$TokenState];
  @override
  final String wireName = 'TokenState';

  @override
  Iterable<Object?> serialize(Serializers serializers, TokenState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(TokenEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  TokenState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = TokenStateBuilder();

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
                const FullType(TokenEntity)
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

class _$TokenUIStateSerializer implements StructuredSerializer<TokenUIState> {
  @override
  final Iterable<Type> types = const [TokenUIState, _$TokenUIState];
  @override
  final String wireName = 'TokenUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, TokenUIState object,
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
            specifiedType: const FullType(TokenEntity)));
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
  TokenUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = TokenUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(TokenEntity))! as TokenEntity);
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

class _$TokenState extends TokenState {
  @override
  final BuiltMap<String, TokenEntity> map;
  @override
  final BuiltList<String> list;

  factory _$TokenState([void Function(TokenStateBuilder)? updates]) =>
      (TokenStateBuilder()..update(updates))._build();

  _$TokenState._({required this.map, required this.list}) : super._();
  @override
  TokenState rebuild(void Function(TokenStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenStateBuilder toBuilder() => TokenStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenState && map == other.map && list == other.list;
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
    return (newBuiltValueToStringHelper(r'TokenState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TokenStateBuilder implements Builder<TokenState, TokenStateBuilder> {
  _$TokenState? _$v;

  MapBuilder<String, TokenEntity>? _map;
  MapBuilder<String, TokenEntity> get map =>
      _$this._map ??= MapBuilder<String, TokenEntity>();
  set map(MapBuilder<String, TokenEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  TokenStateBuilder();

  TokenStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenState other) {
    _$v = other as _$TokenState;
  }

  @override
  void update(void Function(TokenStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenState build() => _build();

  _$TokenState _build() {
    _$TokenState _$result;
    try {
      _$result = _$v ??
          _$TokenState._(
            map: map.build(),
            list: list.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TokenState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TokenUIState extends TokenUIState {
  @override
  final TokenEntity? editing;
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

  factory _$TokenUIState([void Function(TokenUIStateBuilder)? updates]) =>
      (TokenUIStateBuilder()..update(updates))._build();

  _$TokenUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._();
  @override
  TokenUIState rebuild(void Function(TokenUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenUIStateBuilder toBuilder() => TokenUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenUIState &&
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
    return (newBuiltValueToStringHelper(r'TokenUIState')
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

class TokenUIStateBuilder
    implements Builder<TokenUIState, TokenUIStateBuilder> {
  _$TokenUIState? _$v;

  TokenEntityBuilder? _editing;
  TokenEntityBuilder get editing => _$this._editing ??= TokenEntityBuilder();
  set editing(TokenEntityBuilder? editing) => _$this._editing = editing;

  ListUIStateBuilder? _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= ListUIStateBuilder();
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

  TokenUIStateBuilder();

  TokenUIStateBuilder get _$this {
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
  void replace(TokenUIState other) {
    _$v = other as _$TokenUIState;
  }

  @override
  void update(void Function(TokenUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenUIState build() => _build();

  _$TokenUIState _build() {
    _$TokenUIState _$result;
    try {
      _$result = _$v ??
          _$TokenUIState._(
            editing: _editing?.build(),
            listUIState: listUIState.build(),
            selectedId: selectedId,
            forceSelected: forceSelected,
            tabIndex: BuiltValueNullFieldError.checkNotNull(
                tabIndex, r'TokenUIState', 'tabIndex'),
            saveCompleter: saveCompleter,
            cancelCompleter: cancelCompleter,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();
        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TokenUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
