import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'company_state.g.dart';

abstract class CompanyState implements Built<CompanyState, CompanyStateBuilder> {

  factory CompanyState() {
    return _$CompanyState._(
      company: CompanyEntity(),
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