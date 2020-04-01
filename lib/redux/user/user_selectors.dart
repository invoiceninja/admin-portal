import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownUserList = memo3((BuiltMap<String, UserEntity> userMap,
        BuiltList<String> userList, String clientId) =>
    dropdownUsersSelector(userMap, userList, clientId));

List<String> dropdownUsersSelector(BuiltMap<String, UserEntity> userMap,
    BuiltList<String> userList, String clientId) {
  final list = userList.where((userId) {
    final user = userMap[userId];
    /*
    if (clientId != null && clientId > 0 && user.clientId != clientId) {
      return false;
    }
    */
    return user.isActive;
  }).toList();

  list.sort((userAId, userBId) {
    final userA = userMap[userAId];
    final userB = userMap[userBId];
    return userA.compareTo(userB, UserFields.firstName, true);
  });

  return list;
}

var memoizedFilteredUserList = memo3((BuiltMap<String, UserEntity> userMap,
        BuiltList<String> userList, ListUIState userListState) =>
    filteredUsersSelector(userMap, userList, userListState));

List<String> filteredUsersSelector(BuiltMap<String, UserEntity> userMap,
    BuiltList<String> userList, ListUIState userListState) {
  final list = userList.where((userId) {
    final user = userMap[userId];

    if (!user.matchesStates(userListState.stateFilters)) {
      return false;
    }

    return user.matchesFilter(userListState.filter);
  }).toList();

  list.sort((userAId, userBId) {
    final userA = userMap[userAId];
    final userB = userMap[userBId];
    return userA.compareTo(
        userB, userListState.sortField, userListState.sortAscending);
  });

  return list;
}

var memoizedUserList =
    memo1((BuiltMap<String, UserEntity> userMap) => userList(userMap));

List<String> userList(BuiltMap<String, UserEntity> userMap) {
  final list =
      userMap.keys.where((userId) => userMap[userId].isActive).toList();

  list.sort((idA, idB) => userMap[idA]
      .fullName
      .toLowerCase()
      .compareTo(userMap[idB].fullName.toLowerCase()));

  return list;
}

bool hasUserChanges(UserEntity user, BuiltMap<String, UserEntity> userMap) =>
    user.isNew ? user.isChanged : user != userMap[user.id];
