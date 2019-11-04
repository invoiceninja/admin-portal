import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ViewUserList implements PersistUI {
  ViewUserList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewUser implements PersistUI {
  ViewUser({
    @required this.userId,
    @required this.context,
    this.force = false,
  });

  final String userId;
  final BuildContext context;
  final bool force;
}

class EditUser implements PersistUI {
  EditUser(
      {@required this.user,
      @required this.context,
      this.completer,
      this.force = false});

  final UserEntity user;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class UpdateUser implements PersistUI {
  UpdateUser(this.user);

  final UserEntity user;
}

class LoadUser {
  LoadUser({this.completer, this.userId, this.loadActivities = false});

  final Completer completer;
  final String userId;
  final bool loadActivities;
}

class LoadUserActivity {
  LoadUserActivity({this.completer, this.userId});

  final Completer completer;
  final String userId;
}

class LoadUsers {
  LoadUsers({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadUserRequest implements StartLoading {}

class LoadUserFailure implements StopLoading {
  LoadUserFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadUserFailure{error: $error}';
  }
}

class LoadUserSuccess implements StopLoading, PersistData {
  LoadUserSuccess(this.user);

  final UserEntity user;

  @override
  String toString() {
    return 'LoadUserSuccess{user: $user}';
  }
}

class LoadUsersRequest implements StartLoading {}

class LoadUsersFailure implements StopLoading {
  LoadUsersFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadUsersFailure{error: $error}';
  }
}

class LoadUsersSuccess implements StopLoading, PersistData {
  LoadUsersSuccess(this.users);

  final BuiltList<UserEntity> users;

  @override
  String toString() {
    return 'LoadUsersSuccess{users: $users}';
  }
}

class SaveUserRequest implements StartSaving {
  SaveUserRequest({this.completer, this.user});

  final Completer completer;
  final UserEntity user;
}

class SaveUserSuccess implements StopSaving, PersistData, PersistUI {
  SaveUserSuccess(this.user);

  final UserEntity user;
}

class AddUserSuccess implements StopSaving, PersistData, PersistUI {
  AddUserSuccess(this.user);

  final UserEntity user;
}

class SaveUserFailure implements StopSaving {
  SaveUserFailure(this.error);

  final Object error;
}

class ArchiveUserRequest implements StartSaving {
  ArchiveUserRequest(this.completer, this.userIds);

  final Completer completer;
  final List<String> userIds;
}

class ArchiveUserSuccess implements StopSaving, PersistData {
  ArchiveUserSuccess(this.users);

  final List<UserEntity> users;
}

class ArchiveUserFailure implements StopSaving {
  ArchiveUserFailure(this.users);

  final List<UserEntity> users;
}

class DeleteUserRequest implements StartSaving {
  DeleteUserRequest(this.completer, this.userIds);

  final Completer completer;
  final List<String> userIds;
}

class DeleteUserSuccess implements StopSaving, PersistData {
  DeleteUserSuccess(this.users);

  final List<UserEntity> users;
}

class DeleteUserFailure implements StopSaving {
  DeleteUserFailure(this.users);

  final List<UserEntity> users;
}

class RestoreUserRequest implements StartSaving {
  RestoreUserRequest(this.completer, this.userIds);

  final Completer completer;
  final List<String> userIds;
}

class RestoreUserSuccess implements StopSaving, PersistData {
  RestoreUserSuccess(this.users);

  final List<UserEntity> users;
}

class RestoreUserFailure implements StopSaving {
  RestoreUserFailure(this.users);

  final List<UserEntity> users;
}

class FilterUsers {
  FilterUsers(this.filter);

  final String filter;
}

class SortUsers implements PersistUI {
  SortUsers(this.field);

  final String field;
}

class FilterUsersByState implements PersistUI {
  FilterUsersByState(this.state);

  final EntityState state;
}

class FilterUsersByCustom1 implements PersistUI {
  FilterUsersByCustom1(this.value);

  final String value;
}

class FilterUsersByCustom2 implements PersistUI {
  FilterUsersByCustom2(this.value);

  final String value;
}

class FilterUsersByEntity implements PersistUI {
  FilterUsersByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleUserAction(
    BuildContext context, List<BaseEntity> users, EntityAction action) {
  final store = StoreProvider.of<AppState>(context);
  //final state = store.state;
  final localization = AppLocalization.of(context);
  final user = users.first as UserEntity;
  final userIds = users.map((user) => user.id).toList();

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditUser(context: context, user: user));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreUserRequest(
          snackBarCompleter(context, localization.restoredUser), userIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveUserRequest(
          snackBarCompleter(context, localization.archivedUser), userIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteUserRequest(
          snackBarCompleter(context, localization.deletedUser), userIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.userListState.isInMultiselect()) {
        store.dispatch(StartUserMultiselect(context: context));
      }

      if (users.isEmpty) {
        break;
      }

      for (final user in users) {
        if (!store.state.userListState.isSelected(user.id)) {
          store.dispatch(AddToUserMultiselect(context: context, entity: user));
        } else {
          store.dispatch(
              RemoveFromUserMultiselect(context: context, entity: user));
        }
      }
      break;
  }
}

class StartUserMultiselect {
  StartUserMultiselect({@required this.context});

  final BuildContext context;
}

class AddToUserMultiselect {
  AddToUserMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromUserMultiselect {
  RemoveFromUserMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearUserMultiselect {
  ClearUserMultiselect({@required this.context});

  final BuildContext context;
}
