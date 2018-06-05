import 'package:flutter/widgets.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/repositories/persistence_repository.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/routes.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';

List<Middleware<AppState>> createStorePersistenceMiddleware([
  PersistenceRepository repository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'state',
      getApplicationDocumentsDirectory,
    ),
  ),
]) {
  final loadState = _createLoadState(repository);
  final dataLoaded = _createDataLoaded(repository);
  final deleteState = _createDeleteState(repository);

  return [
    TypedMiddleware<AppState, UserLogout>(deleteState),
    TypedMiddleware<AppState, LoadStateRequest>(loadState),
    TypedMiddleware<AppState, LoadDashboardSuccess>(dataLoaded),

    TypedMiddleware<AppState, LoadProductsSuccess>(dataLoaded),
    TypedMiddleware<AppState, AddProductSuccess>(dataLoaded),
    TypedMiddleware<AppState, SaveProductSuccess>(dataLoaded),
    TypedMiddleware<AppState, ArchiveProductSuccess>(dataLoaded),
    TypedMiddleware<AppState, DeleteProductSuccess>(dataLoaded),
    TypedMiddleware<AppState, RestoreProductSuccess>(dataLoaded),
  ];
}

Middleware<AppState> _createLoadState(PersistenceRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.loadData().then((state) {
      store.dispatch(LoadStateSuccess(state));
      Navigator.of(action.context).pushReplacementNamed(AppRoutes.dashboard);
    }).catchError((error) {
      print(error);
      store.dispatch(LoadUserLogin());
    });

    next(action);
  };
}

Middleware<AppState> _createDataLoaded(PersistenceRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    // first process the action so the data is in the state
    next(action);

    if (store.state.isLoaded()) {
      repository.saveData(store.state);
    }
  };
}

Middleware<AppState> _createDeleteState(PersistenceRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.delete();

    next(action);
  };
}
