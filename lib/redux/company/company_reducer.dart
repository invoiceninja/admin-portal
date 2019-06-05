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
import 'package:invoiceninja_flutter/redux/expense/expense_reducer.dart';

import 'package:invoiceninja_flutter/redux/vendor/vendor_reducer.dart';

import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';

import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';

import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';

import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';

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
    ..expenseState.replace(expensesReducer(state.expenseState, action))
    ..vendorState.replace(vendorsReducer(state.vendorState, action))
    ..taskState.replace(tasksReducer(state.taskState, action))
    ..projectState.replace(projectsReducer(state.projectState, action))
    ..paymentState.replace(paymentsReducer(state.paymentState, action))
    ..quoteState.replace(quotesReducer(state.quoteState, action)));
}

Reducer<CompanyEntity> companyEntityReducer = combineReducers([
  TypedReducer<CompanyEntity, LoadCompanySuccess>(loadCompanySuccessReducer),
]);

CompanyEntity loadCompanySuccessReducer(
    CompanyEntity company, LoadCompanySuccess action) {
  var company = action.company;

  if (company.taskStatuses != null) {
    company = company.rebuild((b) => b
      ..taskStatusMap.addAll(Map.fromIterable(
        company.taskStatuses,
        key: (dynamic item) => item.id,
        value: (dynamic item) => item,
      )));
  }

  if (company.expenseCategories != null) {
    company = company.rebuild((b) => b
      ..expenseCategoryMap.addAll(Map.fromIterable(
        company.expenseCategories,
        key: (dynamic item) => item.id,
        value: (dynamic item) => item,
      )));
  }

  return company;

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
