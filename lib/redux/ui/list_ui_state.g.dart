// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_ui_state.dart';

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

Serializer<ListUIState> _$listUIStateSerializer = new _$ListUIStateSerializer();

class _$ListUIStateSerializer implements StructuredSerializer<ListUIState> {
  @override
  final Iterable<Type> types = const [ListUIState, _$ListUIState];
  @override
  final String wireName = 'ListUIState';

  @override
  Iterable serialize(Serializers serializers, ListUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'sortField',
      serializers.serialize(object.sortField,
          specifiedType: const FullType(String)),
      'sortAscending',
      serializers.serialize(object.sortAscending,
          specifiedType: const FullType(bool)),
      'stateFilters',
      serializers.serialize(object.stateFilters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(EntityState)])),
      'statusFilters',
      serializers.serialize(object.statusFilters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(EntityStatus)])),
      'custom1Filters',
      serializers.serialize(object.custom1Filters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'custom2Filters',
      serializers.serialize(object.custom2Filters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    if (object.filter != null) {
      result
        ..add('filter')
        ..add(serializers.serialize(object.filter,
            specifiedType: const FullType(String)));
    }
    if (object.filterEntityId != null) {
      result
        ..add('filterEntityId')
        ..add(serializers.serialize(object.filterEntityId,
            specifiedType: const FullType(int)));
    }
    if (object.filterEntityType != null) {
      result
        ..add('filterEntityType')
        ..add(serializers.serialize(object.filterEntityType,
            specifiedType: const FullType(EntityType)));
    }

    return result;
  }

  @override
  ListUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filterEntityId':
          result.filterEntityId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'filterEntityType':
          result.filterEntityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
        case 'sortField':
          result.sortField = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sortAscending':
          result.sortAscending = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'stateFilters':
          result.stateFilters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(EntityState)]))
              as BuiltList);
          break;
        case 'statusFilters':
          result.statusFilters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(EntityStatus)]))
              as BuiltList);
          break;
        case 'custom1Filters':
          result.custom1Filters.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'custom2Filters':
          result.custom2Filters.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ListUIState extends ListUIState {
  @override
  final String filter;
  @override
  final int filterEntityId;
  @override
  final EntityType filterEntityType;
  @override
  final String sortField;
  @override
  final bool sortAscending;
  @override
  final BuiltList<EntityState> stateFilters;
  @override
  final BuiltList<EntityStatus> statusFilters;
  @override
  final BuiltList<String> custom1Filters;
  @override
  final BuiltList<String> custom2Filters;

  factory _$ListUIState([void updates(ListUIStateBuilder b)]) =>
      (new ListUIStateBuilder()..update(updates)).build();

  _$ListUIState._(
      {this.filter,
      this.filterEntityId,
      this.filterEntityType,
      this.sortField,
      this.sortAscending,
      this.stateFilters,
      this.statusFilters,
      this.custom1Filters,
      this.custom2Filters})
      : super._() {
    if (sortField == null) {
      throw new BuiltValueNullFieldError('ListUIState', 'sortField');
    }
    if (sortAscending == null) {
      throw new BuiltValueNullFieldError('ListUIState', 'sortAscending');
    }
    if (stateFilters == null) {
      throw new BuiltValueNullFieldError('ListUIState', 'stateFilters');
    }
    if (statusFilters == null) {
      throw new BuiltValueNullFieldError('ListUIState', 'statusFilters');
    }
    if (custom1Filters == null) {
      throw new BuiltValueNullFieldError('ListUIState', 'custom1Filters');
    }
    if (custom2Filters == null) {
      throw new BuiltValueNullFieldError('ListUIState', 'custom2Filters');
    }
  }

  @override
  ListUIState rebuild(void updates(ListUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ListUIStateBuilder toBuilder() => new ListUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListUIState &&
        filter == other.filter &&
        filterEntityId == other.filterEntityId &&
        filterEntityType == other.filterEntityType &&
        sortField == other.sortField &&
        sortAscending == other.sortAscending &&
        stateFilters == other.stateFilters &&
        statusFilters == other.statusFilters &&
        custom1Filters == other.custom1Filters &&
        custom2Filters == other.custom2Filters;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, filter.hashCode),
                                    filterEntityId.hashCode),
                                filterEntityType.hashCode),
                            sortField.hashCode),
                        sortAscending.hashCode),
                    stateFilters.hashCode),
                statusFilters.hashCode),
            custom1Filters.hashCode),
        custom2Filters.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListUIState')
          ..add('filter', filter)
          ..add('filterEntityId', filterEntityId)
          ..add('filterEntityType', filterEntityType)
          ..add('sortField', sortField)
          ..add('sortAscending', sortAscending)
          ..add('stateFilters', stateFilters)
          ..add('statusFilters', statusFilters)
          ..add('custom1Filters', custom1Filters)
          ..add('custom2Filters', custom2Filters))
        .toString();
  }
}

