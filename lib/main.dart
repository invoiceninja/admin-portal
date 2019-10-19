import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/app/app_reducer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_middleware.dart';
import 'package:invoiceninja_flutter/redux/client/client_middleware.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_middleware.dart';
import 'package:invoiceninja_flutter/redux/document/document_middleware.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_middleware.dart';
import 'package:invoiceninja_flutter/redux/group/group_middleware.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_middleware.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_middleware.dart';
import 'package:invoiceninja_flutter/redux/product/product_middleware.dart';
import 'package:invoiceninja_flutter/redux/project/project_middleware.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_middleware.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_middleware.dart';
import 'package:invoiceninja_flutter/redux/task/task_middleware.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_middleware.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/main_screen.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/auth/init_screen.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja_flutter/ui/document/document_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/group/edit/group_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/group/group_screen.dart';
import 'package:invoiceninja_flutter/ui/group/group_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/ui/product/product_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/buy_now_buttons_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/client_portal_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/credit_cards_and_banks_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/data_visualizations_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_list_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/import_export_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_design_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/localization_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/notifications_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/online_payments_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/products_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_rates_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/user_details_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:local_auth/local_auth.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_screen.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/edit/tax_rate_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/view/tax_rate_view_vm.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_middleware.dart';

import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_screen.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_middleware.dart';

