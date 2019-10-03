import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// STARTER: import - do not remove comment
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

  CompanyEntity get company => userCompany.company;

  UserEntity get user => userCompany.user;

  TokenEntity get token => userCompany.token;

  //factory CompanyState([void updates(CompanyStateBuilder b)]) = _$CompanyState;
  static Serializer<UserCompanyState> get serializer =>
      _$userCompanyStateSerializer;
}

abstract class SettingsUIState extends Object
    implements Built<SettingsUIState, SettingsUIStateBuilder> {
  factory SettingsUIState({UserCompanyEntity userCompany}) {
    return _$SettingsUIState._(
      editing: userCompany ?? UserCompanyEntity(),
      isChanged: false,
      updatedAt: 0,
    );
  }
  SettingsUIState._();

  @nullable
  UserCompanyEntity get editing;

  bool get isChanged;

  int get updatedAt;

  static Serializer<SettingsUIState> get serializer =>
      _$settingsUIStateSerializer;
}
