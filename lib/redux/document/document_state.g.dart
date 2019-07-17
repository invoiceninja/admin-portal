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
              const [const FullType(int), const FullType(DocumentEntity)])),
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
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(DocumentEntity)
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
            specifiedType: const FullType(DocumentEntity)));
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

class _$DocumentState extends DocumentState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, DocumentEntity> map;
  @override
  final BuiltList<int> list;

  factory _$DocumentState([void Function(DocumentStateBuilder) updates]) =>
      (new DocumentStateBuilder()..update(updates)).build();

  _$DocumentState._({this.lastUpdated, this.map, this.list}) : super._() {
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
    return other is DocumentState &&
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
    return (newBuiltValueToStringHelper('DocumentState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class DocumentStateBuilder
    implements Builder<DocumentState, DocumentStateBuilder> {
  _$DocumentState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, DocumentEntity> _map;
  MapBuilder<int, DocumentEntity> get map =>
      _$this._map ??= new MapBuilder<int, DocumentEntity>();
  set map(MapBuilder<int, DocumentEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  DocumentStateBuilder();

  DocumentStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
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
      _$result = _$v ??
          new _$DocumentState._(
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
  final int selectedId;
  @override
  final ListUIState listUIState;

  factory _$DocumentUIState([void Function(DocumentUIStateBuilder) updates]) =>
      (new DocumentUIStateBuilder()..update(updates)).build();

  _$DocumentUIState._({this.editing, this.selectedId, this.listUIState})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('DocumentUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('DocumentUIState', 'listUIState');
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
        selectedId == other.selectedId &&
        listUIState == other.listUIState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, editing.hashCode), selectedId.hashCode),
        listUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DocumentUIState')
          ..add('editing', editing)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState))
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

  int _selectedId;
  int get selectedId => _$this._selectedId;
  set selectedId(int selectedId) => _$this._selectedId = selectedId;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  DocumentUIStateBuilder();

  DocumentUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
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
              selectedId: selectedId,
              listUIState: listUIState.build());
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