void main({bool isTesting = false}) async {
  final SentryClient _sentry = Config.SENTRY_DNS.isEmpty
      ? null
      : SentryClient(
          dsn: Config.SENTRY_DNS,
          environmentAttributes: Event(
            release: kAppVersion,
            environment: Config.PLATFORM,
          ));

  final prefs = await SharedPreferences.getInstance();
  final enableDarkMode = prefs.getBool(kSharedPrefEnableDarkMode) ?? true;
  final longPressSelectionIsDefault =
      prefs.getBool(kSharedPrefLongPressSelectionIsDefault) ?? true;
  final requireAuthentication =
      prefs.getBool(kSharedPrefRequireAuthentication) ?? false;

  final store = Store<AppState>(appReducer,
      initialState: AppState(
        enableDarkMode: enableDarkMode || isTesting,
        longPressSelectionIsDefault: longPressSelectionIsDefault,
        requireAuthentication: requireAuthentication,
        layout: AppLayout.tablet,
        isTesting: isTesting,
      ),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDocumentsMiddleware())
        ..addAll(createStoreDashboardMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll(createStoreClientsMiddleware())
        ..addAll(createStoreInvoicesMiddleware())
        ..addAll(createStorePersistenceMiddleware())
        ..addAll(createStoreExpensesMiddleware())
        ..addAll(createStoreVendorsMiddleware())
        ..addAll(createStoreTasksMiddleware())
        ..addAll(createStoreProjectsMiddleware())
        ..addAll(createStorePaymentsMiddleware())
        ..addAll(createStoreQuotesMiddleware())
        ..addAll(createStoreSettingsMiddleware())
        // STARTER: middleware - do not remove comment
        ..addAll(createStoreTaxRatesMiddleware())
        ..addAll(createStoreCompanyGatewaysMiddleware())
        ..addAll(createStoreGroupsMiddleware())
        ..addAll(isTesting
            ? []
            : [
                LoggingMiddleware<dynamic>.printer(
                  formatter: LoggingMiddleware.multiLineFormatter,
                ),
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

  if (_sentry == null) {
    runApp(InvoiceNinjaApp(store: store));
  } else {
    runZoned<Future<void>>(() async {
      runApp(InvoiceNinjaApp(store: store));
    }, onError: (dynamic error, dynamic stackTrace) {
      if (store.state.reportErrors) {
        _reportError(error, stackTrace);
      }
    });
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode || !store.state.reportErrors) {
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
          //showPerformanceOverlay: true,
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
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
            LoginScreen.route: (context) => LoginScreen(),
            MainScreen.route: (context) => MainScreen(),
            DashboardScreen.route: (context) => DashboardScreen(),
            ProductScreen.route: (context) => ProductScreenBuilder(),
            ProductViewScreen.route: (context) => ProductViewScreen(),
            ProductEditScreen.route: (context) => ProductEditScreen(),
            ClientScreen.route: (context) => ClientScreenBuilder(),
            ClientViewScreen.route: (context) => ClientViewScreen(),
            ClientEditScreen.route: (context) => ClientEditScreen(),
            InvoiceScreen.route: (context) => InvoiceScreen(),
            InvoiceViewScreen.route: (context) => InvoiceViewScreen(),
            InvoiceEditScreen.route: (context) => InvoiceEditScreen(),
            InvoiceEmailScreen.route: (context) => InvoiceEmailScreen(),
            DocumentScreen.route: (context) => DocumentScreenBuilder(),
            DocumentViewScreen.route: (context) => DocumentViewScreen(),
            DocumentEditScreen.route: (context) => DocumentEditScreen(),
            ExpenseScreen.route: (context) => ExpenseScreenBuilder(),
            ExpenseViewScreen.route: (context) => ExpenseViewScreen(),
            ExpenseEditScreen.route: (context) => ExpenseEditScreen(),
            VendorScreen.route: (context) => VendorScreen(),
            VendorViewScreen.route: (context) => VendorViewScreen(),
            VendorEditScreen.route: (context) => VendorEditScreen(),
            TaskScreen.route: (context) => TaskScreen(),
            TaskViewScreen.route: (context) => TaskViewScreen(),
            TaskEditScreen.route: (context) => TaskEditScreen(),
            ProjectScreen.route: (context) => ProjectScreen(),
            ProjectViewScreen.route: (context) => ProjectViewScreen(),
            ProjectEditScreen.route: (context) => ProjectEditScreen(),
            PaymentScreen.route: (context) => PaymentScreen(),
            PaymentViewScreen.route: (context) => PaymentViewScreen(),
            PaymentEditScreen.route: (context) => PaymentEditScreen(),
            QuoteScreen.route: (context) => QuoteScreen(),
            QuoteViewScreen.route: (context) => QuoteViewScreen(),
            QuoteEditScreen.route: (context) => QuoteEditScreen(),
            QuoteEmailScreen.route: (context) => QuoteEmailScreen(),
            // STARTER: routes - do not remove comment
            GroupSettingsScreen.route: (context) => GroupScreenBuilder(),
            GroupViewScreen.route: (context) => GroupViewScreen(),
            GroupEditScreen.route: (context) => GroupEditScreen(),
            SettingsScreen.route: (context) => SettingsScreen(),
            CompanyDetailsScreen.route: (context) => CompanyDetailsScreen(),
            UserDetailsScreen.route: (context) => UserDetailsScreen(),
            LocalizationScreen.route: (context) => LocalizationScreen(),
            CompanyGatewayScreen.route: (context) =>
                CompanyGatewayScreenBuilder(),
            CompanyGatewayViewScreen.route: (context) =>
                CompanyGatewayViewScreen(),
            CompanyGatewayEditScreen.route: (context) =>
                CompanyGatewayEditScreen(),
            OnlinePaymentsScreen.route: (context) => OnlinePaymentsScreen(),
            TaxRatesScreen.route: (context) => TaxRatesScreen(),
            TaxRateSettingsScreen.route: (context) => TaxRateSettingsScreen(),
            TaxRateViewScreen.route: (context) => TaxRateViewScreen(),
            TaxRateEditScreen.route: (context) => TaxRateEditScreen(),
            ProductSettingsScreen.route: (context) => ProductSettingsScreen(),
            NotificationsSettingsScreen.route: (context) =>
                NotificationsSettingsScreen(),
            ImportExportScreen.route: (context) => ImportExportScreen(),
            DeviceSettingsScreen.route: (context) => DeviceSettingsScreen(),
            GroupSettingsScreen.route: (context) => GroupScreenBuilder(),
            GroupEditScreen.route: (context) => GroupEditScreen(),
            GroupViewScreen.route: (context) => GroupViewScreen(),
            InvoiceSettingsScreen.route: (context) => InvoiceSettingsScreen(),
            InvoiceDesignScreen.route: (context) => InvoiceDesignScreen(),
            ClientPortalScreen.route: (context) => ClientPortalScreen(),
            BuyNowButtonsScreen.route: (context) => BuyNowButtonsScreen(),
            EmailSettingsScreen.route: (context) => EmailSettingsScreen(),
            TemplatesAndRemindersScreen.route: (context) =>
                TemplatesAndRemindersScreen(),
            CreditCardsAndBanksScreen.route: (context) =>
                CreditCardsAndBanksScreen(),
            DataVisualizationsScreen.route: (context) =>
                DataVisualizationsScreen(),
          },
        );
      }),
    );
  }
}
