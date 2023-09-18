// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/user_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/ui/user/edit/user_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view_vm.dart';

List<Middleware<AppState>> createStoreUsersMiddleware([
  UserRepository repository = const UserRepository(),
]) {
  final viewUserList = _viewUserList();
  final viewUser = _viewUser();
  final editUser = _editUser();
  final loadUsers = _loadUsers(repository);
  final loadUser = _loadUser(repository);
  final saveUser = _saveUser(repository);
  final archiveUser = _archiveUser(repository);
  final deleteUser = _deleteUser(repository);
  final restoreUser = _restoreUser(repository);
  final removeUser = _removeUser(repository);
  final resendInvite = _resendInvite(repository);

  return [
    TypedMiddleware<AppState, ViewUserList>(viewUserList),
    TypedMiddleware<AppState, ViewUser>(viewUser),
    TypedMiddleware<AppState, EditUser>(editUser),
    TypedMiddleware<AppState, LoadUsers>(loadUsers),
    TypedMiddleware<AppState, LoadUser>(loadUser),
    TypedMiddleware<AppState, SaveUserRequest>(saveUser),
    TypedMiddleware<AppState, ArchiveUserRequest>(archiveUser),
    TypedMiddleware<AppState, DeleteUserRequest>(deleteUser),
    TypedMiddleware<AppState, RestoreUserRequest>(restoreUser),
    TypedMiddleware<AppState, RemoveUserRequest>(removeUser),
    TypedMiddleware<AppState, ResendInviteRequest>(resendInvite),
  ];
}

Middleware<AppState> _editUser() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditUser?;

    next(action);

    store.dispatch(UpdateCurrentRoute(UserEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(UserEditScreen.route);
    }
  };
}

Middleware<AppState> _viewUser() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewUser?;

    next(action);

    store.dispatch(UpdateCurrentRoute(UserViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(UserViewScreen.route);
    }
  };
}

Middleware<AppState> _viewUserList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewUserList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(UserScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          UserScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveUserRequest;
    final prevUsers =
        action.userIds!.map((id) => store.state.userState.map[id]).toList();

    repository
        .bulkAction(store.state.credentials, action.userIds!,
            EntityAction.archive, action.password, action.idToken)
        .then((List<UserEntity> users) {
      store.dispatch(ArchiveUserSuccess(users));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveUserFailure(prevUsers));
      if ('$error'.contains('412')) {
        store.dispatch(UserUnverifiedPassword());
      }
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteUserRequest;
    final prevUsers =
        action.userIds!.map((id) => store.state.userState.map[id]).toList();

    repository
        .bulkAction(store.state.credentials, action.userIds!,
            EntityAction.delete, action.password, action.idToken)
        .then((List<UserEntity> users) {
      store.dispatch(DeleteUserSuccess(users));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteUserFailure(prevUsers));
      if ('$error'.contains('412')) {
        store.dispatch(UserUnverifiedPassword());
      }
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreUserRequest;
    final prevUsers =
        action.userIds!.map((id) => store.state.userState.map[id]).toList();

    repository
        .bulkAction(store.state.credentials, action.userIds!,
            EntityAction.restore, action.password, action.idToken)
        .then((List<UserEntity> users) {
      store.dispatch(RestoreUserSuccess(users));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreUserFailure(prevUsers));
      if ('$error'.contains('412')) {
        store.dispatch(UserUnverifiedPassword());
      }
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _removeUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RemoveUserRequest;

    repository
        .detachFromCompany(
      store.state.credentials,
      action.userId,
      action.password,
      action.idToken,
    )
        .then((_) {
      store.dispatch(RemoveUserSuccess(action.userId));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RemoveUserFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _resendInvite(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ResendInviteRequest;

    repository
        .resendInvite(
      store.state.credentials,
      action.userId,
      action.password,
      action.idToken,
    )
        .then((_) {
      store.dispatch(ResendInviteSuccess(action.userId));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ResendInviteFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveUserRequest;
    repository
        .saveData(store.state.credentials, action.user!, action.password,
            action.idToken)
        .then((UserEntity user) {
      if (action.user!.isNew) {
        store.dispatch(AddUserSuccess(user));
      } else {
        store.dispatch(SaveUserSuccess(user));
      }
      action.completer.complete(user);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveUserFailure(error));
      if ('$error'.contains('412')) {
        store.dispatch(UserUnverifiedPassword());
      }
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadUser;
    final AppState state = store.state;

    store.dispatch(LoadUserRequest());
    repository.loadItem(state.credentials, action.userId).then((user) {
      store.dispatch(LoadUserSuccess(user));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadUserFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadUsers(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadUsers?;
    final AppState state = store.state;

    store.dispatch(LoadUsersRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadUsersSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
      /*
      if (state.userState.isStale) {
        store.dispatch(LoadUsers());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadUsersFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
