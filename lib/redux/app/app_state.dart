import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
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
import 'package:invoiceninja_flutter/ui/group/edit/group_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit_vm.dart';
// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/edit/tax_rate_edit_vm.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState({
    @required PrefState prefState,
  }) {
    return _$AppState._(
      isLoading: false,
      isSaving: false,
      isTesting: false,
      serverVersion: '',
      lastError: '',
      authState: AuthState(),
      staticState: StaticState(),
      userCompanyStates: BuiltList(
          List<int>.generate(kMaxNumberOfCompanies, (i) => i + 1)
              .map((index) => UserCompanyState())
              .toList()),
      uiState: UIState(),
      prefState: prefState ?? PrefState(),
    );
  }

  AppState._();

  bool get isLoading;

  bool get isSaving;

  bool get isTesting;

  String get lastError;

  String get serverVersion;

  AuthState get authState;

  StaticState get staticState;

  PrefState get prefState;

  UIState get uiState;

  BuiltList<UserCompanyState> get userCompanyStates;

  //factory AppState([void updates(AppStateBuilder b)]) = _$AppState;
  static Serializer<AppState> get serializer => _$appStateSerializer;

  UserCompanyState get userCompanyState =>
      userCompanyStates[uiState.selectedCompanyIndex];

  bool get isLoaded {
    return productState.isLoaded &&
        clientState.isLoaded;
  }

  CompanyEntity get company => userCompanyState.company;

  DashboardUIState get dashboardUIState => uiState.dashboardUIState;

  UserEntity get user => userCompanyState.user;

  UserCompanyEntity get userCompany => userCompanyState.userCompany;

  Credentials get credentials =>
      Credentials(token: userCompanyState.token.token, url: authState.url);

  String get accentColor =>
      prefState.companyPrefs[uiState.selectedCompanyIndex].accentColor;

  BuiltList<HistoryRecord> get historyList =>
      prefState.companyPrefs[uiState.selectedCompanyIndex].historyList;

  BuiltMap<String, SelectableEntity> getEntityMap(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productState.map;
      case EntityType.client:
        return clientState.map;
      case EntityType.invoice:
        return invoiceState.map;
      // STARTER: states switch - do not remove comment
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
      case EntityType.expenseCategory:
        // TODO move to expenseCategoryState.map
        return company.expenseCategoryMap;
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
      default:
        return null;
    }
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
      // TODO add to stater.sh
    }

    if (uiState.currentRoute.startsWith('/settings')) {
      return settingsUIState.isChanged;
    }

    if (uiState.currentRoute.endsWith('edit')) {
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
      final serverParts = serverVersion.split('.');
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

  bool get reportErrors => isHosted && authState.isAuthenticated;

  bool get isHosted => authState.isHosted ?? false;

  bool get isSelfHosted => authState.isSelfHost ?? false;

  @override
  String toString() {
    //return 'Permissions: ${uiState.userUIState.editing.userCompany.permissions}';
    //return 'Layout: ${uiState.layout}, menu: ${uiState.menuSidebarMode}, history: ${uiState.historySidebarMode}';
    //return 'Gateway: ${uiState.companyGatewayUIState.editing.feesAndLimitsMap}';
    //return 'HISTORY: ${uiState.historyList.map((history) => '${history.id}-${history.entityType}')}';
    //return 'Products: ' + productState.list.map((productId) => productState.map[productId].archivedAt).toList().join('-');
    //return 'resetCounterFrequencyId: ${settingsUIState.settings.resetCounterFrequencyId}';
    //return 'Fields: ${uiState.settingsUIState.company.customFields} - ${company.customFields}';
    //return 'Custom: ${uiState.settingsUIState.company.settings.customValue1} - ${company.settings.customValue1}';
    //return 'Platform: ${userCompany.token.token}';
    //return 'INVOICE: ${uiState.invoiceUIState.editing.invitations}';
    turn 'Route: ${uiState.currentRoute} Prev: ${uiState.previousRoute}';
  }
}

class Credentials {
  Credentials({this.url, this.token});

  String url;
  String token;
}
