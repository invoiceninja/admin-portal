import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';

EntityUIState userUIReducer(UserUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(userListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewUser>(
      (String selectedId, dynamic action) => action.userId),
  TypedReducer<String, AddUserSuccess>(
      (String selectedId, dynamic action) => action.user.id),
  TypedReducer<String, FilterUsersByEntity>(
      (selectedId, action) => action.entityId == null ? selectedId : '')
]);

final editingReducer = combineReducers<UserEntity>([
  TypedReducer<UserEntity, SaveUserSuccess>(_updateEditing),
  TypedReducer<UserEntity, AddUserSuccess>(_updateEditing),
  TypedReducer<UserEntity, RestoreUserSuccess>(_updateEditing),
  TypedReducer<UserEntity, ArchiveUserSuccess>(_updateEditing),
  TypedReducer<UserEntity, DeleteUserSuccess>(_updateEditing),
  TypedReducer<UserEntity, EditUser>(_updateEditing),
  TypedReducer<UserEntity, UpdateUser>((user, action) {
    return action.user.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<UserEntity, SelectCompany>(_clearEditing),
  TypedReducer<UserEntity, DiscardChanges>(_clearEditing),
]);

UserEntity _clearEditing(UserEntity user, dynamic action) {
  return UserEntity();
}

UserEntity _updateEditing(UserEntity user, dynamic action) {
  return action.user;
}

final userListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortUsers>(_sortUsers),
  TypedReducer<ListUIState, FilterUsersByState>(_filterUsersByState),
  TypedReducer<ListUIState, FilterUsers>(_filterUsers),
  TypedReducer<ListUIState, FilterUsersByCustom1>(_filterUsersByCustom1),
  TypedReducer<ListUIState, FilterUsersByCustom2>(_filterUsersByCustom2),
  TypedReducer<ListUIState, FilterUsersByEntity>(_filterUsersByClient),
  TypedReducer<ListUIState, StartUserMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToUserMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromUserMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearUserMultiselect>(_clearListMultiselect),
]);

ListUIState _filterUsersByClient(
    ListUIState userListState, FilterUsersByEntity action) {
  return userListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterUsersByCustom1(
    ListUIState userListState, FilterUsersByCustom1 action) {
  if (userListState.custom1Filters.contains(action.value)) {
    return userListState.rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return userListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterUsersByCustom2(
    ListUIState userListState, FilterUsersByCustom2 action) {
  if (userListState.custom2Filters.contains(action.value)) {
    return userListState.rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return userListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterUsersByState(
    ListUIState userListState, FilterUsersByState action) {
  if (userListState.stateFilters.contains(action.state)) {
    return userListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return userListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterUsers(ListUIState userListState, FilterUsers action) {
  return userListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : userListState.filterClearedAt);
}

ListUIState _sortUsers(ListUIState userListState, SortUsers action) {
  return userListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartUserMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToUserMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromUserMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearUserMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

final usersReducer = combineReducers<UserState>([
  TypedReducer<UserState, SaveUserSuccess>(_updateUser),
  TypedReducer<UserState, AddUserSuccess>(_addUser),
  TypedReducer<UserState, LoadUsersSuccess>(_setLoadedUsers),
  TypedReducer<UserState, LoadUserSuccess>(_setLoadedUser),
  TypedReducer<UserState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<UserState, ArchiveUserRequest>(_archiveUserRequest),
  TypedReducer<UserState, ArchiveUserSuccess>(_archiveUserSuccess),
  TypedReducer<UserState, ArchiveUserFailure>(_archiveUserFailure),
  TypedReducer<UserState, DeleteUserRequest>(_deleteUserRequest),
  TypedReducer<UserState, DeleteUserSuccess>(_deleteUserSuccess),
  TypedReducer<UserState, DeleteUserFailure>(_deleteUserFailure),
  TypedReducer<UserState, RestoreUserRequest>(_restoreUserRequest),
  TypedReducer<UserState, RestoreUserSuccess>(_restoreUserSuccess),
  TypedReducer<UserState, RestoreUserFailure>(_restoreUserFailure),
]);

UserState _archiveUserRequest(UserState userState, ArchiveUserRequest action) {
  final user = userState.map[action.userId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return userState.rebuild((b) => b..map[action.userId] = user);
}

UserState _archiveUserSuccess(UserState userState, ArchiveUserSuccess action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _archiveUserFailure(UserState userState, ArchiveUserFailure action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _deleteUserRequest(UserState userState, DeleteUserRequest action) {
  final user = userState.map[action.userId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return userState.rebuild((b) => b..map[action.userId] = user);
}

UserState _deleteUserSuccess(UserState userState, DeleteUserSuccess action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _deleteUserFailure(UserState userState, DeleteUserFailure action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _restoreUserRequest(UserState userState, RestoreUserRequest action) {
  final user = userState.map[action.userId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return userState.rebuild((b) => b..map[action.userId] = user);
}

UserState _restoreUserSuccess(UserState userState, RestoreUserSuccess action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _restoreUserFailure(UserState userState, RestoreUserFailure action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _addUser(UserState userState, AddUserSuccess action) {
  return userState.rebuild((b) => b
    ..map[action.user.id] = action.user
    ..list.add(action.user.id));
}

UserState _updateUser(UserState userState, SaveUserSuccess action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _setLoadedUser(UserState userState, LoadUserSuccess action) {
  return userState.rebuild((b) => b..map[action.user.id] = action.user);
}

UserState _setLoadedUsers(UserState userState, LoadUsersSuccess action) {
  final state = userState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.users,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}

UserState _setLoadedCompany(UserState userState, LoadCompanySuccess action) {
  final state = userState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.userCompany.company.users,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
