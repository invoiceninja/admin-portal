// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_reducer.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_reducer.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja_flutter/redux/design/design_reducer.dart';
import 'package:invoiceninja_flutter/redux/document/document_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_reducer.dart';
import 'package:invoiceninja_flutter/redux/group/group_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_reducer.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_reducer.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_reducer.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_reducer.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_reducer.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_reducer.dart';
import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_reducer.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_reducer.dart';
import 'package:invoiceninja_flutter/redux/token/token_reducer.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_reducer.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_reducer.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_reducer.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/transaction/transaction_reducer.dart';

import 'package:invoiceninja_flutter/redux/bank_account/bank_account_reducer.dart';

import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_reducer.dart';

UIState uiReducer(UIState state, dynamic action) {
  final currentRoute = currentRouteReducer(state.currentRoute, action);
  return state.rebuild((b) => b
    ..filter = filterReducer(state.filter, action)
    ..filterClearedAt = filterClearedAtReducer(state.filterClearedAt, action)
    ..lastActivityAt = lastActivityReducer(state.lastActivityAt, action)
    ..selectedCompanyIndex =
        selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..previousRoute = state.currentRoute == currentRoute
        ? state.previousRoute
        : state.currentRoute.endsWith('edit')
            ? state.previousRoute
            : state.currentRoute
    ..loadingEntityType =
        loadingEntityTypeReducer(state.loadingEntityType, action)
    ..currentRoute = currentRoute
    ..previewStack.replace(previewStackReducer(state.previewStack, action))
    ..filterStack.replace(filterStackReducer(state.filterStack, action))
    ..productUIState.replace(productUIReducer(state.productUIState, action))
    ..clientUIState.replace(clientUIReducer(state.clientUIState, action))
    ..invoiceUIState.replace(invoiceUIReducer(state.invoiceUIState, action))
    ..dashboardUIState
        .replace(dashboardUIReducer(state.dashboardUIState, action))
    ..reportsUIState.replace(reportsUIReducer(state.reportsUIState, action))
    // STARTER: reducer - do not remove comment
    ..transactionUIState
        .replace(transactionUIReducer(state.transactionUIState, action))
    ..bankAccountUIState
        .replace(bankAccountUIReducer(state.bankAccountUIState, action))
    ..purchaseOrderUIState
        .replace(purchaseOrderUIReducer(state.purchaseOrderUIState, action))
    ..recurringExpenseUIState.replace(
        recurringExpenseUIReducer(state.recurringExpenseUIState, action))
    ..subscriptionUIState
        .replace(subscriptionUIReducer(state.subscriptionUIState, action))
    ..taskStatusUIState
        .replace(taskStatusUIReducer(state.taskStatusUIState, action))
    ..expenseCategoryUIState
        .replace(expenseCategoryUIReducer(state.expenseCategoryUIState, action))
    ..recurringInvoiceUIState.replace(
        recurringInvoiceUIReducer(state.recurringInvoiceUIState, action))
    ..webhookUIState.replace(webhookUIReducer(state.webhookUIState, action))
    ..tokenUIState.replace(tokenUIReducer(state.tokenUIState, action))
    ..paymentTermUIState
        .replace(paymentTermUIReducer(state.paymentTermUIState, action))
    ..designUIState.replace(designUIReducer(state.designUIState, action))
    ..creditUIState.replace(creditUIReducer(state.creditUIState, action))
    ..userUIState.replace(userUIReducer(state.userUIState, action))
    ..taxRateUIState.replace(taxRateUIReducer(state.taxRateUIState, action))
    ..companyGatewayUIState
        .replace(companyGatewayUIReducer(state.companyGatewayUIState, action))
    ..groupUIState.replace(groupUIReducer(state.groupUIState, action))
    ..documentUIState.replace(documentUIReducer(state.documentUIState, action))
    ..expenseUIState.replace(expenseUIReducer(state.expenseUIState, action))
    ..vendorUIState.replace(vendorUIReducer(state.vendorUIState, action))
    ..taskUIState.replace(taskUIReducer(state.taskUIState, action))
    ..projectUIState.replace(projectUIReducer(state.projectUIState, action))
    ..paymentUIState.replace(paymentUIReducer(state.paymentUIState, action))
    ..quoteUIState.replace(quoteUIReducer(state.quoteUIState, action))
    ..settingsUIState
        .replace(settingsUIReducer(state.settingsUIState, action)));
}

