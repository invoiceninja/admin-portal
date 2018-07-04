// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<InvoiceState> _$invoiceStateSerializer =
    new _$InvoiceStateSerializer();
Serializer<InvoiceUIState> _$invoiceUIStateSerializer =
    new _$InvoiceUIStateSerializer();

class _$InvoiceStateSerializer implements StructuredSerializer<InvoiceState> {
  @override
  final Iterable<Type> types = const [InvoiceState, _$InvoiceState];
  @override
  final String wireName = 'InvoiceState';

  @override
  Iterable serialize(Serializers serializers, InvoiceState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(InvoiceEntity)])),
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
  InvoiceState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new InvoiceStateBuilder();

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
                const FullType(InvoiceEntity)
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

class _$InvoiceUIStateSerializer
    implements StructuredSerializer<InvoiceUIState> {
  @override
  final Iterable<Type> types = const [InvoiceUIState, _$InvoiceUIState];
  @override
  final String wireName = 'InvoiceUIState';

  @override
  Iterable serialize(Serializers serializers, InvoiceUIState object,
      {FullType specifiedType: FullType.unspecified}) {
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
            specifiedType: const FullType(InvoiceEntity)));
    }

    return result;
  }

  @override
  InvoiceUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new InvoiceUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceEntity)) as InvoiceEntity);
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

class _$InvoiceState extends InvoiceState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, InvoiceEntity> map;
  @override
  final BuiltList<int> list;

  factory _$InvoiceState([void updates(InvoiceStateBuilder b)]) =>
      (new InvoiceStateBuilder()..update(updates)).build();

  _$InvoiceState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) throw new BuiltValueNullFieldError('InvoiceState', 'map');
    if (list == null)
      throw new BuiltValueNullFieldError('InvoiceState', 'list');
  }

  @override
  InvoiceState rebuild(void updates(InvoiceStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceStateBuilder toBuilder() => new InvoiceStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! InvoiceState) return false;
    return lastUpdated == other.lastUpdated &&
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
    return (newBuiltValueToStringHelper('InvoiceState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class InvoiceStateBuilder
    implements Builder<InvoiceState, InvoiceStateBuilder> {
  _$InvoiceState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<int, InvoiceEntity> _map;
  MapBuilder<int, InvoiceEntity> get map =>
      _$this._map ??= new MapBuilder<int, InvoiceEntity>();
  set map(MapBuilder<int, InvoiceEntity> map) => _$this._map = map;

  ListBuilder<int> _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int> list) => _$this._list = list;

  InvoiceStateBuilder();

  InvoiceStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$InvoiceState;
  }

  @override
  void update(void updates(InvoiceStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceState build() {
    _$InvoiceState _$result;
    try {
      _$result = _$v ??
          new _$InvoiceState._(
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
            'InvoiceState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceUIState extends InvoiceUIState {
  @override
  final InvoiceEntity editing;
  @override
  final int selectedId;
  @override
  final ListUIState listUIState;

  factory _$InvoiceUIState([void updates(InvoiceUIStateBuilder b)]) =>
      (new InvoiceUIStateBuilder()..update(updates)).build();

  _$InvoiceUIState._({this.editing, this.selectedId, this.listUIState})
      : super._() {
    if (selectedId == null)
      throw new BuiltValueNullFieldError('InvoiceUIState', 'selectedId');
    if (listUIState == null)
      throw new BuiltValueNullFieldError('InvoiceUIState', 'listUIState');
  }

  @override
  InvoiceUIState rebuild(void updates(InvoiceUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceUIStateBuilder toBuilder() =>
      new InvoiceUIStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! InvoiceUIState) return false;
    return editing == other.editing &&
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
    return (newBuiltValueToStringHelper('InvoiceUIState')
          ..add('editing', editing)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState))
        .toString();
  }
}

class InvoiceUIStateBuilder
    implements Builder<InvoiceUIState, InvoiceUIStateBuilder> {
  _$InvoiceUIState _$v;

  InvoiceEntityBuilder _editing;
  InvoiceEntityBuilder get editing =>
      _$this._editing ??= new InvoiceEntityBuilder();
  set editing(InvoiceEntityBuilder editing) => _$this._editing = editing;

  int _selectedId;
  int get selectedId => _$this._selectedId;
  set selectedId(int selectedId) => _$this._selectedId = selectedId;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  InvoiceUIStateBuilder();

  InvoiceUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceUIState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$InvoiceUIState;
  }

  @override
  void update(void updates(InvoiceUIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceUIState build() {
    _$InvoiceUIState _$result;
    try {
      _$result = _$v ??
          new _$InvoiceUIState._(
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
            'InvoiceUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
