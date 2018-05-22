import 'package:meta/meta.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';

@immutable
class CompanyState {
  final ProductState product;
  final DashboardState dashboard;

  CompanyState(
      {ProductState product,
      DashboardState dashboard}) :
        product = product ?? ProductState(),
        dashboard = dashboard ?? DashboardState();

  //factory AppState.loading() => AppState(isLoading: true);

  CompanyState copyWith({
    ProductState product,
    DashboardState dashboard,
  }) {
    return CompanyState(
      product: product ?? this.product,
      dashboard: dashboard ?? this.dashboard,
    );
  }

  @override
  int get hashCode =>
      product.hashCode ^
      dashboard.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is CompanyState &&
              runtimeType == other.runtimeType &&
              dashboard == other.dashboard &&
              product == other.product;

  @override
  String toString() {
    return 'CompanyState{}';
  }
}