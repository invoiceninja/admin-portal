// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_ui_state.dart';

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

Serializer<EntityUIState> _$entityUIStateSerializer =
    new _$EntityUIStateSerializer();

class _$EntityUIStateSerializer implements StructuredSerializer<EntityUIState> {
  @override
  final Iterable<Type> types = const [EntityUIState, _$EntityUIState];
  @override
  final String wireName = 'EntityUIState';

  @override
  Iterable serialize(Serializers serializers, EntityUIState object,
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
  EntityUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new EntityUIStateBuilder();

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

class _$EntityUIState extends EntityUIState {
  @override
  final String sortField;
  @override
  final bool sortAscending;
  @override
  final BuiltList<int> stateFilterIds;
  @override
  final BuiltList<int> statusFilterIds;

  factory _$EntityUIState([void updates(EntityUIStateBuilder b)]) =>
      (new EntityUIStateBuilder()..update(updates)).build();

  _$EntityUIState._(
      {this.sortField,
      this.sortAscending,
      this.stateFilterIds,
      this.statusFilterIds})
      : super._() {
    if (sortField == null)
      throw new BuiltValueNullFieldError('EntityUIState', 'sortField');
    if (sortAscending == null)
      throw new BuiltValueNullFieldError('EntityUIState', 'sortAscending');
    if (stateFilterIds == null)
      throw new BuiltValueNullFieldError('EntityUIState', 'stateFilterIds');
    if (statusFilterIds == null)
      throw new BuiltValueNullFieldError('EntityUIState', 'statusFilterIds');
  }

  @override
  EntityUIState rebuild(void updates(EntityUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  EntityUIStateBuilder toBuilder() => new EntityUIStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! EntityUIState) return false;
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
    return (newBuiltValueToStringHelper('EntityUIState')
          ..add('sortField', sortField)
          ..add('sortAscending', sortAscending)
          ..add('stateFilterIds', stateFilterIds)
          ..add('statusFilterIds', statusFilterIds))
        .toString();
  }
}

class EntityUIStateBuilder
    implements Builder<EntityUIState, EntityUIStateBuilder> {
  _$EntityUIState _$v;

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

  EntityUIStateBuilder();

  EntityUIStateBuilder get _$this {
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
  void replace(EntityUIState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$EntityUIState;
  }

  @override
  void update(void updates(EntityUIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$EntityUIState build() {
    _$EntityUIState _$result;
    try {
      _$result = _$v ??
          new _$EntityUIState._(
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
            'EntityUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
