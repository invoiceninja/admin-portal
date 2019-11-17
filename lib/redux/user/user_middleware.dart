import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen.dart';
import 'package:invoiceninja_flutter/ui/user/edit/user_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view_vm.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/user_repository.dart';

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
  ];
}

Middleware<AppState> _editUser() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as EditUser;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(UserEditScreen.route));

    if (isMobile(action.context)) {
      final user = await action.navigator.pushNamed(UserEditScreen.route);

      if (action.completer != null && user != null) {
        action.completer.complete(user);
      }
    }
  };
}

Middleware<AppState> _viewUser() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewUser;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(UserViewScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(UserViewScreen.route);
    }
  };
}

Middleware<AppState> _viewUserList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewUserList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.userState.isStale) {
      store.dispatch(LoadUsers());
    }

    store.dispatch(UpdateCurrentRoute(UserScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
          UserScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveUserRequest;

    repository
        .bulkAction(
            store.state.credentials, action.userIds, EntityAction.archive)
        .then((List<UserEntity> users) {
      store.dispatch(ArchiveUserSuccess(users));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      final users =
          action.userIds.map((id) => store.state.userState.map[id]).toList();
      store.dispatch(ArchiveUserFailure(users));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteUserRequest;

    repository
        .bulkAction(
            store.state.credentials, action.userIds, EntityAction.delete)
        .then((List<UserEntity> users) {
      store.dispatch(DeleteUserSuccess(users));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      final users =
          action.userIds.map((id) => store.state.userState.map[id]).toList();
      store.dispatch(DeleteUserFailure(users));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreUserRequest;

    repository
        .bulkAction(
            store.state.credentials, action.userIds, EntityAction.restore)
        .then((List<UserEntity> users) {
      store.dispatch(RestoreUserSuccess(users));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      final users =
          action.userIds.map((id) => store.state.userState.map[id]).toList();
      store.dispatch(RestoreUserFailure(users));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveUserRequest;
    repository
        .saveData(store.state.credentials, action.user)
        .then((UserEntity user) {
      if (action.user.isNew) {
        store.dispatch(AddUserSuccess(user));
      } else {
        store.dispatch(SaveUserSuccess(user));
      }
      action.completer.complete(user);
      final userUIState = store.state.userUIState;
      if (userUIState.saveCompleter != null) {
        userUIState.saveCompleter.complete(user);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveUserFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadUser(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadUser;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadUserRequest());
    repository.loadItem(state.credentials, action.userId).then((user) {
      store.dispatch(LoadUserSuccess(user));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadUserFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadUsers(UserRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadUsers;
    final AppState state = store.state;

    if (!state.userState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.userState.lastUpdated / 1000).round();

    store.dispatch(LoadUsersRequest());
    repository.loadList(state.credentials, updatedAt).then((data) {
      store.dispatch(LoadUsersSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      /*
      if (state.userState.isStale) {
        store.dispatch(LoadUsers());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadUsersFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
