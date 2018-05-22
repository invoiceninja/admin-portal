import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/redux/app/company_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';

@immutable
class AppState {
  final bool isLoading;
  final AuthState auth;
  final int selectedCompanyId;
  final CompanyState company1;
  final CompanyState company2;
  final CompanyState company3;
  final CompanyState company4;
  final CompanyState company5;

  AppState(
      {this.isLoading = false,
        this.selectedCompanyId = 1,
        AuthState auth,
        CompanyState company1,
        CompanyState company2,
        CompanyState company3,
        CompanyState company4,
        CompanyState company5,}) :
        auth = auth ?? AuthState(),
        company1 = company1 ?? CompanyState(),
        company2 = company2 ?? CompanyState(),
        company3 = company3 ?? CompanyState(),
        company4 = company4 ?? CompanyState(),
        company5 = company5 ?? CompanyState();

  factory AppState.loading() => AppState(isLoading: true);

  /*
  static AppState rehydrationJSON(dynamic json) => new AppState(
      auth: new AuthState.fromJSON(json['auth'])
  );
  Map<String, dynamic> toJson() => {
    'auth': auth.toJSON()
  };
  */

  AppState copyWith({
    String selectedCompany,
    bool isLoading,
    AuthState auth,
    CompanyState company1,
    CompanyState company2,
    CompanyState company3,
    CompanyState company4,
    CompanyState company5,
  }) {
    return AppState(
      selectedCompanyId : selectedCompany ?? this.selectedCompanyId,
      isLoading: isLoading ?? this.isLoading,
      auth: auth ?? this.auth,
      company1: company1 ?? this.company1,
      company2: company2 ?? this.company2,
      company3: company3 ?? this.company3,
      company4: company4 ?? this.company4,
      company5: company5 ?? this.company5,
    );
  }

  @override
  int get hashCode =>
      selectedCompanyId.hashCode ^
      isLoading.hashCode ^
      auth.hashCode ^
      company1.hashCode ^
      company2.hashCode ^
      company3.hashCode ^
      company4.hashCode ^
      company5.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              selectedCompanyId == other.selectedCompanyId &&
              company1 == other.company1 &&
              company2 == other.company2 &&
              company3 == other.company3 &&
              company4 == other.company4 &&
              company5 == other.company5 &&
              auth == other.auth;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, url: ${auth.url}, companyId: ${selectedCompanyId}';
  }

  CompanyState selectedCompany() {
    switch (this.selectedCompanyId) {
      case 1:
        return this.company1;
      case 2:
        return this.company2;
      case 3:
        return this.company3;
      case 4:
        return this.company4;
      case 5:
        return this.company5;
    }
  }

  ProductState product() {
    return this.selectedCompany().product;
  }

  DashboardState dashboard() {
    return this.selectedCompany().dashboard;
  }
}