import 'package:invoiceninja/redux/client/client_reducer.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/redux/ui/ui_state.dart';
import 'package:invoiceninja/redux/product/product_reducer.dart';
import 'package:invoiceninja/redux/invoice/invoice_reducer.dart';
import 'package:redux/redux.dart';

UIState uiReducer(UIState state, action) {

  return state.rebuild((b) => b
    ..selectedCompanyIndex = selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..currentRoute = currentRouteReducer(state.currentRoute, action)
    ..entityDropdownFilter = entityDropdownFilterReducer(state.entityDropdownFilter, action)
    ..productUIState.replace(productUIReducer(state.productUIState, action))
    ..clientUIState.replace(clientUIReducer(state.clientUIState, action))
    ..invoiceUIState.replace(invoiceUIReducer(state.invoiceUIState, action))
  );
}

Reducer<String> entityDropdownFilterReducer = combineReducers([
  TypedReducer<String, UpdateEntityDropdownFilter>(updateEntityDropdownFilterReducer),
]);

String updateEntityDropdownFilterReducer(String currentRoute, UpdateEntityDropdownFilter action) {
  return action.filter;
}

Reducer<String> currentRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>(updateCurrentRouteReducer),
]);

String updateCurrentRouteReducer(String currentRoute, UpdateCurrentRoute action) {
  return action.route;
}

Reducer<int> selectedCompanyIndexReducer = combineReducers([
  TypedReducer<int, SelectCompany>(selectCompanyReducer),
]);

int selectCompanyReducer(int selectedCompanyIndex, SelectCompany action) {
  return action.companyIndex;
}