// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_ui_state.dart';

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

Serializer<ListUIState> _$listUIStateSerializer = new _$ListUIStateSerializer();

class _$ListUIStateSerializer implements StructuredSerializer<ListUIState> {
  @override
  final Iterable<Type> types = const [ListUIState, _$ListUIState];
  @override
  final String wireName = 'ListUIState';

  @override
  Iterable serialize(Serializers serializers, ListUIState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'sortField',
      serializers.serialize(object.sortField,
          specifiedType: const FullType(String)),
      'sortAscending',
      serializers.serialize(object.sortAscending,
          specifiedType: const FullType(bool)),
      'stateFilterIds',
      serializers.serialize(object.stateFilterIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
      'statusFilterIds',
      serializers.serialize(object.statusFilterIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  ListUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ListUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sortField':
          result.sortField = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sortAscending':
          result.sortAscending = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'stateFilterIds':
          result.stateFilterIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList);
          break;
        case 'statusFilterIds':
          result.statusFilterIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ListUIState extends ListUIState {
  @override
  final String sortField;
  @override
  final bool sortAscending;
  @override
  final BuiltList<int> stateFilterIds;
  @override
  final BuiltList<int> statusFilterIds;

  factory _$ListUIState([void updates(ListUIStateBuilder b)]) =>
      (new ListUIStateBuilder()..update(updates)).build();

  _$ListUIState._(
      {this.sortField,
      this.sortAscending,
      this.stateFilterIds,
      this.statusFilterIds})
      : super._() {
    if (sortField == null)
      throw new BuiltValueNullFieldError('ListUIState', 'sortField');
    if (sortAscending == null)
      throw new BuiltValueNullFieldError('ListUIState', 'sortAscending');
    if (stateFilterIds == null)
      throw new BuiltValueNullFieldError('ListUIState', 'stateFilterIds');
    if (statusFilterIds == null)
      throw new BuiltValueNullFieldError('ListUIState', 'statusFilterIds');
  }

  @override
  ListUIState rebuild(void updates(ListUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ListUIStateBuilder toBuilder() => new ListUIStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ListUIState) return false;
    return sortField == other.sortField &&
        sortAscending == other.sortAscending &&
        stateFilterIds == other.stateFilterIds &&
        statusFilterIds == other.statusFilterIds;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, sortField.hashCode), sortAscending.hashCode),
            stateFilterIds.hashCode),
        statusFilterIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListUIState')
          ..add('sortField', sortField)
          ..add('sortAscending', sortAscending)
          ..add('stateFilterIds', stateFilterIds)
          ..add('statusFilterIds', statusFilterIds))
        .toString();
  }
}

class ListUIStateBuilder implements Builder<ListUIState, ListUIStateBuilder> {
  _$ListUIState _$v;

  String _sortField;
  String get sortField => _$this._sortField;
  set sortField(String sortField) => _$this._sortField = sortField;

  bool _sortAscending;
  bool get sortAscending => _$this._sortAscending;
  set sortAscending(bool sortAscending) =>
      _$this._sortAscending = sortAscending;

  ListBuilder<int> _stateFilterIds;
  ListBuilder<int> get stateFilterIds =>
      _$this._stateFilterIds ??= new ListBuilder<int>();
  set stateFilterIds(ListBuilder<int> stateFilterIds) =>
      _$this._stateFilterIds = stateFilterIds;

  ListBuilder<int> _statusFilterIds;
  ListBuilder<int> get statusFilterIds =>
      _$this._statusFilterIds ??= new ListBuilder<int>();
  set statusFilterIds(ListBuilder<int> statusFilterIds) =>
      _$this._statusFilterIds = statusFilterIds;

  ListUIStateBuilder();

  ListUIStateBuilder get _$this {
    if (_$v != null) {
      _sortField = _$v.sortField;
      _sortAscending = _$v.sortAscending;
      _stateFilterIds = _$v.stateFilterIds?.toBuilder();
      _statusFilterIds = _$v.statusFilterIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListUIState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ListUIState;
  }

  @override
  void update(void updates(ListUIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ListUIState build() {
    _$ListUIState _$result;
    try {
      _$result = _$v ??
          new _$ListUIState._(
              sortField: sortField,
              sortAscending: sortAscending,
              stateFilterIds: stateFilterIds.build(),
              statusFilterIds: statusFilterIds.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'stateFilterIds';
        stateFilterIds.build();
        _$failedField = 'statusFilterIds';
        statusFilterIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
