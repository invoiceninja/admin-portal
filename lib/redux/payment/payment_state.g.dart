// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

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
  Iterable serialize(Serializers serializers, PaymentState object,
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
  PaymentState deserialize(Serializers serializers, Iterable serialized,
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
              ])) as BuiltMap);
          break;
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList);
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
  Iterable serialize(Serializers serializers, PaymentUIState object,
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
  PaymentUIState deserialize(Serializers serializers, Iterable serialized,
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

  factory _$PaymentState([void updates(PaymentStateBuilder b)]) =>
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
  PaymentState rebuild(void updates(PaymentStateBuilder b)) =>
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
  void update(void updates(PaymentStateBuilder b)) {
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

  factory _$PaymentUIState([void updates(PaymentUIStateBuilder b)]) =>
      (new PaymentUIStateBuilder()..update(updates)).build();

  _$PaymentUIState._({this.editing, this.selectedId, this.listUIState})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('PaymentUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('PaymentUIState', 'listUIState');
    }
  }

  @override
  PaymentUIState rebuild(void updates(PaymentUIStateBuilder b)) =>
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
        listUIState == other.listUIState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, editing.hashCode), selectedId.hashCode),
        listUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentUIState')
          ..add('editing', editing)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState))
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

  PaymentUIStateBuilder();

  PaymentUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
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
  void update(void updates(PaymentUIStateBuilder b)) {
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
              listUIState: listUIState.build());
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
