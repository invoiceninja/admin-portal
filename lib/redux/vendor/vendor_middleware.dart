import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_screen.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/vendor_repository.dart';

List<Middleware<AppState>> createStoreVendorsMiddleware([
  VendorRepository repository = const VendorRepository(),
]) {
  final viewVendorList = _viewVendorList();
  final viewVendor = _viewVendor();
  final editVendor = _editVendor();
  final loadVendors = _loadVendors(repository);
  final loadVendor = _loadVendor(repository);
  final saveVendor = _saveVendor(repository);
  final archiveVendor = _archiveVendor(repository);
  final deleteVendor = _deleteVendor(repository);
  final restoreVendor = _restoreVendor(repository);

  return [
    TypedMiddleware<AppState, ViewVendorList>(viewVendorList),
    TypedMiddleware<AppState, ViewVendor>(viewVendor),
    TypedMiddleware<AppState, EditVendor>(editVendor),
    TypedMiddleware<AppState, LoadVendors>(loadVendors),
    TypedMiddleware<AppState, LoadVendor>(loadVendor),
    TypedMiddleware<AppState, SaveVendorRequest>(saveVendor),
    TypedMiddleware<AppState, ArchiveVendorRequest>(archiveVendor),
    TypedMiddleware<AppState, DeleteVendorRequest>(deleteVendor),
    TypedMiddleware<AppState, RestoreVendorRequest>(restoreVendor),
  ];
}

Middleware<AppState> _editVendor() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as EditVendor;

    if (hasChanges(
        store: store, context: action.context, force: action.force)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(VendorEditScreen.route));

    if (isMobile(action.context)) {
      final vendor =
          await Navigator.of(action.context).pushNamed(VendorEditScreen.route);

      if (action.completer != null && vendor != null) {
        action.completer.complete(vendor);
      }
    }
  };
}

Middleware<AppState> _viewVendor() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewVendor;

    if (hasChanges(
        store: store, context: action.context, force: action.force)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(VendorViewScreen.route));

    if (isMobile(action.context)) {
      Navigator.of(action.context).pushNamed(VendorViewScreen.route);
    }
  };
}

Middleware<AppState> _viewVendorList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewVendorList;

    if (hasChanges(
        store: store, context: action.context, force: action.force)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(VendorScreen.route));

    if (isMobile(action.context)) {
      Navigator.of(action.context).pushNamedAndRemoveUntil(
          VendorScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveVendorRequest;
    final origVendor = store.state.vendorState.map[action.vendorId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origVendor, EntityAction.archive)
        .then((VendorEntity vendor) {
      store.dispatch(ArchiveVendorSuccess(vendor));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveVendorFailure(origVendor));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteVendorRequest;
    final origVendor = store.state.vendorState.map[action.vendorId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origVendor, EntityAction.delete)
        .then((VendorEntity vendor) {
      store.dispatch(DeleteVendorSuccess(vendor));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteVendorFailure(origVendor));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreVendorRequest;
    final origVendor = store.state.vendorState.map[action.vendorId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origVendor, EntityAction.restore)
        .then((VendorEntity vendor) {
      store.dispatch(RestoreVendorSuccess(vendor));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreVendorFailure(origVendor));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveVendorRequest;
    repository
        .saveData(
            store.state.selectedCompany, store.state.authState, action.vendor)
        .then((VendorEntity vendor) {
      if (action.vendor.isNew) {
        store.dispatch(AddVendorSuccess(vendor));
      } else {
        store.dispatch(SaveVendorSuccess(vendor));
      }

      action.completer.complete(vendor);

      final vendorUIState = store.state.vendorUIState;
      if (vendorUIState.saveCompleter != null) {
        vendorUIState.saveCompleter.complete(vendor);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveVendorFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadVendor;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadVendorRequest());
    repository
        .loadItem(state.selectedCompany, state.authState, action.vendorId)
        .then((vendor) {
      store.dispatch(LoadVendorSuccess(vendor));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadVendorFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }

      // Support selfhost users with older versions
      // TODO remove this in v2
      if (state.dashboardState.isStale) {
        store.dispatch(LoadDashboard());
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadVendors(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadVendors;
    final AppState state = store.state;

    if (!state.vendorState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.vendorState.lastUpdated / 1000).round();

    store.dispatch(LoadVendorsRequest());
    repository
        .loadList(state.selectedCompany, state.authState, updatedAt)
        .then((data) {
      store.dispatch(LoadVendorsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.expenseState.isStale) {
        store.dispatch(LoadExpenses());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadVendorsFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
