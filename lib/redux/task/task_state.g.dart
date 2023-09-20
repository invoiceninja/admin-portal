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
  Iterable<Object?> serialize(Serializers serializers, TaskState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
  TaskState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskStateBuilder();

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
                const FullType(TaskEntity)
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

class _$TaskUIStateSerializer implements StructuredSerializer<TaskUIState> {
  @override
  final Iterable<Type> types = const [TaskUIState, _$TaskUIState];
  @override
  final String wireName = 'TaskUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, TaskUIState object,
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
            specifiedType: const FullType(TaskEntity)));
    }
    value = object.kanbanLastUpdated;
    if (value != null) {
      result
        ..add('kanbanLastUpdated')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  TaskUIState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskEntity))! as TaskEntity);
          break;
        case 'kanbanLastUpdated':
          result.kanbanLastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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

class _$TaskState extends TaskState {
  @override
  final BuiltMap<String, TaskEntity> map;
  @override
  final BuiltList<String> list;

  factory _$TaskState([void Function(TaskStateBuilder)? updates]) =>
      (new TaskStateBuilder()..update(updates))._build();

  _$TaskState._({required this.map, required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'TaskState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, r'TaskState', 'list');
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
    return (newBuiltValueToStringHelper(r'TaskState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TaskStateBuilder implements Builder<TaskState, TaskStateBuilder> {
  _$TaskState? _$v;

  MapBuilder<String, TaskEntity>? _map;
  MapBuilder<String, TaskEntity> get map =>
      _$this._map ??= new MapBuilder<String, TaskEntity>();
  set map(MapBuilder<String, TaskEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  TaskStateBuilder();

  TaskStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskState;
  }

  @override
  void update(void Function(TaskStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskState build() => _build();

  _$TaskState _build() {
    _$TaskState _$result;
    try {
      _$result = _$v ?? new _$TaskState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaskState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaskUIState extends TaskUIState {
  @override
  final TaskEntity? editing;
  @override
  final int? editingTimeIndex;
  @override
  final int? kanbanLastUpdated;
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

  factory _$TaskUIState([void Function(TaskUIStateBuilder)? updates]) =>
      (new TaskUIStateBuilder()..update(updates))._build();

  _$TaskUIState._(
      {this.editing,
      this.editingTimeIndex,
      this.kanbanLastUpdated,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'TaskUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(tabIndex, r'TaskUIState', 'tabIndex');
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
        kanbanLastUpdated == other.kanbanLastUpdated &&
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
    _$hash = $jc(_$hash, editingTimeIndex.hashCode);
    _$hash = $jc(_$hash, kanbanLastUpdated.hashCode);
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
    return (newBuiltValueToStringHelper(r'TaskUIState')
          ..add('editing', editing)
          ..add('editingTimeIndex', editingTimeIndex)
          ..add('kanbanLastUpdated', kanbanLastUpdated)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('forceSelected', forceSelected)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class TaskUIStateBuilder implements Builder<TaskUIState, TaskUIStateBuilder> {
  _$TaskUIState? _$v;

  TaskEntityBuilder? _editing;
  TaskEntityBuilder get editing => _$this._editing ??= new TaskEntityBuilder();
  set editing(TaskEntityBuilder? editing) => _$this._editing = editing;

  int? _editingTimeIndex;
  int? get editingTimeIndex => _$this._editingTimeIndex;
  set editingTimeIndex(int? editingTimeIndex) =>
      _$this._editingTimeIndex = editingTimeIndex;

  int? _kanbanLastUpdated;
  int? get kanbanLastUpdated => _$this._kanbanLastUpdated;
  set kanbanLastUpdated(int? kanbanLastUpdated) =>
      _$this._kanbanLastUpdated = kanbanLastUpdated;

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

  TaskUIStateBuilder();

  TaskUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _editing = $v.editing?.toBuilder();
      _editingTimeIndex = $v.editingTimeIndex;
      _kanbanLastUpdated = $v.kanbanLastUpdated;
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
  void replace(TaskUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskUIState;
  }

  @override
  void update(void Function(TaskUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskUIState build() => _build();

  _$TaskUIState _build() {
    _$TaskUIState _$result;
    try {
      _$result = _$v ??
          new _$TaskUIState._(
              editing: _editing?.build(),
              editingTimeIndex: editingTimeIndex,
              kanbanLastUpdated: kanbanLastUpdated,
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'TaskUIState', 'tabIndex'),
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
            r'TaskUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
