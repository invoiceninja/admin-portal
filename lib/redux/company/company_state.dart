import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';

import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';

import 'package:invoiceninja_flutter/redux/expense_category/expense_category_state.dart';

import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_state.dart';

import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';

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

  @nullable
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

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<UserCompanyState> get serializer =>
      _$userCompanyStateSerializer;
}

abstract class SettingsUIState extends Object
    implements Built<SettingsUIState, SettingsUIStateBuilder> {
  factory SettingsUIState(
      {CompanyEntity company,
      ClientEntity client,
      GroupEntity group,
      UserEntity user,
      CompanyEntity origCompany,
      ClientEntity origClient,
      GroupEntity origGroup,
      UserEntity origUser,
      String section}) {
    return _$SettingsUIState._(
      company: company ?? CompanyEntity(),
      client: client ?? ClientEntity(),
      group: group ?? GroupEntity(),
      user: user ?? UserEntity(),
      entityType: client != null
          ? EntityType.client
          : group != null
              ? EntityType.group
              : EntityType.company,
      origClient: origClient ?? ClientEntity(),
      origGroup: origGroup ?? GroupEntity(),
      origCompany: origCompany ?? CompanyEntity(),
      origUser: origUser ?? UserEntity(),
      isChanged: false,
      updatedAt: 0,
      filterClearedAt: 0,
      tabIndex: 0,
      section: section ?? kSettingsCompanyDetails,
    );
  }

  SettingsUIState._();

  @override
  @memoized
  int get hashCode;

  CompanyEntity get company;

  CompanyEntity get origCompany;

  ClientEntity get client;

  ClientEntity get origClient;

  GroupEntity get group;

  GroupEntity get origGroup;

  UserEntity get user;

  UserEntity get origUser;

  EntityType get entityType;

  bool get isChanged;

  int get updatedAt;

  String get section;

  int get tabIndex;

  @nullable
  String get filter;

  int get filterClearedAt;

  bool get isFiltered => entityType != EntityType.company;

  SettingsEntity get settings {
    if (entityType == EntityType.client && client != null) {
      return client.settings;
    } else if (entityType == EntityType.group && group != null) {
      return group.settings;
    } else {
      return company.settings;
    }
  }

  static Serializer<SettingsUIState> get serializer =>
      _$settingsUIStateSerializer;
}
