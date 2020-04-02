import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/design/design_state.dart';

import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';

import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  factory UIState({String currentRoute}) {
    return _$UIState._(
      selectedCompanyIndex: 0,
      filterClearedAt: 0,
      currentRoute: currentRoute ?? LoginScreen.route,
      previousRoute: '',
      dashboardUIState: DashboardUIState(),
      productUIState: ProductUIState(),
      clientUIState: ClientUIState(),
      invoiceUIState: InvoiceUIState(),
      // STARTER: constructor - do not remove comment
      designUIState: DesignUIState(),
      creditUIState: CreditUIState(),
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
      reportsUIState: ReportsUIState(),
    );
  }

  UIState._();

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
  DesignUIState get designUIState;

  CreditUIState get creditUIState;

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

  ReportsUIState get reportsUIState;

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

  bool get isEditing =>
      currentRoute.endsWith('edit') || currentRoute.endsWith('refund');

  bool get isInSettings => currentRoute.contains('settings');
}
