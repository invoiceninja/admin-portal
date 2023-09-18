// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_state.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_state.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_state.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';
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
import 'package:invoiceninja_flutter/redux/schedule/schedule_reducer.dart';

import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_reducer.dart';

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
    ..productUIState.replace(
        productUIReducer(state.productUIState, action) as ProductUIState)
    ..clientUIState
        .replace(clientUIReducer(state.clientUIState, action) as ClientUIState)
    ..invoiceUIState.replace(
        invoiceUIReducer(state.invoiceUIState, action) as InvoiceUIState)
    ..dashboardUIState
        .replace(dashboardUIReducer(state.dashboardUIState, action))
    ..reportsUIState.replace(reportsUIReducer(state.reportsUIState, action))
    // STARTER: reducer - do not remove comment
    ..scheduleUIState.replace(
        scheduleUIReducer(state.scheduleUIState, action) as ScheduleUIState)
    ..transactionRuleUIState.replace(
        transactionRuleUIReducer(state.transactionRuleUIState, action)
            as TransactionRuleUIState)
    ..transactionUIState.replace(
        transactionUIReducer(state.transactionUIState, action)
            as TransactionUIState)
    ..bankAccountUIState.replace(
        bankAccountUIReducer(state.bankAccountUIState, action)
            as BankAccountUIState)
    ..purchaseOrderUIState.replace(
        purchaseOrderUIReducer(state.purchaseOrderUIState, action)
            as PurchaseOrderUIState)
    ..recurringExpenseUIState.replace(
        recurringExpenseUIReducer(state.recurringExpenseUIState, action)
            as RecurringExpenseUIState)
    ..subscriptionUIState.replace(
        subscriptionUIReducer(state.subscriptionUIState, action)
            as SubscriptionUIState)
    ..taskStatusUIState.replace(
        taskStatusUIReducer(state.taskStatusUIState, action)
            as TaskStatusUIState)
    ..expenseCategoryUIState.replace(
        expenseCategoryUIReducer(state.expenseCategoryUIState, action)
            as ExpenseCategoryUIState)
    ..recurringInvoiceUIState.replace(
        recurringInvoiceUIReducer(state.recurringInvoiceUIState, action)
            as RecurringInvoiceUIState)
    ..webhookUIState.replace(
        webhookUIReducer(state.webhookUIState, action) as WebhookUIState)
    ..tokenUIState
        .replace(tokenUIReducer(state.tokenUIState, action) as TokenUIState)
    ..paymentTermUIState.replace(
        paymentTermUIReducer(state.paymentTermUIState, action)
            as PaymentTermUIState)
    ..designUIState
        .replace(designUIReducer(state.designUIState, action) as DesignUIState)
    ..creditUIState
        .replace(creditUIReducer(state.creditUIState, action) as CreditUIState)
    ..userUIState
        .replace(userUIReducer(state.userUIState, action) as UserUIState)
    ..taxRateUIState.replace(
        taxRateUIReducer(state.taxRateUIState, action) as TaxRateUIState)
    ..companyGatewayUIState.replace(
        companyGatewayUIReducer(state.companyGatewayUIState, action)
            as CompanyGatewayUIState)
    ..groupUIState
        .replace(groupUIReducer(state.groupUIState, action) as GroupUIState)
    ..documentUIState.replace(
        documentUIReducer(state.documentUIState, action) as DocumentUIState)
    ..expenseUIState.replace(
        expenseUIReducer(state.expenseUIState, action) as ExpenseUIState)
    ..vendorUIState
        .replace(vendorUIReducer(state.vendorUIState, action) as VendorUIState)
    ..taskUIState
        .replace(taskUIReducer(state.taskUIState, action) as TaskUIState)
    ..projectUIState.replace(
        projectUIReducer(state.projectUIState, action) as ProjectUIState)
    ..paymentUIState.replace(
        paymentUIReducer(state.paymentUIState, action) as PaymentUIState)
    ..quoteUIState
        .replace(quoteUIReducer(state.quoteUIState, action) as QuoteUIState)
    ..settingsUIState
        .replace(settingsUIReducer(state.settingsUIState, action)));
}

Reducer<int> lastActivityReducer = combineReducers([
  TypedReducer<int, UpdateCurrentRoute>((state, action) {
    return DateTime.now().millisecondsSinceEpoch;
  }),
]);

Reducer<String?> filterReducer = combineReducers([
  TypedReducer<String?, FilterCompany>((filter, action) {
    return action.filter;
  }),
  TypedReducer<String?, ViewDashboard>((state, action) {
    return action.filter;
  }),
]);

Reducer<EntityType?> loadingEntityTypeReducer = combineReducers([
  TypedReducer<EntityType?, StopLoading>((state, action) {
    return null;
  }),
  TypedReducer<EntityType?, LoadClientsRequest>((state, action) {
    return EntityType.client;
  }),
  TypedReducer<EntityType?, LoadProductsRequest>((state, action) {
    return EntityType.product;
  }),
  TypedReducer<EntityType?, LoadInvoicesRequest>((state, action) {
    return EntityType.invoice;
  }),
  TypedReducer<EntityType?, LoadRecurringInvoicesRequest>((state, action) {
    return EntityType.recurringInvoice;
  }),
  TypedReducer<EntityType?, LoadPaymentsRequest>((state, action) {
    return EntityType.payment;
  }),
  TypedReducer<EntityType?, LoadQuotesRequest>((state, action) {
    return EntityType.quote;
  }),
  TypedReducer<EntityType?, LoadCreditsRequest>((state, action) {
    return EntityType.credit;
  }),
  TypedReducer<EntityType?, LoadProjectsRequest>((state, action) {
    return EntityType.project;
  }),
  TypedReducer<EntityType?, LoadTasksRequest>((state, action) {
    return EntityType.task;
  }),
  TypedReducer<EntityType?, LoadVendorsRequest>((state, action) {
    return EntityType.vendor;
  }),
  TypedReducer<EntityType?, LoadPurchaseOrdersRequest>((state, action) {
    return EntityType.purchaseOrder;
  }),
  TypedReducer<EntityType?, LoadExpensesRequest>((state, action) {
    return EntityType.expense;
  }),
  TypedReducer<EntityType?, LoadRecurringExpensesRequest>((state, action) {
    return EntityType.recurringExpense;
  }),
  TypedReducer<EntityType?, LoadTransactionsRequest>((state, action) {
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

    return BuiltList(<EntityType?>[
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
    return BuiltList(<BaseEntity?>[
      ...filterStack.where((entity) => entity.entityType != action.entityType),
      action.entity
    ]);
  }),
  TypedReducer<BuiltList<BaseEntity>, PopFilterStack>((filterStack, action) {
    return BuiltList(
        <BaseEntity>[...filterStack.sublist(0, filterStack.length - 1)]);
  }),
]);
