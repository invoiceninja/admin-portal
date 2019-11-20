import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// STARTER: import - do not remove comment
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
  factory UserCompanyState() {
    return _$UserCompanyState._(
      userCompany: UserCompanyEntity(),
      documentState: DocumentState(),
      dashboardState: DashboardState(),
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
      userState: UserState(),
      taxRateState: TaxRateState(),
      companyGatewayState: CompanyGatewayState(),
      groupState: GroupState(),
    );
  }

  UserCompanyState._();

  @nullable
  UserCompanyEntity get userCompany;

  DocumentState get documentState;

  DashboardState get dashboardState;

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
  UserState get userState;

  TaxRateState get taxRateState;

  CompanyGatewayState get companyGatewayState;

  GroupState get groupState;

  CompanyEntity get company => userCompany.company;

  UserEntity get user => userCompany.user;

  TokenEntity get token => userCompany.token;

  //factory CompanyState([void updates(CompanyStateBuilder b)]) = _$CompanyState;
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
          : group != null ? EntityType.group : EntityType.company,
      origClient: origClient ?? ClientEntity(),
      origGroup: origGroup ?? GroupEntity(),
      origCompany: origCompany ?? CompanyEntity(),
      origUser: origUser ?? UserEntity(),
      isChanged: false,
      updatedAt: 0,
      filterClearedAt: 0,
      section: section ?? kSettingsCompanyDetails,
    );
  }

  SettingsUIState._();

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

  @nullable
  String get filter;

  int get filterClearedAt;

  bool get isFiltered => entityType != EntityType.company;

  SettingsEntity get settings {
    if (entityType == EntityType.client && client != null) {
      return company.settings; // TODO fix this, change to client.settings
    } else if (entityType == EntityType.group && group != null) {
      return group.settings;
    } else {
      return company.settings;
    }
  }

  static Serializer<SettingsUIState> get serializer =>
      _$settingsUIStateSerializer;
}
