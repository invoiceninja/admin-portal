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
  Iterable<Object> serialize(Serializers serializers, DocumentState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentStateBuilder();

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
                const FullType(DocumentEntity)
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

class _$DocumentUIStateSerializer
    implements StructuredSerializer<DocumentUIState> {
  @override
  final Iterable<Type> types = const [DocumentUIState, _$DocumentUIState];
  @override
  final String wireName = 'DocumentUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, DocumentUIState object,
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
            specifiedType: const FullType(DocumentEntity)));
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
  DocumentUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(DocumentEntity)) as DocumentEntity);
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

class _$DocumentState extends DocumentState {
  @override
  final BuiltMap<String, DocumentEntity> map;
  @override
  final BuiltList<String> list;

  factory _$DocumentState([void Function(DocumentStateBuilder) updates]) =>
      (new DocumentStateBuilder()..update(updates)).build();

  _$DocumentState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('DocumentState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('DocumentState', 'list');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DocumentState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class DocumentStateBuilder
    implements Builder<DocumentState, DocumentStateBuilder> {
  _$DocumentState _$v;

  MapBuilder<String, DocumentEntity> _map;
  MapBuilder<String, DocumentEntity> get map =>
      _$this._map ??= new MapBuilder<String, DocumentEntity>();
  set map(MapBuilder<String, DocumentEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  DocumentStateBuilder();

  DocumentStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocumentState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DocumentState;
  }

  @override
  void update(void Function(DocumentStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DocumentState build() {
    _$DocumentState _$result;
    try {
      _$result =
          _$v ?? new _$DocumentState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DocumentState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DocumentUIState extends DocumentUIState {
  @override
  final DocumentEntity editing;
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

  factory _$DocumentUIState([void Function(DocumentUIStateBuilder) updates]) =>
      (new DocumentUIStateBuilder()..update(updates)).build();

  _$DocumentUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('DocumentUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('DocumentUIState', 'tabIndex');
    }
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
    return (newBuiltValueToStringHelper('DocumentUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class DocumentUIStateBuilder
    implements Builder<DocumentUIState, DocumentUIStateBuilder> {
  _$DocumentUIState _$v;

  DocumentEntityBuilder _editing;
  DocumentEntityBuilder get editing =>
      _$this._editing ??= new DocumentEntityBuilder();
  set editing(DocumentEntityBuilder editing) => _$this._editing = editing;

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

  DocumentUIStateBuilder();

  DocumentUIStateBuilder get _$this {
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
  void replace(DocumentUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DocumentUIState;
  }

  @override
  void update(void Function(DocumentUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DocumentUIState build() {
    _$DocumentUIState _$result;
    try {
      _$result = _$v ??
          new _$DocumentUIState._(
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
            'DocumentUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
