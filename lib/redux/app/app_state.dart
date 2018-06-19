import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/client/client_state.dart';
import 'package:invoiceninja/redux/invoice/invoice_state.dart';
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
      companyState1: CompanyState(),
      companyState2: CompanyState(),
      companyState3: CompanyState(),
      companyState4: CompanyState(),
      companyState5: CompanyState(),
      uiState: UIState(),
    );
  }

  AppState._();
  //factory AppState([updates(AppStateBuilder b)]) = _$AppState;
  static Serializer<AppState> get serializer => _$appStateSerializer;

  CompanyState get selectedCompanyState {
    switch (this.uiState.selectedCompanyIndex) {
      case 1:
        return this.companyState1;
      case 2:
        return this.companyState2;
      case 3:
        return this.companyState3;
      case 4:
        return this.companyState4;
      case 5:
        return this.companyState5;
    }

    return this.companyState1;
  }

  bool get isLoaded {
    return dashboardState.isLoaded
        && productState.isLoaded
        && clientState.isLoaded;
  }

  CompanyEntity get selectedCompany => this.selectedCompanyState.company;
  DashboardState get dashboardState => this.selectedCompanyState.dashboardState;

  ListUIState getListState(EntityType type) {
    switch (type) {
      case EntityType.product:
        return productListState;
      case EntityType.client:
        return clientListState;
      case EntityType.invoice:
        return invoiceListState;
      default:
        return null;
    }
  }

  ProductState get productState => this.selectedCompanyState.productState;
  ProductUIState get productUIState => this.uiState.productUIState;
  ListUIState get productListState => this.uiState.productUIState.listUIState;

  ClientState get clientState => this.selectedCompanyState.clientState;
  ClientUIState get clientUIState => this.uiState.clientUIState;
  ListUIState get clientListState => this.uiState.clientUIState.listUIState;

  InvoiceState get invoiceState => this.selectedCompanyState.invoiceState;
  InvoiceUIState get invoiceUIState => this.uiState.invoiceUIState;
  ListUIState get invoiceListState => this.uiState.invoiceUIState.listUIState;

  @override
  String toString() {
    return '';
    //return this.invoiceUIState.selected.toString();
  }
}