// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewUserList implements PersistUI {
  ViewUserList({this.force = false});

  final bool force;
}

class ViewUser implements PersistUI, PersistPrefs {
  ViewUser({
    required this.userId,
    this.force = false,
  });

  final String? userId;
  final bool force;
}

class EditUser implements PersistUI, PersistPrefs {
  EditUser({required this.user, this.completer, this.force = false});

  final UserEntity user;
  final Completer? completer;
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

  final Completer? completer;
  final String? userId;
}

class LoadUserActivity {
  LoadUserActivity({this.completer, this.userId});

  final Completer? completer;
  final String? userId;
}

class LoadUsers {
  LoadUsers({this.completer});

  final Completer? completer;
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

class LoadUsersSuccess implements StopLoading {
  LoadUsersSuccess(this.users);

  final BuiltList<UserEntity> users;

  @override
  String toString() {
    return 'LoadUsersSuccess{users: $users}';
  }
}

class SaveUserRequest implements StartSaving {
  SaveUserRequest({
    required this.completer,
    required this.user,
    this.password,
    this.idToken,
  });

  final Completer completer;
  final UserEntity? user;
  final String? password;
  final String? idToken;
}

class SaveUserSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  SaveUserSuccess(this.user);

  final UserEntity user;
}

class AddUserSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  AddUserSuccess(this.user);

  final UserEntity user;
}

class SaveUserFailure implements StopSaving {
  SaveUserFailure(this.error);

  final Object error;
}

class ArchiveUserRequest implements StartSaving {
  ArchiveUserRequest({
    this.completer,
    this.userIds,
    this.password,
    this.idToken,
  });

  final Completer? completer;
  final List<String>? userIds;
  final String? password;
  final String? idToken;
}

class ArchiveUserSuccess
    implements StopSaving, PersistData, UserVerifiedPassword {
  ArchiveUserSuccess(this.users);

  final List<UserEntity> users;
}

class ArchiveUserFailure implements StopSaving {
  ArchiveUserFailure(this.users);

  final List<UserEntity?> users;
}

class DeleteUserRequest implements StartSaving {
  DeleteUserRequest({
    this.completer,
    this.userIds,
    this.password,
    this.idToken,
  });

  final Completer? completer;
  final List<String>? userIds;
  final String? password;
  final String? idToken;
}

class DeleteUserSuccess
    implements StopSaving, PersistData, UserVerifiedPassword {
  DeleteUserSuccess(this.users);

  final List<UserEntity> users;
}

class DeleteUserFailure implements StopSaving {
  DeleteUserFailure(this.users);

  final List<UserEntity?> users;
}

class RestoreUserRequest implements StartSaving {
  RestoreUserRequest({
    this.completer,
    this.userIds,
    this.password,
    this.idToken,
  });

  final Completer? completer;
  final List<String>? userIds;
  final String? password;
  final String? idToken;
}

class RestoreUserSuccess
    implements StopSaving, PersistData, UserVerifiedPassword {
  RestoreUserSuccess(this.users);

  final List<UserEntity> users;
}

class RestoreUserFailure implements StopSaving {
  RestoreUserFailure(this.users);

  final List<UserEntity?> users;
}

class RemoveUserRequest implements StartSaving {
  RemoveUserRequest({
    this.completer,
    this.userId,
    this.password,
    this.idToken,
  });

  final Completer? completer;
  final String? userId;
  final String? password;
  final String? idToken;
}

class RemoveUserSuccess implements StopSaving, PersistData {
  RemoveUserSuccess(this.userId);

  final String? userId;
}

class RemoveUserFailure implements StopSaving {
  RemoveUserFailure(this.error);

  final dynamic error;
}

class ResendInviteRequest implements StartSaving {
  ResendInviteRequest({
    this.completer,
    this.userId,
    this.password,
    this.idToken,
  });

  final Completer? completer;
  final String? userId;
  final String? password;
  final String? idToken;
}

class ResendInviteSuccess implements StopSaving, PersistData {
  ResendInviteSuccess(this.userId);

  final String? userId;
}

class ResendInviteFailure implements StopSaving {
  ResendInviteFailure(this.error);

  final dynamic error;
}

class FilterUsers {
  FilterUsers(this.filter);

  final String? filter;
}

class SortUsers implements PersistUI, PersistPrefs {
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

class FilterUsersByCustom3 implements PersistUI {
  FilterUsersByCustom3(this.value);

  final String value;
}

class FilterUsersByCustom4 implements PersistUI {
  FilterUsersByCustom4(this.value);

