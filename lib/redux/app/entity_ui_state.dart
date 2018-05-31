import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/ui/app/action_popup_menu.dart';

part 'entity_ui_state.g.dart';

abstract class EntityUIState implements Built<EntityUIState, EntityUIStateBuilder> {

  String get sortField;
  bool get sortAscending;
  BuiltList<int> get stateFilterIds;
  BuiltList<int> get statusFilterIds;

  factory EntityUIState(sortField) {
    return _$EntityUIState._(
      sortField: sortField,
      sortAscending: true,
      stateFilterIds: BuiltList<int>(),
      statusFilterIds: BuiltList<int>(),
    );
  }

  EntityUIState._();
  //factory EntityUIState([updates(EntityUIStateBuilder b)]) = _$EntityUIState;
  static Serializer<EntityUIState> get serializer => _$entityUIStateSerializer;
}