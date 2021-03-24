// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WebhookState> _$webhookStateSerializer =
    new _$WebhookStateSerializer();
Serializer<WebhookUIState> _$webhookUIStateSerializer =
    new _$WebhookUIStateSerializer();

class _$WebhookStateSerializer implements StructuredSerializer<WebhookState> {
  @override
  final Iterable<Type> types = const [WebhookState, _$WebhookState];
  @override
  final String wireName = 'WebhookState';

  @override
  Iterable<Object> serialize(Serializers serializers, WebhookState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(WebhookEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  WebhookState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookStateBuilder();

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
                const FullType(WebhookEntity)
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

class _$WebhookUIStateSerializer
    implements StructuredSerializer<WebhookUIState> {
  @override
  final Iterable<Type> types = const [WebhookUIState, _$WebhookUIState];
  @override
  final String wireName = 'WebhookUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, WebhookUIState object,
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
            specifiedType: const FullType(WebhookEntity)));
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
  WebhookUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(WebhookEntity)) as WebhookEntity);
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

class _$WebhookState extends WebhookState {
  @override
  final BuiltMap<String, WebhookEntity> map;
  @override
  final BuiltList<String> list;

  factory _$WebhookState([void Function(WebhookStateBuilder) updates]) =>
      (new WebhookStateBuilder()..update(updates)).build();

  _$WebhookState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('WebhookState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('WebhookState', 'list');
    }
  }

  @override
  WebhookState rebuild(void Function(WebhookStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookStateBuilder toBuilder() => new WebhookStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WebhookState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class WebhookStateBuilder
    implements Builder<WebhookState, WebhookStateBuilder> {
  _$WebhookState _$v;

  MapBuilder<String, WebhookEntity> _map;
  MapBuilder<String, WebhookEntity> get map =>
      _$this._map ??= new MapBuilder<String, WebhookEntity>();
  set map(MapBuilder<String, WebhookEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  WebhookStateBuilder();

  WebhookStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WebhookState;
  }

  @override
  void update(void Function(WebhookStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WebhookState build() {
    _$WebhookState _$result;
    try {
      _$result =
          _$v ?? new _$WebhookState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WebhookState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WebhookUIState extends WebhookUIState {
  @override
  final WebhookEntity editing;
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

  factory _$WebhookUIState([void Function(WebhookUIStateBuilder) updates]) =>
      (new WebhookUIStateBuilder()..update(updates)).build();

  _$WebhookUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('WebhookUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('WebhookUIState', 'tabIndex');
    }
  }

  @override
  WebhookUIState rebuild(void Function(WebhookUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookUIStateBuilder toBuilder() =>
      new WebhookUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookUIState &&
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
    return (newBuiltValueToStringHelper('WebhookUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class WebhookUIStateBuilder
    implements Builder<WebhookUIState, WebhookUIStateBuilder> {
  _$WebhookUIState _$v;

  WebhookEntityBuilder _editing;
  WebhookEntityBuilder get editing =>
      _$this._editing ??= new WebhookEntityBuilder();
  set editing(WebhookEntityBuilder editing) => _$this._editing = editing;

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

  WebhookUIStateBuilder();

  WebhookUIStateBuilder get _$this {
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
  void replace(WebhookUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WebhookUIState;
  }

  @override
  void update(void Function(WebhookUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WebhookUIState build() {
    _$WebhookUIState _$result;
    try {
      _$result = _$v ??
          new _$WebhookUIState._(
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
            'WebhookUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
