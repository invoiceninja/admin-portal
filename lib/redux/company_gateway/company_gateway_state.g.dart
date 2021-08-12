// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_gateway_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompanyGatewayState> _$companyGatewayStateSerializer =
    new _$CompanyGatewayStateSerializer();
Serializer<CompanyGatewayUIState> _$companyGatewayUIStateSerializer =
    new _$CompanyGatewayUIStateSerializer();

class _$CompanyGatewayStateSerializer
    implements StructuredSerializer<CompanyGatewayState> {
  @override
  final Iterable<Type> types = const [
    CompanyGatewayState,
    _$CompanyGatewayState
  ];
  @override
  final String wireName = 'CompanyGatewayState';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CompanyGatewayState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(CompanyGatewayEntity)
          ])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  CompanyGatewayState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyGatewayStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(CompanyGatewayEntity)
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

class _$CompanyGatewayUIStateSerializer
    implements StructuredSerializer<CompanyGatewayUIState> {
  @override
  final Iterable<Type> types = const [
    CompanyGatewayUIState,
    _$CompanyGatewayUIState
  ];
  @override
  final String wireName = 'CompanyGatewayUIState';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CompanyGatewayUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'listUIState',
      serializers.serialize(object.listUIState,
          specifiedType: const FullType(ListUIState)),
      'tabIndex',
      serializers.serialize(object.tabIndex,
          specifiedType: const FullType(int)),
    ];
    Object value;
    value = object.editing;
    if (value != null) {
      result
        ..add('editing')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(CompanyGatewayEntity)));
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
  CompanyGatewayUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyGatewayUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CompanyGatewayEntity))
              as CompanyGatewayEntity);
          break;
        case 'listUIState':
          result.listUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ListUIState)) as ListUIState);
          break;
        case 'selectedId':
          result.selectedId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'forceSelected':
          result.forceSelected = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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

class _$CompanyGatewayState extends CompanyGatewayState {
  @override
  final BuiltMap<String, CompanyGatewayEntity> map;
  @override
  final BuiltList<String> list;

  factory _$CompanyGatewayState(
          [void Function(CompanyGatewayStateBuilder) updates]) =>
      (new CompanyGatewayStateBuilder()..update(updates)).build();

  _$CompanyGatewayState._({this.map, this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(map, 'CompanyGatewayState', 'map');
    BuiltValueNullFieldError.checkNotNull(list, 'CompanyGatewayState', 'list');
  }

  @override
  CompanyGatewayState rebuild(
          void Function(CompanyGatewayStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyGatewayStateBuilder toBuilder() =>
      new CompanyGatewayStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyGatewayState &&
        map == other.map &&
        list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyGatewayState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class CompanyGatewayStateBuilder
    implements Builder<CompanyGatewayState, CompanyGatewayStateBuilder> {
  _$CompanyGatewayState _$v;

  MapBuilder<String, CompanyGatewayEntity> _map;
  MapBuilder<String, CompanyGatewayEntity> get map =>
      _$this._map ??= new MapBuilder<String, CompanyGatewayEntity>();
  set map(MapBuilder<String, CompanyGatewayEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  CompanyGatewayStateBuilder();

  CompanyGatewayStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _map = $v.map.toBuilder();
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyGatewayState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompanyGatewayState;
  }

  @override
  void update(void Function(CompanyGatewayStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyGatewayState build() {
    _$CompanyGatewayState _$result;
    try {
      _$result = _$v ??
          new _$CompanyGatewayState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyGatewayState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CompanyGatewayUIState extends CompanyGatewayUIState {
  @override
  final CompanyGatewayEntity editing;
  @override
  final ListUIState listUIState;
  @override
  final String selectedId;
  @override
  final bool forceSelected;
  @override
  final int tabIndex;
  @override
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;

  factory _$CompanyGatewayUIState(
          [void Function(CompanyGatewayUIStateBuilder) updates]) =>
      (new CompanyGatewayUIStateBuilder()..update(updates)).build();

  _$CompanyGatewayUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.forceSelected,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listUIState, 'CompanyGatewayUIState', 'listUIState');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, 'CompanyGatewayUIState', 'tabIndex');
  }

  @override
  CompanyGatewayUIState rebuild(
          void Function(CompanyGatewayUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyGatewayUIStateBuilder toBuilder() =>
      new CompanyGatewayUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyGatewayUIState &&
        editing == other.editing &&
        listUIState == other.listUIState &&
        selectedId == other.selectedId &&
        forceSelected == other.forceSelected &&
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
                    $jc($jc($jc(0, editing.hashCode), listUIState.hashCode),
                        selectedId.hashCode),
                    forceSelected.hashCode),
                tabIndex.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyGatewayUIState')
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

class CompanyGatewayUIStateBuilder
    implements Builder<CompanyGatewayUIState, CompanyGatewayUIStateBuilder> {
  _$CompanyGatewayUIState _$v;

  CompanyGatewayEntityBuilder _editing;
  CompanyGatewayEntityBuilder get editing =>
      _$this._editing ??= new CompanyGatewayEntityBuilder();
  set editing(CompanyGatewayEntityBuilder editing) => _$this._editing = editing;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  String _selectedId;
  String get selectedId => _$this._selectedId;
  set selectedId(String selectedId) => _$this._selectedId = selectedId;

  bool _forceSelected;
  bool get forceSelected => _$this._forceSelected;
  set forceSelected(bool forceSelected) =>
      _$this._forceSelected = forceSelected;

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

  CompanyGatewayUIStateBuilder();

  CompanyGatewayUIStateBuilder get _$this {
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
  void replace(CompanyGatewayUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompanyGatewayUIState;
  }

  @override
  void update(void Function(CompanyGatewayUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyGatewayUIState build() {
    _$CompanyGatewayUIState _$result;
    try {
      _$result = _$v ??
          new _$CompanyGatewayUIState._(
              editing: _editing?.build(),
              listUIState: listUIState.build(),
              selectedId: selectedId,
              forceSelected: forceSelected,
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, 'CompanyGatewayUIState', 'tabIndex'),
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
            'CompanyGatewayUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
