// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/token_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/token/edit/token_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/token/token_screen.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view_vm.dart';

List<Middleware<AppState>> createStoreTokensMiddleware([
  TokenRepository repository = const TokenRepository(),
]) {
  final viewTokenList = _viewTokenList();
  final viewToken = _viewToken();
  final editToken = _editToken();
  final loadTokens = _loadTokens(repository);
  final loadToken = _loadToken(repository);
  final saveToken = _saveToken(repository);
  final archiveToken = _archiveToken(repository);
  final deleteToken = _deleteToken(repository);
  final restoreToken = _restoreToken(repository);

  return [
    TypedMiddleware<AppState, ViewTokenList>(viewTokenList),
    TypedMiddleware<AppState, ViewToken>(viewToken),
    TypedMiddleware<AppState, EditToken>(editToken),
    TypedMiddleware<AppState, LoadTokens>(loadTokens),
    TypedMiddleware<AppState, LoadToken>(loadToken),
    TypedMiddleware<AppState, SaveTokenRequest>(saveToken),
    TypedMiddleware<AppState, ArchiveTokensRequest>(archiveToken),
    TypedMiddleware<AppState, DeleteTokensRequest>(deleteToken),
    TypedMiddleware<AppState, RestoreTokensRequest>(restoreToken),
  ];
}

Middleware<AppState> _editToken() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditToken?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TokenEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TokenEditScreen.route);
    }
  };
}

Middleware<AppState> _viewToken() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewToken?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TokenViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TokenViewScreen.route);
    }
  };
}

Middleware<AppState> _viewTokenList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewTokenList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(TokenScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          TokenScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveToken(TokenRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveTokensRequest;
    final prevTokens =
        action.tokenIds.map((id) => store.state.tokenState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.tokenIds, EntityAction.archive)
        .then((List<TokenEntity> tokens) {
      store.dispatch(ArchiveTokensSuccess(tokens));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTokensFailure(prevTokens));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteToken(TokenRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteTokensRequest;
    final prevTokens =
        action.tokenIds.map((id) => store.state.tokenState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.tokenIds, EntityAction.delete)
        .then((List<TokenEntity> tokens) {
      store.dispatch(DeleteTokensSuccess(tokens));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTokensFailure(prevTokens));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreToken(TokenRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreTokensRequest;
    final prevTokens =
        action.tokenIds.map((id) => store.state.tokenState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.tokenIds, EntityAction.restore)
        .then((List<TokenEntity> tokens) {
      store.dispatch(RestoreTokensSuccess(tokens));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTokensFailure(prevTokens));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveToken(TokenRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTokenRequest;
    repository
        .saveData(store.state.credentials, action.token!, action.password,
            action.idToken)
        .then((TokenEntity token) {
      if (action.token!.isNew) {
        store.dispatch(AddTokenSuccess(token));
      } else {
        store.dispatch(SaveTokenSuccess(token));
      }
      action.completer.complete(token);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveTokenFailure(error));
      if ('$error'.contains('412')) {
        store.dispatch(UserUnverifiedPassword());
      }
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadToken(TokenRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadToken;
    final AppState state = store.state;

    store.dispatch(LoadTokenRequest());
    repository.loadItem(state.credentials, action.tokenId).then((token) {
      store.dispatch(LoadTokenSuccess(token));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTokenFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadTokens(TokenRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTokens?;
    final AppState state = store.state;

    store.dispatch(LoadTokensRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadTokensSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
      /*
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTokensFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
