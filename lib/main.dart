import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
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
import 'package:invoiceninja_flutter/redux/group/group_middleware.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_middleware.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_middleware.dart';
import 'package:invoiceninja_flutter/redux/product/product_middleware.dart';
import 'package:invoiceninja_flutter/redux/project/project_middleware.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_middleware.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_middleware.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_middleware.dart';
import 'package:invoiceninja_flutter/redux/task/task_middleware.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_middleware.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_middleware.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_middleware.dart';
import 'package:invoiceninja_flutter/utils/sentry.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/webhook/webhook_middleware.dart';
import 'package:invoiceninja_flutter/redux/token/token_middleware.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_middleware.dart';

void main({bool isTesting = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final SentryClient _sentry = Config.SENTRY_DNS.isEmpty
      ? null
      : SentryClient(
          dsn: Config.SENTRY_DNS,
          environmentAttributes: await getSentryEvent());

  final store = Store<AppState>(appReducer,
      initialState: await _initialState(isTesting),
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
        ..addAll(isTesting
            ? []
            : [
                LoggingMiddleware<dynamic>.printer(
                  formatter: LoggingMiddleware.multiLineFormatter,
                ),
              ]));

  if (_sentry == null) {
    runApp(InvoiceNinjaApp(store: store));
  } else {
    runZoned<Future<void>>(() async {
      runApp(InvoiceNinjaApp(store: store));
    }, onError: (dynamic exception, dynamic stackTrace) async {
      if (kDebugMode) {
        print(stackTrace);
      } else if (store.state.reportErrors) {
        final event = await getSentryEvent(
          state: store.state,
          exception: exception,
          stackTrace: stackTrace,
        );
        _sentry.capture(event: event);
      }
    });
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else if (store.state.reportErrors) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}

Future<AppState> _initialState(bool isTesting) async {
  final prefs = await SharedPreferences.getInstance();
  final prefString = prefs?.getString(kSharedPrefs);
  final url = prefs.getString(kSharedPrefUrl) ?? WebUtils.browserUrl;

  var prefState = PrefState(enableDarkMode: url == kAppDemoUrl);

  if (prefString != null) {
    try {
      prefState = serializers.deserializeWith(
          PrefState.serializer, json.decode(prefString));
    } catch (e) {
      print('Failed to load prefs: $e');
    }
  }

  String currentRoute;

  /*
  if (kIsWeb && prefState.isDesktop) {
    currentRoute = html.window.location.hash.replaceFirst('#', '');
    if (currentRoute.isEmpty || currentRoute == '/') {
      currentRoute = DashboardScreenBuilder.route;
    }
  }
   */

  return AppState(
    prefState: prefState,
    currentRoute: currentRoute,
    url: Config.DEMO_MODE ? '' : url,
  );
}
