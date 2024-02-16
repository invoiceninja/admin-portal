// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/app/app_reducer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_middleware.dart';
import 'package:invoiceninja_flutter/redux/client/client_middleware.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_middleware.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_middleware.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_middleware.dart';
import 'package:invoiceninja_flutter/redux/design/design_middleware.dart';
import 'package:invoiceninja_flutter/redux/document/document_middleware.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_middleware.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_middleware.dart';
import 'package:invoiceninja_flutter/redux/group/group_middleware.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_middleware.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_middleware.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_middleware.dart';
import 'package:invoiceninja_flutter/redux/product/product_middleware.dart';
import 'package:invoiceninja_flutter/redux/project/project_middleware.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_middleware.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_middleware.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_middleware.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_middleware.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_middleware.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_middleware.dart';
import 'package:invoiceninja_flutter/redux/task/task_middleware.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_middleware.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_middleware.dart';
import 'package:invoiceninja_flutter/redux/token/token_middleware.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_middleware.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_middleware.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_middleware.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_middleware.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_middleware.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_middleware.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_middleware.dart';
import 'package:window_manager/window_manager.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_middleware.dart';
// STARTER: import - do not remove comment

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

// https://github.com/dart-lang/io/issues/83#issuecomment-940617222
const isrgRootX1 = '''-----BEGIN CERTIFICATE-----
MIIFazCCA1OgAwIBAgIRAIIQz7DSQONZRGPgu2OCiwAwDQYJKoZIhvcNAQELBQAw
TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMTUwNjA0MTEwNDM4
WhcNMzUwNjA0MTEwNDM4WjBPMQswCQYDVQQGEwJVUzEpMCcGA1UEChMgSW50ZXJu
ZXQgU2VjdXJpdHkgUmVzZWFyY2ggR3JvdXAxFTATBgNVBAMTDElTUkcgUm9vdCBY
MTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAK3oJHP0FDfzm54rVygc
h77ct984kIxuPOZXoHj3dcKi/vVqbvYATyjb3miGbESTtrFj/RQSa78f0uoxmyF+
0TM8ukj13Xnfs7j/EvEhmkvBioZxaUpmZmyPfjxwv60pIgbz5MDmgK7iS4+3mX6U
A5/TR5d8mUgjU+g4rk8Kb4Mu0UlXjIB0ttov0DiNewNwIRt18jA8+o+u3dpjq+sW
T8KOEUt+zwvo/7V3LvSye0rgTBIlDHCNAymg4VMk7BPZ7hm/ELNKjD+Jo2FR3qyH
B5T0Y3HsLuJvW5iB4YlcNHlsdu87kGJ55tukmi8mxdAQ4Q7e2RCOFvu396j3x+UC
B5iPNgiV5+I3lg02dZ77DnKxHZu8A/lJBdiB3QW0KtZB6awBdpUKD9jf1b0SHzUv
KBds0pjBqAlkd25HN7rOrFleaJ1/ctaJxQZBKT5ZPt0m9STJEadao0xAH0ahmbWn
OlFuhjuefXKnEgV4We0+UXgVCwOPjdAvBbI+e0ocS3MFEvzG6uBQE3xDk3SzynTn
jh8BCNAw1FtxNrQHusEwMFxIt4I7mKZ9YIqioymCzLq9gwQbooMDQaHWBfEbwrbw
qHyGO0aoSCqI3Haadr8faqU9GY/rOPNk3sgrDQoo//fb4hVC1CLQJ13hef4Y53CI
rU7m2Ys6xt0nUW7/vGT1M0NPAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNV
HRMBAf8EBTADAQH/MB0GA1UdDgQWBBR5tFnme7bl5AFzgAiIyBpY9umbbjANBgkq
hkiG9w0BAQsFAAOCAgEAVR9YqbyyqFDQDLHYGmkgJykIrGF1XIpu+ILlaS/V9lZL
ubhzEFnTIZd+50xx+7LSYK05qAvqFyFWhfFQDlnrzuBZ6brJFe+GnY+EgPbk6ZGQ
3BebYhtF8GaV0nxvwuo77x/Py9auJ/GpsMiu/X1+mvoiBOv/2X/qkSsisRcOj/KK
NFtY2PwByVS5uCbMiogziUwthDyC3+6WVwW6LLv3xLfHTjuCvjHIInNzktHCgKQ5
ORAzI4JMPJ+GslWYHb4phowim57iaztXOoJwTdwJx4nLCgdNbOhdjsnvzqvHu7Ur
TkXWStAmzOVyyghqpZXjFaH3pO3JLF+l+/+sKAIuvtd7u+Nxe5AW0wdeRlN8NwdC
jNPElpzVmbUq4JUagEiuTDkHzsxHpFKVK7q4+63SM1N95R1NbdWhscdCb+ZAJzVc
oyi3B43njTOQ5yOf+1CceWxG1bQVs5ZufpsMljq4Ui0/1lvh+wjChP4kqKOJ2qxq
4RgqsahDYVvTH9w7jXbyLeiNdd8XM2w9U/t7y0Ff/9yi0GE44Za4rF2LN9d11TPA
mRGunUHBcnWEvgJBQl9nJEiU0Zsnvgc/ubhPgXRR4Xq37Z0j4r7g1SgEEzwxA57d
emyPxgcYxn/eR44/KJ4EBs+lVDR3veyJm+kXQ99b21/+jh5Xos1AnX5iItreGCc=
-----END CERTIFICATE-----
''';

