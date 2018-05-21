import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/dashboard_screen.dart';
import 'package:invoiceninja/ui/client/client_list.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/ui/auth/login_screen.dart';
import 'package:invoiceninja/routes.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/product/product_middleware.dart';
import 'package:invoiceninja/redux/auth/auth_middleware.dart';
import 'package:invoiceninja/redux/app/app_reducer.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {

  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final store = new Store<AppState>(null);

  runApp(new InvoiceNinjaApp());
}

class InvoiceNinjaApp extends StatelessWidget {

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll([
          LoggingMiddleware.printer(),
        ])
  );

  @override
  Widget build(BuildContext context) {
    // The StoreProvider should wrap your MaterialApp or WidgetsApp. This will
    // ensure all routes have access to the store.
    return new StoreProvider<AppState>(
      // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
      // Widgets will find and use this value as the `Store`.
      store: store,
      child: new MaterialApp(
        theme: new ThemeData.dark(),
        title: 'Invoice Ninja',
        routes: {
          NinjaRoutes.login: (context) {
            return StoreBuilder<AppState>(
              builder: (context, store) {
                return LoginScreen();
              },
            );
          },
          NinjaRoutes.dashboard: (context) {
            return StoreBuilder<AppState>(
              builder: (context, store) {
                return Dashboard();
              },
            );
          },
          NinjaRoutes.clientList: (context) {
            return StoreBuilder<AppState>(
              builder: (context, store) {
                return ClientList();
              },
            );
          },
          NinjaRoutes.productList: (context) {
            return StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(LoadProductsAction()),
              builder: (context, store) {
                return ProductScreen();
              },
            );
          },
        },
      ),
    );
  }
}
