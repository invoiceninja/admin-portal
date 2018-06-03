import 'package:invoiceninja/data/models/models.dart';
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
  final loadProducts = _loadProducts(repository);
  final saveProduct = _saveProduct(repository);
  final archiveProduct = _archiveProduct(repository);
  final deleteProduct = _deleteProduct(repository);
  final restoreProduct = _restoreProduct(repository);

  return [
    TypedMiddleware<AppState, LoadProductsAction>(loadProducts),
    TypedMiddleware<AppState, SaveProductRequest>(saveProduct),
    TypedMiddleware<AppState, ArchiveProductRequest>(archiveProduct),
    TypedMiddleware<AppState, DeleteProductRequest>(deleteProduct),
    TypedMiddleware<AppState, RestoreProductRequest>(restoreProduct),
  ];
}

Middleware<AppState> _archiveProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origProduct = store.state.productState().map[action.productId];
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
        origProduct, EntityAction.archive)
        .then((product) {
      store.dispatch(ArchiveProductSuccess(product));
    }).catchError((error) {
      print(error);
      store.dispatch(ArchiveProductFailure(origProduct));
    });

    next(action);
  };
}

Middleware<AppState> _deleteProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origProduct = store.state.productState().map[action.productId];
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
        origProduct, EntityAction.delete)
        .then((product) {
      store.dispatch(DeleteProductSuccess(product));
    }).catchError((error) {
      print(error);
      store.dispatch(DeleteProductFailure(origProduct));
    });

    next(action);
  };
}

Middleware<AppState> _restoreProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origProduct = store.state.productState().map[action.productId];
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
        origProduct, EntityAction.restore)
        .then((product) {
      store.dispatch(RestoreProductSuccess(product));
    }).catchError((error) {
      print(error);
      store.dispatch(RestoreProductFailure(origProduct));
    });

    next(action);
  };
}

Middleware<AppState> _saveProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
            action.product)
        .then((product) {
      if (action.product.id == null) {
        store.dispatch(AddProductSuccess(product));
      } else {
        store.dispatch(SaveProductSuccess(product));
      }
      action.completer.complete(null);
    }).catchError((error) {
      print(error);
      store.dispatch(SaveProductFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _loadProducts(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    if (action.force || store.state.productState().isStale()) {
      store.dispatch(LoadProductsRequest());
      repository
          .loadList(store.state.selectedCompany(), store.state.authState)
          .then((data) {
        store.dispatch(ProductsLoadedAction(data));
        if (action.completer != null) {
          action.completer.complete(null);
        }
      }).catchError((error) => store.dispatch(ProductsNotLoadedAction(error)));
    }

    next(action);
  };
}

