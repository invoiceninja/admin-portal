import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
// STARTER: import - do not remove comment

CompanyState companyReducer(CompanyState state, dynamic action) {
  if (action is RefreshData) {
    return CompanyState();
  }

  return state.rebuild((b) => b
      ..company.replace(companyEntityReducer(state.company, action))
      ..clientState.replace(clientsReducer(state.clientState, action))
      ..dashboardState.replace(dashboardReducer(state.dashboardState, action))
      ..productState.replace(productsReducer(state.productState, action))
      ..invoiceState.replace(invoicesReducer(state.invoiceState, action))
      // STARTER: reducer - do not remove comment
  );
}

Reducer<CompanyEntity> companyEntityReducer = combineReducers([
  TypedReducer<CompanyEntity, LoadCompanySuccess>(loadCompanySuccessReducer),
]);

CompanyEntity loadCompanySuccessReducer(CompanyEntity company, LoadCompanySuccess action) {
  return action.company;

  /*
  return action.company.rebuild((b) => b
    ..userMap.addAll(Map.fromIterable(
      action.company.users,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
  );
  */
}