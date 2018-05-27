import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/redux/company/company_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';

@immutable
class AppState {
  bool isLoading;
  AuthState authState;
  int selectedCompanyIndex;
  CompanyState companyState1;
  CompanyState companyState2;
  CompanyState companyState3;
  CompanyState companyState4;
  CompanyState companyState5;

  AppState(
      {this.isLoading = false,
        this.selectedCompanyIndex = 0,
        AuthState auth,
        CompanyState companyState1,
        CompanyState companyState2,
        CompanyState companyState3,
        CompanyState companyState4,
        CompanyState companyState5,}) :
        authState = auth ?? AuthState(),
        companyState1 = companyState1 ?? CompanyState(),
        companyState2 = companyState2 ?? CompanyState(),
        companyState3 = companyState3 ?? CompanyState(),
        companyState4 = companyState4 ?? CompanyState(),
        companyState5 = companyState5 ?? CompanyState();

  /*
  static AppState rehydrationJSON(dynamic json) => new AppState(
      auth: new AuthState.fromJSON(json['auth'])
  );
  Map<String, dynamic> toJson() => {
    'auth': auth.toJSON()
  };
  */

  AppState copyWith({
    bool isLoading,
    AuthState auth,
    int selectedCompanyIndex,
    CompanyState companyState1,
    CompanyState companyState2,
    CompanyState companyState3,
    CompanyState companyState4,
    CompanyState companyState5,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      auth: auth ?? this.authState,
      selectedCompanyIndex : selectedCompanyIndex ?? this.selectedCompanyIndex,
      companyState1: companyState1 ?? this.companyState1,
      companyState2: companyState2 ?? this.companyState2,
      companyState3: companyState3 ?? this.companyState3,
      companyState4: companyState4 ?? this.companyState4,
      companyState5: companyState5 ?? this.companyState5,
    );
  }

  @override
  int get hashCode =>
      selectedCompanyIndex.hashCode ^
      isLoading.hashCode ^
      authState.hashCode ^
      companyState1.hashCode ^
      companyState2.hashCode ^
      companyState3.hashCode ^
      companyState4.hashCode ^
      companyState5.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              selectedCompanyIndex == other.selectedCompanyIndex &&
              companyState1 == other.companyState1 &&
              companyState2 == other.companyState2 &&
              companyState3 == other.companyState3 &&
              companyState4 == other.companyState4 &&
              companyState5 == other.companyState5 &&
              authState == other.authState;

  @override
  String toString() {
    return 'AppState{error: isLoading: ${isLoading}, selectedCompanyIndex: ${selectedCompanyIndex} error: ${authState.error}}';
    //return 'AppState{isLoading: $isLoading, url: ${authState.url}, companyIndex: ${selectedCompanyIndex}, company1: ${companyState1.company.name}, company2: ${companyState2.company.name}';
  }

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