void main({bool isTesting = false}) async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerErrorHandlers();

  try {
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      Uint8List.fromList(isrgRootX1.codeUnits),
    );
  } catch (e) {
    // Ignore CERT_ALREADY_IN_HASH_TABLE
  }

  final prefs = await SharedPreferences.getInstance();

  if (isDesktopOS()) {
    await windowManager.ensureInitialized();

    windowManager.waitUntilReadyToShow(
        WindowOptions(
          center: true,
          size: Size(
            prefs.getDouble(kSharedPrefWidth) ?? 800,
            prefs.getDouble(kSharedPrefHeight) ?? 600,
          ),
        ), () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  final store = Store<AppState>(appReducer,
      initialState: await _initialState(isTesting, prefs),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDocumentsMiddleware())
        ..addAll(createStoreDashboardMiddleware())
        ..addAll(createStoreProductsMiddleware())
        ..addAll(createStoreClientsMiddleware())
        ..addAll(createStoreInvoicesMiddleware())
        ..addAll(createStoreExpensesMiddleware())
        ..addAll(createStoreVendorsMiddleware())
        ..addAll(createStoreTasksMiddleware())
        ..addAll(createStoreProjectsMiddleware())
        ..addAll(createStorePaymentsMiddleware())
        ..addAll(createStoreQuotesMiddleware())
        ..addAll(createStoreSettingsMiddleware())
        ..addAll(createStoreReportsMiddleware())
        // STARTER: middleware - do not remove comment
        ..addAll(createStoreSchedulesMiddleware())
        ..addAll(createStoreTransactionRulesMiddleware())
        ..addAll(createStoreTransactionsMiddleware())
        ..addAll(createStoreBankAccountsMiddleware())
        ..addAll(createStorePurchaseOrdersMiddleware())
        ..addAll(createStoreRecurringExpensesMiddleware())
        ..addAll(createStoreSubscriptionsMiddleware())
        ..addAll(createStoreTaskStatusesMiddleware())
        ..addAll(createStoreExpenseCategoriesMiddleware())
        ..addAll(createStoreRecurringInvoicesMiddleware())
        ..addAll(createStoreWebhooksMiddleware())
        ..addAll(createStoreTokensMiddleware())
        ..addAll(createStorePaymentTermsMiddleware())
        ..addAll(createStoreDesignsMiddleware())
        ..addAll(createStoreCreditsMiddleware())
        ..addAll(createStoreUsersMiddleware())
        ..addAll(createStoreTaxRatesMiddleware())
        ..addAll(createStoreCompanyGatewaysMiddleware())
        ..addAll(createStoreGroupsMiddleware())
        ..addAll(createStorePersistenceMiddleware())
        ..addAll(isTesting || kReleaseMode || !Config.DEBUG_EVENTS
            ? []
            : [
                LoggingMiddleware<dynamic>.printer(
                  formatter: LoggingMiddleware.multiLineFormatter,
                ),
              ]));

  if (!kReleaseMode) {
    runApp(InvoiceNinjaApp(store: store));
  } else {
    await SentryFlutter.init(
      (options) {
        options.dsn = Config.SENTRY_DNS;
        options.release = const String.fromEnvironment('SENTRY_RELEASE',
            defaultValue: kClientVersion);
        options.dist = kClientVersion;
        options.beforeSend = (SentryEvent event, {dynamic hint}) {
          final state = store.state;
          final account = state.account;
          final reportErrors = account.reportErrors;

          if (!reportErrors) {
            return null;
          }

          event = event.copyWith(
            environment: '${store.state.environment}'.split('.').last,
            /*
            extra: <String, dynamic>{
              'server_version': account.currentVersion,
              'route': state.uiState.currentRoute,
            },
            */
          );

          return event;
        };
      },
      appRunner: () => runApp(InvoiceNinjaApp(store: store)),
    );
  }

  /*
  if (isWindows()) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.title = 'Invoice Ninja';
      win.show();
    });
  }
  */
}

