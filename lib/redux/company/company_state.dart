import 'package:invoiceninja/redux/client/client_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'company_state.g.dart';

abstract class CompanyState implements Built<CompanyState, CompanyStateBuilder> {
  @nullable
  CompanyEntity get company;
  DashboardState get dashboardState;
  ProductState get productState;
  ClientState get clientState;

  factory CompanyState() {
    return _$CompanyState._(
      dashboardState: DashboardState(),
      productState: ProductState(),
      clientState: ClientState(),
    );
  }

  CompanyState._();
  //factory CompanyState([updates(CompanyStateBuilder b)]) = _$CompanyState;
  static Serializer<CompanyState> get serializer => _$companyStateSerializer;
}