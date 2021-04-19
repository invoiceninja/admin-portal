import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_reducer.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_reducer.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_reducer.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_reducer.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_reducer.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/document/document_reducer.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_reducer.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_reducer.dart';
import 'package:invoiceninja_flutter/redux/project/project_reducer.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_reducer.dart';
import 'package:invoiceninja_flutter/redux/task/task_reducer.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_reducer.dart';

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

UIState uiReducer(UIState state, dynamic action) {
  if (action is ClearEntityFilter ||
      (action is FilterByEntity &&
          action.entityType == state.filterEntityType &&
          action.entityId == state.filterEntityId)) {
    state = state.rebuild((b) => b
      ..filterEntityType = null
      ..filterEntityId = null);
  } else if (action is FilterByEntity) {
    state = state.rebuild((b) => b
      ..filterEntityType = action.entityType
      ..filterEntityId = action.entityId);
  }

  final currentRoute = currentRouteReducer(state.currentRoute, action);
  return state.rebuild((b) => b
    ..filter = filterReducer(state.filter, action)
    ..filterClearedAt = filterClearedAtReducer(state.filterClearedAt, action)
    ..filterEntityId = filterEntityIdReducer(
        state.filterEntityId, state.filterEntityType, action)
    ..selectedCompanyIndex =
        selectedCompanyIndexReducer(state.selectedCompanyIndex, action)
    ..previousRoute = state.currentRoute == currentRoute
        ? state.previousRoute
        : state.currentRoute.endsWith('edit')
            ? state.previousRoute
            : state.currentRoute
    ..currentRoute = currentRoute
    ..previewStack.replace(previewStackReducer(state.previewStack, action))
    ..productUIState.replace(productUIReducer(state.productUIState, action))
    ..clientUIState.replace(clientUIReducer(state.clientUIState, action))
    ..invoiceUIState.replace(invoiceUIReducer(state.invoiceUIState, action))
    ..dashboardUIState
        .replace(dashboardUIReducer(state.dashboardUIState, action))
    ..reportsUIState.replace(reportsUIReducer(state.reportsUIState, action))
    // STARTER: reducer - do not remove comment
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

String filterEntityIdReducer(
    String entityId, EntityType entityType, dynamic action) {
  if (action is ViewClient && entityType == EntityType.client) {
    return action.clientId;
  } else if (action is ViewInvoice && entityType == EntityType.invoice) {
    return action.invoiceId;
  } else if (action is ViewPayment && entityType == EntityType.payment) {
    return action.paymentId;
  } else if (action is ViewQuote && entityType == EntityType.quote) {
    return action.quoteId;
  } else if (action is ViewCredit && entityType == EntityType.credit) {
    return action.creditId;
  } else if (action is ViewProject && entityType == EntityType.project) {
    return action.projectId;
  } else if (action is ViewTask && entityType == EntityType.task) {
    return action.taskId;
  } else if (action is ViewVendor && entityType == EntityType.vendor) {
    return action.vendorId;
  } else if (action is ViewExpense && entityType == EntityType.expense) {
    return action.expenseId;
  } else if (action is ViewGroup && entityType == EntityType.group) {
    return action.groupId;
  } else if (action is ViewCompanyGateway &&
      entityType == EntityType.companyGateway) {
    return action.companyGatewayId;
    // TODO add to starter
  } else if (action is ViewUser && entityType == EntityType.user) {
    return action.userId;
  }

  return entityId;
}

Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>((filter, action) {
    return action.filter;
  }),
  TypedReducer<String, ViewDashboard>((state, action) {
    return action.filter;
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
