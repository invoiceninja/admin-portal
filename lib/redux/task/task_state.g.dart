// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaskState> _$taskStateSerializer = new _$TaskStateSerializer();
Serializer<TaskUIState> _$taskUIStateSerializer = new _$TaskUIStateSerializer();

class _$TaskStateSerializer implements StructuredSerializer<TaskState> {
  @override
  final Iterable<Type> types = const [TaskState, _$TaskState];
  @override
  final String wireName = 'TaskState';

  @override
  Iterable<Object> serialize(Serializers serializers, TaskState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(TaskEntity)])),
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
  TaskState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskStateBuilder();

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
                const FullType(TaskEntity)
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

class _$TaskUIStateSerializer implements StructuredSerializer<TaskUIState> {
  @override
  final Iterable<Type> types = const [TaskUIState, _$TaskUIState];
  @override
  final String wireName = 'TaskUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, TaskUIState object,
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
            specifiedType: const FullType(TaskEntity)));
    }
    if (object.editingTime != null) {
      result
        ..add('editingTime')
        ..add(serializers.serialize(object.editingTime,
            specifiedType: const FullType(TaskTime)));
    }
    return result;
  }

  @override
  TaskUIState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskEntity)) as TaskEntity);
          break;
        case 'editingTime':
          result.editingTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskTime)) as TaskTime);
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

class _$TaskState extends TaskState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, TaskEntity> map;
  @override
  final BuiltList<int> list;

  factory _$TaskState([void Function(TaskStateBuilder) updates]) =>
      (new TaskStateBuilder()..update(updates)).build();

  _$TaskState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('TaskState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('TaskState', 'list');
    }
  }

  @override
  TaskState rebuild(void Function(TaskStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskStateBuilder toBuilder() => new TaskStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskState &&
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
    return (newBuiltValueToStringHelper('TaskState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TaskStateBuilder implements Builder<TaskState, TaskStateBuilder> {
  _$TaskState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, TaskEntity> _map;
  MapBuilder<int, TaskEntity> get map =>
      _$this._map ??= new MapBuilder<int, TaskEntity>();
  set map(MapBuilder<int, TaskEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  TaskStateBuilder();

  TaskStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskState;
  }

  @override
  void update(void Function(TaskStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskState build() {
    _$TaskState _$result;
    try {
      _$result = _$v ??
          new _$TaskState._(
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
            'TaskState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaskUIState extends TaskUIState {
  @override
  final TaskEntity editing;
  @override
  final TaskTime editingTime;
  @override
  final int selectedId;
  @override
  final ListUIState listUIState;
  @override
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;

  factory _$TaskUIState([void Function(TaskUIStateBuilder) updates]) =>
      (new TaskUIStateBuilder()..update(updates)).build();

  _$TaskUIState._(
      {this.editing,
      this.editingTime,
      this.selectedId,
      this.listUIState,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('TaskUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('TaskUIState', 'listUIState');
    }
  }

  @override
  TaskUIState rebuild(void Function(TaskUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskUIStateBuilder toBuilder() => new TaskUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskUIState &&
        editing == other.editing &&
        editingTime == other.editingTime &&
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
                $jc($jc($jc(0, editing.hashCode), editingTime.hashCode),
                    selectedId.hashCode),
                listUIState.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskUIState')
          ..add('editing', editing)
          ..add('editingTime', editingTime)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class TaskUIStateBuilder implements Builder<TaskUIState, TaskUIStateBuilder> {
  _$TaskUIState _$v;

  TaskEntityBuilder _editing;
  TaskEntityBuilder get editing => _$this._editing ??= new TaskEntityBuilder();
  set editing(TaskEntityBuilder editing) => _$this._editing = editing;

  TaskTimeBuilder _editingTime;
  TaskTimeBuilder get editingTime =>
      _$this._editingTime ??= new TaskTimeBuilder();
  set editingTime(TaskTimeBuilder editingTime) =>
      _$this._editingTime = editingTime;

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

  TaskUIStateBuilder();

  TaskUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingTime = _$v.editingTime?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
      _saveCompleter = _$v.saveCompleter;
      _cancelCompleter = _$v.cancelCompleter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskUIState;
  }

  @override
  void update(void Function(TaskUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskUIState build() {
    _$TaskUIState _$result;
    try {
      _$result = _$v ??
          new _$TaskUIState._(
              editing: _editing?.build(),
              editingTime: _editingTime?.build(),
              selectedId: selectedId,
              listUIState: listUIState.build(),
              saveCompleter: saveCompleter,
              cancelCompleter: cancelCompleter);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();
        _$failedField = 'editingTime';
        _editingTime?.build();

        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaskUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
