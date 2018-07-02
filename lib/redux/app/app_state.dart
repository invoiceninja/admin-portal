import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/static/static_state.dart';
import 'package:invoiceninja/redux/client/client_state.dart';
import 'package:invoiceninja/redux/invoice/invoice_state.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/redux/company/company_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  bool get isLoading;
  AuthState get authState;
  StaticState get staticState;
  UIState get uiState;
  CompanyState get companyState1;
  CompanyState get companyState2;
  CompanyState get companyState3;
  CompanyState get companyState4;
  CompanyState get companyState5;

  factory AppState() {
    return _$AppState._(
      isLoading: false,
      authState: AuthState(),
      staticState: StaticState(),
      companyState1: CompanyState(),
      companyState2: CompanyState(),
      companyState3: CompanyState(),
      companyState4: CompanyState(),
      companyState5: CompanyState(),
      uiState: UIState(),
    );
  }

  AppState._();
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
    return dashboardState.isLoaded
        && productState.isLoaded
        && clientState.isLoaded;
  }

  CompanyEntity get selectedCompany => selectedCompanyState.company;
  DashboardState get dashboardState => selectedCompanyState.dashboardState;

  EntityUIState getUIState(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productUIState;
      case EntityType.client:
        return clientUIState;
      case EntityType.invoice:
        return invoiceUIState;
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

  @override
  String toString() {
    //return 'Is Loading: ${this.isLoading}, Invoice: ${this.invoiceUIState.selected}';
    return 'Route: ${uiState.currentRoute}';
  }
}