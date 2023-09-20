// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DocumentState> _$documentStateSerializer =
    new _$DocumentStateSerializer();
Serializer<DocumentUIState> _$documentUIStateSerializer =
    new _$DocumentUIStateSerializer();

class _$DocumentStateSerializer implements StructuredSerializer<DocumentState> {
  @override
  final Iterable<Type> types = const [DocumentState, _$DocumentState];
  @override
  final String wireName = 'DocumentState';

  @override
  Iterable<Object?> serialize(Serializers serializers, DocumentState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(DocumentEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  DocumentState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentStateBuilder();

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
                const FullType(DocumentEntity)
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

class _$DocumentUIStateSerializer
    implements StructuredSerializer<DocumentUIState> {
  @override
  final Iterable<Type> types = const [DocumentUIState, _$DocumentUIState];
  @override
  final String wireName = 'DocumentUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, DocumentUIState object,
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
            specifiedType: const FullType(DocumentEntity)));
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
  DocumentUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DocumentEntity))!
              as DocumentEntity);
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

class _$DocumentState extends DocumentState {
  @override
  final BuiltMap<String, DocumentEntity> map;
  @override
  final BuiltList<String> list;

  factory _$DocumentState([void Function(DocumentStateBuilder)? updates]) =>
      (new DocumentStateBuilder()..update(updates))._build();

  _$DocumentState._({required this.map, required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'DocumentState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, r'DocumentState', 'list');
  }

  @override
  DocumentState rebuild(void Function(DocumentStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DocumentStateBuilder toBuilder() => new DocumentStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocumentState && map == other.map && list == other.list;
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
    return (newBuiltValueToStringHelper(r'DocumentState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class DocumentStateBuilder
    implements Builder<DocumentState, DocumentStateBuilder> {
  _$DocumentState? _$v;

  MapBuilder<String, DocumentEntity>? _map;
  MapBuilder<String, DocumentEntity> get map =>
      _$this._map ??= new MapBuilder<String, DocumentEntity>();
  set map(MapBuilder<String, DocumentEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  DocumentStateBuilder();

  DocumentStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocumentState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocumentState;
  }

  @override
  void update(void Function(DocumentStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DocumentState build() => _build();

  _$DocumentState _build() {
    _$DocumentState _$result;
    try {
      _$result =
          _$v ?? new _$DocumentState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DocumentState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DocumentUIState extends DocumentUIState {
  @override
  final DocumentEntity? editing;
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

  factory _$DocumentUIState([void Function(DocumentUIStateBuilder)? updates]) =>
      (new DocumentUIStateBuilder()..update(updates))._build();

  _$DocumentUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'DocumentUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'DocumentUIState', 'tabIndex');
  }

  @override
  DocumentUIState rebuild(void Function(DocumentUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DocumentUIStateBuilder toBuilder() =>
      new DocumentUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocumentUIState &&
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
    return (newBuiltValueToStringHelper(r'DocumentUIState')
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

class DocumentUIStateBuilder
    implements Builder<DocumentUIState, DocumentUIStateBuilder> {
  _$DocumentUIState? _$v;

  DocumentEntityBuilder? _editing;
  DocumentEntityBuilder get editing =>
      _$this._editing ??= new DocumentEntityBuilder();
  set editing(DocumentEntityBuilder? editing) => _$this._editing = editing;

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

  DocumentUIStateBuilder();

  DocumentUIStateBuilder get _$this {
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
  void replace(DocumentUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocumentUIState;
  }

  @override
  void update(void Function(DocumentUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DocumentUIState build() => _build();

  _$DocumentUIState _build() {
    _$DocumentUIState _$result;
    try {
      _$result = _$v ??
          new _$DocumentUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'DocumentUIState', 'tabIndex'),
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
            r'DocumentUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
