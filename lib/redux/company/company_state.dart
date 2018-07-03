import 'package:invoiceninja/redux/client/client_state.dart';
import 'package:invoiceninja/redux/invoice/invoice_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'company_state.g.dart';

abstract class CompanyState implements Built<CompanyState, CompanyStateBuilder> {

  factory CompanyState() {
    return _$CompanyState._(
      dashboardState: DashboardState(),
      productState: ProductState(),
      clientState: ClientState(),
      invoiceState: InvoiceState(),
    );
  }
  CompanyState._();

  @nullable
  CompanyEntity get company;
  DashboardState get dashboardState;
  ProductState get productState;
  ClientState get clientState;
  InvoiceState get invoiceState;

  //factory CompanyState([void updates(CompanyStateBuilder b)]) = _$CompanyState;
  static Serializer<CompanyState> get serializer => _$companyStateSerializer;
}