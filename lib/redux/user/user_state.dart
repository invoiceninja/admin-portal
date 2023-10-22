// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  factory UserState() {
    return _$UserState._(
      map: BuiltMap<String, UserEntity>(),
      list: BuiltList<String>(),
    );
  }

  UserState._();

  UserEntity get(String userId) {
    if (map.containsKey(userId)) {
      return map[userId]!;
    } else {
      return UserEntity(id: userId);
    }
  }

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, UserEntity> get map;

  BuiltList<String> get list;

  static Serializer<UserState> get serializer => _$userStateSerializer;
}

abstract class UserUIState extends Object
    with EntityUIState
    implements Built<UserUIState, UserUIStateBuilder> {
  factory UserUIState(PrefStateSortField? sortField) {
    return _$UserUIState._(
      listUIState: ListUIState(sortField?.field ?? UserFields.firstName,
          sortAscending: sortField?.ascending),
      editing: UserEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  UserUIState._();

  @override
  @memoized
  int get hashCode;

  UserEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<UserUIState> get serializer => _$userUIStateSerializer;
}
