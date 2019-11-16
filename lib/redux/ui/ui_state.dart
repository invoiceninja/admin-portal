import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  factory UIState({
    bool isTesting,
    PrefState prefState,
  }) {
    return _$UIState._(
      prefState: prefState ?? PrefState(),
      selectedCompanyIndex: 0,
      filterClearedAt: 0,
      isTesting: isTesting ?? false,
      currentRoute: LoginScreen.route,
      previousRoute: '',
      dashboardUIState: DashboardUIState(),
      productUIState: ProductUIState(),
      clientUIState: ClientUIState(),
      invoiceUIState: InvoiceUIState(),
      // STARTER: constructor - do not remove comment
      userUIState: UserUIState(),
      taxRateUIState: TaxRateUIState(),
      companyGatewayUIState: CompanyGatewayUIState(),
      groupUIState: GroupUIState(),
      documentUIState: DocumentUIState(),
      expenseUIState: ExpenseUIState(),
      vendorUIState: VendorUIState(),
      taskUIState: TaskUIState(),
      projectUIState: ProjectUIState(),
      paymentUIState: PaymentUIState(),
      quoteUIState: QuoteUIState(),
      settingsUIState: SettingsUIState(),
    );
  }

  UIState._();

  PrefState get prefState;

  bool get isTesting;

  int get selectedCompanyIndex;

  String get currentRoute;

  String get previousRoute;

  @nullable
  String get filter;

  int get filterClearedAt;

  DashboardUIState get dashboardUIState;

  ProductUIState get productUIState;

  ClientUIState get clientUIState;

  InvoiceUIState get invoiceUIState;

  // STARTER: properties - do not remove comment
  UserUIState get userUIState;

  TaxRateUIState get taxRateUIState;

  CompanyGatewayUIState get companyGatewayUIState;

  GroupUIState get groupUIState;

  DocumentUIState get documentUIState;

  ExpenseUIState get expenseUIState;

  VendorUIState get vendorUIState;

  TaskUIState get taskUIState;

  ProjectUIState get projectUIState;

  PaymentUIState get paymentUIState;

  QuoteUIState get quoteUIState;

  SettingsUIState get settingsUIState;

  static Serializer<UIState> get serializer => _$uIStateSerializer;

  bool containsRoute(String route) {
    if (route == null || route.isEmpty) {
      return false;
    }
    return currentRoute.contains(route);
  }

  String get mainRoute {
    final parts =
        currentRoute.split('/').where((part) => part.isNotEmpty).toList();
    return parts.isNotEmpty ? parts[0] : '';
  }

  String get subRoute {
    final parts =
        currentRoute.split('/').where((part) => part.isNotEmpty).toList();
    return parts.length > 1 ? parts[1] : '';
  }

  String get previousSubRoute {
    final parts =
        previousRoute.split('/').where((part) => part.isNotEmpty).toList();
    return parts.length > 1 ? parts[1] : '';
  }

  bool get isEditing => currentRoute.endsWith('edit');

  AppLayout get layout => prefState.layout;

  AppSidebarMode get historySidebarMode => prefState.historySidebarMode;

  AppSidebarMode get menuSidebarMode => prefState.menuSidebarMode;

  bool get isMenuVisible => prefState.isMenuVisible;

  bool get isHistoryVisible => prefState.isHistoryVisible;

  bool get enableDarkMode => prefState.enableDarkMode;

  bool get longPressSelectionIsDefault => prefState.longPressSelectionIsDefault;

  bool get requireAuthentication => prefState.requireAuthentication;

  bool get emailPayment => prefState.emailPayment;

  bool get autoStartTasks => prefState.autoStartTasks;

  bool get addDocumentsToInvoice => prefState.addDocumentsToInvoice;

  CompanyPrefState get companyPrefState => prefState.companyPrefs[selectedCompanyIndex];

  String get accentColor => companyPrefState.accentColor;

  BuiltList<HistoryRecord> get historyList => companyPrefState.historyList;

  bool get isMenuFloated =>
      layout == AppLayout.mobile || prefState.menuSidebarMode == AppSidebarMode.float;

  bool get isHistoryFloated =>
      layout == AppLayout.mobile || prefState.historySidebarMode == AppSidebarMode.float;

}

