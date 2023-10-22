// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
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
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/schedule/schedule_state.dart';

import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_state.dart';

part 'company_state.g.dart';

abstract class UserCompanyState
    implements Built<UserCompanyState, UserCompanyStateBuilder> {
  factory UserCompanyState(bool reportErrors) {
    return _$UserCompanyState._(
      lastUpdated: 0,
      userCompany: UserCompanyEntity(reportErrors),
      documentState: DocumentState(),
      productState: ProductState(),
      clientState: ClientState(),
      invoiceState: InvoiceState(),
      expenseState: ExpenseState(),
      vendorState: VendorState(),
      taskState: TaskState(),
      projectState: ProjectState(),
      paymentState: PaymentState(),
      quoteState: QuoteState(),
      // STARTER: constructor - do not remove comment
      scheduleState: ScheduleState(),
      transactionRuleState: TransactionRuleState(),
      transactionState: TransactionState(),
      bankAccountState: BankAccountState(),
      purchaseOrderState: PurchaseOrderState(),
      recurringExpenseState: RecurringExpenseState(),
      subscriptionState: SubscriptionState(),
      taskStatusState: TaskStatusState(),
      expenseCategoryState: ExpenseCategoryState(),
      recurringInvoiceState: RecurringInvoiceState(),
      webhookState: WebhookState(),
      tokenState: TokenState(),
      paymentTermState: PaymentTermState(),
      designState: DesignState(),
      creditState: CreditState(),
      userState: UserState(),
      taxRateState: TaxRateState(),
      companyGatewayState: CompanyGatewayState(),
      groupState: GroupState(),
    );
  }

  UserCompanyState._();

  @override
  @memoized
  int get hashCode;

  int get lastUpdated;

  UserCompanyEntity get userCompany;

  DocumentState get documentState;

  ProductState get productState;

  ClientState get clientState;

  InvoiceState get invoiceState;

  ExpenseState get expenseState;

  VendorState get vendorState;

  TaskState get taskState;

  ProjectState get projectState;

  PaymentState get paymentState;

  QuoteState get quoteState;

  // STARTER: fields - do not remove comment
  ScheduleState get scheduleState;

  TransactionRuleState get transactionRuleState;

  TransactionState get transactionState;

  BankAccountState get bankAccountState;

  PurchaseOrderState get purchaseOrderState;

  RecurringExpenseState get recurringExpenseState;

  SubscriptionState get subscriptionState;

  TaskStatusState get taskStatusState;

  ExpenseCategoryState get expenseCategoryState;

  RecurringInvoiceState get recurringInvoiceState;

  WebhookState get webhookState;

  TokenState get tokenState;

  PaymentTermState get paymentTermState;

  DesignState get designState;

  CreditState get creditState;

  UserState get userState;

  TaxRateState get taxRateState;

  CompanyGatewayState get companyGatewayState;

  GroupState get groupState;

  CompanyEntity get company => userCompany.company;

  UserEntity get user => userCompany.user;

  TokenEntity get token => userCompany.token;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated > 0;

  static Serializer<UserCompanyState> get serializer =>
      _$userCompanyStateSerializer;
}
