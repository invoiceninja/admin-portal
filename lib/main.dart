import 'package:redux/redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_middleware.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen.dart';
import 'package:invoiceninja_flutter/ui/auth/init_screen.dart';
import 'package:invoiceninja_flutter/ui/client/client_screen.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja_flutter/ui/product/product_screen.dart';
import 'package:invoiceninja_flutter/redux/app/app_reducer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_middleware.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_middleware.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_middleware.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_middleware.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  final enableDarkMode = prefs.getBool(kSharedPrefEnableDarkMode);

  final store = Store<AppState>(appReducer,
      initialState: AppState(enableDarkMode: enableDarkMode),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDashboardMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll(createStoreClientsMiddleware())
        ..addAll(createStoreInvoicesMiddleware())
        ..addAll(createStorePersistenceMiddleware())
        ..addAll([
          LoggingMiddleware<dynamic>.printer(),
        ]));

  runApp(InvoiceNinjaApp(store: store));
}

class InvoiceNinjaApp extends StatefulWidget {
  final Store<AppState> store;
  const InvoiceNinjaApp({Key key, this.store})
      : super(key: key);

  @override
  InvoiceNinjaAppState createState() => InvoiceNinjaAppState();
}

class InvoiceNinjaAppState extends State<InvoiceNinjaApp> {

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        //debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
        ],

        // light theme
        theme: widget.store.state.uiState.enableDarkMode
            ? ThemeData(
                brightness: Brightness.dark,
                accentColor: Colors.lightBlueAccent,
              )
            : ThemeData().copyWith(
                //accentColor: Colors.lightBlueAccent,
                primaryColor: const Color(0xFF117cc1),
                primaryColorLight: const Color(0xFF5dabf4),
                primaryColorDark: const Color(0xFF0D5D91),
                indicatorColor: Colors.white,
                bottomAppBarColor: Colors.grey.shade300,
                backgroundColor: Colors.grey.shade200,
                buttonColor: const Color(0xFF0D5D91),
              ),

        title: 'Invoice Ninja',
        routes: {
          InitScreen.route: (context) => InitScreen(),
          LoginScreen.route: (context) {
            return LoginScreen();
          },
          DashboardScreen.route: (context) {
            widget.store.dispatch(LoadDashboard());
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
          SettingsScreen.route: (context) => SettingsScreen(),
        },
      ),
    );
  }
}
