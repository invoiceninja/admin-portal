// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_ui_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ListUIState> _$listUIStateSerializer = new _$ListUIStateSerializer();

class _$ListUIStateSerializer implements StructuredSerializer<ListUIState> {
  @override
  final Iterable<Type> types = const [ListUIState, _$ListUIState];
  @override
  final String wireName = 'ListUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, ListUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'filterClearedAt',
      serializers.serialize(object.filterClearedAt,
          specifiedType: const FullType(int)),
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
      'custom3Filters',
      serializers.serialize(object.custom3Filters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'custom4Filters',
      serializers.serialize(object.custom4Filters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
    value = object.filter;
    if (value != null) {
      result
        ..add('filter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.selectedIds;
    if (value != null) {
      result
        ..add('selectedIds')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  ListUIState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'filterClearedAt':
          result.filterClearedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'sortField':
          result.sortField = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sortAscending':
          result.sortAscending = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'stateFilters':
          result.stateFilters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(EntityState)]))!
              as BuiltList<Object?>);
          break;
        case 'statusFilters':
          result.statusFilters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(EntityStatus)]))!
              as BuiltList<Object?>);
          break;
        case 'custom1Filters':
          result.custom1Filters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'custom2Filters':
          result.custom2Filters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'custom3Filters':
          result.custom3Filters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'custom4Filters':
          result.custom4Filters.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'selectedIds':
          result.selectedIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ListUIState extends ListUIState {
  @override
  final String? filter;
  @override
  final int filterClearedAt;
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
  @override
  final BuiltList<String> custom3Filters;
  @override
  final BuiltList<String> custom4Filters;
  @override
  final BuiltList<String>? selectedIds;

  factory _$ListUIState([void Function(ListUIStateBuilder)? updates]) =>
      (new ListUIStateBuilder()..update(updates))._build();

  _$ListUIState._(
      {this.filter,
      required this.filterClearedAt,
      required this.sortField,
      required this.sortAscending,
      required this.stateFilters,
      required this.statusFilters,
      required this.custom1Filters,
      required this.custom2Filters,
      required this.custom3Filters,
      required this.custom4Filters,
      this.selectedIds})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        filterClearedAt, r'ListUIState', 'filterClearedAt');
    BuiltValueNullFieldError.checkNotNull(
        sortField, r'ListUIState', 'sortField');
    BuiltValueNullFieldError.checkNotNull(
        sortAscending, r'ListUIState', 'sortAscending');
    BuiltValueNullFieldError.checkNotNull(
        stateFilters, r'ListUIState', 'stateFilters');
    BuiltValueNullFieldError.checkNotNull(
        statusFilters, r'ListUIState', 'statusFilters');
    BuiltValueNullFieldError.checkNotNull(
        custom1Filters, r'ListUIState', 'custom1Filters');
    BuiltValueNullFieldError.checkNotNull(
        custom2Filters, r'ListUIState', 'custom2Filters');
    BuiltValueNullFieldError.checkNotNull(
        custom3Filters, r'ListUIState', 'custom3Filters');
    BuiltValueNullFieldError.checkNotNull(
        custom4Filters, r'ListUIState', 'custom4Filters');
  }

  @override
  ListUIState rebuild(void Function(ListUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListUIStateBuilder toBuilder() => new ListUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListUIState &&
        filter == other.filter &&
        filterClearedAt == other.filterClearedAt &&
        sortField == other.sortField &&
        sortAscending == other.sortAscending &&
        stateFilters == other.stateFilters &&
        statusFilters == other.statusFilters &&
        custom1Filters == other.custom1Filters &&
        custom2Filters == other.custom2Filters &&
        custom3Filters == other.custom3Filters &&
        custom4Filters == other.custom4Filters &&
        selectedIds == other.selectedIds;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, filter.hashCode);
    _$hash = $jc(_$hash, filterClearedAt.hashCode);
    _$hash = $jc(_$hash, sortField.hashCode);
    _$hash = $jc(_$hash, sortAscending.hashCode);
    _$hash = $jc(_$hash, stateFilters.hashCode);
    _$hash = $jc(_$hash, statusFilters.hashCode);
    _$hash = $jc(_$hash, custom1Filters.hashCode);
    _$hash = $jc(_$hash, custom2Filters.hashCode);
    _$hash = $jc(_$hash, custom3Filters.hashCode);
    _$hash = $jc(_$hash, custom4Filters.hashCode);
    _$hash = $jc(_$hash, selectedIds.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListUIState')
          ..add('filter', filter)
          ..add('filterClearedAt', filterClearedAt)
          ..add('sortField', sortField)
          ..add('sortAscending', sortAscending)
          ..add('stateFilters', stateFilters)
          ..add('statusFilters', statusFilters)
          ..add('custom1Filters', custom1Filters)
          ..add('custom2Filters', custom2Filters)
          ..add('custom3Filters', custom3Filters)
          ..add('custom4Filters', custom4Filters)
          ..add('selectedIds', selectedIds))
        .toString();
  }
}

