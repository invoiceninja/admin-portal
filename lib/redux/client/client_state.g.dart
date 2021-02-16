// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ClientState> _$clientStateSerializer = new _$ClientStateSerializer();
Serializer<ClientUIState> _$clientUIStateSerializer =
    new _$ClientUIStateSerializer();

class _$ClientStateSerializer implements StructuredSerializer<ClientState> {
  @override
  final Iterable<Type> types = const [ClientState, _$ClientState];
  @override
  final String wireName = 'ClientState';

  @override
  Iterable<Object> serialize(Serializers serializers, ClientState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(ClientEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  ClientState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientStateBuilder();

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
                const FullType(ClientEntity)
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

class _$ClientUIStateSerializer implements StructuredSerializer<ClientUIState> {
  @override
  final Iterable<Type> types = const [ClientUIState, _$ClientUIState];
  @override
  final String wireName = 'ClientUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, ClientUIState object,
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
            specifiedType: const FullType(ClientEntity)));
    }
    if (object.editingContact != null) {
      result
        ..add('editingContact')
        ..add(serializers.serialize(object.editingContact,
            specifiedType: const FullType(ContactEntity)));
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
  ClientUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity)) as ClientEntity);
          break;
        case 'editingContact':
          result.editingContact.replace(serializers.deserialize(value,
              specifiedType: const FullType(ContactEntity)) as ContactEntity);
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

class _$ClientState extends ClientState {
  @override
  final BuiltMap<String, ClientEntity> map;
  @override
  final BuiltList<String> list;

  factory _$ClientState([void Function(ClientStateBuilder) updates]) =>
      (new ClientStateBuilder()..update(updates)).build();

  _$ClientState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('ClientState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('ClientState', 'list');
    }
  }

  @override
  ClientState rebuild(void Function(ClientStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientStateBuilder toBuilder() => new ClientStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClientState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ClientStateBuilder implements Builder<ClientState, ClientStateBuilder> {
  _$ClientState _$v;

  MapBuilder<String, ClientEntity> _map;
  MapBuilder<String, ClientEntity> get map =>
      _$this._map ??= new MapBuilder<String, ClientEntity>();
  set map(MapBuilder<String, ClientEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  ClientStateBuilder();

  ClientStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ClientState;
  }

  @override
  void update(void Function(ClientStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ClientState build() {
    _$ClientState _$result;
    try {
      _$result =
          _$v ?? new _$ClientState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ClientState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ClientUIState extends ClientUIState {
  @override
  final ClientEntity editing;
  @override
  final ContactEntity editingContact;
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

  factory _$ClientUIState([void Function(ClientUIStateBuilder) updates]) =>
      (new ClientUIStateBuilder()..update(updates)).build();

  _$ClientUIState._(
      {this.editing,
      this.editingContact,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('ClientUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('ClientUIState', 'tabIndex');
    }
  }

  @override
  ClientUIState rebuild(void Function(ClientUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientUIStateBuilder toBuilder() => new ClientUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClientUIState &&
        editing == other.editing &&
        editingContact == other.editingContact &&
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
                    $jc($jc($jc(0, editing.hashCode), editingContact.hashCode),
                        listUIState.hashCode),
                    selectedId.hashCode),
                tabIndex.hashCode),
            saveCompleter.hashCode),
        cancelCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientUIState')
          ..add('editing', editing)
          ..add('editingContact', editingContact)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class ClientUIStateBuilder
    implements Builder<ClientUIState, ClientUIStateBuilder> {
  _$ClientUIState _$v;

  ClientEntityBuilder _editing;
  ClientEntityBuilder get editing =>
      _$this._editing ??= new ClientEntityBuilder();
  set editing(ClientEntityBuilder editing) => _$this._editing = editing;

  ContactEntityBuilder _editingContact;
  ContactEntityBuilder get editingContact =>
      _$this._editingContact ??= new ContactEntityBuilder();
  set editingContact(ContactEntityBuilder editingContact) =>
      _$this._editingContact = editingContact;

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

  ClientUIStateBuilder();

  ClientUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingContact = _$v.editingContact?.toBuilder();
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
  void replace(ClientUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ClientUIState;
  }

  @override
  void update(void Function(ClientUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ClientUIState build() {
    _$ClientUIState _$result;
    try {
      _$result = _$v ??
          new _$ClientUIState._(
              editing: _editing?.build(),
              editingContact: _editingContact?.build(),
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
        _$failedField = 'editingContact';
        _editingContact?.build();
        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ClientUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
