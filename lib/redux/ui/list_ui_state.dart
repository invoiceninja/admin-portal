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

  BuiltList<String> get custom1Filters;

  BuiltList<String> get custom2Filters;

  bool get hasStateFilters =>
      stateFilters.length != 1 || stateFilters.first != EntityState.active;

  bool get hasStatusFilters => statusFilters.isNotEmpty;

  bool get hasCustom1Filters => custom1Filters.isNotEmpty;

  bool get hasCustom2Filters => custom2Filters.isNotEmpty;

  @nullable
  List<BaseEntity> get selectedEntities;

  bool isInMultiselect() {
    return selectedEntities != null;
  }

  bool isSelected(BaseEntity entity) {
    return selectedEntities != null && selectedEntities.contains(entity);
  }

  //factory EntityUIState([void updates(EntityUIStateBuilder b)]) = _$listUIState;
  static Serializer<ListUIState> get serializer => _$listUIStateSerializer;
}
