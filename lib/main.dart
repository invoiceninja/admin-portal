import 'package:intl/intl.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_email_vm.dart';
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
//import 'package:quick_actions/quick_actions.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/ui/payment/payment_screen.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_middleware.dart';

import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_middleware.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  final enableDarkMode = prefs.getBool(kSharedPrefEnableDarkMode) ?? false;

  final store = Store<AppState>(appReducer,
      initialState: AppState(
          enableDarkMode: enableDarkMode),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDashboardMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll(createStoreClientsMiddleware())
        ..addAll(createStoreInvoicesMiddleware())
        ..addAll(createStorePersistenceMiddleware())
        // STARTER: middleware - do not remove comment
        ..addAll(createStorePaymentsMiddleware())
        ..addAll(createStoreQuotesMiddleware())
        ..addAll([
          LoggingMiddleware<dynamic>.printer(),
        ]));

  runApp(InvoiceNinjaApp(store: store));
}

class InvoiceNinjaApp extends StatefulWidget {
  final Store<AppState> store;

  const InvoiceNinjaApp({Key key, this.store}) : super(key: key);

  @override
  InvoiceNinjaAppState createState() => InvoiceNinjaAppState();
}

class InvoiceNinjaAppState extends State<InvoiceNinjaApp> {
  @override
  void initState() {
    super.initState();

    /*
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      if (shortcutType == 'action_main') {
        print('The user tapped on the "Main view" action.');
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'action_main', localizedTitle: 'Main view 123', icon: 'AppIcon'),
    ]);
    */
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: AppBuilder(builder: (context) {
        final state = widget.store.state;
        Intl.defaultLocale = localeSelector(state);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
          ],
          home: InitScreen(),
          locale: Locale(localeSelector(state)),
          theme: state.uiState.enableDarkMode
              ? ThemeData(
                  brightness: Brightness.dark,
                  accentColor: Colors.lightBlueAccent,
                )
              : ThemeData().copyWith(
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
            LoginScreen.route: (context) {
              return LoginScreen();
            },
            DashboardScreen.route: (context) {
              if (widget.store.state.dashboardState.isStale) {
                widget.store.dispatch(LoadDashboard());
              }
              return DashboardScreen();
            },
            ProductScreen.route: (context) {
              if (widget.store.state.productState.isStale) {
                widget.store.dispatch(LoadProducts());
              }
              return ProductScreen();
            },
            ProductEditScreen.route: (context) => ProductEditScreen(),
            ClientScreen.route: (context) {
              if (widget.store.state.clientState.isStale) {
                widget.store.dispatch(LoadClients());
              }
              return ClientScreen();
            },
            ClientViewScreen.route: (context) => ClientViewScreen(),
            ClientEditScreen.route: (context) => ClientEditScreen(),
            InvoiceScreen.route: (context) {
              if (widget.store.state.invoiceState.isStale) {
                widget.store.dispatch(LoadInvoices());
              }
              return InvoiceScreen();
            },
            InvoiceViewScreen.route: (context) => InvoiceViewScreen(),
            InvoiceEditScreen.route: (context) => InvoiceEditScreen(),
            InvoiceEmailScreen.route: (context) => InvoiceEmailScreen(),
            // STARTER: routes - do not remove comment
            PaymentScreen.route: (context) {
              if (widget.store.state.paymentState.isStale) {
                widget.store.dispatch(LoadPayments());
              }
              return PaymentScreen();
            },
            PaymentViewScreen.route: (context) => PaymentViewScreen(),
            PaymentEditScreen.route: (context) => PaymentEditScreen(),
            QuoteScreen.route: (context) {
              if (widget.store.state.quoteState.isStale) {
                widget.store.dispatch(LoadQuotes());
              }
              return QuoteScreen();
            },
            QuoteViewScreen.route: (context) => QuoteViewScreen(),
            QuoteEditScreen.route: (context) => QuoteEditScreen(),
            QuoteEmailScreen.route: (context) => QuoteEmailScreen(),
            SettingsScreen.route: (context) => SettingsScreen(),
          },
        );
      }),
    );
  }
}
