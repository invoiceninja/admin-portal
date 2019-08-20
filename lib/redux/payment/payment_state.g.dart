// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PaymentState> _$paymentStateSerializer =
    new _$PaymentStateSerializer();
Serializer<PaymentUIState> _$paymentUIStateSerializer =
    new _$PaymentUIStateSerializer();

class _$PaymentStateSerializer implements StructuredSerializer<PaymentState> {
  @override
  final Iterable<Type> types = const [PaymentState, _$PaymentState];
  @override
  final String wireName = 'PaymentState';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(PaymentEntity)])),
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
  PaymentState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentStateBuilder();

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
                const FullType(PaymentEntity)
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

class _$PaymentUIStateSerializer
    implements StructuredSerializer<PaymentUIState> {
  @override
  final Iterable<Type> types = const [PaymentUIState, _$PaymentUIState];
  @override
  final String wireName = 'PaymentUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentUIState object,
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
            specifiedType: const FullType(PaymentEntity)));
    }
    return result;
  }

  @override
  PaymentUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(PaymentEntity)) as PaymentEntity);
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

class _$PaymentState extends PaymentState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, PaymentEntity> map;
  @override
  final BuiltList<int> list;

  factory _$PaymentState([void Function(PaymentStateBuilder) updates]) =>
      (new PaymentStateBuilder()..update(updates)).build();

  _$PaymentState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('PaymentState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('PaymentState', 'list');
    }
  }

  @override
  PaymentState rebuild(void Function(PaymentStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentStateBuilder toBuilder() => new PaymentStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentState &&
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
    return (newBuiltValueToStringHelper('PaymentState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class PaymentStateBuilder
    implements Builder<PaymentState, PaymentStateBuilder> {
  _$PaymentState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, PaymentEntity> _map;
  MapBuilder<int, PaymentEntity> get map =>
      _$this._map ??= new MapBuilder<int, PaymentEntity>();
  set map(MapBuilder<int, PaymentEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  PaymentStateBuilder();

  PaymentStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentState;
  }

  @override
  void update(void Function(PaymentStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentState build() {
    _$PaymentState _$result;
    try {
      _$result = _$v ??
          new _$PaymentState._(
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
            'PaymentState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentUIState extends PaymentUIState {
  @override
  final PaymentEntity editing;
  @override
  final int selectedId;
  @override
  final ListUIState listUIState;
  @override
  final Completer<SelectableEntity> saveCompleter;

  factory _$PaymentUIState([void Function(PaymentUIStateBuilder) updates]) =>
      (new PaymentUIStateBuilder()..update(updates)).build();

  _$PaymentUIState._(
      {this.editing, this.selectedId, this.listUIState, this.saveCompleter})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('PaymentUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('PaymentUIState', 'listUIState');
    }
  }

  @override
  PaymentUIState rebuild(void Function(PaymentUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentUIStateBuilder toBuilder() =>
      new PaymentUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentUIState &&
        editing == other.editing &&
        selectedId == other.selectedId &&
        listUIState == other.listUIState &&
        saveCompleter == other.saveCompleter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, editing.hashCode), selectedId.hashCode),
            listUIState.hashCode),
        saveCompleter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentUIState')
          ..add('editing', editing)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState)
          ..add('saveCompleter', saveCompleter))
        .toString();
  }
}

class PaymentUIStateBuilder
    implements Builder<PaymentUIState, PaymentUIStateBuilder> {
  _$PaymentUIState _$v;

  PaymentEntityBuilder _editing;
  PaymentEntityBuilder get editing =>
      _$this._editing ??= new PaymentEntityBuilder();
  set editing(PaymentEntityBuilder editing) => _$this._editing = editing;

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

  PaymentUIStateBuilder();

  PaymentUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
      _saveCompleter = _$v.saveCompleter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentUIState;
  }

  @override
  void update(void Function(PaymentUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentUIState build() {
    _$PaymentUIState _$result;
    try {
      _$result = _$v ??
          new _$PaymentUIState._(
              editing: _editing?.build(),
              selectedId: selectedId,
              listUIState: listUIState.build(),
              saveCompleter: saveCompleter);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();

        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