Future<AppState> _initialState(bool isTesting, SharedPreferences prefs) async {
  final prefString = prefs.getString(kSharedPrefs);

  final url = WebUtils.apiUrl ?? prefs.getString(kSharedPrefUrl) ?? '';
  if (!kReleaseMode) {
    //url = kAppStagingUrl;
    //url = kAppProductionUrl;
    //url = kAppDemoUrl;
  }

  PrefState? prefState = PrefState();
  if (prefString != null) {
    try {
      prefState = serializers.deserializeWith(
          PrefState.serializer, json.decode(prefString));
    } catch (e) {
      print('## Error: Failed to load prefs: $e');
    }
  }

  prefState = prefState!.rebuild((b) => b
    ..enableDarkModeSystem =
        PlatformDispatcher.instance.platformBrightness == Brightness.dark);

  String? browserRoute;
  if (kIsWeb && prefState.isDesktop) {
    browserRoute = WebUtils.browserRoute;
    if (browserRoute!.isNotEmpty && browserRoute.length > 4) {
      if (browserRoute == '/kanban') {
        browserRoute = '/task';
        prefState = prefState.rebuild((b) => b
          ..showKanban = true
          ..useSidebarEditor[EntityType.task] = true);
      }
    } else {
      browserRoute = null;
    }
  }

  bool reportErrors = false;
  bool whiteLabeled = false;
  String? referralCode = '';

  if (kIsWeb) {
    reportErrors = WebUtils.getHtmlValue('report-errors') == '1';
    whiteLabeled = WebUtils.getHtmlValue('white-label') == '1';
    referralCode = WebUtils.getHtmlValue('rc');
    if (reportErrors) {
      print('## Error reporting is enabled');
    }
  }

  return AppState(
    prefState: prefState,
    url: Config.DEMO_MODE ? '' : url,
    referralCode: referralCode,
    reportErrors: reportErrors,
    isWhiteLabeled: whiteLabeled,
    currentRoute: browserRoute,
  );
}

void _registerErrorHandlers() {
  /*
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    //errorLogger.logError(details.exception, details.stack);
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    //errorLogger.logError(error, stack);
    return true;
  };
  */

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: Colors.grey.shade100,
      child: Center(
        child: Text(
          details.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  };
}
