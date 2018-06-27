import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/app/app_middleware.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/client/client_middleware.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/ui/auth/init_screen.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja/ui/product/edit/product_edit_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/auth/login_vm.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/ui/settings/settings_screen.dart';
import 'package:invoiceninja/redux/app/app_reducer.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_middleware.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_middleware.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/product/product_middleware.dart';
import 'package:invoiceninja/redux/invoice/invoice_middleware.dart';
import 'package:invoiceninja/utils/theme.dart';
import 'package:invoiceninja/ui/invoice/invoice_screen.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

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
          LoggingMiddleware.printer(),
        ]));

  runApp(InvoiceNinjaApp(store: store));
}

class InvoiceNinjaApp extends StatefulWidget {
  final Store<AppState> store;

  InvoiceNinjaApp({Key key, this.store}) : super(key: key);

  @override
  _InvoiceNinjaAppState createState() => _InvoiceNinjaAppState();
}

class _InvoiceNinjaAppState extends State<InvoiceNinjaApp> {

  Future<bool> _isDark;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _isDark = _prefs.then((SharedPreferences prefs) {
      return(prefs.getBool('isDark') ?? false);
    });
  }

  void onThemeChange (bool isDark) async {
    final SharedPreferences prefs = await _prefs;
    if(isDark) {
      setState(() {
        _isDark = prefs.setBool('isDark', true).then((bool success) {
          return true;
        });
      });
    }
    else {
      setState(() {
        _isDark = prefs.setBool('isDark', false).then((bool success) {
          return false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: new FutureBuilder<bool>(
        future: _isDark,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if(snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    const AppLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                  ],

                  theme: AppTheme.setTheme(snapshot.data ? 'dark' : 'light'),

                  title: 'Invoice Ninja',
                  routes: {
                    InitScreen.route: (context) {
                      widget.store.dispatch(LoadStateRequest(context));
                      //widget.store.dispatch(LoadUserLogin());
                      return InitScreen();
                    },
                    LoginScreen.route: (context) {
                      return LoginScreen();
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
                    ClientViewScreen.route: (context) => ClientViewScreen(),
                    ClientEditScreen.route: (context) => ClientEditScreen(),
                    InvoiceScreen.route: (context) {
                      widget.store.dispatch(LoadInvoices());
                      return InvoiceScreen();
                    },
                    InvoiceViewScreen.route: (context) => InvoiceViewScreen(),
                    InvoiceEditScreen.route: (context) => InvoiceEditScreen(),
                    SettingsScreen.route: (context) => SettingsScreen(onThemeChange, snapshot.data),
                  },
                );
          }
        },
      ), 
    );
  }
}
