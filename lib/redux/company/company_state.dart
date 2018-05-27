import 'package:meta/meta.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'company_state.g.dart';

abstract class CompanyState implements Built<CompanyState, CompanyStateBuilder> {
  @nullable
  CompanyEntity get company;
  ProductState get productState;
  DashboardState get dashboardState;

  factory CompanyState() {
    return _$CompanyState._(
      productState: ProductState(),
      dashboardState: DashboardState(),
    );
  }

  CompanyState._();
  //factory CompanyState([updates(CompanyStateBuilder b)]) = _$CompanyState;
  static Serializer<CompanyState> get serializer => _$companyStateSerializer;
}