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
    company1: state.selectedCompanyId == 1
        ? companyReducer(state.company1, action) : state.company1,
    company2: state.selectedCompanyId == 2
        ? companyReducer(state.company2, action) : state.company2,
    company3: state.selectedCompanyId == 3
        ? companyReducer(state.company3, action) : state.company3,
    company4: state.selectedCompanyId == 4
        ? companyReducer(state.company4, action) : state.company4,
    company5: state.selectedCompanyId == 5
        ? companyReducer(state.company5, action) : state.company5,
  );
}

Reducer<int> selectedCompanyIdReducer = combineReducers([
  TypedReducer<int, SelectCompany>(selectCompanyReducer),
]);

int selectCompanyReducer(int selectedCompanyId, SelectCompany action) {
  return action.companyId;
}