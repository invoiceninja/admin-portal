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
              const [const FullType(String), const FullType(TaskEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

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
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(TaskEntity)])));
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

class _$TaskUIStateSerializer implements StructuredSerializer<TaskUIState> {
  @override
  final Iterable<Type> types = const [TaskUIState, _$TaskUIState];
  @override
  final String wireName = 'TaskUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, TaskUIState object,
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
            specifiedType: const FullType(TaskEntity)));
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

class _$TaskState extends TaskState {
  @override
  final BuiltMap<String, TaskEntity> map;
  @override
  final BuiltList<String> list;

  factory _$TaskState([void Function(TaskStateBuilder) updates]) =>
      (new TaskStateBuilder()..update(updates)).build();

  _$TaskState._({this.map, this.list}) : super._() {
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
    return other is TaskState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TaskStateBuilder implements Builder<TaskState, TaskStateBuilder> {
  _$TaskState _$v;

  MapBuilder<String, TaskEntity> _map;
  MapBuilder<String, TaskEntity> get map =>
      _$this._map ??= new MapBuilder<String, TaskEntity>();
  set map(MapBuilder<String, TaskEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  TaskStateBuilder();

  TaskStateBuilder get _$this {
    if (_$v != null) {
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
      _$result = _$v ?? new _$TaskState._(map: map.build(), list: list.build());
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
  final int editingTimeIndex;
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

  factory _$TaskUIState([void Function(TaskUIStateBuilder) updates]) =>
      (new TaskUIStateBuilder()..update(updates)).build();

  _$TaskUIState._(
      {this.editing,
      this.editingTimeIndex,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('TaskUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('TaskUIState', 'tabIndex');
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
        editingTimeIndex == other.editingTimeIndex &&
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
                        $jc($jc(0, editing.hashCode),
                            editingTimeIndex.hashCode),
                        listUIState.hashCode),
                    selectedId.hashCode),
                tabIndex.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskUIState')
          ..add('editing', editing)
          ..add('editingTimeIndex', editingTimeIndex)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
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

  int _editingTimeIndex;
  int get editingTimeIndex => _$this._editingTimeIndex;
  set editingTimeIndex(int editingTimeIndex) =>
      _$this._editingTimeIndex = editingTimeIndex;

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

  TaskUIStateBuilder();

  TaskUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingTimeIndex = _$v.editingTimeIndex;
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
              editingTimeIndex: editingTimeIndex,
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
            'TaskUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
