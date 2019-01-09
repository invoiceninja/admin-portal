import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';

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
  StaticDataItemResponse,
  CountryItemResponse,
  CountryListResponse,
  CurrencyItemResponse,
  CurrencyListResponse,
  DateFormatItemResponse,
  DateFormatListResponse,
  DatetimeFormatItemResponse,
  DatetimeFormatListResponse,
  FrequencyItemResponse,
  FrequencyListResponse,
  IndustryItemResponse,
  IndustryListResponse,
  InvoiceDesignItemResponse,
  InvoiceDesignListResponse,
  LanguageItemResponse,
  LanguageListResponse,
  PaymentTypeItemResponse,
  PaymentTypeListResponse,
  SizeItemResponse,
  SizeListResponse,
  TimezoneItemResponse,
  TimezoneListResponse,
  // STARTER: serializers - do not remove comment
  TaskEntity,
  ProjectEntity,
  PaymentEntity,
  TaskStatusEntity,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
