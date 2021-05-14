import 'dart:io';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/account_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/redux/design/design_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/group/edit/group_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit_vm.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_selectors.dart';

import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/task_status/edit/task_status_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';

import 'package:invoiceninja_flutter/redux/expense_category/expense_category_state.dart';
import 'package:invoiceninja_flutter/ui/expense_category/edit/expense_category_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_selectors.dart';

import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_state.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';

import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';
import 'package:invoiceninja_flutter/ui/webhook/edit/webhook_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_selectors.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/ui/token/edit/token_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/token/token_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_state.dart';
import 'package:invoiceninja_flutter/ui/payment_term/edit/payment_term_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_selectors.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/edit/tax_rate_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState({
    @required PrefState prefState,
    @required bool reportErrors,
    String url,
    String currentRoute,
  }) {
    return _$AppState._(
      isLoading: false,
      isSaving: false,
      isTesting: false,
      lastError: '',
      authState: AuthState(url: url),
      staticState: StaticState(),
      userCompanyStates: BuiltList(
          List<int>.generate(kMaxNumberOfCompanies, (i) => i + 1)
              .map((index) => UserCompanyState(reportErrors))
              .toList()),
      uiState: UIState(currentRoute: currentRoute),
      prefState: prefState ?? PrefState(),
    );
  }

  AppState._();

  @override
  @memoized
  int get hashCode;

  bool get isLoading;

  bool get isSaving;

  bool get isTesting;

  String get lastError;

  AuthState get authState;

  StaticState get staticState;

  PrefState get prefState;

  UIState get uiState;

  BuiltList<UserCompanyState> get userCompanyStates;

  //factory AppState([void updates(AppStateBuilder b)]) = _$AppState;
  static Serializer<AppState> get serializer => _$appStateSerializer;

  UserCompanyState get userCompanyState =>
      userCompanyStates[uiState.selectedCompanyIndex];

  bool get isLoaded => userCompanyState.isLoaded;

  bool get isStale => userCompanyState.isStale || staticState.isStale;

  AccountEntity get account => userCompany.account;

  CompanyEntity get company => userCompanyState.company;

  List<CompanyEntity> get companies {
    final List<CompanyEntity> list = [];

    for (var companyState in userCompanyStates) {
      if (companyState.company != null) {
        list.add(companyState.company);
      }
    }

    return list
        .where((CompanyEntity company) => (company.id ?? '').isNotEmpty)
        .toList();
  }

  DashboardUIState get dashboardUIState => uiState.dashboardUIState;

  UserEntity get user => userCompanyState.user;

  UserCompanyEntity get userCompany => userCompanyState.userCompany;

  Credentials get credentials =>
      Credentials(token: userCompanyState.token.token, url: authState.url);

  bool get hasAccentColor {
    if (isDemo) {
      return true;
    }

    return userCompany?.settings?.accentColor != null;
  }

  Color get linkColor => prefState.enableDarkMode
      ? convertHexStringToColor('#FFFFFF')
      : accentColor;

  Color get headerTextColor => prefState.enableDarkMode || hasAccentColor
      ? convertHexStringToColor('#FFFFFF')
      : convertHexStringToColor('#000000');

  Color get accentColor => convertHexStringToColor(
      userCompany?.settings?.accentColor ?? kDefaultAccentColor);

  String get appVersion {
    String version = 'v';

    version += account?.currentVersion ?? '';

    if (version.isNotEmpty) {
      version += '-';
    }

    if (kIsWeb) {
      version += 'C';
    } else {
      if (Platform.isIOS) {
        version += 'I';
      } else if (Platform.isAndroid) {
        version += 'A';
      } else if (Platform.isWindows) {
        version += 'W';
      } else if (Platform.isLinux) {
        version += 'L';
      } else if (Platform.isMacOS) {
        version += 'M';
      }
    }

    version += kClientVersion.split('.').last;

    return version;
  }

  List<HistoryRecord> get historyList =>
      prefState.companyPrefs[company.id].historyList.where((history) {
        final entityMap = getEntityMap(history.entityType);
        if (entityMap != null) {
          final entity = entityMap[history.id] as BaseEntity;
          if (entity?.isDeleted == true) {
            return false;
          }
        }
        return true;
      }).toList();

  List<HistoryRecord> get unfilteredHistoryList =>
      prefState.companyPrefs[company.id].historyList.toList();

  bool shouldSelectEntity({EntityType entityType, List<String> entityList}) {
    final entityUIState = getUIState(entityType);

    if (prefState.isMobile ||
        !prefState.isPreviewEnabled ||
        (!prefState.isPreviewVisible &&
            prefState.moduleLayout == ModuleLayout.table) ||
        uiState.isEditing ||
        entityType.isSetting ||
        (entityList.isEmpty && (entityUIState.selectedId ?? '').isEmpty)) {
      return false;
    }

    if ((entityUIState.selectedId ?? '').isEmpty ||
        !entityList.contains(entityUIState.selectedId)) {
      return true;
    } else if (unfilteredHistoryList.isNotEmpty &&
        uiState.isViewing &&
        unfilteredHistoryList.first.entityType != entityType) {
      // check if this needs to be added to the history
      return null;
    }

    return false;
  }

  BaseEntity getEntity(EntityType type, String id) {
    final map = getEntityMap(type);

    return map != null ? map[id] : null;
  }

  BuiltMap<String, SelectableEntity> getEntityMap(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productState.map;
      case EntityType.client:
        return clientState.map;
      case EntityType.invoice:
        return invoiceState.map;
      // STARTER: states switch map - do not remove comment
      case EntityType.subscription:
        return subscriptionState.map;
      case EntityType.taskStatus:
        return taskStatusState.map;
      case EntityType.expenseCategory:
        return expenseCategoryState.map;
      case EntityType.recurringInvoice:
        return recurringInvoiceState.map;
      case EntityType.webhook:
        return webhookState.map;
      case EntityType.token:
        return tokenState.map;
      case EntityType.paymentTerm:
        return paymentTermState.map;
      case EntityType.design:
        return designState.map;
      case EntityType.credit:
        return creditState.map;
      case EntityType.user:
        return userState.map;
      case EntityType.taxRate:
        return taxRateState.map;
      case EntityType.companyGateway:
        return companyGatewayState.map;
      case EntityType.group:
        return groupState.map;
      case EntityType.document:
        return documentState.map;
      case EntityType.expense:
        return expenseState.map;
      case EntityType.vendor:
        return vendorState.map;
      case EntityType.task:
        return taskState.map;
      case EntityType.project:
        return projectState.map;
      case EntityType.payment:
        return paymentState.map;
      case EntityType.quote:
        return quoteState.map;
      case EntityType.paymentType:
        return staticState.paymentTypeMap;
      case EntityType.currency:
        return staticState.currencyMap;
      case EntityType.country:
        return staticState.countryMap;
      case EntityType.language:
        return staticState.languageMap;
      case EntityType.industry:
        return staticState.industryMap;
      case EntityType.size:
        return staticState.sizeMap;
      case EntityType.gateway:
        return staticState.gatewayMap;
      case EntityType.dateFormat:
        return staticState.dateFormatMap;
      case EntityType.timezone:
        return staticState.timezoneMap;
      case EntityType.dashboard:
      case EntityType.reports:
      case EntityType.settings:
        return null;
      default:
        print('Error: getEntityMap $type not found');
        return null;
    }
  }

  BuiltList<String> getEntityList(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productState.list;
      case EntityType.client:
        return clientState.list;
      case EntityType.invoice:
        return invoiceState.list;
      // STARTER: states switch list - do not remove comment
      case EntityType.subscription:
        return subscriptionState.list;

      case EntityType.taskStatus:
        return taskStatusState.list;
      case EntityType.expenseCategory:
        return expenseCategoryState.list;
      case EntityType.recurringInvoice:
        return recurringInvoiceState.list;
      case EntityType.webhook:
        return webhookState.list;
      case EntityType.token:
        return tokenState.list;
      case EntityType.paymentTerm:
        return paymentTermState.list;
      case EntityType.design:
        return designState.list;
      case EntityType.credit:
        return creditState.list;
      case EntityType.user:
        return userState.list;
      case EntityType.taxRate:
        return taxRateState.list;
      case EntityType.companyGateway:
        return companyGatewayState.list;
      case EntityType.group:
        return groupState.list;
      case EntityType.document:
        return documentState.list;
      case EntityType.expense:
        return expenseState.list;
      case EntityType.vendor:
        return vendorState.list;
      case EntityType.task:
        return taskState.list;
      case EntityType.project:
        return projectState.list;
      case EntityType.payment:
        return paymentState.list;
      case EntityType.quote:
        return quoteState.list;
      default:
        return null;
    }
  }

  SelectionState getUISelection(EntityType type) {
    final entityUIState = getUIState(type);

    return SelectionState(
      selectedId:
          entityUIState.forceSelected == true ? entityUIState.selectedId : null,
      filterEntityId: uiState.filterEntityId,
      filterEntityType: uiState.filterEntityType,
    );
  }

  EntityUIState getUIState(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productUIState;
      case EntityType.client:
        return clientUIState;
      case EntityType.invoice:
        return invoiceUIState;
      // STARTER: states switch - do not remove comment
      case EntityType.subscription:
        return subscriptionUIState;

      case EntityType.taskStatus:
        return taskStatusUIState;
      case EntityType.expenseCategory:
        return expenseCategoryUIState;
      case EntityType.recurringInvoice:
        return recurringInvoiceUIState;
      case EntityType.webhook:
        return webhookUIState;
      case EntityType.token:
        return tokenUIState;
      case EntityType.paymentTerm:
        return paymentTermUIState;
      case EntityType.design:
        return designUIState;
      case EntityType.credit:
        return creditUIState;
      case EntityType.user:
        return userUIState;
      case EntityType.taxRate:
        return taxRateUIState;
      case EntityType.companyGateway:
        return companyGatewayUIState;
      case EntityType.group:
        return groupUIState;
      case EntityType.document:
        return documentUIState;
      case EntityType.expense:
        return expenseUIState;
      case EntityType.vendor:
        return vendorUIState;
      case EntityType.task:
        return taskUIState;
      case EntityType.project:
        return projectUIState;
      case EntityType.payment:
        return paymentUIState;
      case EntityType.quote:
        return quoteUIState;
      default:
        return null;
    }
  }

  ListUIState getListState(EntityType type) {
    return getUIState(type).listUIState;
  }

  ProductState get productState => userCompanyState.productState;

  ProductUIState get productUIState => uiState.productUIState;

  ListUIState get productListState => uiState.productUIState.listUIState;

  ClientState get clientState => userCompanyState.clientState;

  ClientUIState get clientUIState => uiState.clientUIState;

  ListUIState get clientListState => uiState.clientUIState.listUIState;

  InvoiceState get invoiceState => userCompanyState.invoiceState;

  InvoiceUIState get invoiceUIState => uiState.invoiceUIState;

  ListUIState get invoiceListState => uiState.invoiceUIState.listUIState;

  // STARTER: state getters - do not remove comment
  SubscriptionState get subscriptionState => userCompanyState.subscriptionState;

  ListUIState get subscriptionListState =>
      uiState.subscriptionUIState.listUIState;

  SubscriptionUIState get subscriptionUIState => uiState.subscriptionUIState;

  TaskStatusState get taskStatusState => userCompanyState.taskStatusState;

  ListUIState get taskStatusListState => uiState.taskStatusUIState.listUIState;

  TaskStatusUIState get taskStatusUIState => uiState.taskStatusUIState;

  ExpenseCategoryState get expenseCategoryState =>
      userCompanyState.expenseCategoryState;

  ListUIState get expenseCategoryListState =>
      uiState.expenseCategoryUIState.listUIState;

  ExpenseCategoryUIState get expenseCategoryUIState =>
      uiState.expenseCategoryUIState;

  RecurringInvoiceState get recurringInvoiceState =>
      userCompanyState.recurringInvoiceState;

  ListUIState get recurringInvoiceListState =>
      uiState.recurringInvoiceUIState.listUIState;

  RecurringInvoiceUIState get recurringInvoiceUIState =>
      uiState.recurringInvoiceUIState;

  WebhookState get webhookState => userCompanyState.webhookState;

  ListUIState get webhookListState => uiState.webhookUIState.listUIState;

  WebhookUIState get webhookUIState => uiState.webhookUIState;

  TokenState get tokenState => userCompanyState.tokenState;

  ListUIState get tokenListState => uiState.tokenUIState.listUIState;

  TokenUIState get tokenUIState => uiState.tokenUIState;

  PaymentTermState get paymentTermState => userCompanyState.paymentTermState;

  ListUIState get paymentTermListState =>
      uiState.paymentTermUIState.listUIState;

  PaymentTermUIState get paymentTermUIState => uiState.paymentTermUIState;

  DesignState get designState => userCompanyState.designState;

  ListUIState get designListState => uiState.designUIState.listUIState;

  DesignUIState get designUIState => uiState.designUIState;

  CreditState get creditState => userCompanyState.creditState;

  ListUIState get creditListState => uiState.creditUIState.listUIState;

  CreditUIState get creditUIState => uiState.creditUIState;

  UserState get userState => userCompanyState.userState;

  ListUIState get userListState => uiState.userUIState.listUIState;

  UserUIState get userUIState => uiState.userUIState;

  TaxRateState get taxRateState => userCompanyState.taxRateState;

  ListUIState get taxRateListState => uiState.taxRateUIState.listUIState;

  TaxRateUIState get taxRateUIState => uiState.taxRateUIState;

  CompanyGatewayState get companyGatewayState =>
      userCompanyState.companyGatewayState;

  ListUIState get companyGatewayListState =>
      uiState.companyGatewayUIState.listUIState;

  CompanyGatewayUIState get companyGatewayUIState =>
      uiState.companyGatewayUIState;

  GroupState get groupState => userCompanyState.groupState;

  ListUIState get groupListState => uiState.groupUIState.listUIState;

  GroupUIState get groupUIState => uiState.groupUIState;

  DocumentState get documentState => userCompanyState.documentState;

  ListUIState get documentListState => uiState.documentUIState.listUIState;

  DocumentUIState get documentUIState => uiState.documentUIState;

  ExpenseState get expenseState => userCompanyState.expenseState;

  ListUIState get expenseListState => uiState.expenseUIState.listUIState;

  ExpenseUIState get expenseUIState => uiState.expenseUIState;

  VendorState get vendorState => userCompanyState.vendorState;

  ListUIState get vendorListState => uiState.vendorUIState.listUIState;

  VendorUIState get vendorUIState => uiState.vendorUIState;

  TaskState get taskState => userCompanyState.taskState;

  ListUIState get taskListState => uiState.taskUIState.listUIState;

  TaskUIState get taskUIState => uiState.taskUIState;

  ProjectState get projectState => userCompanyState.projectState;

  ListUIState get projectListState => uiState.projectUIState.listUIState;

  ProjectUIState get projectUIState => uiState.projectUIState;

  PaymentState get paymentState => userCompanyState.paymentState;

  ListUIState get paymentListState => uiState.paymentUIState.listUIState;

  PaymentUIState get paymentUIState => uiState.paymentUIState;

  QuoteState get quoteState => userCompanyState.quoteState;

  ListUIState get quoteListState => uiState.quoteUIState.listUIState;

  QuoteUIState get quoteUIState => uiState.quoteUIState;

  SettingsUIState get settingsUIState => uiState.settingsUIState;

  bool hasChanges() {
    switch (uiState.currentRoute) {
      case ClientEditScreen.route:
        return hasClientChanges(clientUIState.editing, clientState.map);
      case ProductEditScreen.route:
        return hasProductChanges(productUIState.editing, productState.map);
      case InvoiceEditScreen.route:
        return hasInvoiceChanges(invoiceUIState.editing, invoiceState.map);
      case PaymentEditScreen.route:
        return hasPaymentChanges(paymentUIState.editing, paymentState.map);
      case QuoteEditScreen.route:
        return hasQuoteChanges(quoteUIState.editing, quoteState.map);
      case ProjectEditScreen.route:
        return hasProjectChanges(projectUIState.editing, projectState.map);
      case TaskEditScreen.route:
        return hasTaskChanges(taskUIState.editing, taskState.map);
      case VendorEditScreen.route:
        return hasVendorChanges(vendorUIState.editing, vendorState.map);
      case ExpenseEditScreen.route:
        return hasExpenseChanges(expenseUIState.editing, expenseState.map);
      case GroupEditScreen.route:
        return hasGroupChanges(groupUIState.editing, groupState.map);
      case TaxRateEditScreen.route:
        return hasTaxRateChanges(taxRateUIState.editing, taxRateState.map);
      case CompanyGatewayEditScreen.route:
        return hasCompanyGatewayChanges(
            companyGatewayUIState.editing, companyGatewayState.map);
      case CreditEditScreen.route:
        return hasCreditChanges(creditUIState.editing, creditState.map);
      // STARTER: has changes - do not remove comment
      case SubscriptionEditScreen.route:
        return hasSubscriptionChanges(
            subscriptionUIState.editing, subscriptionState.map);

      case TaskStatusEditScreen.route:
        return hasTaskStatusChanges(
            taskStatusUIState.editing, taskStatusState.map);
      case ExpenseCategoryEditScreen.route:
        return hasExpenseCategoryChanges(
            expenseCategoryUIState.editing, expenseCategoryState.map);
      case RecurringInvoiceEditScreen.route:
        return hasRecurringInvoiceChanges(
            recurringInvoiceUIState.editing, recurringInvoiceState.map);
      case WebhookEditScreen.route:
        return hasWebhookChanges(webhookUIState.editing, webhookState.map);
      case TokenEditScreen.route:
        return hasTokenChanges(tokenUIState.editing, tokenState.map);
      case PaymentTermEditScreen.route:
        return hasPaymentTermChanges(
            paymentTermUIState.editing, paymentTermState.map);
      case DesignEditScreen.route:
        return hasDesignChanges(designUIState.editing, designState.map);
    }

    if (uiState.isInSettings) {
      return settingsUIState.isChanged;
    }

    if (uiState.currentRoute.endsWith('/edit') ||
        uiState.currentRoute.endsWith('_edit')) {
      throw 'AppState.hasChanges is not defined for ${uiState.currentRoute}';
    }

    return false;
  }

  bool supportsVersion(String version) {
    final parts = version.split('.');
    final int major = int.parse(parts[0]);
    final int minor = int.parse(parts[1]);
    final int patch = int.parse(parts[2]);

    try {
      final serverParts = account.currentVersion.split('.');
      final int serverMajor = int.parse(serverParts[0]);
      final int serverMinor = int.parse(serverParts[1]);
      final int serverPatch = int.parse(serverParts[2]);

      return serverMajor >= major &&
          serverMinor >= minor &&
          serverPatch >= patch;
    } catch (e) {
      return false;
    }
  }

  AppEnvironment get environment {
    if (isTesting) {
      return AppEnvironment.testing;
    } else if (isDemo) {
      return AppEnvironment.demo;
    } else if (isStaging) {
      return AppEnvironment.staging;
    } else if (isHosted) {
      return AppEnvironment.hosted;
    } else {
      return AppEnvironment.selfhosted;
    }
  }

  bool get reportErrors => account?.reportErrors ?? false;

  bool get isHosted => authState.isHosted ?? false;

  bool get isSelfHosted => authState.isSelfHost ?? false;

  bool get isDemo => cleanApiUrl(authState.url) == kAppDemoUrl;

  bool get isStaging => cleanApiUrl(authState.url) == kAppStagingUrl;

  bool get isProduction => cleanApiUrl(authState.url) == kAppProductionUrl;

  bool get isWhiteLabeled => account.plan == kPlanWhiteLabel;

  bool get isProPlan => isEnterprisePlan || account.plan == kPlanPro;

  bool get isEnterprisePlan =>
      !kReleaseMode || !isProduction || account.plan == kPlanEnterprise;

  //bool get isEnterprisePlan => isSelfHosted || account.plan == kPlanEnterprise;

  bool get isPaidAccount =>
      isSelfHosted ? isWhiteLabeled : (isProPlan || isEnterprisePlan);

  bool get isUserConfirmed {
    if (!kReleaseMode) {
      return true;
    }

    if (isSelfHosted) {
      return true;
    }

    return (user.emailVerifiedAt ?? 0) > 0;
  }

  int get createdAtLimit {
    final numberYearsActive = userCompany.settings.numberYearsActive;

    if (!company.isLarge || numberYearsActive == 0) {
      return 0;
    }

    final offset = numberYearsActive * (60 * 60 * 24 * 365);

    return (DateTime.now().millisecondsSinceEpoch / 1000).round() - offset;
  }

  bool get filterDeletedClients {
    if (!company.isLarge) {
      return false;
    }

    return !userCompany.settings.includeDeletedClients;
  }

  bool get canAddCompany => userCompany.isOwner && companies.length < 10;

  bool get isMenuCollapsed =>
      (prefState.isNotMobile &&
          prefState.showFilterSidebar &&
          prefState.showMenu &&
          !uiState.isInSettings &&
          uiState.filterEntityType != null) ||
      prefState.isMenuCollapsed;

  bool get isFullScreen {
    bool isFullScreen = false;
    final mainRoute = '/' + uiState.mainRoute;
    final subRoute = uiState.subRoute;
    final isEdit = subRoute == 'edit';
    final isEmail = subRoute == 'email';
    final isPdf = subRoute == 'pdf';

    if (<String>[
      InvoiceScreen.route,
      QuoteScreen.route,
      CreditScreen.route,
      RecurringInvoiceScreen.route,
      TaskScreen.route,
    ].contains(mainRoute)) {
      if (isEmail || isPdf) {
        isFullScreen = true;
      } else if (isEdit) {
        if (mainRoute == TaskScreen.route) {
          isFullScreen = prefState.isEditorFullScreen(EntityType.task);
        } else {
          isFullScreen = prefState.isEditorFullScreen(EntityType.invoice);
        }
      }
    }

    if (DesignEditScreen.route == uiState.currentRoute) {
      isFullScreen = true;
    }

    return isFullScreen;
  }

  @override
  String toString() {
    final companyUpdated = userCompanyState.lastUpdated == null ||
            userCompanyState.lastUpdated == 0
        ? 'Blank'
        : timeago.format(convertTimestampToDate(
            (userCompanyState.lastUpdated / 1000).round()));

    final staticUpdated =
        staticState.updatedAt == null || staticState.updatedAt == 0
            ? 'Blank'
            : timeago.format(
                convertTimestampToDate((staticState.updatedAt / 1000).round()));

    final passwordUpdated = authState.lastEnteredPasswordAt == null ||
            authState.lastEnteredPasswordAt == 0
        ? 'Blank'
        : timeago.format(convertTimestampToDate(
            (authState.lastEnteredPasswordAt / 1000).round()));

    //return 'latestVersion: ${account.latestVersion}';
    //return 'Last Updated: ${userCompanyStates.map((state) => state.lastUpdated).join(',')}';
    //return 'Names: ${userCompanyStates.map((state) => state.company.id).join(',')}';
    //return 'Client Count: ${userCompanyState.clientState.list.length}, Last Updated: ${userCompanyState.lastUpdated}';
    //return 'Token: ${credentials.token} - ${userCompanyStates.map((state) => state?.token?.token ?? '').where((name) => name.isNotEmpty).join(',')}';
    //return 'Payment Terms: ${company.settings.defaultPaymentTerms}';
    //return 'Invitations: ${uiState.invoiceUIState.editing.invitations}';
    //return 'Selection: ${clientUIState.selectedId}';
    //return '${clientState.map[clientUIState.selectedId].gatewayTokens}';
    //return 'gatewayId: ${companyGatewayState.map[companyGatewayUIState.selectedId].gatewayId}';
    //return 'Language Id: ${company.settings.languageId}';
    //return 'Rates: ${staticState.currencyMap.keys.map((key) => 'Rate: ${staticState.currencyMap[key].exchangeRate}').join(',')}';
    //return 'LOG: ${clientState.map[clientUIState.selectedId]?.systemLogs ?? ''}';
    //return 'FREQ: ${recurringInvoiceUIState.editing.frequencyId}';
    //return '## Logs: ${company.systemLogs}';

    return '';

    return '\n\nForce: ${clientUIState.forceSelected}'
        '\n\nURL: ${authState.url}'
        '\nRoute: ${uiState.currentRoute}'
        '\nPrevious: ${uiState.previousRoute}'
        '\nPreview: ${uiState.previewStack}'
        '\nFilter: ${uiState.filterEntityType} ${uiState.filterEntityId}'
        '\nIs Loaded: ${isLoaded ? 'Yes' : 'No'}'
        '\nis Large: ${(company?.isLarge ?? false) ? 'Yes' : 'No'}'
        '\nCompany: $companyUpdated${userCompanyState.isStale ? ' [S]' : ''}'
        '\nStatic: $staticUpdated${staticState.isStale ? ' [S]' : ''}'
        '\nPassword: $passwordUpdated${authState.hasRecentlyEnteredPassword ? '' : ' [S]'}'
        '\n';
  }
}

class Credentials {
  const Credentials({this.url, this.token});

  final String url;
  final String token;
}

class SelectionState {
  const SelectionState({
    this.selectedId,
    this.filterEntityId,
    this.filterEntityType,
  });

  final String selectedId;
  final String filterEntityId;
  final EntityType filterEntityType;
}