class ListUIStateBuilder implements Builder<ListUIState, ListUIStateBuilder> {
  _$ListUIState _$v;

  String _filter;
  String get filter => _$this._filter;
  set filter(String filter) => _$this._filter = filter;

  int _filterEntityId;
  int get filterEntityId => _$this._filterEntityId;
  set filterEntityId(int filterEntityId) =>
      _$this._filterEntityId = filterEntityId;

  EntityType _filterEntityType;
  EntityType get filterEntityType => _$this._filterEntityType;
  set filterEntityType(EntityType filterEntityType) =>
      _$this._filterEntityType = filterEntityType;

  String _sortField;
  String get sortField => _$this._sortField;
  set sortField(String sortField) => _$this._sortField = sortField;

  bool _sortAscending;
  bool get sortAscending => _$this._sortAscending;
  set sortAscending(bool sortAscending) =>
      _$this._sortAscending = sortAscending;

  ListBuilder<EntityState> _stateFilters;
  ListBuilder<EntityState> get stateFilters =>
      _$this._stateFilters ??= new ListBuilder<EntityState>();
  set stateFilters(ListBuilder<EntityState> stateFilters) =>
      _$this._stateFilters = stateFilters;

  ListBuilder<EntityStatus> _statusFilters;
  ListBuilder<EntityStatus> get statusFilters =>
      _$this._statusFilters ??= new ListBuilder<EntityStatus>();
  set statusFilters(ListBuilder<EntityStatus> statusFilters) =>
      _$this._statusFilters = statusFilters;

  ListBuilder<String> _custom1Filters;
  ListBuilder<String> get custom1Filters =>
      _$this._custom1Filters ??= new ListBuilder<String>();
  set custom1Filters(ListBuilder<String> custom1Filters) =>
      _$this._custom1Filters = custom1Filters;

  ListBuilder<String> _custom2Filters;
  ListBuilder<String> get custom2Filters =>
      _$this._custom2Filters ??= new ListBuilder<String>();
  set custom2Filters(ListBuilder<String> custom2Filters) =>
      _$this._custom2Filters = custom2Filters;

  ListUIStateBuilder();

  ListUIStateBuilder get _$this {
    if (_$v != null) {
      _filter = _$v.filter;
      _filterEntityId = _$v.filterEntityId;
      _filterEntityType = _$v.filterEntityType;
      _sortField = _$v.sortField;
      _sortAscending = _$v.sortAscending;
      _stateFilters = _$v.stateFilters?.toBuilder();
      _statusFilters = _$v.statusFilters?.toBuilder();
      _custom1Filters = _$v.custom1Filters?.toBuilder();
      _custom2Filters = _$v.custom2Filters?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              filter: filter,
              filterEntityId: filterEntityId,
              filterEntityType: filterEntityType,
              sortField: sortField,
              sortAscending: sortAscending,
              stateFilters: stateFilters.build(),
              statusFilters: statusFilters.build(),
              custom1Filters: custom1Filters.build(),
              custom2Filters: custom2Filters.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'stateFilters';
        stateFilters.build();
        _$failedField = 'statusFilters';
        statusFilters.build();
        _$failedField = 'custom1Filters';
        custom1Filters.build();
        _$failedField = 'custom2Filters';
        custom2Filters.build();
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
