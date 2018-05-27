import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/app/loading_reducer.dart';
import 'package:invoiceninja/redux/auth/auth_reducer.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja/redux/product/product_reducer.dart';
import 'package:invoiceninja/redux/company/company_reducer.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {

  return state.rebuild((b) => b
    ..selectedCompanyIndex = selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..isLoading = loadingReducer(state.isLoading, action)
    ..authState = authReducer(state.authState, action).toBuilder()
    ..companyState1 = state.selectedCompanyIndex == 1
        ? companyReducer(state.companyState1, action).toBuilder() : state.companyState1.toBuilder()
    ..companyState2 = state.selectedCompanyIndex == 2
        ? companyReducer(state.companyState2, action).toBuilder() : state.companyState2.toBuilder()
    ..companyState3 = state.selectedCompanyIndex == 3
        ? companyReducer(state.companyState3, action).toBuilder() : state.companyState3.toBuilder()
    ..companyState4 = state.selectedCompanyIndex == 4
        ? companyReducer(state.companyState4, action).toBuilder() : state.companyState4.toBuilder()
    ..companyState5 = state.selectedCompanyIndex == 5
        ? companyReducer(state.companyState5, action).toBuilder() : state.companyState5.toBuilder()
  );
}

Reducer<int> selectedCompanyIndexReducer = combineReducers([
  TypedReducer<int, SelectCompany>(selectCompanyReducer),
]);

int selectCompanyReducer(int selectedCompanyIndex, SelectCompany action) {
  return action.companyIndex;
}