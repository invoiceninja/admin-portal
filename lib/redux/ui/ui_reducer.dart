import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_reducer.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/document/document_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';
import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';
import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_reducer.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/webhook/webhook_reducer.dart';
import 'package:invoiceninja_flutter/redux/token/token_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_reducer.dart';
import 'package:invoiceninja_flutter/redux/design/design_reducer.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_reducer.dart';
import 'package:invoiceninja_flutter/redux/user/user_reducer.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_reducer.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_reducer.dart';
import 'package:invoiceninja_flutter/redux/group/group_reducer.dart';

UIState uiReducer(UIState state, dynamic action) {
  if (action is ClearEntityFilter ||
      (action is FilterByEntity &&
          action.entityType == state.filterEntityType &&
          action.entityId == state.filterEntityId)) {
    state = state.rebuild((b) => b
      ..filterEntityType = null
      ..filterEntityId = null);
  } else if (action is FilterByEntity) {
    state = state.rebuild((b) => b
      ..filterEntityType = action.entityType
      ..filterEntityId = action.entityId);
  }

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
    ..selectedEntities
        .replace(selectedEntitiesReducer(state.selectedEntities, action))
    ..reportsUIState.replace(reportsUIReducer(state.reportsUIState, action))
    // STARTER: reducer - do not remove comment
    ..webhookUIState.replace(webhookUIReducer(state.webhookUIState, action))
    ..tokenUIState.replace(tokenUIReducer(state.tokenUIState, action))
    ..paymentTermUIState
        .replace(paymentTermUIReducer(state.paymentTermUIState, action))
    ..designUIState.replace(designUIReducer(state.designUIState, action))
    ..creditUIState.replace(creditUIReducer(state.creditUIState, action))
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

Reducer<BuiltMap<EntityType, BuiltList<String>>> selectedEntitiesReducer =
    combineReducers([
  TypedReducer<BuiltMap<EntityType, BuiltList<String>>,
      UpdateDashboardSelection>((state, action) {
    return state.rebuild((b) =>
        b..[action.entityType] = BuiltList(action.entityIds ?? <String>[]));
  }),
]);

Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>((filter, action) {
    return action.filter;
  }),
  TypedReducer<String, ViewDashboard>((state, action) {
    return action.filter;
  }),
]);

Reducer<int> filterClearedAtReducer = combineReducers([
  TypedReducer<int, FilterCompany>((filterClearedAt, action) {
    return action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : filterClearedAt;
  }),
  TypedReducer<int, ViewDashboard>((state, action) {
    return DateTime.now().millisecondsSinceEpoch;
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
  TypedReducer<SettingsUIState, ViewSettings>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company ?? state.company)
      ..origCompany.replace(action.company ?? state.origCompany)
      ..group.replace(action.group ?? state.group)
      ..origGroup.replace(action.group ?? state.origGroup)
      ..client.replace(action.client ?? state.client)
      ..origClient.replace(action.client ?? state.origClient)
      ..user.replace(action.user ?? state.user)
      ..origUser.replace(action.user ?? state.origUser)
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
          ..client.settings.replace(action.settings)
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
  TypedReducer<SettingsUIState, UpdateUserSettings>((state, action) {
    return state.rebuild((b) => b
      ..user.replace(action.user)
      ..isChanged = true);
  }),
  TypedReducer<SettingsUIState, ResetSettings>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(state.origCompany)
      ..group.replace(state.origGroup)
      ..client.replace(state.origClient)
      ..user.replace(state.origUser)
      ..isChanged = false
      ..updatedAt = DateTime.now().millisecondsSinceEpoch);
  }),
  TypedReducer<SettingsUIState, SaveCompanySuccess>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company)
      ..origCompany.replace(action.company)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveGroupSuccess>((state, action) {
    return state.rebuild((b) => b
      ..group.replace(action.group)
      ..origGroup.replace(action.group)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveClientSuccess>((state, action) {
    return state.rebuild((b) => b
      ..client.replace(action.client)
      ..origClient.replace(action.client)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveAuthUserSuccess>((state, action) {
    return state.rebuild((b) => b
      ..user.replace(action.user)
      ..origUser.replace(action.user)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, FilterSettings>((state, action) {
    return state.rebuild((b) => b
      ..filter = action.filter
      ..filterClearedAt = action.filter == null
          ? DateTime.now().millisecondsSinceEpoch
          : state.filterClearedAt);
  }),
  TypedReducer<SettingsUIState, ClearSettingsFilter>((state, action) {
    return state.rebuild((b) => b
      ..updatedAt = DateTime.now().millisecondsSinceEpoch
      ..company.replace(state.origCompany)
      ..entityType = EntityType.company
      ..isChanged = false);
  }),
]);
