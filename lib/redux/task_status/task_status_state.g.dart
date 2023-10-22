// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_status_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaskStatusState> _$taskStatusStateSerializer =
    new _$TaskStatusStateSerializer();
Serializer<TaskStatusUIState> _$taskStatusUIStateSerializer =
    new _$TaskStatusUIStateSerializer();

class _$TaskStatusStateSerializer
    implements StructuredSerializer<TaskStatusState> {
  @override
  final Iterable<Type> types = const [TaskStatusState, _$TaskStatusState];
  @override
  final String wireName = 'TaskStatusState';

  @override
  Iterable<Object?> serialize(Serializers serializers, TaskStatusState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(TaskStatusEntity)
          ])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  TaskStatusState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskStatusStateBuilder();

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
                const FullType(TaskStatusEntity)
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

class _$TaskStatusUIStateSerializer
    implements StructuredSerializer<TaskStatusUIState> {
  @override
  final Iterable<Type> types = const [TaskStatusUIState, _$TaskStatusUIState];
  @override
  final String wireName = 'TaskStatusUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, TaskStatusUIState object,
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
            specifiedType: const FullType(TaskStatusEntity)));
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
  TaskStatusUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskStatusUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TaskStatusEntity))!
              as TaskStatusEntity);
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

class _$TaskStatusState extends TaskStatusState {
  @override
  final BuiltMap<String, TaskStatusEntity> map;
  @override
  final BuiltList<String> list;

  factory _$TaskStatusState([void Function(TaskStatusStateBuilder)? updates]) =>
      (new TaskStatusStateBuilder()..update(updates))._build();

  _$TaskStatusState._({required this.map, required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, r'TaskStatusState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, r'TaskStatusState', 'list');
  }

  @override
  TaskStatusState rebuild(void Function(TaskStatusStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskStatusStateBuilder toBuilder() =>
      new TaskStatusStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskStatusState && map == other.map && list == other.list;
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
    return (newBuiltValueToStringHelper(r'TaskStatusState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class TaskStatusStateBuilder
    implements Builder<TaskStatusState, TaskStatusStateBuilder> {
  _$TaskStatusState? _$v;

  MapBuilder<String, TaskStatusEntity>? _map;
  MapBuilder<String, TaskStatusEntity> get map =>
      _$this._map ??= new MapBuilder<String, TaskStatusEntity>();
  set map(MapBuilder<String, TaskStatusEntity>? map) => _$this._map = map;

  ListBuilder<String>? _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String>? list) => _$this._list = list;

  TaskStatusStateBuilder();

  TaskStatusStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskStatusState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskStatusState;
  }

  @override
  void update(void Function(TaskStatusStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskStatusState build() => _build();

  _$TaskStatusState _build() {
    _$TaskStatusState _$result;
    try {
      _$result =
          _$v ?? new _$TaskStatusState._(map: map.build(), list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaskStatusState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaskStatusUIState extends TaskStatusUIState {
  @override
  final TaskStatusEntity? editing;
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

  factory _$TaskStatusUIState(
          [void Function(TaskStatusUIStateBuilder)? updates]) =>
      (new TaskStatusUIStateBuilder()..update(updates))._build();

  _$TaskStatusUIState._(
      {this.editing,
      required this.listUIState,
      this.selectedId,
      this.forceSelected,
      required this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, r'TaskStatusUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'TaskStatusUIState', 'tabIndex');
  }

  @override
  TaskStatusUIState rebuild(void Function(TaskStatusUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskStatusUIStateBuilder toBuilder() =>
      new TaskStatusUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskStatusUIState &&
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
    return (newBuiltValueToStringHelper(r'TaskStatusUIState')
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

class TaskStatusUIStateBuilder
    implements Builder<TaskStatusUIState, TaskStatusUIStateBuilder> {
  _$TaskStatusUIState? _$v;

  TaskStatusEntityBuilder? _editing;
  TaskStatusEntityBuilder get editing =>
      _$this._editing ??= new TaskStatusEntityBuilder();
  set editing(TaskStatusEntityBuilder? editing) => _$this._editing = editing;

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

  TaskStatusUIStateBuilder();

  TaskStatusUIStateBuilder get _$this {
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
  void replace(TaskStatusUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskStatusUIState;
  }

  @override
  void update(void Function(TaskStatusUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskStatusUIState build() => _build();

  _$TaskStatusUIState _build() {
    _$TaskStatusUIState _$result;
    try {
      _$result = _$v ??
          new _$TaskStatusUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'TaskStatusUIState', 'tabIndex'),
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
            r'TaskStatusUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
