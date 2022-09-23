// Dart imports:
import 'dart:async';
import 'dart:convert';

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
import 'package:window_manager/window_manager.dart';
// STARTER: import - do not remove comment

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

void main({bool isTesting = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDesktopOS()) {
    await windowManager.ensureInitialized();

    final prefs = await SharedPreferences.getInstance();
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
          final reportErrors = account?.reportErrors ?? false;

          if (!reportErrors) {
            return null;
          }

          event = event.copyWith(
            environment: '${store.state.environment}'.split('.').last,
            extra: <String, dynamic>{
              'server_version': account?.currentVersion ?? 'Unknown',
              'route': state.uiState.currentRoute,
            },
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

Future<AppState> _initialState(bool isTesting) async {
  final prefs = await SharedPreferences.getInstance();
  final prefString = prefs?.getString(kSharedPrefs);

  final url = WebUtils.apiUrl ?? prefs.getString(kSharedPrefUrl) ?? '';
  if (!kReleaseMode) {
    //url = kAppStagingUrl;
    //url = kAppProductionUrl;
    //url = kAppDemoUrl;
  }

  var prefState = PrefState();
  if (prefString != null) {
    try {
      prefState = serializers.deserializeWith(
          PrefState.serializer, json.decode(prefString));
    } catch (e) {
      print('Failed to load prefs: $e');
    }
  }

  String browserRoute;
  if (kIsWeb && prefState.isDesktop) {
    browserRoute = WebUtils.browserRoute;
    if (browserRoute.isNotEmpty && browserRoute.length > 4) {
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
  String referralCode = '';
  if (kIsWeb) {
    reportErrors = WebUtils.getHtmlValue('report-errors') == '1';
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
    currentRoute: browserRoute,
  );
}
