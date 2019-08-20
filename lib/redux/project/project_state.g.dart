// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectState> _$projectStateSerializer =
    new _$ProjectStateSerializer();
Serializer<ProjectUIState> _$projectUIStateSerializer =
    new _$ProjectUIStateSerializer();

class _$ProjectStateSerializer implements StructuredSerializer<ProjectState> {
  @override
  final Iterable<Type> types = const [ProjectState, _$ProjectState];
  @override
  final String wireName = 'ProjectState';

  @override
  Iterable<Object> serialize(Serializers serializers, ProjectState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(ProjectEntity)])),
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
  ProjectState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectStateBuilder();

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
                const FullType(ProjectEntity)
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

class _$ProjectUIStateSerializer
    implements StructuredSerializer<ProjectUIState> {
  @override
  final Iterable<Type> types = const [ProjectUIState, _$ProjectUIState];
  @override
  final String wireName = 'ProjectUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, ProjectUIState object,
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
            specifiedType: const FullType(ProjectEntity)));
    }
    return result;
  }

  @override
  ProjectUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProjectEntity)) as ProjectEntity);
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

class _$ProjectState extends ProjectState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, ProjectEntity> map;
  @override
  final BuiltList<int> list;

  factory _$ProjectState([void Function(ProjectStateBuilder) updates]) =>
      (new ProjectStateBuilder()..update(updates)).build();

  _$ProjectState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('ProjectState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('ProjectState', 'list');
    }
  }

  @override
  ProjectState rebuild(void Function(ProjectStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectStateBuilder toBuilder() => new ProjectStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectState &&
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
    return (newBuiltValueToStringHelper('ProjectState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ProjectStateBuilder
    implements Builder<ProjectState, ProjectStateBuilder> {
  _$ProjectState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, ProjectEntity> _map;
  MapBuilder<int, ProjectEntity> get map =>
      _$this._map ??= new MapBuilder<int, ProjectEntity>();
  set map(MapBuilder<int, ProjectEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  ProjectStateBuilder();

  ProjectStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProjectState;
  }

  @override
  void update(void Function(ProjectStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectState build() {
    _$ProjectState _$result;
    try {
      _$result = _$v ??
          new _$ProjectState._(
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
            'ProjectState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProjectUIState extends ProjectUIState {
  @override
  final ProjectEntity editing;
  @override
  final int selectedId;
  @override
  final ListUIState listUIState;
  @override
  final Completer<SelectableEntity> saveCompleter;

  factory _$ProjectUIState([void Function(ProjectUIStateBuilder) updates]) =>
      (new ProjectUIStateBuilder()..update(updates)).build();

  _$ProjectUIState._(
      {this.editing, this.selectedId, this.listUIState, this.saveCompleter})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('ProjectUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('ProjectUIState', 'listUIState');
    }
  }

  @override
  ProjectUIState rebuild(void Function(ProjectUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectUIStateBuilder toBuilder() =>
      new ProjectUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectUIState &&
        editing == other.editing &&
        selectedId == other.selectedId &&
        listUIState == other.listUIState &&
        saveCompleter == other.saveCompleter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, editing.hashCode), selectedId.hashCode),
            listUIState.hashCode),
        saveCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectUIState')
          ..add('editing', editing)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState)
          ..add('saveCompleter', saveCompleter))
        .toString();
  }
}

class ProjectUIStateBuilder
    implements Builder<ProjectUIState, ProjectUIStateBuilder> {
  _$ProjectUIState _$v;

  ProjectEntityBuilder _editing;
  ProjectEntityBuilder get editing =>
      _$this._editing ??= new ProjectEntityBuilder();
  set editing(ProjectEntityBuilder editing) => _$this._editing = editing;

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

  ProjectUIStateBuilder();

  ProjectUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
      _saveCompleter = _$v.saveCompleter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProjectUIState;
  }

  @override
  void update(void Function(ProjectUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectUIState build() {
    _$ProjectUIState _$result;
    try {
      _$result = _$v ??
          new _$ProjectUIState._(
              editing: _editing?.build(),
              selectedId: selectedId,
              listUIState: listUIState.build(),
              saveCompleter: saveCompleter);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();

        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProjectUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
