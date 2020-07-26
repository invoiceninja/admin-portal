import 'dart:math';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
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
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';

import 'package:invoiceninja_flutter/redux/token/token_actions.dart';

import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';

import 'package:invoiceninja_flutter/redux/design/design_actions.dart';

import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';

import 'package:redux/redux.dart';

PrefState prefReducer(
    PrefState state, dynamic action, int selectedCompanyIndex) {
  return state.rebuild((b) => b
    ..companyPrefs[selectedCompanyIndex] =
        companyPrefReducer(state.companyPrefs[selectedCompanyIndex], action)
    ..appLayout = layoutReducer(state.appLayout, action)
    ..moduleLayout = moduleLayoutReducer(state.moduleLayout, action)
    ..isPreviewVisible = isPreviewVisibleReducer(state.isPreviewVisible, action)
    ..menuSidebarMode = manuSidebarReducer(state.menuSidebarMode, action)
    ..historySidebarMode =
        historySidebarReducer(state.historySidebarMode, action)
    ..isMenuVisible = menuVisibleReducer(state.isMenuVisible, action)
    ..isHistoryVisible = historyVisibleReducer(state.isHistoryVisible, action)
    ..enableDarkMode = darkModeReducer(state.enableDarkMode, action)
    ..showFilterSidebar =
        showFilterSidebarReducer(state.showFilterSidebar, action)
    ..longPressSelectionIsDefault =
        longPressReducer(state.longPressSelectionIsDefault, action)
    ..autoStartTasks = autoStartTasksReducer(state.autoStartTasks, action)
    ..requireAuthentication =
        requireAuthenticationReducer(state.requireAuthentication, action)
    ..addDocumentsToInvoice =
        addDocumentsToInvoiceReducer(state.addDocumentsToInvoice, action));
}

Reducer<bool> menuVisibleReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>((value, action) {
    return action.sidebar == AppSidebar.menu ? !value : value;
  }),
  TypedReducer<bool, UserPreferencesChanged>((value, action) {
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
  TypedReducer<bool, UserPreferencesChanged>((value, action) {
    return action.sidebar == AppSidebar.history ? !value : value;
  }),
  TypedReducer<bool, UserPreferencesChanged>((value, action) {
    return action.historyMode == AppSidebarMode.visible
        ? true
        : action.historyMode == AppSidebarMode.float ? false : value;
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
  TypedReducer<AppLayout, UserPreferencesChanged>((layout, action) {
    return action.layout ?? layout;
  }),
]);

Reducer<ModuleLayout> moduleLayoutReducer = combineReducers([
  TypedReducer<ModuleLayout, SwitchListTableLayout>((moduleLayout, action) {
    if (moduleLayout == ModuleLayout.list) {
      return ModuleLayout.table;
    } else {
      return ModuleLayout.list;
    }
  }),
]);

Reducer<AppSidebarMode> manuSidebarReducer = combineReducers([
  TypedReducer<AppSidebarMode, UserPreferencesChanged>((mode, action) {
    return action.menuMode ?? mode;
  }),
]);

Reducer<AppSidebarMode> historySidebarReducer = combineReducers([
  TypedReducer<AppSidebarMode, UserPreferencesChanged>((mode, action) {
    return action.historyMode ?? mode;
  }),
]);

Reducer<bool> darkModeReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>((enableDarkMode, action) {
    return action.enableDarkMode ?? enableDarkMode;
  }),
]);

Reducer<bool> showFilterSidebarReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>((value, action) {
    return action.showFilterSidebar ?? value;
  }),
]);

Reducer<bool> longPressReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>(
      (longPressSelectionIsDefault, action) {
    return action.longPressSelectionIsDefault ?? longPressSelectionIsDefault;
  }),
]);

Reducer<bool> autoStartTasksReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>((autoStartTasks, action) {
    return action.autoStartTasks ?? autoStartTasks;
  }),
]);

