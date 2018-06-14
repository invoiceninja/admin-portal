// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_state.dart';

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

Serializer<InvoiceState> _$invoiceStateSerializer =
    new _$InvoiceStateSerializer();

class _$InvoiceStateSerializer implements StructuredSerializer<InvoiceState> {
  @override
  final Iterable<Type> types = const [InvoiceState, _$InvoiceState];
  @override
  final String wireName = 'InvoiceState';

  @override
  Iterable serialize(Serializers serializers, InvoiceState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'lastUpdated',
      serializers.serialize(object.lastUpdated,
          specifiedType: const FullType(int)),
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(InvoiceEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];
    if (object.editing != null) {
      result
        ..add('editing')
        ..add(serializers.serialize(object.editing,
            specifiedType: const FullType(InvoiceEntity)));
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
  InvoiceState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new InvoiceStateBuilder();

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
                const FullType(InvoiceEntity)
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
              specifiedType: const FullType(InvoiceEntity)) as InvoiceEntity);
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

class _$InvoiceState extends InvoiceState {
  @override
  final bool isLoading;
  @override
  final int lastUpdated;
  @override
  final BuiltMap<int, InvoiceEntity> map;
  @override
  final BuiltList<int> list;
  @override
  final InvoiceEntity editing;
  @override
  final String editingFor;

  factory _$InvoiceState([void updates(InvoiceStateBuilder b)]) =>
      (new InvoiceStateBuilder()..update(updates)).build();

  _$InvoiceState._(
      {this.isLoading,
      this.lastUpdated,
      this.map,
      this.list,
      this.editing,
      this.editingFor})
      : super._() {
    if (isLoading == null)
      throw new BuiltValueNullFieldError('InvoiceState', 'isLoading');
    if (lastUpdated == null)
      throw new BuiltValueNullFieldError('InvoiceState', 'lastUpdated');
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
    return (newBuiltValueToStringHelper('InvoiceState')
          ..add('isLoading', isLoading)
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list)
          ..add('editing', editing)
          ..add('editingFor', editingFor))
        .toString();
  }
}

class InvoiceStateBuilder
    implements Builder<InvoiceState, InvoiceStateBuilder> {
  _$InvoiceState _$v;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

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

  InvoiceEntityBuilder _editing;
  InvoiceEntityBuilder get editing =>
      _$this._editing ??= new InvoiceEntityBuilder();
  set editing(InvoiceEntityBuilder editing) => _$this._editing = editing;

  String _editingFor;
  String get editingFor => _$this._editingFor;
  set editingFor(String editingFor) => _$this._editingFor = editingFor;

  InvoiceStateBuilder();

  InvoiceStateBuilder get _$this {
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
            'InvoiceState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
