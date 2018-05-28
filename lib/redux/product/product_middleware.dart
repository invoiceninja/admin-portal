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
  final loadProducts = _createLoadProducts(repository);
  final saveProduct = _createSaveProduct(repository);

  return [
    TypedMiddleware<AppState, LoadProductsAction>(loadProducts),
    TypedMiddleware<AppState, SaveProductRequest>(saveProduct),
  ];
}

Middleware<AppState> _createSaveProduct(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.saveData(store.state.selectedCompany(), store.state.authState, action.product).then(
        (product) {
          var message;
          if (action.product.id == 0) {
            message = 'Successfully created product';
            store.dispatch(AddProductSuccess(product));
          } else {
            message = 'Successfully updated product';
            store.dispatch(SaveProductSuccess(product));
          }

          Scaffold.of(action.context).showSnackBar(
              SnackBar(
                  content: Row(
                    children: <Widget>[
                      Icon(Icons.check_circle),
                      Text(message)
                    ],
                  ),
                  duration: Duration(seconds: 3)
              )
          );
        }
    );
    /*
        .catchError((error) {
      store.dispatch(SaveProductFailure(error));
    });
    */


    /*
    repository.login(action.email, action.password, action.url).then(
            (data) {
          _saveAuthLocal(action);

          for (int i=0; i<data.length; i++) {
            store.dispatch(SelectCompany(i+1));
            store.dispatch(LoadCompanySuccess(data[i]));
          }

          store.dispatch(SelectCompany(1));
          store.dispatch(UserLoginSuccess());

          Navigator.of(action.context).popAndPushNamed(AppRoutes.dashboard);
        }
    ).catchError((error) {
      store.dispatch(UserLoginFailure(error));
    });
    */

    next(action);

  };
}

Middleware<AppState> _createLoadProducts(ProductsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.loadList(store.state.selectedCompany(), store.state.authState).then(
            (data) => store.dispatch(ProductsLoadedAction(data))
    ).catchError((error) => store.dispatch(ProductsNotLoadedAction(error)));

    next(action);
  };
}
