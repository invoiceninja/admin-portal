// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_state.dart';

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

Serializer<QuoteState> _$quoteStateSerializer = new _$QuoteStateSerializer();
Serializer<QuoteUIState> _$quoteUIStateSerializer =
    new _$QuoteUIStateSerializer();

class _$QuoteStateSerializer implements StructuredSerializer<QuoteState> {
  @override
  final Iterable<Type> types = const [QuoteState, _$QuoteState];
  @override
  final String wireName = 'QuoteState';

  @override
  Iterable serialize(Serializers serializers, QuoteState object,
      {FullType specifiedType = FullType.unspecified}) {
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
  QuoteState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuoteStateBuilder();

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

class _$QuoteUIStateSerializer implements StructuredSerializer<QuoteUIState> {
  @override
  final Iterable<Type> types = const [QuoteUIState, _$QuoteUIState];
  @override
  final String wireName = 'QuoteUIState';

  @override
  Iterable serialize(Serializers serializers, QuoteUIState object,
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
            specifiedType: const FullType(InvoiceEntity)));
    }
    if (object.editingItem != null) {
      result
        ..add('editingItem')
        ..add(serializers.serialize(object.editingItem,
            specifiedType: const FullType(InvoiceItemEntity)));
    }

    return result;
  }

  @override
  QuoteUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuoteUIStateBuilder();

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
        case 'editingItem':
          result.editingItem.replace(serializers.deserialize(value,
                  specifiedType: const FullType(InvoiceItemEntity))
              as InvoiceItemEntity);
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

class _$QuoteState extends QuoteState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, InvoiceEntity> map;
  @override
  final BuiltList<int> list;

  factory _$QuoteState([void updates(QuoteStateBuilder b)]) =>
      (new QuoteStateBuilder()..update(updates)).build();

  _$QuoteState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('QuoteState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('QuoteState', 'list');
    }
  }

  @override
  QuoteState rebuild(void updates(QuoteStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteStateBuilder toBuilder() => new QuoteStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuoteState &&
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
    return (newBuiltValueToStringHelper('QuoteState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class QuoteStateBuilder implements Builder<QuoteState, QuoteStateBuilder> {
  _$QuoteState _$v;

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

  QuoteStateBuilder();

  QuoteStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuoteState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuoteState;
  }

  @override
  void update(void updates(QuoteStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$QuoteState build() {
    _$QuoteState _$result;
    try {
      _$result = _$v ??
          new _$QuoteState._(
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
            'QuoteState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$QuoteUIState extends QuoteUIState {
  @override
  final InvoiceEntity editing;
  @override
  final InvoiceItemEntity editingItem;
  @override
  final int selectedId;
  @override
  final ListUIState listUIState;

  factory _$QuoteUIState([void updates(QuoteUIStateBuilder b)]) =>
      (new QuoteUIStateBuilder()..update(updates)).build();

  _$QuoteUIState._(
      {this.editing, this.editingItem, this.selectedId, this.listUIState})
      : super._() {
    if (selectedId == null) {
      throw new BuiltValueNullFieldError('QuoteUIState', 'selectedId');
    }
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('QuoteUIState', 'listUIState');
    }
  }

  @override
  QuoteUIState rebuild(void updates(QuoteUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteUIStateBuilder toBuilder() => new QuoteUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuoteUIState &&
        editing == other.editing &&
        editingItem == other.editingItem &&
        selectedId == other.selectedId &&
        listUIState == other.listUIState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, editing.hashCode), editingItem.hashCode),
            selectedId.hashCode),
        listUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QuoteUIState')
          ..add('editing', editing)
          ..add('editingItem', editingItem)
          ..add('selectedId', selectedId)
          ..add('listUIState', listUIState))
        .toString();
  }
}

class QuoteUIStateBuilder
    implements Builder<QuoteUIState, QuoteUIStateBuilder> {
  _$QuoteUIState _$v;

  InvoiceEntityBuilder _editing;
  InvoiceEntityBuilder get editing =>
      _$this._editing ??= new InvoiceEntityBuilder();
  set editing(InvoiceEntityBuilder editing) => _$this._editing = editing;

  InvoiceItemEntityBuilder _editingItem;
  InvoiceItemEntityBuilder get editingItem =>
      _$this._editingItem ??= new InvoiceItemEntityBuilder();
  set editingItem(InvoiceItemEntityBuilder editingItem) =>
      _$this._editingItem = editingItem;

  int _selectedId;
  int get selectedId => _$this._selectedId;
  set selectedId(int selectedId) => _$this._selectedId = selectedId;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  QuoteUIStateBuilder();

  QuoteUIStateBuilder get _$this {
    if (_$v != null) {
      _editing = _$v.editing?.toBuilder();
      _editingItem = _$v.editingItem?.toBuilder();
      _selectedId = _$v.selectedId;
      _listUIState = _$v.listUIState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuoteUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuoteUIState;
  }

  @override
  void update(void updates(QuoteUIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$QuoteUIState build() {
    _$QuoteUIState _$result;
    try {
      _$result = _$v ??
          new _$QuoteUIState._(
              editing: _editing?.build(),
              editingItem: _editingItem?.build(),
              selectedId: selectedId,
              listUIState: listUIState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'editing';
        _editing?.build();
        _$failedField = 'editingItem';
        _editingItem?.build();

        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QuoteUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
