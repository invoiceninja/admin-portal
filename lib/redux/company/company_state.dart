import 'package:meta/meta.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja/data/models/entities.dart';

@immutable
class CompanyState {
  CompanyEntity company;
  final ProductState productState;
  final DashboardState dashboardState;

  CompanyState(
      {CompanyEntity company,
        ProductState productState,
      DashboardState dashboardState}) :
        company = company ?? CompanyEntity(0),
        productState = productState ?? ProductState(),
        dashboardState = dashboardState ?? DashboardState();

  //factory AppState.loading() => AppState(isLoading: true);

  CompanyState copyWith({
    CompanyEntity company,
    ProductState productState,
    DashboardState dashboardState,
  }) {
    return CompanyState(
      company: company ?? this.company,
      productState: productState ?? this.productState,
      dashboardState: dashboardState ?? this.dashboardState,
    );
  }

  @override
  int get hashCode =>
      company.hashCode ^
      productState.hashCode ^
      dashboardState.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is CompanyState &&
              runtimeType == other.runtimeType &&
              company == other.company &&
              dashboardState == other.dashboardState &&
              productState == other.productState;

  @override
  String toString() {
    return 'CompanyState{}';
  }
}