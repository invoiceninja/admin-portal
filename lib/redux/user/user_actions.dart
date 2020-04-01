import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ViewUserList extends AbstractNavigatorAction implements PersistUI {
  ViewUserList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewUser extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewUser({
    @required this.userId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String userId;
  final bool force;
}

class EditUser extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditUser(
      {@required this.user,
      @required NavigatorState navigator,
      this.completer,
      this.force = false})
      : super(navigator: navigator);

  final UserEntity user;
  final Completer completer;
  final bool force;
}

class UpdateUser implements PersistUI {
  UpdateUser(this.user);

  final UserEntity user;
}

// TODO remove this action and related code/update with user
class UpdateUserCompany implements PersistUI {
  UpdateUserCompany(this.userCompany);

  final UserCompanyEntity userCompany;
}

class LoadUser {
  LoadUser({this.completer, this.userId});

  final Completer completer;
  final String userId;
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
  SaveUserRequest({
    @required this.completer,
    @required this.user,
    this.password,
  });

  final Completer completer;
  final UserEntity user;
  final String password;
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
  ArchiveUserRequest({this.completer, this.userIds, this.password});

  final Completer completer;
  final List<String> userIds;
  final String password;
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
  DeleteUserRequest({this.completer, this.userIds, this.password});

  final Completer completer;
  final List<String> userIds;
  final String password;
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
  RestoreUserRequest({this.completer, this.userIds, this.password});

  final Completer completer;
  final List<String> userIds;
  final String password;
}

class RestoreUserSuccess implements StopSaving, PersistData {
  RestoreUserSuccess(this.users);

  final List<UserEntity> users;
}

class RestoreUserFailure implements StopSaving {
  RestoreUserFailure(this.users);

  final List<UserEntity> users;
}

class RemoveUserRequest implements StartSaving {
  RemoveUserRequest({this.completer, this.userId, this.password});

  final Completer completer;
  final String userId;
  final String password;
}

class RemoveUserSuccess implements StopSaving, PersistData {
  RemoveUserSuccess(this.users);

  final List<UserEntity> users;
}

class RemoveUserFailure implements StopSaving {
  RemoveUserFailure(this.error);

  final dynamic error;
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
  if (users.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final user = users.first as UserEntity;
  final userIds = users.map((user) => user.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: user);
      break;
    case EntityAction.restore:
      final dispatch = ([String password]) => store.dispatch(RestoreUserRequest(
          completer: snackBarCompleter<Null>(context, localization.restoredUser),
          userIds: userIds,
          password: password));
      if (state.authState.hasRecentlyEnteredPassword) {
        dispatch();
      } else {
        passwordCallback(context: context, callback: (password) {
          dispatch(password);
        });
      }
      break;
    case EntityAction.archive:
      final dispatch = ([String password]) => store.dispatch(ArchiveUserRequest(
          completer: snackBarCompleter<Null>(context, localization.archivedUser),
          userIds: userIds,
          password: password));
      if (state.authState.hasRecentlyEnteredPassword) {
        dispatch();
      } else {
        passwordCallback(context: context, callback: (password) {
          dispatch(password);
        });
      }
      break;
    case EntityAction.delete:
      final dispatch = ([String password]) => store.dispatch(DeleteUserRequest(
          completer: snackBarCompleter<Null>(context, localization.deletedUser),
          userIds: userIds,
          password: password));
      if (state.authState.hasRecentlyEnteredPassword) {
        dispatch();
      } else {
        passwordCallback(context: context, callback: (password) {
          dispatch(password);
        });
      }
      break;
    case EntityAction.remove:
      final dispatch = ([String password]) => store.dispatch(RemoveUserRequest(
          completer: snackBarCompleter<Null>(context, localization.removedUser),
          userId: user.id,
          password: password));
      if (state.authState.hasRecentlyEnteredPassword) {
        dispatch();
      } else {
        passwordCallback(context: context, callback: (password) {
          dispatch(password);
        });
      }
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.userListState.isInMultiselect()) {
        store.dispatch(StartUserMultiselect());
      }

      if (users.isEmpty) {
        break;
      }

      for (final user in users) {
        if (!store.state.userListState.isSelected(user.id)) {
          store.dispatch(AddToUserMultiselect(entity: user));
        } else {
          store.dispatch(RemoveFromUserMultiselect(entity: user));
        }
      }
      break;
  }
}

class StartUserMultiselect {}

class AddToUserMultiselect {
  AddToUserMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromUserMultiselect {
  RemoveFromUserMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearUserMultiselect {}
