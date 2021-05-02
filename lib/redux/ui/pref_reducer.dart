import 'dart:math';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';

import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:redux/redux.dart';

PrefState prefReducer(
    PrefState state, dynamic action, String selectedCompanyId) {
  return state.rebuild(
    (b) => b
      ..companyPrefs[selectedCompanyId] =
          companyPrefReducer(state.companyPrefs[selectedCompanyId], action)
      ..appLayout = layoutReducer(state.appLayout, action)
      ..rowsPerPage = rowsPerPageReducer(state.rowsPerPage, action)
      ..moduleLayout = moduleLayoutReducer(state.moduleLayout, action)
      ..isPreviewVisible =
          isPreviewVisibleReducer(state.isPreviewVisible, action)
      ..isPreviewEnabled =
          isPreviewEnabledReducer(state.isPreviewEnabled, action)
      ..menuSidebarMode = manuSidebarReducer(state.menuSidebarMode, action)
      ..historySidebarMode =
          historySidebarReducer(state.historySidebarMode, action)
      ..isMenuVisible = menuVisibleReducer(state.isMenuVisible, action)
      ..isHistoryVisible = historyVisibleReducer(state.isHistoryVisible, action)
      ..enableDarkMode = darkModeReducer(state.enableDarkMode, action)
      ..showKanban = showKanbanReducer(state.showKanban, action)
      ..showFilterSidebar =
          showFilterSidebarReducer(state.showFilterSidebar, action)
      ..longPressSelectionIsDefault =
          longPressReducer(state.longPressSelectionIsDefault, action)
      ..requireAuthentication =
          requireAuthenticationReducer(state.requireAuthentication, action)
      ..colorTheme = colorThemeReducer(state.colorTheme, action)
      ..useSidebarEditor
          .replace(sidebarEditorReducer(state.useSidebarEditor, action)),
  );
}

Reducer<BuiltMap<EntityType, bool>> sidebarEditorReducer = combineReducers([
  TypedReducer<BuiltMap<EntityType, bool>, ToggleEditorLayout>((value, action) {
    final entityType = action.entityType;
    if (value.containsKey(entityType)) {
      return value.rebuild((b) => b..[entityType] = !value[entityType]);
    } else {
      return value.rebuild((b) => b..[entityType] = true);
    }
  }),
]);

Reducer<bool> menuVisibleReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.sidebar == AppSidebar.menu ? !value : value;
  }),
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    switch (action.menuMode) {
      case AppSidebarMode.visible:
        return true;
      case AppSidebarMode.collapse:
      case AppSidebarMode.float:
        return false;
      default:
        return value;
    }
  }),
]);

Reducer<bool> historyVisibleReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.sidebar == AppSidebar.history ? !value : value;
  }),
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.historyMode == AppSidebarMode.visible
        ? true
        : action.historyMode == AppSidebarMode.float
            ? false
            : value;
  }),
]);

Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>((filter, action) {
    return action.filter;
  }),
]);

Reducer<int> filterClearedAtReducer = combineReducers([
  TypedReducer<int, FilterCompany>((filterClearedAt, action) {
    return action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : filterClearedAt;
  }),
]);

Reducer<AppLayout> layoutReducer = combineReducers([
  TypedReducer<AppLayout, UpdateUserPreferences>((layout, action) {
    return action.appLayout ?? layout;
  }),
]);

Reducer<ModuleLayout> moduleLayoutReducer = combineReducers([
  TypedReducer<ModuleLayout, UpdateUserPreferences>((moduleLayout, action) {
    return action.moduleLayout ?? moduleLayout;
  }),
  TypedReducer<ModuleLayout, SwitchListTableLayout>((moduleLayout, action) {
    if (moduleLayout == ModuleLayout.list) {
      return ModuleLayout.table;
    } else {
      return ModuleLayout.list;
    }
  }),
]);

Reducer<int> rowsPerPageReducer = combineReducers([
  TypedReducer<int, UpdateUserPreferences>((numRows, action) {
    return action.rowsPerPage ?? numRows;
  }),
]);

Reducer<AppSidebarMode> manuSidebarReducer = combineReducers([
  TypedReducer<AppSidebarMode, UpdateUserPreferences>((mode, action) {
    return action.menuMode ?? mode;
  }),
]);