Reducer<int> lastActivityReducer = combineReducers([
  TypedReducer<int, UpdateCurrentRoute>((state, action) {
    return DateTime.now().millisecondsSinceEpoch;
  }),
]);

Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>((filter, action) {
    return action.filter;
  }),
  TypedReducer<String, ViewDashboard>((state, action) {
    return action.filter;
  }),
]);

Reducer<EntityType> loadingEntityTypeReducer = combineReducers([
  TypedReducer<EntityType, StopLoading>((state, action) {
    return null;
  }),
  TypedReducer<EntityType, LoadClientsRequest>((state, action) {
    return EntityType.client;
  }),
  TypedReducer<EntityType, LoadProductsRequest>((state, action) {
    return EntityType.product;
  }),
  TypedReducer<EntityType, LoadInvoicesRequest>((state, action) {
    return EntityType.invoice;
  }),
  TypedReducer<EntityType, LoadRecurringInvoicesRequest>((state, action) {
    return EntityType.recurringInvoice;
  }),
  TypedReducer<EntityType, LoadPaymentsRequest>((state, action) {
    return EntityType.payment;
  }),
  TypedReducer<EntityType, LoadQuotesRequest>((state, action) {
    return EntityType.quote;
  }),
  TypedReducer<EntityType, LoadCreditsRequest>((state, action) {
    return EntityType.credit;
  }),
  TypedReducer<EntityType, LoadProjectsRequest>((state, action) {
    return EntityType.project;
  }),
  TypedReducer<EntityType, LoadTasksRequest>((state, action) {
    return EntityType.task;
  }),
  TypedReducer<EntityType, LoadVendorsRequest>((state, action) {
    return EntityType.vendor;
  }),
  TypedReducer<EntityType, LoadPurchaseOrdersRequest>((state, action) {
    return EntityType.purchaseOrder;
  }),
  TypedReducer<EntityType, LoadExpensesRequest>((state, action) {
    return EntityType.expense;
  }),
  TypedReducer<EntityType, LoadRecurringExpensesRequest>((state, action) {
    return EntityType.recurringExpense;
  }),
  TypedReducer<EntityType, LoadTransactionsRequest>((state, action) {
    return EntityType.transaction;
  }),
]);

Reducer<int> filterClearedAtReducer = combineReducers([
  TypedReducer<int, FilterCompany>((filterClearedAt, action) {
    return action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : filterClearedAt;
  }),
  TypedReducer<int, ViewDashboard>((state, action) {
    return DateTime.now().millisecondsSinceEpoch;
  }),
]);

Reducer<String> currentRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>((currentRoute, action) {
    return action.route;
  }),
]);

Reducer<String> previousRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>((currentRoute, action) {
    return currentRoute;
  }),
]);

Reducer<int> selectedCompanyIndexReducer = combineReducers([
  TypedReducer<int, SelectCompany>((selectedCompanyIndex, action) {
    return action.companyIndex;
  }),
]);

Reducer<BuiltList<EntityType>> previewStackReducer = combineReducers([
  TypedReducer<BuiltList<EntityType>, PreviewEntity>((previewStack, action) {
    if (action.entityType == null) {
      return previewStack;
    }

    if (previewStack.isNotEmpty && previewStack.last == action.entityType) {
      return BuiltList(<EntityType>[]);
    }

    return BuiltList(<EntityType>[
      ...previewStack.where((entityType) => entityType != action.entityType),
      action.entityType
    ]);
  }),
  TypedReducer<BuiltList<EntityType>, ClearPreviewStack>(
      (previewStack, action) {
    return BuiltList(<EntityType>[]);
  }),
  TypedReducer<BuiltList<EntityType>, PopPreviewStack>((previewStack, action) {
    return BuiltList(
        <EntityType>[...previewStack.sublist(0, previewStack.length - 1)]);
  }),
]);

Reducer<BuiltList<BaseEntity>> filterStackReducer = combineReducers([
  TypedReducer<BuiltList<BaseEntity>, ClearEntityFilter>((filterStack, action) {
    return BuiltList<BaseEntity>();
  }),
  TypedReducer<BuiltList<BaseEntity>, FilterByEntity>((filterStack, action) {
    if (filterStack.isNotEmpty) {
      if (action.entityId == filterStack.last.id &&
          action.entityType == filterStack.last.entityType) {
        return BuiltList<BaseEntity>();
      }
    }
    return BuiltList(<BaseEntity>[
      ...filterStack.where((entity) => entity.entityType != action.entityType),
      action.entity
    ]);
  }),
  TypedReducer<BuiltList<BaseEntity>, PopFilterStack>((filterStack, action) {
    return BuiltList(
        <BaseEntity>[...filterStack.sublist(0, filterStack.length - 1)]);
  }),
]);
