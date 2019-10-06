import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:redux/redux.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/document/document_reducer.dart';

import 'package:invoiceninja_flutter/redux/expense/expense_reducer.dart';

import 'package:invoiceninja_flutter/redux/vendor/vendor_reducer.dart';

import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';

import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';

import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';

import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';

UIState uiReducer(UIState state, dynamic action) {
  final currentRoute = currentRouteReducer(state.currentRoute, action);
  return state.rebuild((b) => b
    ..filter = filterReducer(state.filter, action)
    ..selectedCompanyIndex =
        selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..layout = layoutReducer(state.layout, action)
    ..isMenuVisible = menuVisibleReducer(state.isMenuVisible, action)
    ..isHistoryVisible = historyVisibleReducer(state.isHistoryVisible, action)
    ..previousRoute = state.currentRoute == currentRoute
        ? state.previousRoute
        : state.currentRoute.contains('/edit')
            ? state.previousRoute
            : state.currentRoute
    ..currentRoute = currentRoute
    ..enableDarkMode = darkModeReducer(state.enableDarkMode, action)
    ..autoStartTasks = autoStartTasksReducer(state.autoStartTasks, action)
    ..requireAuthentication =
        requireAuthenticationReducer(state.requireAuthentication, action)
    ..emailPayment = emailPaymentReducer(state.emailPayment, action)
    ..addDocumentsToInvoice =
        addDocumentsToInvoiceReducer(state.addDocumentsToInvoice, action)
    ..productUIState.replace(productUIReducer(state.productUIState, action))
    ..clientUIState.replace(clientUIReducer(state.clientUIState, action))
    ..invoiceUIState.replace(invoiceUIReducer(state.invoiceUIState, action))
    ..dashboardUIState
        .replace(dashboardUIReducer(state.dashboardUIState, action))
    // STARTER: reducer - do not remove comment
    ..documentUIState.replace(documentUIReducer(state.documentUIState, action))
    ..expenseUIState.replace(expenseUIReducer(state.expenseUIState, action))
    ..vendorUIState.replace(vendorUIReducer(state.vendorUIState, action))
    ..taskUIState.replace(taskUIReducer(state.taskUIState, action))
    ..projectUIState.replace(projectUIReducer(state.projectUIState, action))
    ..paymentUIState.replace(paymentUIReducer(state.paymentUIState, action))
    ..quoteUIState.replace(quoteUIReducer(state.quoteUIState, action))
    ..settingsUIState
        .replace(settingsUIReducer(state.settingsUIState, action)));
}

Reducer<bool> menuVisibleReducer = combineReducers([
  TypedReducer<bool, UpdateSidebar>(updateMenuVisible),
]);

bool updateMenuVisible(bool value, UpdateSidebar action) {
  return action.sidebar == AppSidebar.menu ? !value : value;
}

Reducer<bool> historyVisibleReducer = combineReducers([
  TypedReducer<bool, UpdateSidebar>(updateHistoryVisible),
]);

bool updateHistoryVisible(bool value, UpdateSidebar action) {
  return action.sidebar == AppSidebar.history ? !value : value;
}

Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>(updateFilter),
]);

String updateFilter(String filter, FilterCompany action) {
  return action.filter;
}

Reducer<AppLayout> layoutReducer = combineReducers([
  TypedReducer<AppLayout, UpdateLayout>(updateLayout),
]);

AppLayout updateLayout(AppLayout layout, UpdateLayout action) {
  return action.layout;
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

bool updateAutoStartTasksReducer(
    bool autoStartTasks, UserSettingsChanged action) {
  return action.autoStartTasks ?? autoStartTasks;
}

Reducer<bool> addDocumentsToInvoiceReducer = combineReducers([
  TypedReducer<bool, UserSettingsChanged>(updateAddDocumentsToInvoiceReducer),
]);

bool updateAddDocumentsToInvoiceReducer(
    bool addDocumentsToInvoice, UserSettingsChanged action) {
  return action.addDocumentsToInvoice ?? addDocumentsToInvoice;
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

Reducer<String> previousRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>(updatePreviousRouteReducer),
]);

String updatePreviousRouteReducer(
    String currentRoute, UpdateCurrentRoute action) {
  return currentRoute;
}

Reducer<int> selectedCompanyIndexReducer = combineReducers([
  TypedReducer<int, SelectCompany>(selectCompanyReducer),
]);

int selectCompanyReducer(int selectedCompanyIndex, SelectCompany action) {
  return action.companyIndex;
}

Reducer<SettingsUIState> settingsUIReducer = combineReducers([
  TypedReducer<SettingsUIState, ViewSettings>((state, action) {
    return SettingsUIState(
        userCompany: action.userCompany, section: action.section);
  }),
  TypedReducer<SettingsUIState, UpdateCompany>((state, action) {
    return state.rebuild((b) => b
      ..userCompany.company.replace(action.company)
      ..isChanged = true);
  }),
  TypedReducer<SettingsUIState, UpdateSettings>((state, action) {
    switch (state.entityType) {
      case EntityType.client:
        return state.rebuild((b) => b
          //..client.settings.replace(action.settings)
          ..isChanged = true);
      case EntityType.group:
        return state.rebuild((b) => b
          ..group.settings.replace(action.settings)
          ..isChanged = true);
      default:
        return state.rebuild((b) => b
          ..userCompany.company.settings.replace(action.settings)
          ..isChanged = true);
    }
  }),
  TypedReducer<SettingsUIState, UpdateUser>((state, action) {
    return state.rebuild((b) => b
      ..userCompany.user.replace(action.user)
      ..isChanged = true);
  }),
  TypedReducer<SettingsUIState, ResetCompany>((state, action) {
    return state.rebuild((b) => b
      ..userCompany.company.replace(action.company)
      ..isChanged = false
      ..updatedAt = DateTime.now().millisecondsSinceEpoch);
  }),
  TypedReducer<SettingsUIState, ResetUser>((state, action) {
    return state.rebuild((b) => b
      ..userCompany.user.replace(action.user)
      ..isChanged = false
      ..updatedAt = DateTime.now().millisecondsSinceEpoch);
  }),
]);
