import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/document/document_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';
import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';
import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_reducer.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/user/user_reducer.dart';

import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_reducer.dart';

import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_reducer.dart';

import 'package:invoiceninja_flutter/redux/group/group_reducer.dart';

UIState uiReducer(UIState state, dynamic action) {
  final currentRoute = currentRouteReducer(state.currentRoute, action);
  return state.rebuild((b) => b
    ..filter = filterReducer(state.filter, action)
    ..filterClearedAt = filterClearedAtReducer(state.filterClearedAt, action)
    ..selectedCompanyIndex =
        selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..previousRoute = state.currentRoute == currentRoute
        ? state.previousRoute
        : state.currentRoute.endsWith('edit')
            ? state.previousRoute
            : state.currentRoute
    ..currentRoute = currentRoute
    ..productUIState.replace(productUIReducer(state.productUIState, action))
    ..clientUIState.replace(clientUIReducer(state.clientUIState, action))
    ..invoiceUIState.replace(invoiceUIReducer(state.invoiceUIState, action))
    ..dashboardUIState
        .replace(dashboardUIReducer(state.dashboardUIState, action))
    // STARTER: reducer - do not remove comment
    ..userUIState.replace(userUIReducer(state.userUIState, action))
    ..taxRateUIState.replace(taxRateUIReducer(state.taxRateUIState, action))
    ..companyGatewayUIState
        .replace(companyGatewayUIReducer(state.companyGatewayUIState, action))
    ..groupUIState.replace(groupUIReducer(state.groupUIState, action))
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

Reducer<BuiltList<HistoryRecord>> historyReducer = combineReducers([
  TypedReducer<BuiltList<HistoryRecord>, ViewClient>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.clientId, entityType: EntityType.client))),
  TypedReducer<BuiltList<HistoryRecord>, EditClient>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.client.id, entityType: EntityType.client))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProduct>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.productId, entityType: EntityType.product))),
  TypedReducer<BuiltList<HistoryRecord>, EditProduct>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.product.id, entityType: EntityType.product))),
  TypedReducer<BuiltList<HistoryRecord>, ViewInvoice>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.invoiceId, entityType: EntityType.invoice))),
  TypedReducer<BuiltList<HistoryRecord>, EditInvoice>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.invoice.id, entityType: EntityType.invoice))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPayment>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.paymentId, entityType: EntityType.payment))),
  TypedReducer<BuiltList<HistoryRecord>, EditPayment>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.payment.id, entityType: EntityType.payment))),
  TypedReducer<BuiltList<HistoryRecord>, ViewQuote>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.quoteId, entityType: EntityType.quote))),
  TypedReducer<BuiltList<HistoryRecord>, EditQuote>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.quote.id, entityType: EntityType.quote))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTask>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.taskId, entityType: EntityType.task))),
  TypedReducer<BuiltList<HistoryRecord>, EditTask>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.task.id, entityType: EntityType.task))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProject>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.projectId, entityType: EntityType.project))),
  TypedReducer<BuiltList<HistoryRecord>, EditProject>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.project.id, entityType: EntityType.project))),
  TypedReducer<BuiltList<HistoryRecord>, ViewVendor>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.vendorId, entityType: EntityType.vendor))),
  TypedReducer<BuiltList<HistoryRecord>, EditVendor>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.vendor.id, entityType: EntityType.vendor))),
  TypedReducer<BuiltList<HistoryRecord>, ViewExpense>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.expenseId, entityType: EntityType.expense))),
  TypedReducer<BuiltList<HistoryRecord>, EditExpense>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.expense.id, entityType: EntityType.expense))),
  TypedReducer<BuiltList<HistoryRecord>, ViewCompanyGateway>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.companyGatewayId,
              entityType: EntityType.companyGateway))),
  TypedReducer<BuiltList<HistoryRecord>, EditCompanyGateway>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.companyGateway.id,
              entityType: EntityType.companyGateway))),
  TypedReducer<BuiltList<HistoryRecord>, ViewUser>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.userId, entityType: EntityType.user))),
  TypedReducer<BuiltList<HistoryRecord>, EditUser>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.user.id, entityType: EntityType.user))),
  TypedReducer<BuiltList<HistoryRecord>, ViewGroup>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.groupId, entityType: EntityType.group))),
  TypedReducer<BuiltList<HistoryRecord>, EditGroup>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.group.id, entityType: EntityType.group))),
  // TODO add to starter.sh
]);

BuiltList<HistoryRecord> _addToHistory(
    BuiltList<HistoryRecord> list, HistoryRecord record) {
  // don't track new records
  if (record.id.startsWith('-')) {
    return list;
  }

  final old =
      list.firstWhere((item) => item.matchesRecord(record), orElse: () => null);
  if (old != null) {
    return list.rebuild((b) => b
      ..remove(old)
      ..insert(0, record));
  } else {
    return list.rebuild((b) => b
      ..insert(0, record)
      ..sublist(0, min(200, list.length + 1)));
  }
}

Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>((filter, action) {
    return action.filter;
  }),
]);

Reducer<int> filterClearedAtReducer = combineReducers([
  TypedReducer<int, FilterCompany>((filterClearedAt, action) {
    return action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : filterClearedAt;
  }),
]);

Reducer<String> currentRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>((currentRoute, action) {
    return action.route;
  }),
]);

Reducer<String> previousRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>((currentRoute, action) {
    return currentRoute;
  }),
]);

Reducer<int> selectedCompanyIndexReducer = combineReducers([
  TypedReducer<int, SelectCompany>((selectedCompanyIndex, action) {
    return action.companyIndex;
  }),
]);

Reducer<SettingsUIState> settingsUIReducer = combineReducers([
  TypedReducer<SettingsUIState, ClearSettingsFilter>((state, action) {
    return state.rebuild((b) => b
      ..updatedAt = DateTime.now().millisecondsSinceEpoch
      ..company.replace(state.origCompany)
      ..entityType = EntityType.company
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, ViewSettings>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company ?? state.company)
      ..origCompany.replace(action.company ?? state.origCompany)
      ..group.replace(action.group ?? state.group)
      ..origGroup.replace(action.group ?? state.origGroup)
      ..client.replace(action.client ?? state.client)
      ..origClient.replace(action.client ?? state.origClient)
      ..updatedAt = DateTime.now().millisecondsSinceEpoch
      ..section = action.section ?? state.section
      ..isChanged = false
      ..entityType = action.client != null
          ? EntityType.client
          : action.group != null ? EntityType.group : state.entityType);
  }),
  TypedReducer<SettingsUIState, UpdateCompany>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company)
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
          ..company.settings.replace(action.settings)
          ..isChanged = true);
    }
  }),
  TypedReducer<SettingsUIState, UpdateSettingsUser>((state, action) {
    return state.rebuild((b) => b
      ..user.replace(action.user)
      ..isChanged = true);
  }),
  TypedReducer<SettingsUIState, ResetSettings>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(state.origCompany)
      ..group.replace(state.origGroup)
      ..client.replace(state.origClient)
      ..isChanged = false
      ..updatedAt = DateTime.now().millisecondsSinceEpoch);
  }),
  TypedReducer<SettingsUIState, SaveCompanySuccess>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveGroupSuccess>((state, action) {
    return state.rebuild((b) => b
      ..group.replace(action.group)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveClientSuccess>((state, action) {
    return state.rebuild((b) => b
      ..client.replace(action.client)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, FilterSettings>((state, action) {
    return state.rebuild((b) => b
      ..filter = action.filter
      ..filterClearedAt = action.filter == null
          ? DateTime.now().millisecondsSinceEpoch
          : state.filterClearedAt);
  }),
]);
