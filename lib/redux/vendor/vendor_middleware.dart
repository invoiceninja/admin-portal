// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/vendor_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_screen.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';

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
  final saveDocument = _saveDocument(repository);

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
    TypedMiddleware<AppState, SaveVendorDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _editVendor() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditVendor?;

    next(action);

    store.dispatch(UpdateCurrentRoute(VendorEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(VendorEditScreen.route);
    }
  };
}

Middleware<AppState> _viewVendor() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewVendor?;

    next(action);

    store.dispatch(UpdateCurrentRoute(VendorViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(VendorViewScreen.route);
    }
  };
}

Middleware<AppState> _viewVendorList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewVendorList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(VendorScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          VendorScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveVendorRequest;
    final prevVendors =
        action.vendorIds.map((id) => store.state.vendorState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.vendorIds, EntityAction.archive)
        .then((List<VendorEntity> vendors) {
      store.dispatch(ArchiveVendorSuccess(vendors));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveVendorFailure(prevVendors));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteVendorRequest;
    final prevVendors =
        action.vendorIds.map((id) => store.state.vendorState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.vendorIds, EntityAction.delete)
        .then((List<VendorEntity> vendors) {
      store.dispatch(DeleteVendorSuccess(vendors));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteVendorFailure(prevVendors));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreVendorRequest;
    final prevVendors =
        action.vendorIds.map((id) => store.state.vendorState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.vendorIds, EntityAction.restore)
        .then((List<VendorEntity> vendors) {
      store.dispatch(RestoreVendorSuccess(vendors));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreVendorFailure(prevVendors));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveVendorRequest;
    repository
        .saveData(store.state.credentials, action.vendor!)
        .then((VendorEntity vendor) {
      if (action.vendor!.isNew) {
        store.dispatch(AddVendorSuccess(vendor));
      } else {
        store.dispatch(SaveVendorSuccess(vendor));
      }

      action.completer!.complete(vendor);

      final vendorUIState = store.state.vendorUIState;
      if (vendorUIState.saveCompleter != null) {
        vendorUIState.saveCompleter!.complete(vendor);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveVendorFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadVendor(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadVendor;

    store.dispatch(LoadVendorRequest());
    repository
        .loadItem(store.state.credentials, action.vendorId)
        .then((vendor) {
      store.dispatch(LoadVendorSuccess(vendor));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadVendorFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadVendors(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadVendors;

    store.dispatch(LoadVendorsRequest());
    repository.loadList(store.state.credentials, action.page).then((data) {
      store.dispatch(LoadVendorsSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((vendor) {
        vendor.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = vendor.id
            ..parentType = EntityType.vendor));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadVendors(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(LoadPurchaseOrders());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadVendorsFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(VendorRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveVendorDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocument(
        store.state.credentials,
        action!.vendor,
        action.multipartFiles,
        action.isPrivate,
      )
          .then((vendor) {
        store.dispatch(SaveVendorSuccess(vendor));

        final documents = <DocumentEntity>[];
        vendor.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = vendor.id
            ..parentType = EntityType.vendor));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveVendorDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveVendorDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
