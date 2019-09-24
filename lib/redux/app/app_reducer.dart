import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_reducer.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/app/loading_reducer.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_reducer.dart';
import 'package:invoiceninja_flutter/redux/static/static_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, dynamic action) {
  if (action is UserLogout) {
    return AppState().rebuild((b) => b
      ..authState
          .replace(state.authState.rebuild((b) => b..isAuthenticated = false))
      ..uiState.enableDarkMode = state.uiState.enableDarkMode
      ..uiState.isTesting = state.uiState.isTesting);
  } else if (action is LoadStateSuccess) {
    return action.state.rebuild((b) => b
      ..isLoading = false
      ..isSaving = false);
  }

  return state.rebuild((b) => b
    ..isLoading = loadingReducer(state.isLoading, action)
    ..isSaving = savingReducer(state.isSaving, action)
    ..lastError = lastErrorReducer(state.lastError, action)
    ..serverVersion = serverVersionReducer(state.serverVersion, action)
    ..authState.replace(authReducer(state.authState, action))
    ..staticState.replace(staticReducer(state.staticState, action))
    ..companyState1.replace(state.uiState.selectedCompanyIndex == 1
        ? companyReducer(state.companyState1, action)
        : state.companyState1)
    ..companyState2.replace(state.uiState.selectedCompanyIndex == 2
        ? companyReducer(state.companyState2, action)
        : state.companyState2)
    ..companyState3.replace(state.uiState.selectedCompanyIndex == 3
        ? companyReducer(state.companyState3, action)
        : state.companyState3)
    ..companyState4.replace(state.uiState.selectedCompanyIndex == 4
        ? companyReducer(state.companyState4, action)
        : state.companyState4)
    ..companyState5.replace(state.uiState.selectedCompanyIndex == 5
        ? companyReducer(state.companyState5, action)
        : state.companyState5)
    ..uiState.replace(uiReducer(state.uiState, action)));
}

final serverVersionReducer = combineReducers<String>([
  // TODO re-enable this
  //TypedReducer<String, LoadStaticSuccess>(_loadStaticSuccess),
]);

final lastErrorReducer = combineReducers<String>([
  TypedReducer<String, ClearLastError>((state, action) {
    return '';
  }),
  TypedReducer<String, LoadDashboardFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadClientsFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadProductsFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadInvoicesFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadPaymentsFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadQuotesFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadProjectsFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadTasksFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadVendorsFailure>((state, action) {
    return action.error;
  }),
  TypedReducer<String, LoadExpensesFailure>((state, action) {
    return action.error;
  }),
  // TODO add to starter.sh
]);
