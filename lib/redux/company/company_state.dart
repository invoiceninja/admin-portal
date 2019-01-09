import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/task/task_state.dart';

import 'package:invoiceninja_flutter/redux/project/project_state.dart';

import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';

import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';

part 'company_state.g.dart';

abstract class CompanyState
    implements Built<CompanyState, CompanyStateBuilder> {
  factory CompanyState() {
    return _$CompanyState._(
      company: CompanyEntity(),
      dashboardState: DashboardState(),
      productState: ProductState(),
      clientState: ClientState(),
      invoiceState: InvoiceState(),
      // STARTER: constructor - do not remove comment
      taskState: TaskState(),
      projectState: ProjectState(),
      paymentState: PaymentState(),
      quoteState: QuoteState(),
    );
  }

  CompanyState._();

  @nullable
  CompanyEntity get company;

  DashboardState get dashboardState;

  ProductState get productState;

  ClientState get clientState;

  InvoiceState get invoiceState;

  // STARTER: fields - do not remove comment
  TaskState get taskState;

  ProjectState get projectState;

  PaymentState get paymentState;

  QuoteState get quoteState;

  //factory CompanyState([void updates(CompanyStateBuilder b)]) = _$CompanyState;
  static Serializer<CompanyState> get serializer => _$companyStateSerializer;
}
