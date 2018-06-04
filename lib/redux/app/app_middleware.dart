import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/repositories/persistence_repository.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
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
  final dataLoaded = _createDataLoaded(repository);

  return [
    TypedMiddleware<AppState, LoadDashboardSuccess>(dataLoaded),
  ];
}

Middleware<AppState> _createDataLoaded(PersistenceRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    if (store.state.isLoaded()) {
      repository.saveData(store.state);
    }

    next(action);
  };
}
