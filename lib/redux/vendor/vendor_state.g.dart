// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VendorState> _$vendorStateSerializer = new _$VendorStateSerializer();
Serializer<VendorUIState> _$vendorUIStateSerializer =
    new _$VendorUIStateSerializer();

class _$VendorStateSerializer implements StructuredSerializer<VendorState> {
  @override
  final Iterable<Type> types = const [VendorState, _$VendorState];
  @override
  final String wireName = 'VendorState';

  @override
  Iterable<Object> serialize(Serializers serializers, VendorState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(VendorEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  VendorState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorStateBuilder();

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
                const FullType(VendorEntity)
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

class _$VendorUIStateSerializer implements StructuredSerializer<VendorUIState> {
  @override
  final Iterable<Type> types = const [VendorUIState, _$VendorUIState];
  @override
  final String wireName = 'VendorUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, VendorUIState object,
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
            specifiedType: const FullType(VendorEntity)));
    }
    if (object.editingContact != null) {
      result
        ..add('editingContact')
        ..add(serializers.serialize(object.editingContact,
            specifiedType: const FullType(VendorContactEntity)));
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
  VendorUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(VendorEntity)) as VendorEntity);
          break;
        case 'editingContact':
          result.editingContact.replace(serializers.deserialize(value,
                  specifiedType: const FullType(VendorContactEntity))
              as VendorContactEntity);
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

class _$VendorState extends VendorState {
  @override
  final BuiltMap<String, VendorEntity> map;
  @override
  final BuiltList<String> list;

  factory _$VendorState([void Function(VendorStateBuilder) updates]) =>
      (new VendorStateBuilder()..update(updates)).build();

  _$VendorState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('VendorState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('VendorState', 'list');
    }
  }

  @override
  VendorState rebuild(void Function(VendorStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorStateBuilder toBuilder() => new VendorStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VendorState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class VendorStateBuilder implements Builder<VendorState, VendorStateBuilder> {
  _$VendorState _$v;

  MapBuilder<String, VendorEntity> _map;
  MapBuilder<String, VendorEntity> get map =>
      _$this._map ??= new MapBuilder<String, VendorEntity>();
  set map(MapBuilder<String, VendorEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  VendorStateBuilder();

  VendorStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VendorState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VendorState;
  }

  @override
  void update(void Function(VendorStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VendorState build() {
    _$VendorState _$result;
    try {
      _$result =
          _$v ?? new _$VendorState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VendorState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VendorUIState extends VendorUIState {
  @override
  final VendorEntity editing;
  @override
  final VendorContactEntity editingContact;
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

  factory _$VendorUIState([void Function(VendorUIStateBuilder) updates]) =>
      (new VendorUIStateBuilder()..update(updates)).build();

  _$VendorUIState._(
      {this.editing,
      this.editingContact,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('VendorUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('VendorUIState', 'tabIndex');
    }
  }

  @override
  VendorUIState rebuild(void Function(VendorUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorUIStateBuilder toBuilder() => new VendorUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorUIState &&
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
    return (newBuiltValueToStringHelper('VendorUIState')
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

class VendorUIStateBuilder
    implements Builder<VendorUIState, VendorUIStateBuilder> {
  _$VendorUIState _$v;

  VendorEntityBuilder _editing;
  VendorEntityBuilder get editing =>
      _$this._editing ??= new VendorEntityBuilder();
  set editing(VendorEntityBuilder editing) => _$this._editing = editing;

  VendorContactEntityBuilder _editingContact;
  VendorContactEntityBuilder get editingContact =>
      _$this._editingContact ??= new VendorContactEntityBuilder();
  set editingContact(VendorContactEntityBuilder editingContact) =>
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

  VendorUIStateBuilder();

  VendorUIStateBuilder get _$this {
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
  void replace(VendorUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VendorUIState;
  }

  @override
  void update(void Function(VendorUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VendorUIState build() {
    _$VendorUIState _$result;
    try {
      _$result = _$v ??
          new _$VendorUIState._(
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
            'VendorUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
