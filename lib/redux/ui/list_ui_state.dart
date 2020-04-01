import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'list_ui_state.g.dart';

abstract class ListUIState implements Built<ListUIState, ListUIStateBuilder> {
  factory ListUIState(String sortField, {bool sortAscending = true}) {
    return _$ListUIState._(
        filterClearedAt: 0,
        sortField: sortField,
        sortAscending: sortAscending,
        stateFilters: BuiltList<EntityState>(<EntityState>[
          EntityState.active,
        ]),
        statusFilters: BuiltList<EntityStatus>(),
        custom1Filters: BuiltList<String>(),
        custom2Filters: BuiltList<String>(),
        custom3Filters: BuiltList<String>(),
        custom4Filters: BuiltList<String>(),
        filter: null);
  }

  ListUIState._();

  @nullable
  String get filter;

  int get filterClearedAt;

  @nullable
  String get filterEntityId;

  @nullable
  EntityType get filterEntityType;

  bool entityMatchesFilter(BaseEntity entity) {
    return filterEntityId == entity.id && filterEntityType == entity.entityType;
  }

  String get sortField;

  bool get sortAscending;

  BuiltList<EntityState> get stateFilters;

  BuiltList<EntityStatus> get statusFilters;

  BuiltList<String> getCustomFilters(int fieldNumber) {
    switch (fieldNumber) {
      case 1:
        return custom1Filters;
      case 2:
        return custom2Filters;
      case 3:
        return custom3Filters;
      case 4:
        return custom4Filters;
      default:
        return null;
    }
  }

  BuiltList<String> get custom1Filters;

  BuiltList<String> get custom2Filters;

  BuiltList<String> get custom3Filters;

  BuiltList<String> get custom4Filters;

  bool get hasStateFilters =>
      stateFilters.length != 1 || stateFilters.first != EntityState.active;

  bool get hasStatusFilters => statusFilters.isNotEmpty;

  bool get hasCustom1Filters => custom1Filters.isNotEmpty;

  bool get hasCustom2Filters => custom2Filters.isNotEmpty;

  bool get hasCustom3Filters => custom3Filters.isNotEmpty;

  bool get hasCustom4Filters => custom4Filters.isNotEmpty;

  @nullable
  BuiltList<String> get selectedIds;

  bool isInMultiselect() {
    return selectedIds != null;
  }

  bool isSelected(String id) {
    return selectedIds != null && selectedIds.contains(id);
  }

  //factory EntityUIState([void updates(EntityUIStateBuilder b)]) = _$listUIState;
  static Serializer<ListUIState> get serializer => _$listUIStateSerializer;
}
