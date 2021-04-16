import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'group_state.g.dart';

abstract class GroupState implements Built<GroupState, GroupStateBuilder> {
  factory GroupState() {
    return _$GroupState._(
      map: BuiltMap<String, GroupEntity>(),
      list: BuiltList<String>(),
    );
  }

  GroupState._();

  @override
  @memoized
  int get hashCode;

  GroupEntity get(String groupId) {
    if (map.containsKey(groupId)) {
      return map[groupId];
    } else {
      return GroupEntity(id: groupId);
    }
  }

  BuiltMap<String, GroupEntity> get map;

  BuiltList<String> get list;

  static Serializer<GroupState> get serializer => _$groupStateSerializer;
}

abstract class GroupUIState extends Object
    with EntityUIState
    implements Built<GroupUIState, GroupUIStateBuilder> {
  factory GroupUIState() {
    return _$GroupUIState._(
      listUIState: ListUIState(GroupFields.name),
      editing: GroupEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  GroupUIState._();

  @override
  @memoized
  int get hashCode;

  @nullable
  GroupEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<GroupUIState> get serializer => _$groupUIStateSerializer;
}
