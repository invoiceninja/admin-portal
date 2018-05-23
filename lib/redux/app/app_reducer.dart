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

  /*
  if (action is PersistLoadedAction<AppState>) {
    return action.state ?? state;
  } else {
    return new AppState(
      auth: authReducer(state.auth, action),
    );
  }
  */

  return AppState(
    selectedCompanyId: selectedCompanyIdReducer(state.selectedCompanyId, action),
    isLoading: loadingReducer(state.isLoading, action),
    auth: authReducer(state.auth, action),
    companyState1: state.selectedCompanyId == 1
        ? companyReducer(state.companyState1, action) : state.companyState1,
    companyState2: state.selectedCompanyId == 2
        ? companyReducer(state.companyState2, action) : state.companyState2,
    companyState3: state.selectedCompanyId == 3
        ? companyReducer(state.companyState3, action) : state.companyState3,
    companyState4: state.selectedCompanyId == 4
        ? companyReducer(state.companyState4, action) : state.companyState4,
    companyState5: state.selectedCompanyId == 5
        ? companyReducer(state.companyState5, action) : state.companyState5,
  );
}

Reducer<int> selectedCompanyIdReducer = combineReducers([
  TypedReducer<int, SelectCompany>(selectCompanyReducer),
]);

int selectCompanyReducer(int selectedCompanyId, SelectCompany action) {
  return action.companyId;
}