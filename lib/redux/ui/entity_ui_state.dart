import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';

part 'entity_ui_state.g.dart';

abstract class EntityUIState implements Built<EntityUIState, EntityUIStateBuilder> {

  ListUIState get listUIState;

  factory EntityUIState(sortField) {
    return _$EntityUIState._(
      listUIState: ListUIState(sortField),
    );
  }

  EntityUIState._();
  //factory EntityUIState([updates(EntityUIStateBuilder b)]) = _$EntityUIState;
  static Serializer<EntityUIState> get serializer => _$entityUIStateSerializer;
}