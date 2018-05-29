import 'package:invoiceninja/utils/localization.dart';
import 'package:flutter/material.dart';
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

    repository.saveData(store.state.selectedCompany(), store.state.authState, action.product, 'archive').then(
            (product) {

              store.dispatch(ArchiveProductSuccess());
          Scaffold.of(action.context).showSnackBar(
              SnackBar(
                  content: Row(
                    children: <Widget>[
                      Icon(Icons.check_circle),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(AppLocalization.of(action.context).successfullyArchivedProduct),
                      )
                    ],
                  ),
                  duration: Duration(seconds: 3)
              )
          );
        }
    ).catchError((error) {
      print(error);
      store.dispatch(ArchiveProductFailure());
    });

    next(action);
  };
}

Middleware<AppState> _deleteProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    next(action);
  };
}

Middleware<AppState> _restoreProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    next(action);
  };
}


Middleware<AppState> _saveProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.saveData(store.state.selectedCompany(), store.state.authState, action.product).then(
        (product) {
          var message;
          if (action.product.id == null) {
            message = AppLocalization.of(action.context).successfullyCreatedProduct;
            store.dispatch(AddProductSuccess(product));
          } else {
            message = AppLocalization.of(action.context).successfullyUpdatedProduct;
            store.dispatch(SaveProductSuccess(product));
          }

          Scaffold.of(action.context).showSnackBar(
              SnackBar(
                  content: Row(
                    children: <Widget>[
                      Icon(Icons.check_circle),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(message),
                      )
                    ],
                  ),
                  duration: Duration(seconds: 3)
              )
          );
        }
    ).catchError((error) {
      print(error);
      store.dispatch(SaveProductFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _loadProducts(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.loadList(store.state.selectedCompany(), store.state.authState).then(
            (data) => store.dispatch(ProductsLoadedAction(data))
    ).catchError((error) => store.dispatch(ProductsNotLoadedAction(error)));

    next(action);
  };
}
