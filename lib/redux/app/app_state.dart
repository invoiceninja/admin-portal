import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
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
    String appVersion,
    bool enableDarkMode,
    String accentColor,
    bool requireAuthentication,
    bool longPressSelectionIsDefault,
    AppLayout layout,
    bool isTesting,
  }) {
    return _$AppState._(
      isLoading: false,
      isSaving: false,
      serverVersion: '',
      lastError: '',
      authState: AuthState(),
      staticState: StaticState(),
      companyState1: UserCompanyState(),
      companyState2: UserCompanyState(),
      companyState3: UserCompanyState(),
      companyState4: UserCompanyState(),
      companyState5: UserCompanyState(),
      companyState6: UserCompanyState(),
      companyState7: UserCompanyState(),
      companyState8: UserCompanyState(),
      companyState9: UserCompanyState(),
      companyState10: UserCompanyState(),
      uiState: UIState(
        CompanyEntity(),
        enableDarkMode: enableDarkMode,
        accentColor: accentColor,
        longPressSelectionIsDefault: longPressSelectionIsDefault,
        requireAuthentication: requireAuthentication,
        layout: layout ?? AppLayout.mobile,
        isTesting: isTesting,
      ),
    );
  }

  AppState._();

  bool get isLoading;

  bool get isSaving;

  String get lastError;

  String get serverVersion;

  AuthState get authState;

  StaticState get staticState;

  UIState get uiState;

  UserCompanyState get companyState1;

  UserCompanyState get companyState2;

  UserCompanyState get companyState3;

  UserCompanyState get companyState4;

  UserCompanyState get companyState5;

  UserCompanyState get companyState6;

  UserCompanyState get companyState7;

  UserCompanyState get companyState8;

  UserCompanyState get companyState9;

  UserCompanyState get companyState10;

  //factory AppState([void updates(AppStateBuilder b)]) = _$AppState;
  static Serializer<AppState> get serializer => _$appStateSerializer;

  UserCompanyState get selectedCompanyState {
    switch (uiState.selectedCompanyIndex) {
      case 1:
        return companyState1;
      case 2:
        return companyState2;
      case 3:
        return companyState3;
      case 4:
        return companyState4;
      case 5:
        return companyState5;
      case 6:
        return companyState6;
      case 7:
        return companyState7;
      case 8:
        return companyState8;
      case 9:
        return companyState9;
      case 10:
        return companyState10;
    }

    return companyState1;
  }

  bool get isLoaded {
    return dashboardState.isLoaded &&
        productState.isLoaded &&
        clientState.isLoaded;
  }

  CompanyEntity get selectedCompany => selectedCompanyState.company;

  DashboardState get dashboardState => selectedCompanyState.dashboardState;

  DashboardUIState get dashboardUIState => uiState.dashboardUIState;

  UserEntity get user => selectedCompanyState.user;

  UserCompanyEntity get userCompany => selectedCompanyState.userCompany;

  Credentials get credentials =>
      Credentials(token: selectedCompanyState.token.token, url: authState.url);

  BuiltMap<String, SelectableEntity> getEntityMap(EntityType type) {
    switch (type) {
      case EntityType.product:
        return projectState.map;
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
        return selectedCompany.expenseCategoryMap;
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

  ProductState get productState => selectedCompanyState.productState;

  ProductUIState get productUIState => uiState.productUIState;

  ListUIState get productListState => uiState.productUIState.listUIState;

  ClientState get clientState => selectedCompanyState.clientState;

  ClientUIState get clientUIState => uiState.clientUIState;

  ListUIState get clientListState => uiState.clientUIState.listUIState;

  InvoiceState get invoiceState => selectedCompanyState.invoiceState;

  InvoiceUIState get invoiceUIState => uiState.invoiceUIState;

  ListUIState get invoiceListState => uiState.invoiceUIState.listUIState;

  // STARTER: state getters - do not remove comment
  UserState get userState => selectedCompanyState.userState;

  ListUIState get userListState => uiState.userUIState.listUIState;

  UserUIState get userUIState => uiState.userUIState;

  TaxRateState get taxRateState => selectedCompanyState.taxRateState;

  ListUIState get taxRateListState => uiState.taxRateUIState.listUIState;

  TaxRateUIState get taxRateUIState => uiState.taxRateUIState;

  CompanyGatewayState get companyGatewayState =>
      selectedCompanyState.companyGatewayState;

  ListUIState get companyGatewayListState =>
      uiState.companyGatewayUIState.listUIState;

  CompanyGatewayUIState get companyGatewayUIState =>
      uiState.companyGatewayUIState;

  GroupState get groupState => selectedCompanyState.groupState;

  ListUIState get groupListState => uiState.groupUIState.listUIState;

  GroupUIState get groupUIState => uiState.groupUIState;

  DocumentState get documentState => selectedCompanyState.documentState;

  ListUIState get documentListState => uiState.documentUIState.listUIState;

  DocumentUIState get documentUIState => uiState.documentUIState;

  ExpenseState get expenseState => selectedCompanyState.expenseState;

  ListUIState get expenseListState => uiState.expenseUIState.listUIState;

  ExpenseUIState get expenseUIState => uiState.expenseUIState;

  VendorState get vendorState => selectedCompanyState.vendorState;

  ListUIState get vendorListState => uiState.vendorUIState.listUIState;

  VendorUIState get vendorUIState => uiState.vendorUIState;

  TaskState get taskState => selectedCompanyState.taskState;

  ListUIState get taskListState => uiState.taskUIState.listUIState;

  TaskUIState get taskUIState => uiState.taskUIState;

  ProjectState get projectState => selectedCompanyState.projectState;

  ListUIState get projectListState => uiState.projectUIState.listUIState;

  ProjectUIState get projectUIState => uiState.projectUIState;

  PaymentState get paymentState => selectedCompanyState.paymentState;

  ListUIState get paymentListState => uiState.paymentUIState.listUIState;

  PaymentUIState get paymentUIState => uiState.paymentUIState;

  QuoteState get quoteState => selectedCompanyState.quoteState;

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
    //return 'Custom fields [UI]: ${uiState.settingsUIState.userCompany.company.customFields}, [DB] ${selectedCompany.customFields}';
    //return 'Permissions: ${uiState.userUIState.editing.id}';
    return 'Layout: ${uiState.layout}, menu: ${uiState.menuSidebarMode}, history: ${uiState.historySidebarMode}';
    //return 'Sidebars - isMenuVisible: ${uiState.isMenuVisible}, isHistoryVisible: ${uiState.isHistoryVisible}';
    //return 'Gateway: ${uiState.companyGatewayUIState.editing.feesAndLimitsMap}';
    //return 'Routes: Current: ${uiState.currentRoute} Prev: ${uiState.previousRoute}';
    //return 'Route: ${uiState.currentRoute}, Setting Type: ${uiState.settingsUIState.entityType}, Name: ${uiState.settingsUIState.settings.name}, Updated: ${uiState.settingsUIState.updatedAt}';
    //return 'Route: ${uiState.currentRoute}, Previous: ${uiState.previousRoute}, Layout: ${uiState.layout}, Menu: ${uiState.isMenuVisible}, History: ${uiState.isHistoryVisible}';
    //return 'Route: ${uiState.currentRoute} Prev: ${uiState.previousRoute}';
  }
}

class Credentials {
  Credentials({this.url, this.token});

  String url;
  String token;
}
