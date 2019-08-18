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
              const [const FullType(int), const FullType(ClientEntity)])),
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
  ClientState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientStateBuilder();

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
                const FullType(ClientEntity)
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

class _$ClientUIStateSerializer implements StructuredSerializer<ClientUIState> {
  @override
  final Iterable<Type> types = const [ClientUIState, _$ClientUIState];
  @override
  final String wireName = 'ClientUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, ClientUIState object,
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
            specifiedType: const FullType(ClientEntity)));
    }
    if (object.editingContact != null) {
      result
        ..add('editingContact')
        ..add(serializers.serialize(object.editingContact,
            specifiedType: const FullType(ContactEntity)));
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

class _$ClientState extends ClientState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, ClientEntity> map;
  @override
  final BuiltList<int> list;

  factory _$ClientState([void Function(ClientStateBuilder) updates]) =>
      (new ClientStateBuilder()..update(updates)).build();

  _$ClientState._({this.lastUpdated, this.map, this.list}) : super._() {
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
    return other is ClientState &&
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
    return (newBuiltValueToStringHelper('ClientState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ClientStateBuilder implements Builder<ClientState, ClientStateBuilder> {
  _$ClientState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, ClientEntity> _map;
  MapBuilder<int, ClientEntity> get map =>
      _$this._map ??= new MapBuilder<int, ClientEntity>();
  set map(MapBuilder<int, ClientEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  ClientStateBuilder();

  ClientStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
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
      _$result = _$v ??
          new _$ClientState._(
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
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;
  @override
  final int selectedId;
  @override
  final ListUIState listUIState;

  factory _$ClientUIState([void Function(ClientUIStateBuilder) updates]) =>
      (new ClientUIStateBuilder()..update(updates)).build();

  _$ClientUIState._(
      {this.editing,
      this.editingContact,
      this.saveCompleter,
      this.cancelCompleter,
      this.selectedId,
      this.listUIState})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('ClientUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('ClientUIState', 'listUIState');
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
        saveCompleter == other.saveCompleter &&
        cancelCompleter == other.cancelCompleter &&
        selectedId == other.selectedId &&
        listUIState == other.listUIState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, editing.hashCode), editingContact.hashCode),
                    saveCompleter.hashCode),
                cancelCompleter.hashCode),
            selectedId.hashCode),
        listUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientUIState')
          ..add('editing', editing)
          ..add('editingContact', editingContact)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState))
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

  Completer<SelectableEntity> _saveCompleter;
  Completer<SelectableEntity> get saveCompleter => _$this._saveCompleter;
  set saveCompleter(Completer<SelectableEntity> saveCompleter) =>
      _$this._saveCompleter = saveCompleter;

  Completer<Null> _cancelCompleter;
  Completer<Null> get cancelCompleter => _$this._cancelCompleter;
  set cancelCompleter(Completer<Null> cancelCompleter) =>
      _$this._cancelCompleter = cancelCompleter;

  int _selectedId;
  int get selectedId => _$this._selectedId;
  set selectedId(int selectedId) => _$this._selectedId = selectedId;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  ClientUIStateBuilder();

  ClientUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingContact = _$v.editingContact?.toBuilder();
      _saveCompleter = _$v.saveCompleter;
      _cancelCompleter = _$v.cancelCompleter;
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
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
              saveCompleter: saveCompleter,
              cancelCompleter: cancelCompleter,
              selectedId: selectedId,
              listUIState: listUIState.build());
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
