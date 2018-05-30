import 'package:invoiceninja/redux/app/ui_reducer.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/app/loading_reducer.dart';
import 'package:invoiceninja/redux/auth/auth_reducer.dart';
import 'package:invoiceninja/redux/company/company_reducer.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  if (action is UserLogout) {
    return AppState();
  }

  return state.rebuild((b) => b
    ..selectedCompanyIndex = selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..isLoading = loadingReducer(state.isLoading, action)
    ..authState.replace(authReducer(state.authState, action))
    ..companyState1.replace(state.selectedCompanyIndex == 1
        ? companyReducer(state.companyState1, action) : state.companyState1)
    ..companyState2.replace(state.selectedCompanyIndex == 2
        ? companyReducer(state.companyState2, action) : state.companyState2)
    ..companyState3.replace(state.selectedCompanyIndex == 3
        ? companyReducer(state.companyState3, action) : state.companyState3)
    ..companyState4.replace(state.selectedCompanyIndex == 4
        ? companyReducer(state.companyState4, action) : state.companyState4)
    ..companyState5.replace(state.selectedCompanyIndex == 5
        ? companyReducer(state.companyState5, action) : state.companyState5)
      ..uiState.replace(uiReducer(state.uiState, action))
  );
}

Reducer<int> selectedCompanyIndexReducer = combineReducers([
  TypedReducer<int, SelectCompany>(selectCompanyReducer),
]);

int selectCompanyReducer(int selectedCompanyIndex, SelectCompany action) {
  return action.companyIndex;
}