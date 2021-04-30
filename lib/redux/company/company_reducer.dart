import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_reducer.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_reducer.dart';
import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';
import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/subscription/subscription_reducer.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_reducer.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_reducer.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_reducer.dart';
import 'package:invoiceninja_flutter/redux/token/token_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_reducer.dart';
import 'package:invoiceninja_flutter/redux/design/design_reducer.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_reducer.dart';
import 'package:invoiceninja_flutter/redux/user/user_reducer.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_reducer.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_reducer.dart';
import 'package:invoiceninja_flutter/redux/group/group_reducer.dart';

UserCompanyState companyReducer(UserCompanyState state, dynamic action) {
  if (action is DeleteCompanySuccess) {
    return UserCompanyState(false);
  }

  return state.rebuild((b) => b
    ..lastUpdated = lastUpdatedReducer(state.lastUpdated, action)
    ..userCompany.replace(userCompanyEntityReducer(state.userCompany, action))
    ..documentState.replace(documentsReducer(state.documentState, action))
    ..clientState.replace(clientsReducer(state.clientState, action))
    ..productState.replace(productsReducer(state.productState, action))
    ..invoiceState.replace(invoicesReducer(state.invoiceState, action))
    ..expenseState.replace(expensesReducer(state.expenseState, action))
    ..vendorState.replace(vendorsReducer(state.vendorState, action))
    ..taskState.replace(tasksReducer(state.taskState, action))
    // STARTER: reducer - do not remove comment
    ..subscriptionState
        .replace(subscriptionsReducer(state.subscriptionState, action))
    ..taskStatusState
        .replace(taskStatusesReducer(state.taskStatusState, action))
    ..expenseCategoryState
        .replace(expenseCategoriesReducer(state.expenseCategoryState, action))
    ..recurringInvoiceState
        .replace(recurringInvoicesReducer(state.recurringInvoiceState, action))
    ..webhookState.replace(webhooksReducer(state.webhookState, action))
    ..tokenState.replace(tokensReducer(state.tokenState, action))
    ..paymentTermState
        .replace(paymentTermsReducer(state.paymentTermState, action))
    ..designState.replace(designsReducer(state.designState, action))
    ..creditState.replace(creditsReducer(state.creditState, action))
    ..userState.replace(usersReducer(state.userState, action))
    ..taxRateState.replace(taxRatesReducer(state.taxRateState, action))
    ..companyGatewayState
        .replace(companyGatewaysReducer(state.companyGatewayState, action))
    ..projectState.replace(projectsReducer(state.projectState, action))
    ..paymentState.replace(paymentsReducer(state.paymentState, action))
    ..quoteState.replace(quotesReducer(state.quoteState, action))
    ..groupState.replace(groupsReducer(state.groupState, action)));
}

