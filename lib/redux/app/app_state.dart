// Dart imports:
import 'dart:ui';

// Flutter imports:

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_state.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/account_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/expense_category/edit/expense_category_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/payment_term/edit/payment_term_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/edit/recurring_expense_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_screen.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/task_status/edit/task_status_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/token/edit/token_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/edit/webhook_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_state.dart';
import 'package:invoiceninja_flutter/ui/transaction/edit/transaction_edit_vm.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_state.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit_vm.dart';
// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/schedule/schedule_state.dart';
import 'package:invoiceninja_flutter/ui/schedule/edit/schedule_edit_vm.dart';

import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_state.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/edit/transaction_rule_edit_vm.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState({
    required PrefState? prefState,
    required bool reportErrors,
    required bool isWhiteLabeled,
    String? url,
    String? referralCode,
    String? currentRoute,
  }) {
    return _$AppState._(
      isLoading: false,
      isSaving: false,
      isTesting: false,
      isWhiteLabeled: isWhiteLabeled,
      dismissedNativeWarning: false,
      lastError: '',
      authState: AuthState(
        url: url,
        referralCode: referralCode,
      ),
      staticState: StaticState(),
      userCompanyStates: BuiltList(
          List<int>.generate(kMaxNumberOfCompanies, (i) => i + 1)
              .map((index) => UserCompanyState(reportErrors))
              .toList()),
      uiState: UIState(
          currentRoute: currentRoute,
          sortFields: prefState?.sortFields ??
              BuiltMap<EntityType, PrefStateSortField>()),
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

  bool get isWhiteLabeled;

  bool get dismissedNativeWarning;

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
      list.add(companyState.company);
    }

    final companies =
        list.where((CompanyEntity company) => company.id.isNotEmpty).toList();

    return companies;
  }

  DashboardUIState get dashboardUIState => uiState.dashboardUIState;

  UserEntity get user => userCompanyState.user;

  UserCompanyEntity get userCompany => userCompanyState.userCompany;

  String get token => userCompany.token.token;

  Credentials get credentials =>
      Credentials(token: userCompanyState.token.token, url: authState.url);

  bool get hasAccentColor {
    if (isDemo) {
      return true;
    }

    final color = userCompany.settings.accentColor ?? '';

    if (color == '#ffffff' && !prefState.enableDarkMode) {
      return false;
    }

    return color.isNotEmpty;
  }

  bool get showReviewApp => !prefState.hideReviewApp && company.daysActive > 60;

  bool get showOneYearReviewApp =>
      !prefState.hideOneYearReviewApp && company.daysActive > 365;

  bool get showTwoYearReviewApp =>
      !prefState.hideTwoYearReviewApp && company.daysActive > 730;

  Color? get linkColor => prefState.enableDarkMode
      ? convertHexStringToColor('#FFFFFF')
      : accentColor;

  Color? get headerTextColor => prefState.enableDarkMode || hasAccentColor
      ? convertHexStringToColor('#FFFFFF')
      : convertHexStringToColor('#000000');

  Color? get accentColor {
    var color = userCompany.settings.accentColor ?? kDefaultAccentColor;

    if (color == '#ffffff' && !prefState.enableDarkMode) {
      color = kDefaultAccentColor;
    } else if (color == '#000000' && prefState.enableDarkMode) {
      color = kDefaultAccentColor;
    }

    return convertHexStringToColor(color);
  }

  String get appVersion {
    String version = 'v';

    version += account.currentVersion;

    if (version.isNotEmpty) {
      version += '-';
    }

    //version += isSelfHosted ? 'S' : 'H';
    version += getPlatformLetter();
    version += kClientVersion.split('.').last;

    return version;
  }

  List<HistoryRecord> get historyList =>
      prefState.companyPrefs[company.id]!.historyList.where((history) {
        final entityMap = getEntityMap(history.entityType);
        if (entityMap != null) {
          final entity = entityMap[history.id] as BaseEntity?;
          if (entity?.isDeleted == true) {
            return false;
          }
        }
        return true;
      }).toList();

  List<HistoryRecord> get unfilteredHistoryList =>
      prefState.companyPrefs[company.id]!.historyList.toList();

  bool? shouldSelectEntity(
      {EntityType? entityType, List<String?>? entityList}) {
    final entityUIState = getUIState(entityType);

    if (prefState.isMobile ||
        !prefState.isPreviewVisible ||
        uiState.isEditing ||
        (prefState.isModuleList && entityType!.hasFullWidthViewer) ||
        entityType!.isSetting ||
        (entityList!.isEmpty && (entityUIState!.selectedId ?? '').isEmpty)) {
      return false;
    }

    if ((entityUIState!.selectedId ?? '').isEmpty ||
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

  BaseEntity? getEntity(EntityType? type, String? id) {
    final map = getEntityMap(type);

    return map != null ? map[id] as BaseEntity? : null;
  }

  BuiltMap<String?, SelectableEntity?>? getEntityMap(EntityType? type) {
    switch (type) {
      case EntityType.product:
        return productState.map;
      case EntityType.client:
        return clientState.map;
      case EntityType.invoice:
        return invoiceState.map;
      // STARTER: states switch map - do not remove comment
      case EntityType.schedule:
        return scheduleState.map;
      case EntityType.transactionRule:
        return transactionRuleState.map;
      case EntityType.transaction:
        return transactionState.map;
      case EntityType.bankAccount:
        return bankAccountState.map;
      case EntityType.purchaseOrder:
        return purchaseOrderState.map;
      case EntityType.recurringExpense:
        return recurringExpenseState.map;
      case EntityType.paymentLink:
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
      case EntityType.company:
        return BuiltMap(Map<String?, SelectableEntity?>.fromIterable(
          companies,
          key: (dynamic item) => item.id,
          value: (dynamic item) => item,
        ));
      case EntityType.dashboard:
      case EntityType.reports:
      case EntityType.settings:
        return null;
      default:
        print('## ERROR: getEntityMap $type not found');
        return null;
    }
  }

  BuiltList<String>? getEntityList(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productState.list;
      case EntityType.client:
        return clientState.list;
      case EntityType.invoice:
        return invoiceState.list;
      // STARTER: states switch list - do not remove comment
      case EntityType.schedule:
        return scheduleState.list;

      case EntityType.transactionRule:
        return transactionRuleState.list;

      case EntityType.transaction:
        return transactionState.list;

      case EntityType.bankAccount:
        return bankAccountState.list;

      case EntityType.purchaseOrder:
        return purchaseOrderState.list;

      case EntityType.recurringExpense:
        return recurringExpenseState.list;

      case EntityType.paymentLink:
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
    final entityUIState = getUIState(type)!;

    return SelectionState(
      selectedId:
          entityUIState.forceSelected == true ? entityUIState.selectedId : null,
      filterEntityId: uiState.filterEntityId,
      filterEntityType: uiState.filterEntityType,
    );
  }

  EntityUIState? getUIState(EntityType? type) {
    switch (type) {
      case EntityType.product:
        return productUIState;
      case EntityType.client:
        return clientUIState;
      case EntityType.invoice:
        return invoiceUIState;
      // STARTER: states switch - do not remove comment
      case EntityType.schedule:
        return scheduleUIState;

      case EntityType.transactionRule:
        return transactionRuleUIState;

      case EntityType.transaction:
        return transactionUIState;

      case EntityType.bankAccount:
        return bankAccountUIState;

      case EntityType.purchaseOrder:
        return purchaseOrderUIState;

      case EntityType.recurringExpense:
        return recurringExpenseUIState;
      case EntityType.paymentLink:
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

  ListUIState getListState(EntityType? type) {
    return getUIState(type)!.listUIState;
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
  ScheduleState get scheduleState => userCompanyState.scheduleState;
  ListUIState get scheduleListState => uiState.scheduleUIState.listUIState;
  ScheduleUIState get scheduleUIState => uiState.scheduleUIState;

  TransactionRuleState get transactionRuleState =>
      userCompanyState.transactionRuleState;
  ListUIState get transactionRuleListState =>
      uiState.transactionRuleUIState.listUIState;
  TransactionRuleUIState get transactionRuleUIState =>
      uiState.transactionRuleUIState;

  TransactionState get transactionState => userCompanyState.transactionState;
  ListUIState get transactionListState =>
      uiState.transactionUIState.listUIState;
  TransactionUIState get transactionUIState => uiState.transactionUIState;

  BankAccountState get bankAccountState => userCompanyState.bankAccountState;
  ListUIState get bankAccountListState =>
      uiState.bankAccountUIState.listUIState;
  BankAccountUIState get bankAccountUIState => uiState.bankAccountUIState;

  PurchaseOrderState get purchaseOrderState =>
      userCompanyState.purchaseOrderState;
  ListUIState get purchaseOrderListState =>
      uiState.purchaseOrderUIState.listUIState;
  PurchaseOrderUIState get purchaseOrderUIState => uiState.purchaseOrderUIState;

  RecurringExpenseState get recurringExpenseState =>
      userCompanyState.recurringExpenseState;
  ListUIState get recurringExpenseListState =>
      uiState.recurringExpenseUIState.listUIState;
  RecurringExpenseUIState get recurringExpenseUIState =>
      uiState.recurringExpenseUIState;

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
        return clientUIState.editing!.isChanged == true;
      case ProductEditScreen.route:
        return productUIState.editing!.isChanged == true;
      case InvoiceEditScreen.route:
        return invoiceUIState.editing!.isChanged == true;
      case PaymentEditScreen.route:
        return paymentUIState.editing!.isChanged == true;
      case QuoteEditScreen.route:
        return quoteUIState.editing!.isChanged == true;
      case ProjectEditScreen.route:
        return projectUIState.editing!.isChanged == true;
      case TaskEditScreen.route:
        return taskUIState.editing!.isChanged == true;
      case VendorEditScreen.route:
        return vendorUIState.editing!.isChanged == true;
      case ExpenseEditScreen.route:
        return expenseUIState.editing!.isChanged == true;
      case GroupEditScreen.route:
        return groupUIState.editing!.isChanged == true;
      case TaxRateEditScreen.route:
        return taxRateUIState.editing!.isChanged == true;
      case CompanyGatewayEditScreen.route:
        return companyGatewayUIState.editing!.isChanged == true;
      case CreditEditScreen.route:
        return creditUIState.editing!.isChanged == true;
      // STARTER: has changes - do not remove comment
      case ScheduleEditScreen.route:
        return scheduleUIState.editing!.isChanged == true;
      case TransactionRuleEditScreen.route:
        return transactionRuleUIState.editing!.isChanged == true;
      case TransactionEditScreen.route:
        return transactionUIState.editing!.isChanged == true;
      case PurchaseOrderEditScreen.route:
        return purchaseOrderUIState.editing!.isChanged == true;
      case RecurringExpenseEditScreen.route:
        return recurringExpenseUIState.editing!.isChanged == true;
      case SubscriptionEditScreen.route:
        return subscriptionUIState.editing!.isChanged == true;
      case TaskStatusEditScreen.route:
        return taskStatusUIState.editing!.isChanged == true;
      case ExpenseCategoryEditScreen.route:
        return expenseCategoryUIState.editing!.isChanged == true;
      case RecurringInvoiceEditScreen.route:
        return recurringInvoiceUIState.editing!.isChanged == true;
      case WebhookEditScreen.route:
        return webhookUIState.editing!.isChanged == true;
      case TokenEditScreen.route:
        return tokenUIState.editing!.isChanged == true;
      case PaymentTermEditScreen.route:
        return paymentTermUIState.editing!.isChanged == true;
      case DesignEditScreen.route:
        return designUIState.editing!.isChanged == true;
      case DocumentEditScreen.route:
        return documentUIState.editing!.isChanged == true;
    }

    if (uiState.isInSettings) {
      return settingsUIState.isChanged;
    }

    if (uiState.currentRoute.endsWith('/edit')) {
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

  bool get reportErrors => account.reportErrors;

  bool get isHosted => account.isOld ? account.isHosted : authState.isHosted;

  bool get isSelfHosted => !isHosted;

  bool get isDemo => cleanApiUrl(authState.url) == kFlutterDemoUrl;

  bool get isStaging => cleanApiUrl(authState.url) == kAppStagingUrl;

  bool get isProPlan => isEnterprisePlan || account.plan == kPlanPro;

  bool get isTrial => isHosted && account.isTrial;

  bool get isEnterprisePlan => isSelfHosted || account.plan == kPlanEnterprise;

  bool get isPaidAccount => isSelfHosted
      ? (isWhiteLabeled || account.plan == kPlanWhiteLabel)
      : ((isProPlan || isEnterprisePlan) && !isTrial);

  bool get isUpdateAvailable =>
      isSelfHosted && account.isUpdateAvailable && userCompany.isAdmin;

  bool get isUsingPostmark => [
        if (isHosted) SettingsEntity.EMAIL_SENDING_METHOD_DEFAULT,
        SettingsEntity.EMAIL_SENDING_METHOD_POSTMARK,
      ].contains(company.settings.emailSendingMethod);

  bool get isUserConfirmed {
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

  bool get canAddCompany =>
      userCompany.isOwner && companies.length < 10 && !isDemo;

  bool get isMenuCollapsed {
    if (prefState.isMobile) {
      return false;
    }

    return (prefState.isFilterVisible &&
            prefState.showMenu &&
            !uiState.isInSettings &&
            uiState.filterEntityType != null) ||
        prefState.isMenuCollapsed;
  }

  bool get isFullScreen {
    bool isFullScreen = false;
    final mainRoute = '/' + uiState.mainRoute;
    final subRoute = uiState.subRoute;
    final isEdit = subRoute == 'edit';
    final isEmail = subRoute == 'email';
    final isPdf = subRoute == 'pdf';

    if (<String>[
      ClientScreen.route,
      VendorScreen.route,
      ExpenseScreen.route,
      InvoiceScreen.route,
      QuoteScreen.route,
      CreditScreen.route,
      RecurringInvoiceScreen.route,
      RecurringExpenseScreen.route,
      TaskScreen.route,
      PurchaseOrderScreen.route,
    ].contains(mainRoute)) {
      if (isEmail || isPdf) {
        isFullScreen = true;
      } else if (isEdit) {
        if (mainRoute == TaskScreen.route) {
          isFullScreen = prefState.isEditorFullScreen(EntityType.task);
        } else if (mainRoute == ClientScreen.route) {
          isFullScreen = prefState.isEditorFullScreen(EntityType.client);
        } else if (mainRoute == VendorScreen.route) {
          isFullScreen = prefState.isEditorFullScreen(EntityType.vendor);
        } else if (mainRoute == ExpenseScreen.route ||
            mainRoute == RecurringExpenseScreen.route) {
          isFullScreen = prefState.isEditorFullScreen(EntityType.expense);
        } else {
          isFullScreen = prefState.isEditorFullScreen(EntityType.invoice);
        }
      }
    }

    if (uiState.currentRoute == DesignEditScreen.route) {
      isFullScreen = true;
    } else if (uiState.currentRoute == InvoiceDesignScreen.route) {
      isFullScreen = settingsUIState.showPdfPreview;
    }

    return isFullScreen;
  }

  bool get hasRecentlyEnteredPassword {
    if (Config.DEMO_MODE) {
      return true;
    }

    if (authState.lastEnteredPasswordAt == 0) {
      return false;
    }

    final millisecondsSinceEnteredPassword =
        DateTime.now().millisecondsSinceEpoch - authState.lastEnteredPasswordAt;

    return millisecondsSinceEnteredPassword < company.passwordTimeout;
  }

  @override
  String toString() {
    final companyUpdated = userCompanyState.lastUpdated == 0
        ? 'Blank'
        : timeago.format(convertTimestampToDate(
            (userCompanyState.lastUpdated / 1000).round()));

    final staticUpdated = staticState.updatedAt == null ||
            staticState.updatedAt == 0
        ? 'Blank'
        : timeago.format(
            convertTimestampToDate((staticState.updatedAt! / 1000).round()));

    final passwordUpdated = authState.lastEnteredPasswordAt == 0
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

    /*
    var str = '\n\n\n';
    for (var userCompany in userCompanyStates) {
      //str += userCompany.company.id + ' => ' + userCompany.token.token + '\n';
      str += '## ' +
          userCompany.company.displayName +
          ' => ' +
          userCompany.clientState.list.length.toString() +
          ' ' +
          userCompany.lastUpdated.toString() +
          '\n';
    }
    return str;
    */

    return '\n\nForce: ${clientUIState.forceSelected}'
        '\n\nURL: ${authState.url}'
        '\nRoute: ${uiState.currentRoute}'
        '\nPrevious: ${uiState.previousRoute}'
        '\nPreview: ${uiState.previewStack}'
        '\nFilter: ${uiState.filterEntityType} ${uiState.filterEntityId}'
        '\nIs Loading: ${isLoading ? 'Yes' : 'No'}'
        '\nIs Saving: ${isSaving ? 'Yes' : 'No'}'
        '\nIs Loaded: ${isLoaded ? 'Yes' : 'No'}'
        '\nis Large: ${(company.isLarge) ? 'Yes' : 'No'}'
        '\nCompany: $companyUpdated${userCompanyState.isStale ? ' [S]' : ''}'
        '\nStatic: $staticUpdated${staticState.isStale ? ' [S]' : ''}'
        '\nPassword: $passwordUpdated${hasRecentlyEnteredPassword ? '' : ' [S]'}'
        '\nAccent: $hasAccentColor ${userCompany.settings.accentColor ?? ''}'
        '\n';
  }
}

class Credentials {
  const Credentials({required this.url, required this.token});

  final String url;
  final String token;
}

class SelectionState {
  const SelectionState({
    this.selectedId,
    this.filterEntityId,
    this.filterEntityType,
  });

  final String? selectedId;
  final String? filterEntityId;
  final EntityType? filterEntityType;

  @override
  bool operator ==(Object other) {
    if (other is SelectionState) {
      return selectedId == other.selectedId &&
          filterEntityId == other.filterEntityId &&
          filterEntityType == other.filterEntityType;
    }
    return false;
  }
}
