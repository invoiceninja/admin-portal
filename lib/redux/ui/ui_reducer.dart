import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:redux/redux.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';

import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';

import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';

import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';

UIState uiReducer(UIState state, dynamic action) {
  return state.rebuild((b) => b
    ..filter = filterReducer(state.filter, action)
    ..selectedCompanyIndex =
        selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..currentRoute = currentRouteReducer(state.currentRoute, action)
    ..enableDarkMode = darkModeReducer(state.enableDarkMode, action)
    ..autoStartTasks = autoStartTasksReducer(state.autoStartTasks, action)
    ..requireAuthentication =
        requireAuthenticationReducer(state.requireAuthentication, action)
    ..emailPayment = emailPaymentReducer(state.emailPayment, action)
    ..productUIState.replace(productUIReducer(state.productUIState, action))
    ..clientUIState.replace(clientUIReducer(state.clientUIState, action))
    ..invoiceUIState.replace(invoiceUIReducer(state.invoiceUIState, action))
    ..dashboardUIState
        .replace(dashboardUIReducer(state.dashboardUIState, action))
    // STARTER: reducer - do not remove comment
    ..taskUIState.replace(taskUIReducer(state.taskUIState, action))
    ..projectUIState.replace(projectUIReducer(state.projectUIState, action))
    ..paymentUIState.replace(paymentUIReducer(state.paymentUIState, action))
    ..quoteUIState.replace(quoteUIReducer(state.quoteUIState, action)));
}

Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>(updateFilter),
]);

String updateFilter(String filter, FilterCompany action) {
  return action.filter;
}

Reducer<bool> emailPaymentReducer = combineReducers([
  TypedReducer<bool, UserSettingsChanged>(updateEmailPaymentReducer),
]);

bool updateEmailPaymentReducer(bool emailPayment, UserSettingsChanged action) {
  return action.emailPayment ?? emailPayment;
}

Reducer<bool> darkModeReducer = combineReducers([
  TypedReducer<bool, UserSettingsChanged>(updateDarkModeReducer),
]);

bool updateDarkModeReducer(bool enableDarkMode, UserSettingsChanged action) {
  return action.enableDarkMode ?? enableDarkMode;
}

Reducer<bool> autoStartTasksReducer = combineReducers([
  TypedReducer<bool, UserSettingsChanged>(updateAutoStartTasksReducer),
]);

bool updateAutoStartTasksReducer(bool autoStartTasks, UserSettingsChanged action) {
  return action.autoStartTasks ?? autoStartTasks;
}

Reducer<bool> requireAuthenticationReducer = combineReducers([
  TypedReducer<bool, UserSettingsChanged>(updateRequireAuthenticationReducer),
]);

bool updateRequireAuthenticationReducer(
    bool requireAuthentication, UserSettingsChanged action) {
  return action.requireAuthentication ?? requireAuthentication;
}

Reducer<String> currentRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>(updateCurrentRouteReducer),
]);

String updateCurrentRouteReducer(
    String currentRoute, UpdateCurrentRoute action) {
  return action.route;
}

Reducer<int> selectedCompanyIndexReducer = combineReducers([
  TypedReducer<int, SelectCompany>(selectCompanyReducer),
]);

int selectCompanyReducer(int selectedCompanyIndex, SelectCompany action) {
  return action.companyIndex;
}
