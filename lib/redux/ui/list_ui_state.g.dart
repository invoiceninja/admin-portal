// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_ui_state.dart';

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
      'stateFilters',
      serializers.serialize(object.stateFilters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(EntityState)])),
      'statusFilters',
      serializers.serialize(object.statusFilters,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];
    if (object.search != null) {
      result
        ..add('search')
        ..add(serializers.serialize(object.search,
            specifiedType: const FullType(String)));
    }

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
        case 'search':
          result.search = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
  final String search;
  @override
  final String sortField;
  @override
  final bool sortAscending;
  @override
  final BuiltList<EntityState> stateFilters;
  @override
  final BuiltList<int> statusFilters;

  factory _$ListUIState([void updates(ListUIStateBuilder b)]) =>
      (new ListUIStateBuilder()..update(updates)).build();

  _$ListUIState._(
      {this.search,
      this.sortField,
      this.sortAscending,
      this.stateFilters,
      this.statusFilters})
      : super._() {
    if (sortField == null)
      throw new BuiltValueNullFieldError('ListUIState', 'sortField');
    if (sortAscending == null)
      throw new BuiltValueNullFieldError('ListUIState', 'sortAscending');
    if (stateFilters == null)
      throw new BuiltValueNullFieldError('ListUIState', 'stateFilters');
    if (statusFilters == null)
      throw new BuiltValueNullFieldError('ListUIState', 'statusFilters');
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
    return search == other.search &&
        sortField == other.sortField &&
        sortAscending == other.sortAscending &&
        stateFilters == other.stateFilters &&
        statusFilters == other.statusFilters;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, search.hashCode), sortField.hashCode),
                sortAscending.hashCode),
            stateFilters.hashCode),
        statusFilters.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListUIState')
          ..add('search', search)
          ..add('sortField', sortField)
          ..add('sortAscending', sortAscending)
          ..add('stateFilters', stateFilters)
          ..add('statusFilters', statusFilters))
        .toString();
  }
}

class ListUIStateBuilder implements Builder<ListUIState, ListUIStateBuilder> {
  _$ListUIState _$v;

  String _search;
  String get search => _$this._search;
  set search(String search) => _$this._search = search;

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

  ListBuilder<int> _statusFilters;
  ListBuilder<int> get statusFilters =>
      _$this._statusFilters ??= new ListBuilder<int>();
  set statusFilters(ListBuilder<int> statusFilters) =>
      _$this._statusFilters = statusFilters;

  ListUIStateBuilder();

  ListUIStateBuilder get _$this {
    if (_$v != null) {
      _search = _$v.search;
      _sortField = _$v.sortField;
      _sortAscending = _$v.sortAscending;
      _stateFilters = _$v.stateFilters?.toBuilder();
      _statusFilters = _$v.statusFilters?.toBuilder();
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
              search: search,
              sortField: sortField,
              sortAscending: sortAscending,
              stateFilters: stateFilters.build(),
              statusFilters: statusFilters.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'stateFilters';
        stateFilters.build();
        _$failedField = 'statusFilters';
        statusFilters.build();
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
