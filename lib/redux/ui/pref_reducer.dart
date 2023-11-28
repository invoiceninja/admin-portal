// Dart imports:
import 'dart:math';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';

import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';

import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';

import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';

import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';

PrefState prefReducer(
    PrefState state, dynamic action, String selectedCompanyId) {
  return state.rebuild((b) => b
    ..companyPrefs[selectedCompanyId] =
        companyPrefReducer(state.companyPrefs[selectedCompanyId], action)
    ..appLayout = layoutReducer(state.appLayout, action)
    ..rowsPerPage = rowsPerPageReducer(state.rowsPerPage, action)
    ..moduleLayout = moduleLayoutReducer(state.moduleLayout, action)
    ..statementIncludes
        .replace(statementIncludesReducer(state.statementIncludes, action))
    ..isPreviewVisible = isPreviewVisibleReducer(state.isPreviewVisible, action)
    ..menuSidebarMode = manuSidebarReducer(state.menuSidebarMode, action)
    ..historySidebarMode =
        historySidebarReducer(state.historySidebarMode, action)
    ..hideDesktopWarning =
        hideDesktopWarningReducer(state.hideDesktopWarning, action)
    ..hideTaskExtensionBanner =
        hideTaskExtensionBannerReducer(state.hideTaskExtensionBanner, action)
    ..hideGatewayWarning =
        hideGatewayWarningReducer(state.hideGatewayWarning, action)
    ..hideReviewApp = hideReviewAppReducer(state.hideReviewApp, action)
    ..hideOneYearReviewApp =
        hideOneYearReviewAppReducer(state.hideOneYearReviewApp, action)
    ..hideTwoYearReviewApp =
        hideTwoYearReviewAppReducer(state.hideTwoYearReviewApp, action)
    ..textScaleFactor = textScaleFactorReducer(state.textScaleFactor, action)
    ..isMenuVisible = menuVisibleReducer(state.isMenuVisible, action)
    ..isHistoryVisible = historyVisibleReducer(state.isHistoryVisible, action)
    ..darkModeType = darkModeTypeReducer(state.darkModeType, action)
    ..enableDarkModeSystem =
        darkModeSystemReducer(state.enableDarkModeSystem, action)
    ..enableTooltips = enableTooltipsReducer(state.enableTooltips, action)
    ..enableFlexibleSearch =
        enableFlexibleSearchReducer(state.enableFlexibleSearch, action)
    ..enableNativeBrowser =
        enableNativeBrowserReducer(state.enableNativeBrowser, action)
    ..persistData = persistDataReducer(state.persistData, action)
    ..showKanban = showKanbanReducer(state.showKanban, action)
    ..isFilterVisible = isFilterVisibleReducer(state.isFilterVisible, action)
    ..longPressSelectionIsDefault =
        longPressReducer(state.longPressSelectionIsDefault, action)
    ..tapSelectedToEdit =
        tapSelectedToEditReducer(state.tapSelectedToEdit, action)
    ..donwloadsFolder = downloadsFolderReducer(state.donwloadsFolder, action)
    ..requireAuthentication =
        requireAuthenticationReducer(state.requireAuthentication, action)
    ..colorTheme = colorThemeReducer(state.colorTheme, action)
    ..darkColorTheme = darkColorThemeReducer(state.darkColorTheme, action)
    ..customColors.replace(customColorsReducer(state.customColors, action))
    ..darkCustomColors
        .replace(darkCustomColorsReducer(state.darkCustomColors, action))
    ..useSidebarEditor
        .replace(sidebarEditorReducer(state.useSidebarEditor, action))
    ..useSidebarViewer
        .replace(sidebarViewerReducer(state.useSidebarViewer, action))
    ..sortFields.replace(sortFieldsReducer(state.sortFields, action))
    ..editAfterSaving = editAfterSavingReducer(state.editAfterSaving, action)
    ..enableTouchEvents =
        enableTouchEventsReducer(state.enableTouchEvents, action)
    ..showPdfPreview = showPdfPreviewReducer(state.showPdfPreview, action)
    ..showPdfPreviewSideBySide = showPdfPreviewSideBySideReducer(
        state.showPdfPreviewSideBySide, action));
}

