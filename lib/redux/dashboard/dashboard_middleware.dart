import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/data/repositories/repositories.dart';
import 'package:invoiceninja/data/repositories/dashboard_repository.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/redux/product/product_selectors.dart';
import 'package:invoiceninja/data/models/entities.dart';

List<Middleware<AppState>> createStoreDashboardMiddleware([
  BaseRepository repository = const DashboardRepositoryFlutter(
    fileStorage: const FileStorage(
      '__invoiceninja__',
      getApplicationDocumentsDirectory,
    ),
  ),
]) {
  final loadDashboard = _createLoadDashboard(repository);

  return [
    TypedMiddleware<AppState, LoadDashboardAction>(loadDashboard),
  ];
}

Middleware<AppState> _createSaveDashboard(BaseRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    /*
    repository.saveDashboard(
      productsSelector(store.state).map((product) => product.toEntity()).toList(),
    );
    */
  };
}

Middleware<AppState> _createLoadDashboard(BaseRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.loadItems(store.state.auth).then(
          (data) {
        store.dispatch(
          DashboardLoadedAction(
            //products.map(ProductEntity.fromEntity).toList(),
            data,
          ),
        );
      },
    ).catchError((error) => store.dispatch(DashboardNotLoadedAction(error)));

    next(action);
  };
}
