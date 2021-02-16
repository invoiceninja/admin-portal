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
              const [const FullType(String), const FullType(PaymentEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

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
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(PaymentEntity)
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
            specifiedType: const FullType(PaymentEntity)));
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

class _$PaymentState extends PaymentState {
  @override
  final BuiltMap<String, PaymentEntity> map;
  @override
  final BuiltList<String> list;

  factory _$PaymentState([void Function(PaymentStateBuilder) updates]) =>
      (new PaymentStateBuilder()..update(updates)).build();

  _$PaymentState._({this.map, this.list}) : super._() {
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
    return other is PaymentState && map == other.map && list == other.list;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentState')
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class PaymentStateBuilder
    implements Builder<PaymentState, PaymentStateBuilder> {
  _$PaymentState _$v;

  MapBuilder<String, PaymentEntity> _map;
  MapBuilder<String, PaymentEntity> get map =>
      _$this._map ??= new MapBuilder<String, PaymentEntity>();
  set map(MapBuilder<String, PaymentEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  PaymentStateBuilder();

  PaymentStateBuilder get _$this {
    if (_$v != null) {
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
      _$result =
          _$v ?? new _$PaymentState._(map: map.build(), list: list.build());
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
  final ListUIState listUIState;
  @override
  final String selectedId;
  @override
  final int tabIndex;
  @override
  final Completer<SelectableEntity> saveCompleter;
  @override
  final Completer<Null> cancelCompleter;

  factory _$PaymentUIState([void Function(PaymentUIStateBuilder) updates]) =>
      (new PaymentUIStateBuilder()..update(updates)).build();

  _$PaymentUIState._(
      {this.editing,
      this.listUIState,
      this.selectedId,
      this.tabIndex,
      this.saveCompleter,
      this.cancelCompleter})
      : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('PaymentUIState', 'listUIState');
    }
    if (tabIndex == null) {
      throw new BuiltValueNullFieldError('PaymentUIState', 'tabIndex');
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
    return (newBuiltValueToStringHelper('PaymentUIState')
          ..add('editing', editing)
          ..add('listUIState', listUIState)
          ..add('selectedId', selectedId)
          ..add('tabIndex', tabIndex)
          ..add('saveCompleter', saveCompleter)
          ..add('cancelCompleter', cancelCompleter))
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

  PaymentUIStateBuilder();

  PaymentUIStateBuilder get _$this {
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
            'PaymentUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
