import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'group_state.g.dart';

abstract class GroupState implements Built<GroupState, GroupStateBuilder> {
  factory GroupState() {
    return _$GroupState._(
      lastUpdated: 0,
      map: BuiltMap<String, GroupEntity>(),
      list: BuiltList<String>(),
    );
  }
  GroupState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, GroupEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

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
    );
  }
  GroupUIState._();

  @nullable
  GroupEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<GroupUIState> get serializer => _$groupUIStateSerializer;
}
