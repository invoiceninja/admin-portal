import 'package:invoiceninja/redux/ui/ui_reducer.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/app/loading_reducer.dart';
import 'package:invoiceninja/redux/auth/auth_reducer.dart';
import 'package:invoiceninja/redux/company/company_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  if (action is UserLogout) {
    return AppState().rebuild((b) => b.authState.replace(state.authState));
  } else if (action is LoadStateSuccess) {
    return action.state.rebuild((b) => b.isLoading = false);
  }

  return state.rebuild((b) => b
    ..isLoading = loadingReducer(state.isLoading, action)
    ..authState.replace(authReducer(state.authState, action))
    ..companyState1.replace(state.uiState.selectedCompanyIndex == 1
        ? companyReducer(state.companyState1, action) : state.companyState1)
    ..companyState2.replace(state.uiState.selectedCompanyIndex == 2
        ? companyReducer(state.companyState2, action) : state.companyState2)
    ..companyState3.replace(state.uiState.selectedCompanyIndex == 3
        ? companyReducer(state.companyState3, action) : state.companyState3)
    ..companyState4.replace(state.uiState.selectedCompanyIndex == 4
        ? companyReducer(state.companyState4, action) : state.companyState4)
    ..companyState5.replace(state.uiState.selectedCompanyIndex == 5
        ? companyReducer(state.companyState5, action) : state.companyState5)
      ..uiState.replace(uiReducer(state.uiState, action))
  );
}
