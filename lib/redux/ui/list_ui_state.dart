import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_ui_state.g.dart';

abstract class ListUIState implements Built<ListUIState, ListUIStateBuilder> {

  String get sortField;
  bool get sortAscending;
  BuiltList<int> get stateFilterIds;
  BuiltList<int> get statusFilterIds;

  factory ListUIState(sortField) {
    return _$ListUIState._(
      sortField: sortField,
      sortAscending: true,
      stateFilterIds: BuiltList<int>(),
      statusFilterIds: BuiltList<int>(),
    );
  }

  ListUIState._();
  //factory EntityUIState([updates(EntityUIStateBuilder b)]) = _$listUIState;
  static Serializer<ListUIState> get serializer => _$listUIStateSerializer;
}