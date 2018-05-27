import 'package:redux/redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/company/company_state.dart';
import 'package:invoiceninja/redux/product/product_reducer.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';

CompanyState companyReducer(CompanyState state, action) {

  return state.rebuild((b) => b
      ..company = companyEntityReducer(state.company, action).toBuilder()
      ..dashboardState = dashboardReducer(state.dashboardState, action).toBuilder()
      ..productState = productsReducer(state.productState, action) .toBuilder()
  );
}

Reducer<CompanyEntity> companyEntityReducer = combineReducers([
  TypedReducer<CompanyEntity, LoadCompanySuccess>(loadCompanySuccessReducer),
]);

CompanyEntity loadCompanySuccessReducer(CompanyEntity company, LoadCompanySuccess action) {
  return action.company;
}