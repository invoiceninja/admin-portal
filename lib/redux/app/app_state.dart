import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit_vm.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState({
    String appVersion,
    bool enableDarkMode,
    bool requireAuthentication,
    AppLayout layout,
    bool isTesting,
  }) {
    return _$AppState._(
      isLoading: false,
      isSaving: false,
      serverVersion: '',
      authState: AuthState(),
      staticState: StaticState(),
      companyState1: CompanyState(),
      companyState2: CompanyState(),
      companyState3: CompanyState(),
      companyState4: CompanyState(),
      companyState5: CompanyState(),
      uiState: UIState(
        CompanyEntity(),
        enableDarkMode: enableDarkMode,
        requireAuthentication: requireAuthentication,
        layout: layout ?? AppLayout.mobile,
        isTesting: isTesting,
      ),
    );
  }

  AppState._();

  bool get isLoading;

  bool get isSaving;

  String get serverVersion;

  AuthState get authState;

  StaticState get staticState;

  UIState get uiState;

  CompanyState get companyState1;

  CompanyState get companyState2;

  CompanyState get companyState3;

  CompanyState get companyState4;

  CompanyState get companyState5;

  //factory AppState([void updates(AppStateBuilder b)]) = _$AppState;
  static Serializer<AppState> get serializer => _$appStateSerializer;

  CompanyState get selectedCompanyState {
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

  UserEntity get user => selectedCompany.user;

  EntityUIState getUIState(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productUIState;
      case EntityType.client:
        return clientUIState;
      case EntityType.invoice:
        return invoiceUIState;
      // STARTER: states switch - do not remove comment
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
    return 'URL: ${authState.url}, ${selectedCompany.plan}';
    //return 'Is Testing: ${uiState.isTesting}';
    //return 'Route: ${uiState.currentRoute}, Previous: ${uiState.previousRoute}, Layout: ${uiState.layout}, Menu: ${uiState.isMenuVisible}, History: ${uiState.isHistoryVisible}';
  }
}
