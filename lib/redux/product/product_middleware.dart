import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/data/repositories/product_repository.dart';
import 'package:invoiceninja/data/file_storage.dart';

List<Middleware<AppState>> createStoreProductsMiddleware([
  ProductsRepository repository = const ProductsRepository(
    fileStorage: const FileStorage(
      '__invoiceninja__',
      getApplicationDocumentsDirectory,
    ),
  ),
]) {
  final loadProducts = _createLoadProducts(repository);
  final saveProducts = _createSaveProducts(repository);

  return [
    TypedMiddleware<AppState, LoadProductsAction>(loadProducts),
    //TypedMiddleware<AppState, ProductsLoadedAction>(saveProducts),
  ];
}

Middleware<AppState> _createSaveProducts(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    /*
    repository.saveProducts(
      productsSelector(store.state).map((product) => product.toEntity()).toList(),
    );
    */
  };
}

Middleware<AppState> _createLoadProducts(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.loadList(store.state.selectedCompany(), store.state.auth).then(
            (data) => store.dispatch(ProductsLoadedAction(data))
    ).catchError((error) => store.dispatch(ProductsNotLoadedAction(error)));

    next(action);
  };
}