BuiltMap<EntityType, PrefStateSortField> _resortFields(
    BuiltMap<EntityType, PrefStateSortField> value,
    EntityType entityType,
    String field) {
  final sortField =
      value[entityType] ?? PrefStateSortField(field, field != 'number');
  final directon = sortField.rebuild((b) => b
    ..ascending = sortField.field != field || !sortField.ascending
    ..field = field);
  return value.rebuild((b) => b..[entityType] = directon);
}

Reducer<BuiltMap<EntityType, PrefStateSortField>> sortFieldsReducer =
    combineReducers([
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortClients>(
      (value, action) => _resortFields(value, EntityType.client, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortProducts>(
      (value, action) =>
          _resortFields(value, EntityType.product, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortInvoices>(
      (value, action) =>
          _resortFields(value, EntityType.invoice, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortPayments>(
      (value, action) =>
          _resortFields(value, EntityType.payment, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortRecurringInvoices>(
      (value, action) =>
          _resortFields(value, EntityType.recurringInvoice, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortQuotes>(
      (value, action) => _resortFields(value, EntityType.quote, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortCredits>(
      (value, action) => _resortFields(value, EntityType.credit, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortProjects>(
      (value, action) =>
          _resortFields(value, EntityType.project, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortTasks>(
      (value, action) => _resortFields(value, EntityType.task, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortVendors>(
      (value, action) => _resortFields(value, EntityType.vendor, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortExpenses>(
      (value, action) =>
          _resortFields(value, EntityType.expense, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortPaymentTerms>(
      (value, action) =>
          _resortFields(value, EntityType.payment, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortTaxRates>(
      (value, action) =>
          _resortFields(value, EntityType.taxRate, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortCompanyGateways>(
      (value, action) =>
          _resortFields(value, EntityType.companyGateway, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortUsers>(
      (value, action) => _resortFields(value, EntityType.user, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortGroups>(
      (value, action) => _resortFields(value, EntityType.group, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortDesigns>(
      (value, action) => _resortFields(value, EntityType.design, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortTokens>(
      (value, action) => _resortFields(value, EntityType.token, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortWebhooks>(
      (value, action) =>
          _resortFields(value, EntityType.webhook, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortExpenseCategories>(
      (value, action) =>
          _resortFields(value, EntityType.expenseCategory, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortTaskStatuses>(
      (value, action) =>
          _resortFields(value, EntityType.taskStatus, action.field)),
  TypedReducer<BuiltMap<EntityType, PrefStateSortField>, SortSubscriptions>(
      (value, action) =>
          _resortFields(value, EntityType.paymentLink, action.field)),
  // TODO add to starter.sh
]);

Reducer<BuiltMap<EntityType, bool>> sidebarEditorReducer = combineReducers([
  TypedReducer<BuiltMap<EntityType, bool>, ToggleEditorLayout>((value, action) {
    final entityType = action.entityType!.baseType;
    if (value.containsKey(entityType)) {
      return value.rebuild((b) => b..[entityType] = !value[entityType]!);
    } else {
      return value.rebuild((b) => b..[entityType] = true);
    }
  }),
]);

Reducer<BuiltMap<EntityType, bool>> sidebarViewerReducer = combineReducers([
  TypedReducer<BuiltMap<EntityType, bool>, ToggleViewerLayout>((value, action) {
    final entityType = action.entityType!.baseType;
    if (value.containsKey(entityType)) {
      return value.rebuild((b) => b..[entityType] = !value[entityType]!);
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

Reducer<double> textScaleFactorReducer = combineReducers([
  TypedReducer<double, UpdateUserPreferences>((value, action) {
    return action.textScaleFactor ?? value;
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

/*
Reducer<String> filterReducer = combineReducers([
  TypedReducer<String, FilterCompany>((filter, action) {
    return action.filter;
  }),
]);
*/

Reducer<bool> hideDesktopWarningReducer = combineReducers([
  TypedReducer<bool, DismissNativeWarningPermanently>((filter, action) {
    return true;
  }),
]);

Reducer<bool> hideTaskExtensionBannerReducer = combineReducers([
  TypedReducer<bool, DismissTaskExtensionBanner>((filter, action) {
    return true;
  }),
]);

Reducer<bool> hideGatewayWarningReducer = combineReducers([
  TypedReducer<bool, DismissGatewayWarningPermanently>((filter, action) {
    return true;
  }),
]);

Reducer<bool> hideReviewAppReducer = combineReducers([
  TypedReducer<bool, DismissReviewAppPermanently>((filter, action) {
    return true;
  }),
  TypedReducer<bool, DismissOneYearReviewAppPermanently>((filter, action) {
    return true;
  }),
  TypedReducer<bool, DismissTwoYearReviewAppPermanently>((filter, action) {
    return true;
  }),
]);

Reducer<bool> hideOneYearReviewAppReducer = combineReducers([
  TypedReducer<bool, DismissOneYearReviewAppPermanently>((filter, action) {
    return true;
  }),
  TypedReducer<bool, DismissTwoYearReviewAppPermanently>((filter, action) {
    return true;
  }),
]);

Reducer<bool> hideTwoYearReviewAppReducer = combineReducers([
  TypedReducer<bool, DismissTwoYearReviewAppPermanently>((filter, action) {
    return true;
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

Reducer<ModuleLayout?> moduleLayoutReducer = combineReducers([
  TypedReducer<ModuleLayout?, UpdateUserPreferences>((moduleLayout, action) {
    if (action.moduleLayout != null) {
      return action.moduleLayout;
    } else if (action.appLayout != null) {
      return (action.appLayout == AppLayout.desktop)
          ? ModuleLayout.table
          : ModuleLayout.list;
    }

    return moduleLayout;
  }),
  TypedReducer<ModuleLayout?, SwitchListTableLayout>((moduleLayout, action) {
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

Reducer<String> darkModeTypeReducer = combineReducers([
  TypedReducer<String, UpdateUserPreferences>((enableDarkMode, action) {
    return action.darkModeType ?? enableDarkMode;
  }),
]);

Reducer<bool> darkModeSystemReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((enableDarkMode, action) {
    return action.enableDarkModeSystem ?? enableDarkMode;
  }),
]);

Reducer<BuiltList<String>> statementIncludesReducer = combineReducers([
  TypedReducer<BuiltList<String>, UpdateUserPreferences>((includes, action) {
    return action.statementIncludes ?? includes;
  }),
]);

Reducer<bool> enableTooltipsReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((enableTooltips, action) {
    return action.enableTooltips ?? enableTooltips;
  }),
]);

Reducer<bool> enableFlexibleSearchReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((enableFlexibleSearch, action) {
    return action.flexibleSearch ?? enableFlexibleSearch;
  }),
]);

Reducer<bool> enableNativeBrowserReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((enableNativeBrowser, action) {
    return action.enableNativeBrowser ?? enableNativeBrowser;
  }),
]);

Reducer<bool> persistDataReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((persistData, action) {
    return action.persistData ?? persistData;
  }),
]);

Reducer<bool> showKanbanReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((showKanban, action) {
    return action.showKanban ?? showKanban;
  }),
]);

Reducer<bool> isFilterVisibleReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.isFilterVisible ?? value;
  }),
]);

Reducer<bool> longPressReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>(
      (longPressSelectionIsDefault, action) {
    return action.longPressSelectionIsDefault ?? longPressSelectionIsDefault;
  }),
]);

Reducer<bool> tapSelectedToEditReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((tapSelectedToEdit, action) {
    return action.tapSelectedToEdit ?? tapSelectedToEdit;
  }),
]);

Reducer<String> downloadsFolderReducer = combineReducers([
  TypedReducer<String, UpdateUserPreferences>((downloadsFolder, action) {
    return action.downloadsFolder ?? downloadsFolder;
  }),
]);

Reducer<bool> isPreviewVisibleReducer = combineReducers([
  TypedReducer<bool, TogglePreviewSidebar>((value, action) {
    return !value;
  }),
  TypedReducer<bool, UpdateUserPreferences>((isPreviewEnabled, action) {
    return action.isPreviewVisible ?? isPreviewEnabled;
  }),
  TypedReducer<bool, StartClientMultiselect>((value, action) => false),
  TypedReducer<bool, StartProductMultiselect>((value, action) => false),
  TypedReducer<bool, StartInvoiceMultiselect>((value, action) => false),
  TypedReducer<bool, StartRecurringInvoiceMultiselect>(
      (value, action) => false),
  TypedReducer<bool, StartPaymentMultiselect>((value, action) => false),
  TypedReducer<bool, StartQuoteMultiselect>((value, action) => false),
  TypedReducer<bool, StartCreditMultiselect>((value, action) => false),
  TypedReducer<bool, StartProjectMultiselect>((value, action) => false),
  TypedReducer<bool, StartTaskMultiselect>((value, action) => false),
  TypedReducer<bool, StartVendorMultiselect>((value, action) => false),
  TypedReducer<bool, StartPurchaseOrderMultiselect>((value, action) => false),
  TypedReducer<bool, StartExpenseMultiselect>((value, action) => false),
  TypedReducer<bool, StartRecurringExpenseMultiselect>(
      (value, action) => false),
  TypedReducer<bool, StartTransactionMultiselect>((value, action) => true),
  // TODO add to starter.sh
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

Reducer<String> darkColorThemeReducer = combineReducers([
  TypedReducer<String, UpdateUserPreferences>((currentColorTheme, action) {
    return action.darkColorTheme ?? currentColorTheme;
  }),
]);

Reducer<bool> showPdfPreviewReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.showPdfPreview ?? value;
  }),
]);

Reducer<bool> showPdfPreviewSideBySideReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.showPdfPreviewSideBySide ?? value;
  }),
]);

Reducer<bool> editAfterSavingReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.editAfterSaving ?? value;
  }),
]);

Reducer<bool> enableTouchEventsReducer = combineReducers([
  TypedReducer<bool, UpdateUserPreferences>((value, action) {
    return action.enableTouchEvents ?? value;
  }),
]);

Reducer<BuiltMap<String, String>> customColorsReducer = combineReducers([
  TypedReducer<BuiltMap<String, String>, UpdateUserPreferences>(
      (customColors, action) {
    return action.customColors ?? customColors;
  }),
]);

Reducer<BuiltMap<String, String>> darkCustomColorsReducer = combineReducers([
  TypedReducer<BuiltMap<String, String>, UpdateUserPreferences>(
      (customColors, action) {
    return action.darkCustomColors ?? customColors;
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

CompanyPrefState companyPrefReducer(CompanyPrefState? state, dynamic action) {
  state ??= CompanyPrefState();

  return state.rebuild((b) =>
      b..historyList.replace(historyReducer(state!.historyList, action)));
}

Reducer<BuiltList<HistoryRecord>> historyReducer = combineReducers([
  TypedReducer<BuiltList<HistoryRecord>, PurgeDataSuccess>(
      (historyList, action) {
    return BuiltList<HistoryRecord>();
  }),
  TypedReducer<BuiltList<HistoryRecord>, PopLastHistory>(
    (historyList, action) {
      if (historyList.isEmpty) {
        return historyList;
      } else {
        return historyList.rebuild((b) => b..removeAt(0));
      }
    },
  ),
  TypedReducer<BuiltList<HistoryRecord>, UpdateLastHistory>(
    (historyList, action) {
      if (historyList.isEmpty) {
        return historyList;
      }

      final history = historyList.first;

      return historyList.rebuild(
          (b) => b..[0] = history.rebuild((b) => b.page = action.page));
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
  TypedReducer<BuiltList<HistoryRecord>, ViewClientList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.client, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditClient>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.client.id, entityType: EntityType.client))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProduct>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.productId, entityType: EntityType.product))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProductList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.product, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditProduct>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.product.id, entityType: EntityType.product))),
  TypedReducer<BuiltList<HistoryRecord>, ViewInvoice>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.invoiceId, entityType: EntityType.invoice))),
  TypedReducer<BuiltList<HistoryRecord>, ViewInvoiceList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.invoice, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditInvoice>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.invoice!.id, entityType: EntityType.invoice))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPayment>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.paymentId, entityType: EntityType.payment))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPaymentList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.payment, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditPayment>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.payment.id, entityType: EntityType.payment))),
  TypedReducer<BuiltList<HistoryRecord>, ViewQuote>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.quoteId, entityType: EntityType.quote))),
  TypedReducer<BuiltList<HistoryRecord>, ViewQuoteList>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.quote, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditQuote>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.quote!.id, entityType: EntityType.quote))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTask>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.taskId, entityType: EntityType.task))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTaskList>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.task, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditTask>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.task!.id, entityType: EntityType.task))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProject>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.projectId, entityType: EntityType.project))),
  TypedReducer<BuiltList<HistoryRecord>, ViewProjectList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.project, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditProject>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.project.id, entityType: EntityType.project))),
  TypedReducer<BuiltList<HistoryRecord>, ViewVendor>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.vendorId, entityType: EntityType.vendor))),
  TypedReducer<BuiltList<HistoryRecord>, ViewVendorList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.vendor, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditVendor>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.vendor.id, entityType: EntityType.vendor))),
  TypedReducer<BuiltList<HistoryRecord>, ViewExpense>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.expenseId, entityType: EntityType.expense))),
  TypedReducer<BuiltList<HistoryRecord>, ViewExpenseList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.expense, page: action.page))),
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
  TypedReducer<BuiltList<HistoryRecord>, ViewCompanyGatewayList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.companyGateway))),
  TypedReducer<BuiltList<HistoryRecord>, EditCompanyGateway>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.companyGateway.id,
              entityType: EntityType.companyGateway))),
  TypedReducer<BuiltList<HistoryRecord>, ViewUser>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.userId, entityType: EntityType.user))),
  TypedReducer<BuiltList<HistoryRecord>, ViewUserList>((historyList, action) =>
      _addToHistory(historyList, HistoryRecord(entityType: EntityType.user))),
  TypedReducer<BuiltList<HistoryRecord>, EditUser>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.user.id, entityType: EntityType.user))),
  TypedReducer<BuiltList<HistoryRecord>, ViewGroup>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.groupId, entityType: EntityType.group))),
  TypedReducer<BuiltList<HistoryRecord>, ViewGroupList>((historyList, action) =>
      _addToHistory(historyList, HistoryRecord(entityType: EntityType.group))),
  TypedReducer<BuiltList<HistoryRecord>, EditGroup>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.group.id, entityType: EntityType.group))),
  // STARTER: history - do not remove comment
  TypedReducer<BuiltList<HistoryRecord>, ViewSchedule>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.scheduleId, entityType: EntityType.schedule))),
  TypedReducer<BuiltList<HistoryRecord>, ViewScheduleList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.schedule))),
  TypedReducer<BuiltList<HistoryRecord>, EditSchedule>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.schedule.id, entityType: EntityType.schedule))),

  TypedReducer<BuiltList<HistoryRecord>, ViewTransactionRule>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.transactionRuleId,
              entityType: EntityType.transactionRule))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTransactionRuleList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.transactionRule))),
  TypedReducer<BuiltList<HistoryRecord>, EditTransactionRule>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.transactionRule.id,
              entityType: EntityType.transactionRule))),

  TypedReducer<BuiltList<HistoryRecord>, ViewTransaction>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.transactionId, entityType: EntityType.transaction))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTransactionList>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              entityType: EntityType.transaction, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditTransaction>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.transaction.id, entityType: EntityType.transaction))),

  TypedReducer<BuiltList<HistoryRecord>, ViewBankAccount>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.bankAccountId, entityType: EntityType.bankAccount))),
  TypedReducer<BuiltList<HistoryRecord>, ViewBankAccountList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.bankAccount))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPurchaseOrder>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.purchaseOrderId,
              entityType: EntityType.purchaseOrder))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPurchaseOrderList>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              entityType: EntityType.purchaseOrder, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditPurchaseOrder>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.purchaseOrder.id,
              entityType: EntityType.purchaseOrder))),
  TypedReducer<BuiltList<HistoryRecord>, ViewRecurringExpense>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.recurringExpenseId,
              entityType: EntityType.recurringExpense))),
  TypedReducer<BuiltList<HistoryRecord>, ViewRecurringExpenseList>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              entityType: EntityType.recurringExpense, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditRecurringExpense>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.recurringExpense.id,
              entityType: EntityType.recurringExpense))),

  TypedReducer<BuiltList<HistoryRecord>, ViewSubscription>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.subscriptionId, entityType: EntityType.paymentLink))),
  TypedReducer<BuiltList<HistoryRecord>, ViewSubscriptionList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.paymentLink))),
  TypedReducer<BuiltList<HistoryRecord>, EditSubscription>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.subscription.id, entityType: EntityType.paymentLink))),

  TypedReducer<BuiltList<HistoryRecord>, ViewTaskStatus>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.taskStatusId, entityType: EntityType.taskStatus))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTaskStatusList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.taskStatus))),
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
  TypedReducer<BuiltList<HistoryRecord>, ViewExpenseCategoryList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.expenseCategory))),
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
  TypedReducer<BuiltList<HistoryRecord>, ViewRecurringInvoiceList>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              entityType: EntityType.recurringInvoice, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditRecurringInvoice>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.recurringInvoice.id,
              entityType: EntityType.recurringInvoice))),

  TypedReducer<BuiltList<HistoryRecord>, ViewWebhook>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.webhookId, entityType: EntityType.webhook))),
  TypedReducer<BuiltList<HistoryRecord>, ViewWebhookList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.webhook))),
  TypedReducer<BuiltList<HistoryRecord>, EditWebhook>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.webhook.id, entityType: EntityType.webhook))),
  TypedReducer<BuiltList<HistoryRecord>, ViewToken>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.tokenId, entityType: EntityType.token))),
  TypedReducer<BuiltList<HistoryRecord>, ViewTokenList>((historyList, action) =>
      _addToHistory(historyList, HistoryRecord(entityType: EntityType.token))),
  TypedReducer<BuiltList<HistoryRecord>, EditToken>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.token.id, entityType: EntityType.token))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPaymentTerm>(
      (historyList, action) => _addToHistory(
          historyList,
          HistoryRecord(
              id: action.paymentTermId, entityType: EntityType.paymentTerm))),
  TypedReducer<BuiltList<HistoryRecord>, ViewPaymentTermList>(
      (historyList, action) => _addToHistory(
          historyList, HistoryRecord(entityType: EntityType.paymentTerm))),
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
  TypedReducer<BuiltList<HistoryRecord>, ViewCreditList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.credit, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditCredit>((historyList, action) =>
      _addToHistory(historyList,
          HistoryRecord(id: action.credit!.id, entityType: EntityType.credit))),
  TypedReducer<BuiltList<HistoryRecord>, ViewDocument>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.documentId, entityType: EntityType.document))),
  TypedReducer<BuiltList<HistoryRecord>, ViewDocumentList>(
      (historyList, action) => _addToHistory(historyList,
          HistoryRecord(entityType: EntityType.document, page: action.page))),
  TypedReducer<BuiltList<HistoryRecord>, EditDocument>((historyList, action) =>
      _addToHistory(
          historyList,
          HistoryRecord(
              id: action.document!.id, entityType: EntityType.document))),
  TypedReducer<BuiltList<HistoryRecord>, FilterByEntity>((historyList, action) {
    if (action.clearSelection) {
      return historyList;
    }
    return _addToHistory(historyList,
        HistoryRecord(id: action.entityId, entityType: action.entityType!));
  }),
]);

BuiltList<HistoryRecord> _addToHistory(
    BuiltList<HistoryRecord> list, HistoryRecord record) {
  // don't track new records
  if (record.id != null && record.id!.startsWith('-')) {
    return list;
  }

  if (record.entityType == EntityType.settings) {
    if ((record.id ?? '').endsWith('/edit')) {
      return list;
    }
  }

  final old = list.firstWhereOrNull((item) => item.matchesRecord(record));

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