class ListUIStateBuilder implements Builder<ListUIState, ListUIStateBuilder> {
  _$ListUIState? _$v;

  String? _filter;
  String? get filter => _$this._filter;
  set filter(String? filter) => _$this._filter = filter;

  int? _filterClearedAt;
  int? get filterClearedAt => _$this._filterClearedAt;
  set filterClearedAt(int? filterClearedAt) =>
      _$this._filterClearedAt = filterClearedAt;

  String? _sortField;
  String? get sortField => _$this._sortField;
  set sortField(String? sortField) => _$this._sortField = sortField;

  bool? _sortAscending;
  bool? get sortAscending => _$this._sortAscending;
  set sortAscending(bool? sortAscending) =>
      _$this._sortAscending = sortAscending;

  ListBuilder<EntityState>? _stateFilters;
  ListBuilder<EntityState> get stateFilters =>
      _$this._stateFilters ??= new ListBuilder<EntityState>();
  set stateFilters(ListBuilder<EntityState>? stateFilters) =>
      _$this._stateFilters = stateFilters;

  ListBuilder<EntityStatus>? _statusFilters;
  ListBuilder<EntityStatus> get statusFilters =>
      _$this._statusFilters ??= new ListBuilder<EntityStatus>();
  set statusFilters(ListBuilder<EntityStatus>? statusFilters) =>
      _$this._statusFilters = statusFilters;

  ListBuilder<String>? _custom1Filters;
  ListBuilder<String> get custom1Filters =>
      _$this._custom1Filters ??= new ListBuilder<String>();
  set custom1Filters(ListBuilder<String>? custom1Filters) =>
      _$this._custom1Filters = custom1Filters;

  ListBuilder<String>? _custom2Filters;
  ListBuilder<String> get custom2Filters =>
      _$this._custom2Filters ??= new ListBuilder<String>();
  set custom2Filters(ListBuilder<String>? custom2Filters) =>
      _$this._custom2Filters = custom2Filters;

  ListBuilder<String>? _custom3Filters;
  ListBuilder<String> get custom3Filters =>
      _$this._custom3Filters ??= new ListBuilder<String>();
  set custom3Filters(ListBuilder<String>? custom3Filters) =>
      _$this._custom3Filters = custom3Filters;

  ListBuilder<String>? _custom4Filters;
  ListBuilder<String> get custom4Filters =>
      _$this._custom4Filters ??= new ListBuilder<String>();
  set custom4Filters(ListBuilder<String>? custom4Filters) =>
      _$this._custom4Filters = custom4Filters;

  ListBuilder<String>? _selectedIds;
  ListBuilder<String> get selectedIds =>
      _$this._selectedIds ??= new ListBuilder<String>();
  set selectedIds(ListBuilder<String>? selectedIds) =>
      _$this._selectedIds = selectedIds;

  ListUIStateBuilder();

  ListUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _filter = $v.filter;
      _filterClearedAt = $v.filterClearedAt;
      _sortField = $v.sortField;
      _sortAscending = $v.sortAscending;
      _stateFilters = $v.stateFilters.toBuilder();
      _statusFilters = $v.statusFilters.toBuilder();
      _custom1Filters = $v.custom1Filters.toBuilder();
      _custom2Filters = $v.custom2Filters.toBuilder();
      _custom3Filters = $v.custom3Filters.toBuilder();
      _custom4Filters = $v.custom4Filters.toBuilder();
      _selectedIds = $v.selectedIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ListUIState;
  }

  @override
  void update(void Function(ListUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListUIState build() => _build();

  _$ListUIState _build() {
    _$ListUIState _$result;
    try {
      _$result = _$v ??
          new _$ListUIState._(
              filter: filter,
              filterClearedAt: BuiltValueNullFieldError.checkNotNull(
                  filterClearedAt, r'ListUIState', 'filterClearedAt'),
              sortField: BuiltValueNullFieldError.checkNotNull(
                  sortField, r'ListUIState', 'sortField'),
              sortAscending: BuiltValueNullFieldError.checkNotNull(
                  sortAscending, r'ListUIState', 'sortAscending'),
              stateFilters: stateFilters.build(),
              statusFilters: statusFilters.build(),
              custom1Filters: custom1Filters.build(),
              custom2Filters: custom2Filters.build(),
              custom3Filters: custom3Filters.build(),
              custom4Filters: custom4Filters.build(),
              selectedIds: _selectedIds?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'stateFilters';
        stateFilters.build();
        _$failedField = 'statusFilters';
        statusFilters.build();
        _$failedField = 'custom1Filters';
        custom1Filters.build();
        _$failedField = 'custom2Filters';
        custom2Filters.build();
        _$failedField = 'custom3Filters';
        custom3Filters.build();
        _$failedField = 'custom4Filters';
        custom4Filters.build();
        _$failedField = 'selectedIds';
        _selectedIds?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ListUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
