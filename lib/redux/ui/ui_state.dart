// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
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
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_state.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/schedule/schedule_state.dart';

import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_state.dart';

import 'package:invoiceninja_flutter/redux/transaction/transaction_state.dart';

import 'package:invoiceninja_flutter/redux/bank_account/bank_account_state.dart';

import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  factory UIState({
    String? currentRoute,
    required BuiltMap<EntityType, PrefStateSortField> sortFields,
  }) {
    return _$UIState._(
      selectedCompanyIndex: 0,
      filterClearedAt: 0,
      lastActivityAt: 0,
      currentRoute: currentRoute ?? LoginScreen.route,
      previousRoute: '',
      previewStack: BuiltList<EntityType>(),
      filterStack: BuiltList<BaseEntity>(),
      dashboardUIState: DashboardUIState(),
      settingsUIState: SettingsUIState(),
      reportsUIState: ReportsUIState(),
      productUIState: ProductUIState(sortFields[EntityType.product]),
      clientUIState: ClientUIState(sortFields[EntityType.client]),
      invoiceUIState: InvoiceUIState(sortFields[EntityType.invoice]),
      subscriptionUIState:
          SubscriptionUIState(sortFields[EntityType.paymentLink]),
      taskStatusUIState: TaskStatusUIState(sortFields[EntityType.taskStatus]),
      expenseCategoryUIState:
          ExpenseCategoryUIState(sortFields[EntityType.expenseCategory]),
      recurringInvoiceUIState:
          RecurringInvoiceUIState(sortFields[EntityType.recurringInvoice]),
      webhookUIState: WebhookUIState(sortFields[EntityType.webhook]),
      tokenUIState: TokenUIState(sortFields[EntityType.token]),
      paymentTermUIState:
          PaymentTermUIState(sortFields[EntityType.paymentTerm]),
      designUIState: DesignUIState(sortFields[EntityType.design]),
      creditUIState: CreditUIState(sortFields[EntityType.credit]),
      userUIState: UserUIState(sortFields[EntityType.user]),
      taxRateUIState: TaxRateUIState(sortFields[EntityType.taxRate]),
      companyGatewayUIState:
          CompanyGatewayUIState(sortFields[EntityType.companyGateway]),
      groupUIState: GroupUIState(sortFields[EntityType.group]),
      documentUIState: DocumentUIState(sortFields[EntityType.document]),
      expenseUIState: ExpenseUIState(sortFields[EntityType.expense]),
      vendorUIState: VendorUIState(sortFields[EntityType.vendor]),
      taskUIState: TaskUIState(sortFields[EntityType.task]),
      projectUIState: ProjectUIState(sortFields[EntityType.project]),
      paymentUIState: PaymentUIState(sortFields[EntityType.payment]),
      quoteUIState: QuoteUIState(sortFields[EntityType.quote]),
      // STARTER: constructor - do not remove comment
      scheduleUIState: ScheduleUIState(sortFields[EntityType.schedule]),

      transactionRuleUIState:
          TransactionRuleUIState(sortFields[EntityType.transactionRule]),

      transactionUIState:
          TransactionUIState(sortFields[EntityType.transaction]),

      bankAccountUIState:
          BankAccountUIState(sortFields[EntityType.bankAccount]),

      purchaseOrderUIState:
          PurchaseOrderUIState(sortFields[EntityType.purchaseOrder]),

      recurringExpenseUIState:
          RecurringExpenseUIState(sortFields[EntityType.recurringExpense]),
    );
  }

  UIState._();

  @override
  @memoized
  int get hashCode;

  int get selectedCompanyIndex;

  String get currentRoute;

  String get previousRoute;

  EntityType? get loadingEntityType;

  BuiltList<EntityType> get previewStack;

  BuiltList<BaseEntity> get filterStack;

  BaseEntity get filterEntity => filterStack.last;

  String? get filterEntityId => filterStack.isEmpty ? null : filterEntity.id;

  EntityType? get filterEntityType =>
      filterStack.isEmpty ? null : filterEntity.entityType;

  String? get filter;

  int get filterClearedAt;

  int get lastActivityAt;

  DashboardUIState get dashboardUIState;

  ProductUIState get productUIState;

  ClientUIState get clientUIState;

  InvoiceUIState get invoiceUIState;

  // STARTER: properties - do not remove comment
  ScheduleUIState get scheduleUIState;

  TransactionRuleUIState get transactionRuleUIState;

  TransactionUIState get transactionUIState;

  BankAccountUIState get bankAccountUIState;

  PurchaseOrderUIState get purchaseOrderUIState;

  RecurringExpenseUIState get recurringExpenseUIState;

  SubscriptionUIState get subscriptionUIState;

  TaskStatusUIState get taskStatusUIState;

  ExpenseCategoryUIState get expenseCategoryUIState;

  RecurringInvoiceUIState get recurringInvoiceUIState;

  WebhookUIState get webhookUIState;

  TokenUIState get tokenUIState;

  PaymentTermUIState get paymentTermUIState;

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

  bool containsRoute(String route) {
    if (route.isEmpty) {
      return false;
    }
    return currentRoute.contains(route);
  }

  EntityType get entityTypeRoute {
    final entityType = mainRoute.replaceFirst('/', '');
    return EntityType.valueOf(toCamelCase(entityType));
  }

  String get mainRoute {
    final parts =
        currentRoute.split('/').where((part) => part.isNotEmpty).toList();
    return parts.isNotEmpty ? parts[0] : '';
  }

  String get subRoute {
    final parts =
        currentRoute.split('/').where((part) => part.isNotEmpty).toList();
    if (parts.length == 3) {
      return '${parts[1]}/${parts[2]}';
    } else {
      return parts.length > 1 ? parts[1] : '';
    }
  }

  String get baseRoute {
    String route = currentRoute;
    route = route.replaceAll('/edit', '');
    route = route.replaceAll('/view', '');
    route = route.replaceAll('/pdf', '');
    route = route.replaceAll('/email', '');
    return route;
  }

  String get baseSubRoute {
    String route = subRoute;
    route = route.replaceAll('/edit', '');
    route = route.replaceAll('/view', '');
    route = route.replaceAll('/pdf', '');
    route = route.replaceAll('/email', '');
    return route;
  }

  String get previousMainRoute {
    final parts =
        previousRoute.split('/').where((part) => part.isNotEmpty).toList();
    return parts.isNotEmpty ? parts[0] : '';
  }

  String get previousSubRoute {
    final parts =
        previousRoute.split('/').where((part) => part.isNotEmpty).toList();
    return parts.length > 1 ? parts[1] : '';
  }

  bool get isEditing =>
      currentRoute.endsWith('/edit') || currentRoute.endsWith('refund');

  bool get isEmailing => currentRoute.endsWith('/email');

  bool get isPDF => currentRoute.endsWith('/pdf');

  bool get isViewing => !isEditing && !isEmailing;

  bool get isInSettings => currentRoute.startsWith('/settings');

  bool get isPreviewing => previewStack.isNotEmpty;

  bool get isList => !isEditing && !isEmailing && !isPDF && !isInSettings;

  bool get hasRecentActivity {
    if (lastActivityAt == 0) {
      return false;
    }

    return DateTime.now().millisecondsSinceEpoch - lastActivityAt <
        kMillisecondsToRefreshStaticData;
  }

  // ignore: unused_element
  static void _initializeBuilder(UIStateBuilder builder) => builder
    ..lastActivityAt = 0
    ..filterStack.replace(BuiltList<BaseEntity>());

  static Serializer<UIState> get serializer => _$uIStateSerializer;
}
