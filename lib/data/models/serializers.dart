import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:invoiceninja/data/models/credit_model.dart';
import 'package:invoiceninja/data/models/expense_model.dart';
import 'package:invoiceninja/data/models/invoice_model.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/models/payment_model.dart';
import 'package:invoiceninja/data/models/project_model.dart';
import 'package:invoiceninja/data/models/task_model.dart';
import 'package:invoiceninja/data/models/vendor_model.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/redux/company/company_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/client/client_state.dart';
import 'package:invoiceninja/redux/ui/ui_state.dart';
import 'package:invoiceninja/redux/invoice/invoice_state.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AppState,
  LoginResponse,
  DashboardResponse,
  ProductListResponse,
  ProductItemResponse,
  ClientListResponse,
  ClientItemResponse,
  CreditListResponse,
  CreditItemResponse,
  ProjectListResponse,
  ProjectItemResponse,
  PaymentListResponse,
  PaymentItemResponse,
  InvoiceListResponse,
  InvoiceItemResponse,
  ExpenseListResponse,
  ExpenseItemResponse,
  TaskListResponse,
  TaskItemResponse,
  VendorListResponse,
  VendorItemResponse,
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();