// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_term_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PaymentTermState> _$paymentTermStateSerializer =
    new _$PaymentTermStateSerializer();
Serializer<PaymentTermUIState> _$paymentTermUIStateSerializer =
    new _$PaymentTermUIStateSerializer();

class _$PaymentTermStateSerializer
    implements StructuredSerializer<PaymentTermState> {
  @override
  final Iterable<Type> types = const [PaymentTermState, _$PaymentTermState];
  @override
  final String wireName = 'PaymentTermState';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentTermState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(PaymentTermEntity)
          ])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  PaymentTermState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTermStateBuilder();

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
                const FullType(PaymentTermEntity)
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

class _$PaymentTermUIStateSerializer
    implements StructuredSerializer<PaymentTermUIState> {
  @override
  final Iterable<Type> types = const [PaymentTermUIState, _$PaymentTermUIState];
  @override
  final String wireName = 'PaymentTermUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentTermUIState object,
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
            specifiedType: const FullType(PaymentTermEntity)));
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
  PaymentTermUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTermUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'editing':
          result.editing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaymentTermEntity))
              as PaymentTermEntity);
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

class _$PaymentTermState extends PaymentTermState {
  @override
  final BuiltMap<String, PaymentTermEntity> map;
  @override
  final BuiltList<String> list;

  factory _$PaymentTermState(
          [void Function(PaymentTermStateBuilder) updates]) =>
      (new PaymentTermStateBuilder()..update(updates)).build();

  _$PaymentTermState._({this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('PaymentTermState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('PaymentTermState', 'list');
    }
  }

  @override
  PaymentTermState rebuild(void Function(PaymentTermStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTermStateBuilder toBuilder() =>
      new PaymentTermStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTermState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTermState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class PaymentTermStateBuilder
    implements Builder<PaymentTermState, PaymentTermStateBuilder> {
  _$PaymentTermState _$v;

  MapBuilder<String, PaymentTermEntity> _map;
  MapBuilder<String, PaymentTermEntity> get map =>
      _$this._map ??= new MapBuilder<String, PaymentTermEntity>();
  set map(MapBuilder<String, PaymentTermEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  PaymentTermStateBuilder();

  PaymentTermStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTermState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentTermState;
  }

  @override
  void update(void Function(PaymentTermStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTermState build() {
    _$PaymentTermState _$result;
    try {
      _$result =
          _$v ?? new _$PaymentTermState._(map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentTermState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentTermUIState extends PaymentTermUIState {
  @override
  final PaymentTermEntity editing;
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

  factory _$PaymentTermUIState(
          [void Function(PaymentTermUIStateBuilder) updates]) =>
      (new PaymentTermUIStateBuilder()..update(updates)).build();

  _$PaymentTermUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('PaymentTermUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('PaymentTermUIState', 'tabIndex');
    }
  }

  @override
  PaymentTermUIState rebuild(
          void Function(PaymentTermUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTermUIStateBuilder toBuilder() =>
      new PaymentTermUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTermUIState &&
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
    return (newBuiltValueToStringHelper('PaymentTermUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
        .toString();
  }
}

class PaymentTermUIStateBuilder
    implements Builder<PaymentTermUIState, PaymentTermUIStateBuilder> {
  _$PaymentTermUIState _$v;

  PaymentTermEntityBuilder _editing;
  PaymentTermEntityBuilder get editing =>
      _$this._editing ??= new PaymentTermEntityBuilder();
  set editing(PaymentTermEntityBuilder editing) => _$this._editing = editing;

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

  PaymentTermUIStateBuilder();

  PaymentTermUIStateBuilder get _$this {
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
  void replace(PaymentTermUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentTermUIState;
  }

  @override
  void update(void Function(PaymentTermUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTermUIState build() {
    _$PaymentTermUIState _$result;
    try {
      _$result = _$v ??
          new _$PaymentTermUIState._(
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
            'PaymentTermUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
