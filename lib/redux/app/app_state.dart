import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
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
import 'package:invoiceninja_flutter/redux/task/task_state.dart';

import 'package:invoiceninja_flutter/redux/project/project_state.dart';

import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';

import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState(
      {String appVersion, bool enableDarkMode, bool requireAuthentication}) {
    return _$AppState._(
      isLoading: false,
      isSaving: false,
      authState: AuthState(),
      staticState: StaticState(),
      companyState1: CompanyState(),
      companyState2: CompanyState(),
      companyState3: CompanyState(),
      companyState4: CompanyState(),
      companyState5: CompanyState(),
      uiState: UIState(CompanyEntity(),
          enableDarkMode: enableDarkMode,
          requireAuthentication: requireAuthentication),
    );
  }

  AppState._();

  bool get isLoading;

  bool get isSaving;

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

  @override
  String toString() {
    //return 'Is Loading: ${this.isLoading}, Invoice: ${this.invoiceUIState.selected}';
    //return 'Date Formats: ${staticState.dateFormatMap}';
    return 'Route: ${uiState.currentRoute}';
  }
}
