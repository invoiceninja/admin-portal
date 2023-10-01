// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/app/loading_reducer.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_reducer.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_reducer.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_reducer.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_reducer.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';

import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';

import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';

import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';

import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, dynamic action) {
  if (action is UserLogout) {
    return AppState(
            prefState: state.prefState,
            isWhiteLabeled: state.isWhiteLabeled,
            reportErrors: state.account.reportErrors)
        .rebuild((b) => b
          ..authState.replace(state.authState.rebuild((b) => b
            ..isAuthenticated = false
            ..lastEnteredPasswordAt = 0))
          ..isTesting = state.isTesting);
  } else if (action is LoadStateSuccess) {
    return action.state.rebuild((b) => b
      ..isLoading = false
      ..isSaving = false);
  } else if (action is ClearData) {
    return state.rebuild((b) => b
      ..userCompanyStates[state.uiState.selectedCompanyIndex] =
          UserCompanyState(state.account.reportErrors));
  }

  return state.rebuild((b) => b
    ..isLoading = loadingReducer(state.isLoading, action)
    ..isSaving = savingReducer(state.isSaving, action)
    ..dismissedNativeWarning =
        dismissedNativeWarningReducer(state.dismissedNativeWarning, action)
    ..lastError = lastErrorReducer(state.lastError, action)
    ..authState.replace(authReducer(state.authState, action))
    ..staticState.replace(staticReducer(state.staticState, action))
    ..userCompanyStates[state.uiState.selectedCompanyIndex] = companyReducer(
        state.userCompanyStates[state.uiState.selectedCompanyIndex], action)
    ..uiState.replace(uiReducer(state.uiState, action))
    ..prefState
        .replace(prefReducer(state.prefState, action, state.company.id)));
}

final lastErrorReducer = combineReducers<String>([
  TypedReducer<String, ClearLastError>((state, action) {
    return '';
  }),
  TypedReducer<String, LoadClientsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadProductsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadInvoicesFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadPaymentsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadQuotesFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadProjectsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadTasksFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadVendorsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadExpensesFailure>((state, action) {
    return '${action.error}';
  }),
  // STARTER: errors - do not remove comment
  TypedReducer<String, LoadSchedulesFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadTransactionRulesFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadTransactionsFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadBankAccountsFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadPurchaseOrdersFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadRecurringExpensesFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadSubscriptionsFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadTaskStatusesFailure>((state, action) {
    return '${action.error}';
  }),

  TypedReducer<String, LoadRecurringInvoicesFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadWebhooksFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadTokensFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadPaymentTermsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadDesignsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, LoadCreditsFailure>((state, action) {
    return '${action.error}';
  }),
  TypedReducer<String, RefreshDataFailure>((state, action) {
    return '${action.error}';
  }),
]);

final dismissedNativeWarningReducer = combineReducers<bool>([
  TypedReducer<bool, DismissNativeWarning>((state, action) {
    return true;
  }),
  TypedReducer<bool, DismissNativeWarningPermanently>((state, action) {
    return true;
  }),
]);
