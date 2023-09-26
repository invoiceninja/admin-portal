// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/subscription_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/subscription/subscription_screen.dart';
import 'package:invoiceninja_flutter/ui/subscription/view/subscription_view_vm.dart';

List<Middleware<AppState>> createStoreSubscriptionsMiddleware([
  SubscriptionRepository repository = const SubscriptionRepository(),
]) {
  final viewSubscriptionList = _viewSubscriptionList();
  final viewSubscription = _viewSubscription();
  final editSubscription = _editSubscription();
  final loadSubscriptions = _loadSubscriptions(repository);
  final loadSubscription = _loadSubscription(repository);
  final saveSubscription = _saveSubscription(repository);
  final archiveSubscription = _archiveSubscription(repository);
  final deleteSubscription = _deleteSubscription(repository);
  final restoreSubscription = _restoreSubscription(repository);

  return [
    TypedMiddleware<AppState, ViewSubscriptionList>(viewSubscriptionList),
    TypedMiddleware<AppState, ViewSubscription>(viewSubscription),
    TypedMiddleware<AppState, EditSubscription>(editSubscription),
    TypedMiddleware<AppState, LoadSubscriptions>(loadSubscriptions),
    TypedMiddleware<AppState, LoadSubscription>(loadSubscription),
    TypedMiddleware<AppState, SaveSubscriptionRequest>(saveSubscription),
    TypedMiddleware<AppState, ArchiveSubscriptionsRequest>(archiveSubscription),
    TypedMiddleware<AppState, DeleteSubscriptionsRequest>(deleteSubscription),
    TypedMiddleware<AppState, RestoreSubscriptionsRequest>(restoreSubscription),
  ];
}

Middleware<AppState> _editSubscription() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditSubscription?;

    next(action);

    store.dispatch(UpdateCurrentRoute(SubscriptionEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(SubscriptionEditScreen.route);
    }
  };
}

Middleware<AppState> _viewSubscription() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewSubscription?;

    next(action);

    store.dispatch(UpdateCurrentRoute(SubscriptionViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(SubscriptionViewScreen.route);
    }
  };
}

Middleware<AppState> _viewSubscriptionList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewSubscriptionList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(SubscriptionScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          SubscriptionScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveSubscription(SubscriptionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveSubscriptionsRequest;
    final prevSubscriptions = action.subscriptionIds
        .map((id) => store.state.subscriptionState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.subscriptionIds,
            EntityAction.archive)
        .then((List<SubscriptionEntity> subscriptions) {
      store.dispatch(ArchiveSubscriptionsSuccess(subscriptions));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveSubscriptionsFailure(prevSubscriptions));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteSubscription(SubscriptionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteSubscriptionsRequest;
    final prevSubscriptions = action.subscriptionIds
        .map((id) => store.state.subscriptionState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.subscriptionIds,
            EntityAction.delete)
        .then((List<SubscriptionEntity> subscriptions) {
      store.dispatch(DeleteSubscriptionsSuccess(subscriptions));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteSubscriptionsFailure(prevSubscriptions));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreSubscription(SubscriptionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreSubscriptionsRequest;
    final prevSubscriptions = action.subscriptionIds
        .map((id) => store.state.subscriptionState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.subscriptionIds,
            EntityAction.restore)
        .then((List<SubscriptionEntity> subscriptions) {
      store.dispatch(RestoreSubscriptionsSuccess(subscriptions));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreSubscriptionsFailure(prevSubscriptions));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveSubscription(SubscriptionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveSubscriptionRequest;
    repository
        .saveData(store.state.credentials, action.subscription!)
        .then((SubscriptionEntity subscription) {
      if (action.subscription!.isNew) {
        store.dispatch(AddSubscriptionSuccess(subscription));
      } else {
        store.dispatch(SaveSubscriptionSuccess(subscription));
      }

      action.completer!.complete(subscription);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveSubscriptionFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadSubscription(SubscriptionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadSubscription;
    final AppState state = store.state;

    store.dispatch(LoadSubscriptionRequest());
    repository
        .loadItem(state.credentials, action.subscriptionId)
        .then((subscription) {
      store.dispatch(LoadSubscriptionSuccess(subscription));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadSubscriptionFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadSubscriptions(SubscriptionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadSubscriptions?;
    final AppState state = store.state;

    store.dispatch(LoadSubscriptionsRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadSubscriptionsSuccess(data));

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
      store.dispatch(LoadSubscriptionsFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
