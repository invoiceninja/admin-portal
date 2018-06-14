// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_state.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<ClientState> _$clientStateSerializer = new _$ClientStateSerializer();

class _$ClientStateSerializer implements StructuredSerializer<ClientState> {
  @override
  final Iterable<Type> types = const [ClientState, _$ClientState];
  @override
  final String wireName = 'ClientState';

  @override
  Iterable serialize(Serializers serializers, ClientState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
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
    if (object.editing != null) {
      result
        ..add('editing')
        ..add(serializers.serialize(object.editing,
            specifiedType: const FullType(ClientEntity)));
    }
    if (object.editingFor != null) {
      result
        ..add('editingFor')
        ..add(serializers.serialize(object.editingFor,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  ClientState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ClientStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(ClientEntity)
              ])) as BuiltMap);
          break;
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList);
          break;
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity)) as ClientEntity);
          break;
        case 'editingFor':
          result.editingFor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ClientState extends ClientState {
  @override
  final bool isLoading;
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, ClientEntity> map;
  @override
  final BuiltList<int> list;
  @override
  final ClientEntity editing;
  @override
  final String editingFor;

  factory _$ClientState([void updates(ClientStateBuilder b)]) =>
      (new ClientStateBuilder()..update(updates)).build();

  _$ClientState._(
      {this.isLoading,
      this.lastUpdated,
      this.map,
      this.list,
      this.editing,
      this.editingFor})
      : super._() {
    if (isLoading == null)
      throw new BuiltValueNullFieldError('ClientState', 'isLoading');
    if (map == null) throw new BuiltValueNullFieldError('ClientState', 'map');
    if (list == null) throw new BuiltValueNullFieldError('ClientState', 'list');
  }

  @override
  ClientState rebuild(void updates(ClientStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientStateBuilder toBuilder() => new ClientStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ClientState) return false;
    return isLoading == other.isLoading &&
        lastUpdated == other.lastUpdated &&
        map == other.map &&
        list == other.list &&
        editing == other.editing &&
        editingFor == other.editingFor;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, isLoading.hashCode), lastUpdated.hashCode),
                    map.hashCode),
                list.hashCode),
            editing.hashCode),
        editingFor.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientState')
          ..add('isLoading', isLoading)
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list)
          ..add('editing', editing)
          ..add('editingFor', editingFor))
        .toString();
  }
}

class ClientStateBuilder implements Builder<ClientState, ClientStateBuilder> {
  _$ClientState _$v;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

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

  ClientEntityBuilder _editing;
  ClientEntityBuilder get editing =>
      _$this._editing ??= new ClientEntityBuilder();
  set editing(ClientEntityBuilder editing) => _$this._editing = editing;

  String _editingFor;
  String get editingFor => _$this._editingFor;
  set editingFor(String editingFor) => _$this._editingFor = editingFor;

  ClientStateBuilder();

  ClientStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _editing = _$v.editing?.toBuilder();
      _editingFor = _$v.editingFor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ClientState;
  }

  @override
  void update(void updates(ClientStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ClientState build() {
    _$ClientState _$result;
    try {
      _$result = _$v ??
          new _$ClientState._(
              isLoading: isLoading,
              lastUpdated: lastUpdated,
              map: map.build(),
              list: list.build(),
              editing: _editing?.build(),
              editingFor: editingFor);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
        _$failedField = 'editing';
        _editing?.build();
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
