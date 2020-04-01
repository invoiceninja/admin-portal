import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  factory UserState() {
    return _$UserState._(
      lastUpdated: 0,
      map: BuiltMap<String, UserEntity>(),
      list: BuiltList<String>(),
    );
  }
  UserState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, UserEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<UserState> get serializer => _$userStateSerializer;
}

abstract class UserUIState extends Object
    with EntityUIState
    implements Built<UserUIState, UserUIStateBuilder> {
  factory UserUIState() {
    return _$UserUIState._(
      listUIState: ListUIState(UserFields.firstName),
      editing: UserEntity(),
      selectedId: '',
    );
  }
  UserUIState._();

  @nullable
  UserEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<UserUIState> get serializer => _$userUIStateSerializer;
}
