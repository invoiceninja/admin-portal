import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
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
  factory UIState(
    CompanyEntity company, {
    bool isTesting,
    bool enableDarkMode,
    String accentColor,
    bool requireAuthentication,
    bool longPressSelectionIsDefault,
    AppLayout layout,
    AppSidebarMode historySidebarMode,
    AppSidebarMode menuSidebarMode,
  }) {
    return _$UIState._(
      selectedCompanyIndex: 0,
      //layout: layout ?? AppLayout.mobile,
      layout: layout ?? AppLayout.tablet,
      historySidebarMode: historySidebarMode ??
          ((layout ?? AppLayout.tablet) == AppLayout.tablet
              ? AppSidebarMode.visible
              : AppSidebarMode.float),
      menuSidebarMode: menuSidebarMode ?? AppSidebarMode.float,
      isTesting: isTesting ?? false,
      isMenuVisible: true,
      isHistoryVisible: false,
      currentRoute: LoginScreen.route,
      previousRoute: '',
      enableDarkMode: enableDarkMode ?? false,
      requireAuthentication: requireAuthentication ?? false,
      emailPayment: false,
      autoStartTasks: false,
      longPressSelectionIsDefault: longPressSelectionIsDefault ?? false,
      addDocumentsToInvoice: false,
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

  AppLayout get layout;

  AppSidebarMode get menuSidebarMode;

  AppSidebarMode get historySidebarMode;

  bool get isTesting;

  bool get isMenuVisible;

  bool get isHistoryVisible;

  int get selectedCompanyIndex;

  String get currentRoute;

  String get previousRoute;

  bool get enableDarkMode;

  @nullable
  String get accentColor;

  bool get longPressSelectionIsDefault;

  bool get requireAuthentication;

  bool get emailPayment;

  bool get autoStartTasks;

  bool get addDocumentsToInvoice;

  @nullable
  String get filter;

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

  bool get isMenuFloated =>
      layout == AppLayout.mobile || menuSidebarMode == AppSidebarMode.float;

  bool get isHistoryFloated =>
      layout == AppLayout.mobile || historySidebarMode == AppSidebarMode.float;
}

class AppLayout extends EnumClass {
  const AppLayout._(String name) : super(name);

  static Serializer<AppLayout> get serializer => _$appLayoutSerializer;

  static const AppLayout mobile = _$mobile;
  static const AppLayout tablet = _$tablet;
  static const AppLayout desktop = _$desktop;

  static BuiltSet<AppLayout> get values => _$values;

  static AppLayout valueOf(String name) => _$valueOf(name);
}

class AppSidebar extends EnumClass {
  const AppSidebar._(String name) : super(name);

  static Serializer<AppSidebar> get serializer => _$appSidebarSerializer;
  static const AppSidebar menu = _$menu;
  static const AppSidebar history = _$history;

  static BuiltSet<AppSidebar> get values => _$valuesSidebar;

  static AppSidebar valueOf(String name) => _$valueOfSidebar(name);
}

class AppSidebarMode extends EnumClass {
  const AppSidebarMode._(String name) : super(name);

  static Serializer<AppSidebarMode> get serializer =>
      _$appSidebarModeSerializer;

  static const AppSidebarMode float = _$float;
  static const AppSidebarMode visible = _$visible;
  static const AppSidebarMode collapse = _$collapse;

  static BuiltSet<AppSidebarMode> get values => _$valuesSidebarMode;

  static AppSidebarMode valueOf(String name) => _$valueOfSidebarMode(name);
}
