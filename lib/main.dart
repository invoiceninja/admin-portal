import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:invoiceninja/routes.dart';
import 'package:invoiceninja/ui/auth/login_vm.dart';
import 'package:invoiceninja/ui/dashboard/dashboard.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/redux/app/app_reducer.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_middleware.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_middleware.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/product/product_middleware.dart';
import 'package:invoiceninja/utils/localization.dart';


void main() {
  final store = Store<AppState>(
      appReducer,
      initialState: AppState(),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDashboardMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll([
          LoggingMiddleware.printer(),
        ])
  );

  runApp(new InvoiceNinjaApp(store: store));
}

class InvoiceNinjaApp extends StatefulWidget  {

  final Store<AppState> store;

  InvoiceNinjaApp({Key key, this.store}) : super(key: key);

  @override
  _InvoiceNinjaAppState createState() => new _InvoiceNinjaAppState();
}

class _InvoiceNinjaAppState extends State<InvoiceNinjaApp> {
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: widget.store,
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
          ],
        theme: ThemeData().copyWith(
          primaryColor: const Color(0xFF117cc1),
          primaryColorDark: const Color(0xFF005090),
          primaryColorLight: const Color(0xFF5dabf4),
        ),
        /*
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.lightBlueAccent,
        ),
        */
        title: 'Invoice Ninja',
        routes: {
          AppRoutes.login: (context) {
            return StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(LoadUserLogin()),
              builder: (context, store) {
                return LoginVM();
              },
            );
          },
          AppRoutes.dashboard: (context) {
            return StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(LoadDashboardAction()),
              builder: (context, store) {
                return Dashboard();
              },
            );
          },
          /*
          AppRoutes.clients: (context) {
            return StoreBuilder<AppState>(
              builder: (context, store) {
                return ClientList();
              },
            );
          },
          */
          AppRoutes.products: (context) {
            return StoreBuilder<AppState>(
              onInit: (store) => store.state.productState().isStale() ? store.dispatch(LoadProductsAction()) : null,
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