Reducer<AppSidebarMode> historySidebarReducer = combineReducers([
  TypedReducer<AppSidebarMode, UpdateUserPreferences>((mode, action) {
    return action.historyMode ?? mode;
  }),
]);

Reducer<bool> darkModeReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((enableDarkMode, action) {
    return action.enableDarkMode ?? enableDarkMode;
  }),
]);

Reducer<bool> showKanbanReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((showKanban, action) {
    return action.showKanban ?? showKanban;
  }),
]);

Reducer<bool> showFilterSidebarReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.showFilterSidebar ?? value;
  }),
]);

Reducer<bool> longPressReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>(
      (longPressSelectionIsDefault, action) {
    return action.longPressSelectionIsDefault ?? longPressSelectionIsDefault;
  }),
]);

Reducer<bool> isPreviewVisibleReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((isPreviewVisible, action) {
    return action.isPreviewVisible ?? isPreviewVisible;
  }),
]);

Reducer<bool> isPreviewEnabledReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((isPreviewEnabled, action) {
    return action.isPreviewEnabled ?? isPreviewEnabled;
  }),
]);

Reducer<bool> requireAuthenticationReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((requireAuthentication, action) {
    return action.requireAuthentication ?? requireAuthentication;
  }),
]);

Reducer<String> colorThemeReducer = combineReducers([
  TypedReducer<String, UpdateUserPreferences>((currentColorTheme, action) {
    return action.colorTheme ?? currentColorTheme;
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

CompanyPrefState companyPrefReducer(CompanyPrefState state, dynamic action) {
  state ??= CompanyPrefState();

  return state.rebuild(
      (b) => b..historyList.replace(historyReducer(state.historyList, action)));
}

Reducer<BuiltList<HistoryRecord>> historyReducer = combineReducers([
  TypedReducer<BuiltList<HistoryRecord>, PopLastHistory>(
    (historyList, action) {
      if (historyList.isEmpty) {
        return historyList;
      } else {
        return historyList.rebuild((b) => b..removeAt(0));
      }
    },
  ),
  TypedReducer<BuiltList<HistoryRecord>, ViewDashboard>((historyList, action) =>
      _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.dashboard))),
  TypedReducer<BuiltList<HistoryRecord>, ViewReports>((historyList, action) =>
      _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.reports))),
  TypedReducer<BuiltList<HistoryRecord>, ViewSettings>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              entityType: EntityType.settings,
              id: action.section ?? kSettingsCompanyDetails))),
  TypedReducer<BuiltList<HistoryRecord>, ViewClient>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.clientId, entityType: EntityType.client))),
  TypedReducer<BuiltList<HistoryRecord>, EditClient>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.client.id, entityType: EntityType.client))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProduct>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.productId, entityType: EntityType.product))),
  TypedReducer<BuiltList<HistoryRecord>, EditProduct>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.product.id, entityType: EntityType.product))),
  TypedReducer<BuiltList<HistoryRecord>, ViewInvoice>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.invoiceId, entityType: EntityType.invoice))),
  TypedReducer<BuiltList<HistoryRecord>, EditInvoice>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.invoice.id, entityType: EntityType.invoice))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPayment>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.paymentId, entityType: EntityType.payment))),
  TypedReducer<BuiltList<HistoryRecord>, EditPayment>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.payment.id, entityType: EntityType.payment))),
  TypedReducer<BuiltList<HistoryRecord>, ViewQuote>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.quoteId, entityType: EntityType.quote))),
  TypedReducer<BuiltList<HistoryRecord>, EditQuote>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.quote.id, entityType: EntityType.quote))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTask>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.taskId, entityType: EntityType.task))),
  TypedReducer<BuiltList<HistoryRecord>, EditTask>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.task.id, entityType: EntityType.task))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProject>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.projectId, entityType: EntityType.project))),
  TypedReducer<BuiltList<HistoryRecord>, EditProject>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.project.id, entityType: EntityType.project))),
  TypedReducer<BuiltList<HistoryRecord>, ViewVendor>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.vendorId, entityType: EntityType.vendor))),
  TypedReducer<BuiltList<HistoryRecord>, EditVendor>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.vendor.id, entityType: EntityType.vendor))),
  TypedReducer<BuiltList<HistoryRecord>, ViewExpense>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.expenseId, entityType: EntityType.expense))),
  TypedReducer<BuiltList<HistoryRecord>, EditExpense>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.expense.id, entityType: EntityType.expense))),
  TypedReducer<BuiltList<HistoryRecord>, ViewCompanyGateway>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.companyGatewayId,
              entityType: EntityType.companyGateway))),
  TypedReducer<BuiltList<HistoryRecord>, EditCompanyGateway>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.companyGateway.id,
              entityType: EntityType.companyGateway))),
  TypedReducer<BuiltList<HistoryRecord>, ViewUser>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.userId, entityType: EntityType.user))),
  TypedReducer<BuiltList<HistoryRecord>, EditUser>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.user.id, entityType: EntityType.user))),
  TypedReducer<BuiltList<HistoryRecord>, ViewGroup>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.groupId, entityType: EntityType.group))),
  TypedReducer<BuiltList<HistoryRecord>, EditGroup>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.group.id, entityType: EntityType.group))),
  // STARTER: history - do not remove comment
  TypedReducer<BuiltList<HistoryRecord>, ViewSubscription>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.subscriptionId, entityType: EntityType.subscription))),
  TypedReducer<BuiltList<HistoryRecord>, EditSubscription>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.subscription.id,
              entityType: EntityType.subscription))),

  TypedReducer<BuiltList<HistoryRecord>, ViewTaskStatus>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.taskStatusId, entityType: EntityType.taskStatus))),
  TypedReducer<BuiltList<HistoryRecord>, EditTaskStatus>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.taskStatus.id, entityType: EntityType.taskStatus))),

  TypedReducer<BuiltList<HistoryRecord>, ViewExpenseCategory>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.expenseCategoryId,
              entityType: EntityType.expenseCategory))),
  TypedReducer<BuiltList<HistoryRecord>, EditExpenseCategory>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.expenseCategory.id,
              entityType: EntityType.expenseCategory))),

  TypedReducer<BuiltList<HistoryRecord>, ViewRecurringInvoice>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.recurringInvoiceId,
              entityType: EntityType.recurringInvoice))),
  TypedReducer<BuiltList<HistoryRecord>, EditRecurringInvoice>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.recurringInvoice.id,
              entityType: EntityType.recurringInvoice))),

  TypedReducer<BuiltList<HistoryRecord>, ViewWebhook>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.webhookId, entityType: EntityType.webhook))),
  TypedReducer<BuiltList<HistoryRecord>, EditWebhook>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.webhook.id, entityType: EntityType.webhook))),

  TypedReducer<BuiltList<HistoryRecord>, ViewToken>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.tokenId, entityType: EntityType.token))),
  TypedReducer<BuiltList<HistoryRecord>, EditToken>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.token.id, entityType: EntityType.token))),

  TypedReducer<BuiltList<HistoryRecord>, ViewPaymentTerm>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.paymentTermId, entityType: EntityType.paymentTerm))),
  TypedReducer<BuiltList<HistoryRecord>, EditPaymentTerm>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.paymentTerm.id, entityType: EntityType.paymentTerm))),

  TypedReducer<BuiltList<HistoryRecord>, EditDesign>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.design.id, entityType: EntityType.design))),
  TypedReducer<BuiltList<HistoryRecord>, ViewCredit>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.creditId, entityType: EntityType.credit))),
  TypedReducer<BuiltList<HistoryRecord>, EditCredit>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.credit.id, entityType: EntityType.credit))),
]);

BuiltList<HistoryRecord> _addToHistory(
    BuiltList<HistoryRecord> list, HistoryRecord record) {
  // don't track new records
  if (record.id != null && record.id.startsWith('-')) {
    return list;
  }

  if (record.entityType == EntityType.settings) {
    if ((record.id ?? '').endsWith('_edit')) {
      return list;
    }
  }

  final old =
      list.firstWhere((item) => item.matchesRecord(record), orElse: () => null);

  if (old != null) {
    return list.rebuild((b) => b
      ..remove(old)
      ..insert(0, record));
  } else {
    return list.rebuild((b) => b
      ..insert(0, record)
      ..sublist(0, min(kMaxNumberOfHistory, list.length + 1)));
  }
}