Reducer<bool> isPreviewVisibleReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>((isPreviewVisible, action) {
    return action.isPreviewVisible ?? isPreviewVisible;
  }),
]);

Reducer<bool> addDocumentsToInvoiceReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>((addDocumentsToInvoice, action) {
    return action.addDocumentsToInvoice ?? addDocumentsToInvoice;
  }),
]);

Reducer<bool> requireAuthenticationReducer = combineReducers([
  TypedReducer<bool, UserPreferencesChanged>((requireAuthentication, action) {
    return action.requireAuthentication ?? requireAuthentication;
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

Reducer<SettingsUIState> settingsUIReducer = combineReducers([
  TypedReducer<SettingsUIState, ViewSettings>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company ?? state.company)
      ..origCompany.replace(action.company ?? state.origCompany)
      ..group.replace(action.group ?? state.group)
      ..origGroup.replace(action.group ?? state.origGroup)
      ..client.replace(action.client ?? state.client)
      ..origClient.replace(action.client ?? state.origClient)
      ..user.replace(action.user ?? state.user)
      ..origUser.replace(action.user ?? state.origUser)
      ..updatedAt = DateTime.now().millisecondsSinceEpoch
      ..section = action.section ?? state.section
      ..isChanged = false
      ..entityType = action.client != null
          ? EntityType.client
          : action.group != null ? EntityType.group : state.entityType);
  }),
  TypedReducer<SettingsUIState, UpdateCompany>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company)
      ..isChanged = true);
  }),
  TypedReducer<SettingsUIState, UpdateSettings>((state, action) {
    switch (state.entityType) {
      case EntityType.client:
        return state.rebuild((b) => b
          ..client.settings.replace(action.settings)
          ..isChanged = true);
      case EntityType.group:
        return state.rebuild((b) => b
          ..group.settings.replace(action.settings)
          ..isChanged = true);
      default:
        return state.rebuild((b) => b
          ..company.settings.replace(action.settings)
          ..isChanged = true);
    }
  }),
  TypedReducer<SettingsUIState, UpdateUserSettings>((state, action) {
    return state.rebuild((b) => b
      ..user.replace(action.user)
      ..isChanged = true);
  }),
  TypedReducer<SettingsUIState, ResetSettings>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(state.origCompany)
      ..group.replace(state.origGroup)
      ..client.replace(state.origClient)
      ..user.replace(state.origUser)
      ..isChanged = false
      ..updatedAt = DateTime.now().millisecondsSinceEpoch);
  }),
  TypedReducer<SettingsUIState, SaveCompanySuccess>((state, action) {
    return state.rebuild((b) => b
      ..company.replace(action.company)
      ..origCompany.replace(action.company)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveGroupSuccess>((state, action) {
    return state.rebuild((b) => b
      ..group.replace(action.group)
      ..origGroup.replace(action.group)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveClientSuccess>((state, action) {
    return state.rebuild((b) => b
      ..client.replace(action.client)
      ..origClient.replace(action.client)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, SaveAuthUserSuccess>((state, action) {
    return state.rebuild((b) => b
      ..user.replace(action.user)
      ..origUser.replace(action.user)
      ..isChanged = false);
  }),
  TypedReducer<SettingsUIState, FilterSettings>((state, action) {
    return state.rebuild((b) => b
      ..filter = action.filter
      ..filterClearedAt = action.filter == null
          ? DateTime.now().millisecondsSinceEpoch
          : state.filterClearedAt);
  }),
  TypedReducer<SettingsUIState, ClearSettingsFilter>((state, action) {
    return state.rebuild((b) => b
      ..updatedAt = DateTime.now().millisecondsSinceEpoch
      ..company.replace(state.company)
      ..entityType = EntityType.company
      ..isChanged = false);
  }),
]);

CompanyPrefState companyPrefReducer(CompanyPrefState state, dynamic action) {
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
