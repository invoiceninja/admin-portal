import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'list_ui_state.g.dart';

abstract class ListUIState implements Built<ListUIState, ListUIStateBuilder> {

  factory ListUIState(String sortField) {
    return _$ListUIState._(
      sortField: sortField,
      sortAscending: true,
      stateFilters: BuiltList<EntityState>(<EntityState>[
        EntityState.active,
      ]),
      statusFilters: BuiltList<EntityStatus>(),
    );
  }
  ListUIState._();

  @nullable
  String get filter;

  @nullable
  int get filterClientId;

  String get sortField;
  bool get sortAscending;
  BuiltList<EntityState> get stateFilters;
  BuiltList<EntityStatus> get statusFilters;

  bool get hasCustomStateFilters => stateFilters.length != 1 || stateFilters.first != EntityState.active;
  bool get hasCustomStatusFilters => statusFilters.isNotEmpty;

  //factory EntityUIState([void updates(EntityUIStateBuilder b)]) = _$listUIState;
  static Serializer<ListUIState> get serializer => _$listUIStateSerializer;
}