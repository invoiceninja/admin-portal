// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/design_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/design/design_screen.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';

List<Middleware<AppState>> createStoreDesignsMiddleware([
  DesignRepository repository = const DesignRepository(),
]) {
  final viewDesignList = _viewDesignList();
  final viewDesign = _viewDesign();
  final editDesign = _editDesign();
  final loadDesigns = _loadDesigns(repository);
  final loadDesign = _loadDesign(repository);
  final saveDesign = _saveDesign(repository);
  final archiveDesign = _archiveDesign(repository);
  final deleteDesign = _deleteDesign(repository);
  final restoreDesign = _restoreDesign(repository);

  return [
    TypedMiddleware<AppState, ViewDesignList>(viewDesignList),
    TypedMiddleware<AppState, ViewDesign>(viewDesign),
    TypedMiddleware<AppState, EditDesign>(editDesign),
    TypedMiddleware<AppState, LoadDesigns>(loadDesigns),
    TypedMiddleware<AppState, LoadDesign>(loadDesign),
    TypedMiddleware<AppState, SaveDesignRequest>(saveDesign),
    TypedMiddleware<AppState, ArchiveDesignsRequest>(archiveDesign),
    TypedMiddleware<AppState, DeleteDesignsRequest>(deleteDesign),
    TypedMiddleware<AppState, RestoreDesignsRequest>(restoreDesign),
  ];
}

Middleware<AppState> _editDesign() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditDesign?;

    next(action);

    store.dispatch(UpdateCurrentRoute(DesignEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(DesignEditScreen.route);
    }
  };
}

Middleware<AppState> _viewDesign() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewDesign?;

    next(action);

    store.dispatch(UpdateCurrentRoute(DesignViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(DesignViewScreen.route);
    }
  };
}

Middleware<AppState> _viewDesignList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewDesignList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(DesignScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          DesignScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveDesign(DesignRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveDesignsRequest;
    final prevDesigns =
        action.designIds.map((id) => store.state.designState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.designIds, EntityAction.archive)
        .then((List<DesignEntity> designs) {
      store.dispatch(ArchiveDesignsSuccess(designs));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveDesignsFailure(prevDesigns));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteDesign(DesignRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteDesignsRequest;
    final prevDesigns =
        action.designIds.map((id) => store.state.designState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.designIds, EntityAction.delete)
        .then((List<DesignEntity> designs) {
      store.dispatch(DeleteDesignsSuccess(designs));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteDesignsFailure(prevDesigns));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreDesign(DesignRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreDesignsRequest;
    final prevDesigns =
        action.designIds.map((id) => store.state.designState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.designIds, EntityAction.restore)
        .then((List<DesignEntity> designs) {
      store.dispatch(RestoreDesignsSuccess(designs));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreDesignsFailure(prevDesigns));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveDesign(DesignRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveDesignRequest;
    repository
        .saveData(store.state.credentials, action.design!)
        .then((DesignEntity design) {
      if (action.design!.isNew) {
        store.dispatch(AddDesignSuccess(design));
      } else {
        store.dispatch(SaveDesignSuccess(design));
      }

      action.completer!.complete(design);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveDesignFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadDesign(DesignRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadDesign;
    final AppState state = store.state;

    store.dispatch(LoadDesignRequest());
    repository.loadItem(state.credentials, action.designId).then((design) {
      store.dispatch(LoadDesignSuccess(design));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadDesignFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadDesigns(DesignRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadDesigns?;
    final AppState state = store.state;

    store.dispatch(LoadDesignsRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadDesignsSuccess(data));

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
      store.dispatch(LoadDesignsFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