  final String value;
}

void handleUserAction(
    BuildContext? context, List<BaseEntity> users, EntityAction? action) {
  if (users.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final user = users.first as UserEntity;
  final userIds = users.map((user) => user.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: user);
      break;
    case EntityAction.newClient:
      createEntity(
          entity: ClientEntity(state: state)
              .rebuild((b) => b.assignedUserId = user.id));
      break;
    case EntityAction.newInvoice:
      createEntity(
          entity: InvoiceEntity(state: state)
              .rebuild((b) => b.assignedUserId = user.id));
      break;
    case EntityAction.newRecurringInvoice:
      createEntity(
          entity: InvoiceEntity(
                  state: state, entityType: EntityType.recurringInvoice)
              .rebuild((b) => b.assignedUserId = user.id));
      break;
    case EntityAction.newQuote:
      createEntity(
        entity: InvoiceEntity(
          state: state,
          entityType: EntityType.quote,
        ).rebuild((b) => b.assignedUserId = user.id),
      );
      break;
    case EntityAction.newCredit:
      createEntity(
        entity: InvoiceEntity(
          state: state,
          entityType: EntityType.credit,
        ).rebuild((b) => b.assignedUserId = user.id),
      );
      break;
    case EntityAction.newExpense:
      createEntity(
        entity: ExpenseEntity(state: state)
            .rebuild((b) => b.assignedUserId = user.id),
      );
      break;
    case EntityAction.newPayment:
      createEntity(
        entity: PaymentEntity(state: state)
            .rebuild((b) => b.assignedUserId = user.id),
      );
      break;
    case EntityAction.newProject:
      createEntity(
        entity: ProjectEntity(state: state)
            .rebuild((b) => b.assignedUserId = user.id),
      );
      break;
    case EntityAction.newTask:
      createEntity(
        entity:
            TaskEntity(state: state).rebuild((b) => b.assignedUserId = user.id),
      );
      break;
    case EntityAction.newVendor:
      createEntity(
        entity: VendorEntity(state: state)
            .rebuild((b) => b.assignedUserId = user.id),
      );
      break;
    case EntityAction.restore:
      final message = userIds.length > 1
          ? localization!.restoredUsers
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', userIds.length.toString())
          : localization!.restoredUser;
      final dispatch = ([String? password, String? idToken]) =>
          store.dispatch(RestoreUserRequest(
            completer: snackBarCompleter<Null>(message),
            userIds: userIds,
            password: password,
            idToken: idToken,
          ));
      passwordCallback(
          context: context,
          callback: (password, idToken) {
            dispatch(password, idToken);
          });
      break;
    case EntityAction.archive:
      final message = userIds.length > 1
          ? localization!.archivedUsers
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', userIds.length.toString())
          : localization!.archivedUser;
      final dispatch = ([String? password, String? idToken]) =>
          store.dispatch(ArchiveUserRequest(
            completer: snackBarCompleter<Null>(message),
            userIds: userIds,
            password: password,
            idToken: idToken,
          ));
      passwordCallback(
          context: context,
          callback: (password, idToken) {
            dispatch(password, idToken);
          });
      break;
    case EntityAction.delete:
      final message = userIds.length > 1
          ? localization!.deletedUsers
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', userIds.length.toString())
          : localization!.deletedUser;
      final dispatch = ([
        String? password,
        String? idToken,
      ]) =>
          store.dispatch(DeleteUserRequest(
            completer: snackBarCompleter<Null>(message),
            userIds: userIds,
            password: password,
            idToken: idToken,
          ));
      passwordCallback(
          context: context,
          callback: (password, idToken) {
            dispatch(password, idToken);
          });
      break;
    case EntityAction.newRecurringExpense:
      createEntity(
          entity: ExpenseEntity(
              state: state,
              user: user,
              entityType: EntityType.recurringExpense));
      break;
    case EntityAction.remove:
      final message = userIds.length > 1
          ? localization!.removedUsers
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', userIds.length.toString())
          : localization!.removedUser;
      final dispatch = ([
        String? password,
        String? idToken,
      ]) =>
          store.dispatch(RemoveUserRequest(
            completer: snackBarCompleter<Null>(message),
            userId: user.id,
            password: password,
            idToken: idToken,
          ));
      confirmCallback(
          context: context,
          callback: (_) {
            passwordCallback(
                context: context,
                callback: (password, idToken) {
                  dispatch(password, idToken);
                });
          });
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
    case EntityAction.resendInvite:
      passwordCallback(
          context: context,
          callback: (password, idToken) {
            store.dispatch(ResendInviteRequest(
              userId: user.id,
              password: password,
              idToken: idToken,
              completer: snackBarCompleter<Null>(
                  localization!.emailSentToConfirmEmail),
            ));
          });
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [user],
      );
      break;
  }
}

class StartUserMultiselect {}

class AddToUserMultiselect {
  AddToUserMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromUserMultiselect {
  RemoveFromUserMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearUserMultiselect {}
