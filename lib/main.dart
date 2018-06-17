import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/app/app_middleware.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/client/client_middleware.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/ui/product/edit/product_edit_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/auth/login_vm.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/redux/app/app_reducer.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_middleware.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_middleware.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/product/product_middleware.dart';
import 'package:invoiceninja/redux/invoice/invoice_middleware.dart';
import 'package:invoiceninja/ui/invoice/invoice_screen.dart';
//import 'package:redux_logging/redux_logging.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState(),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDashboardMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll(createStoreClientsMiddleware())
        ..addAll(createStoreInvoicesMiddleware())
        ..addAll(createStorePersistenceMiddleware())
        ..addAll([
          //LoggingMiddleware.printer(),
        ]));

  runApp(new InvoiceNinjaApp(store: store));
}

class InvoiceNinjaApp extends StatefulWidget {
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
        // light theme
        theme: ThemeData().copyWith(
          accentColor: Colors.lightBlueAccent,
          primaryColor: const Color(0xFF117cc1),
          primaryColorLight: const Color(0xFF5dabf4),
          primaryColorDark: const Color(0xFF0D5D91),
          indicatorColor: const Color(0xFFFFFFFF),
          iconTheme: IconThemeData().copyWith(),
          bottomAppBarColor: const Color(0xFF117cc1),
          backgroundColor: Colors.grey[200],
        ),
        
        //dark theme
        /*
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.lightBlueAccent,
        ),
        */

        title: 'Invoice Ninja',
        routes: {
          LoginVM.route: (context) {
            widget.store.dispatch(LoadStateRequest(context));
            return LoginVM();
          },
          DashboardScreen.route: (context) {
            widget.store.dispatch(LoadDashboardAction());
            return DashboardScreen();
          },
          ProductScreen.route: (context) {
            widget.store.dispatch(LoadProducts());
            return ProductScreen();
          },
          ProductEditScreen.route: (context) => ProductEditScreen(),
          ClientScreen.route: (context) {
            widget.store.dispatch(LoadClients());
            return ClientScreen();
          },
          InvoiceScreen.route: (context) {
            widget.store.dispatch(LoadInvoices());
            return InvoiceScreen();
          },
        },
      ),
    );
  }
}
