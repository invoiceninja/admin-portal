import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:sentry/sentry.dart';
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
import 'package:local_auth/local_auth.dart';

//import 'package:quick_actions/quick_actions.dart';
// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_middleware.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_middleware.dart';
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
  final SentryClient _sentry = SentryClient(
      dsn: Config.SENTRY_DNS,
      environmentAttributes: Event(
        release: kAppVersion,
        environment: Config.PLATFORM,
      ));
  final prefs = await SharedPreferences.getInstance();
  final enableDarkMode = prefs.getBool(kSharedPrefEnableDarkMode) ?? false;
  final requireAuthentication =
      prefs.getBool(kSharedPrefRequireAuthentication) ?? false;

  final store = Store<AppState>(appReducer,
      initialState: AppState(
          enableDarkMode: enableDarkMode,
          requireAuthentication: requireAuthentication),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDashboardMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll(createStoreClientsMiddleware())
        ..addAll(createStoreInvoicesMiddleware())
        ..addAll(createStorePersistenceMiddleware())
        // STARTER: middleware - do not remove comment
        ..addAll(createStoreTasksMiddleware())
        ..addAll(createStoreProjectsMiddleware())
        ..addAll(createStorePaymentsMiddleware())
        ..addAll(createStoreQuotesMiddleware())
        ..addAll([
          LoggingMiddleware<dynamic>.printer(),
        ]));

  Future<void> _reportError(dynamic error, dynamic stackTrace) async {
    print('Caught error: $error');
    if (isInDebugMode) {
      print(stackTrace);
      return;
    } else {
      _sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  runZoned<Future<void>>(() async {
    runApp(InvoiceNinjaApp(store: store));
  }, onError: (dynamic error, dynamic stackTrace) {
    _reportError(error, stackTrace);
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

class InvoiceNinjaApp extends StatefulWidget {
  const InvoiceNinjaApp({Key key, this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  InvoiceNinjaAppState createState() => InvoiceNinjaAppState();
}

class InvoiceNinjaAppState extends State<InvoiceNinjaApp> {
  bool _authenticated = false;

  Future<Null> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await LocalAuthentication().authenticateWithBiometrics(
          localizedReason: 'Please authenticate to access the app',
          useErrorDialogs: true,
          stickyAuth: false);
    } catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        _authenticated = authenticated;
      });
    }
  }

  /*
  @override
  void initState() {
    super.initState();

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      if (shortcutType == 'action_new_client') {
        widget.store
            .dispatch(EditClient(context: context, client: ClientEntity()));
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'action_new_client',
          localizedTitle: 'New Client',
          icon: 'AppIcon'),
    ]);
  }
  */

  @override
  void didChangeDependencies() {
    final state = widget.store.state;
    if (state.uiState.requireAuthentication && !_authenticated) {
      _authenticate();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: AppBuilder(builder: (context) {
        final state = widget.store.state;
        Intl.defaultLocale = localeSelector(state);
        final localization = AppLocalization(Locale(Intl.defaultLocale));

        return MaterialApp(
          supportedLocales: kLanguages
              .map((String locale) => AppLocalization.createLocale(locale))
              .toList(),
          //debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
          ],
          home: state.uiState.requireAuthentication && !_authenticated
              ? Material(
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.lock,
                            size: 24.0,
                            color: Colors.grey[400],
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            localization.locked,
                            style: TextStyle(
                              fontSize: 32.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        onPressed: () => _authenticate(),
                        child: Text(localization.authenticate),
                      )
                    ],
                  ),
                )
              : InitScreen(),
          locale: AppLocalization.createLocale(localeSelector(state)),
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
            TaskScreen.route: (context) {
              widget.store.dispatch(LoadTasks());
              return TaskScreen();
            },
            TaskViewScreen.route: (context) => TaskViewScreen(),
            TaskEditScreen.route: (context) => TaskEditScreen(),
            ProjectScreen.route: (context) {
              widget.store.dispatch(LoadProjects());
              return ProjectScreen();
            },
            ProjectViewScreen.route: (context) => ProjectViewScreen(),
            ProjectEditScreen.route: (context) => ProjectEditScreen(),

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
