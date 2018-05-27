import 'package:invoiceninja/data/models/models.dart';
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
  int get selectedCompanyIndex;
  CompanyState get companyState1;
  CompanyState get companyState2;
  CompanyState get companyState3;
  CompanyState get companyState4;
  CompanyState get companyState5;

  factory AppState() {
    return _$AppState._(
      isLoading: false,
      authState: AuthState(),
      selectedCompanyIndex: 0,
      companyState1: CompanyState(),
      companyState2: CompanyState(),
      companyState3: CompanyState(),
      companyState4: CompanyState(),
      companyState5: CompanyState(),
    );
  }

  AppState._();
  //factory AppState([updates(AppStateBuilder b)]) = _$AppState;
  static Serializer<AppState> get serializer => _$appStateSerializer;

  CompanyState selectedCompanyState() {
    switch (this.selectedCompanyIndex) {
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

  CompanyEntity selectedCompany() {
    return this.selectedCompanyState().company;
  }

  ProductState productState() {
    return this.selectedCompanyState().productState;
  }

  DashboardState dashboardState() {
    return this.selectedCompanyState().dashboardState;
  }
}