import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_screen.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/edit/tax_rate_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/view/tax_rate_view_vm.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/tax_rate_repository.dart';

List<Middleware<AppState>> createStoreTaxRatesMiddleware([
  TaxRateRepository repository = const TaxRateRepository(),
]) {
  final viewTaxRateList = _viewTaxRateList();
  final viewTaxRate = _viewTaxRate();
  final editTaxRate = _editTaxRate();
  final loadTaxRates = _loadTaxRates(repository);
  final loadTaxRate = _loadTaxRate(repository);
  final saveTaxRate = _saveTaxRate(repository);
  final archiveTaxRate = _archiveTaxRate(repository);
  final deleteTaxRate = _deleteTaxRate(repository);
  final restoreTaxRate = _restoreTaxRate(repository);

  return [
    TypedMiddleware<AppState, ViewTaxRateList>(viewTaxRateList),
    TypedMiddleware<AppState, ViewTaxRate>(viewTaxRate),
    TypedMiddleware<AppState, EditTaxRate>(editTaxRate),
    TypedMiddleware<AppState, LoadTaxRates>(loadTaxRates),
    TypedMiddleware<AppState, LoadTaxRate>(loadTaxRate),
    TypedMiddleware<AppState, SaveTaxRateRequest>(saveTaxRate),
    TypedMiddleware<AppState, ArchiveTaxRateRequest>(archiveTaxRate),
    TypedMiddleware<AppState, DeleteTaxRateRequest>(deleteTaxRate),
    TypedMiddleware<AppState, RestoreTaxRateRequest>(restoreTaxRate),
  ];
}

Middleware<AppState> _editTaxRate() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditTaxRate;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(TaxRateEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(TaxRateEditScreen.route);
    }
  };
}

Middleware<AppState> _viewTaxRate() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewTaxRate;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(TaxRateViewScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(TaxRateViewScreen.route);
    }
  };
}

Middleware<AppState> _viewTaxRateList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewTaxRateList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.taxRateState.isStale) {
      store.dispatch(LoadTaxRates());
    }

    store.dispatch(UpdateCurrentRoute(TaxRateSettingsScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
          TaxRateSettingsScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveTaxRate(TaxRateRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveTaxRateRequest;
    final prevTaxRates = action.taxRateIds
        .map((id) => store.state.taxRateState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.taxRateIds, EntityAction.archive)
        .then((List<TaxRateEntity> taxRates) {
      store.dispatch(ArchiveTaxRatesSuccess(taxRates));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTaxRateFailure(prevTaxRates));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteTaxRate(TaxRateRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteTaxRateRequest;
    final prevTaxRates = action.taxRateIds
        .map((id) => store.state.taxRateState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.taxRateIds, EntityAction.delete)
        .then((List<TaxRateEntity> taxRates) {
      store.dispatch(DeleteTaxRatesSuccess(taxRates));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTaxRateFailure(prevTaxRates));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreTaxRate(TaxRateRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreTaxRateRequest;
    final prevTaxRates = action.taxRateIds
        .map((id) => store.state.taxRateState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.taxRateIds, EntityAction.restore)
        .then((List<TaxRateEntity> taxRates) {
      store.dispatch(RestoreTaxRatesSuccess(taxRates));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTaxRateFailure(prevTaxRates));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveTaxRate(TaxRateRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTaxRateRequest;
    repository
        .saveData(store.state.credentials, action.taxRate)
        .then((TaxRateEntity taxRate) {
      if (action.taxRate.isNew) {
        store.dispatch(AddTaxRateSuccess(taxRate));
      } else {
        store.dispatch(SaveTaxRateSuccess(taxRate));
      }
      action.completer.complete(taxRate);
      final taxRateUIState = store.state.taxRateUIState;
      if (taxRateUIState.saveCompleter != null) {
        taxRateUIState.saveCompleter.complete(taxRate);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveTaxRateFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadTaxRate(TaxRateRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTaxRate;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadTaxRateRequest());
    repository.loadItem(state.credentials, action.taxRateId).then((taxRate) {
      store.dispatch(LoadTaxRateSuccess(taxRate));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTaxRateFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadTaxRates(TaxRateRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTaxRates;
    final AppState state = store.state;

    if (!state.taxRateState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.taxRateState.lastUpdated / 1000).round();

    store.dispatch(LoadTaxRatesRequest());
    repository.loadList(state.credentials, updatedAt).then((data) {
      store.dispatch(LoadTaxRatesSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      /*
      if (state.taxRateState.isStale) {
        store.dispatch(LoadTaxRates());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTaxRatesFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
