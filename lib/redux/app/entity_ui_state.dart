import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entity_ui_state.g.dart';

abstract class EntityUIState implements Built<EntityUIState, EntityUIStateBuilder> {

  String get sortField;

  factory EntityUIState(sortField) {
    return _$EntityUIState._(
      sortField: sortField,
    );
  }

  EntityUIState._();
  //factory EntityUIState([updates(EntityUIStateBuilder b)]) = _$EntityUIState;
  static Serializer<EntityUIState> get serializer => _$entityUIStateSerializer;
}