Reducer<UserCompanyEntity> userCompanyEntityReducer = combineReducers([
  TypedReducer<UserCompanyEntity, LoadCompanySuccess>(
      loadCompanySuccessReducer),
  TypedReducer<UserCompanyEntity, SaveCompanySuccess>(
      saveCompanySuccessReducer),
  TypedReducer<UserCompanyEntity, UpdateReportSettings>((userCompany, action) {
    if (userCompany.settings.reportSettings.containsKey(action.report)) {
      final settings = userCompany.settings.reportSettings[action.report];
      return userCompany.rebuild((b) => b
        ..settings.reportSettings[action.report] = settings.rebuild((b) => b
          ..sortAscending = action.sortColumn == null
              ? settings.sortAscending
              : action.sortColumn == settings.sortColumn
                  ? !settings.sortAscending
                  : true
          ..sortTotalsAscending = action.sortTotalsIndex == null
              ? settings.sortTotalsAscending
              : action.sortTotalsIndex == settings.sortTotalsIndex
                  ? !settings.sortTotalsAscending
                  : true
          ..sortColumn = action.sortColumn ?? settings.sortColumn
          ..sortTotalsIndex =
              action.sortTotalsIndex ?? settings.sortTotalsIndex));
    } else {
      return userCompany.rebuild(
        (b) => b
          ..settings.reportSettings[action.report] = ReportSettingsEntity(
            sortColumn: action.sortColumn,
            sortTotalsIndex: action.sortTotalsIndex,
          ),
      );
    }
  }),
  TypedReducer<UserCompanyEntity, SaveAuthUserSuccess>(
    (userCompany, action) => userCompany.rebuild((b) => b
      ..user.replace(action.user)
      ..settings.replace(action.user.userCompany.settings)),
  ),
  TypedReducer<UserCompanyEntity, ConnecOAuthUserSuccess>(
    (userCompany, action) =>
        userCompany.rebuild((b) => b..user.replace(action.user)),
  ),
  TypedReducer<UserCompanyEntity, ConnecGmailUserSuccess>(
    (userCompany, action) =>
        userCompany.rebuild((b) => b..user.replace(action.user)),
  ),
  TypedReducer<UserCompanyEntity, SaveUserSettingsSuccess>(
      (userCompany, action) => userCompany
          .rebuild((b) => b..settings.replace(action.userCompany.settings))),
  TypedReducer<UserCompanyEntity, UpdateCompanyLanguage>(
    (userCompany, action) => userCompany
        .rebuild((b) => b..company.settings.languageId = action.languageId),
  ),
]);

UserCompanyEntity loadCompanySuccessReducer(
    UserCompanyEntity company, LoadCompanySuccess action) {
  var userCompany = action.userCompany;

  // Check user has a blank user settings object
  if (userCompany.settings == null) {
    userCompany = userCompany.rebuild((b) => b
      ..settings.replace(UserSettingsEntity())
      ..user
          .userCompany
          .notifications
          .replace(BuiltMap<String, BuiltList<String>>()));
  }

  userCompany = userCompany.rebuild((b) => b.company
    ..taskStatuses.replace(<TaskStatusEntity>[])
    ..taskStatusMap.replace(BuiltMap<String, TaskStatusEntity>())
    ..expenseCategories.replace(<ExpenseCategoryEntity>[]));

  /*

  return userCompany;

  if (userCompany.company.taskStatuses != null) {
    userCompany = userCompany
      ..company.rebuild((b) => b
        ..taskStatusMap.addAll(Map.fromIterable(
          userCompany.company.taskStatuses,
          key: (dynamic item) => item.id,
          value: (dynamic item) => item,
        )));
  }

  if (userCompany.company.expenseCategories != null) {
    userCompany = userCompany
      ..company.rebuild((b) => b
        ..expenseCategoryMap.addAll(Map.fromIterable(
          userCompany.company.expenseCategories,
          key: (dynamic item) => item.id,
          value: (dynamic item) => item,
        )));
  }
  */

  // clear all sub-data
  userCompany = userCompany
      .rebuild((b) => b..company.replace(userCompany.company.coreCompany));

  return userCompany;
}

UserCompanyEntity saveCompanySuccessReducer(
    UserCompanyEntity userCompany, SaveCompanySuccess action) {
  final company = action.company.rebuild((b) => b
    ..taxRates.replace(userCompany.company.taxRates)
    ..taskStatuses.replace(userCompany.company.taskStatuses)
    ..taskStatusMap.replace(userCompany.company.taskStatusMap)
    ..expenseCategories.replace(userCompany.company.expenseCategories)
    ..users.replace(userCompany.company.users));

  userCompany = userCompany.rebuild((b) => b..company.replace(company));

  return userCompany;
}

Reducer<int> lastUpdatedReducer = combineReducers([
  TypedReducer<int, LoadCompanySuccess>((state, action) {
    return action.userCompany.company.isLarge && state == 0
        ? 0
        : DateTime.now().millisecondsSinceEpoch;
  }),
  TypedReducer<int, LoadExpensesSuccess>((state, action) {
    return DateTime.now().millisecondsSinceEpoch;
  }),
]);
