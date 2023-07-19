// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/account_model.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/health_check_model.dart';
import 'package:invoiceninja_flutter/data/models/import_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';
import 'package:invoiceninja_flutter/data/models/tax_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_state.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_state.dart';
// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/schedule/schedule_state.dart';

import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_state.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AppState,
  LoginResponse,
  UserItemResponse,
  CompanyItemResponse,
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
  DocumentListResponse,
  DocumentItemResponse,
  StaticDataItemResponse,
  CountryItemResponse,
  CountryListResponse,
  CurrencyItemResponse,
  CurrencyListResponse,
  DateFormatItemResponse,
  DateFormatListResponse,
  DatetimeFormatItemResponse,
  DatetimeFormatListResponse,
  IndustryItemResponse,
  IndustryListResponse,
  LanguageItemResponse,
  LanguageListResponse,
  PaymentTypeItemResponse,
  PaymentTypeListResponse,
  SizeItemResponse,
  SizeListResponse,
  TimezoneItemResponse,
  TimezoneListResponse,
  ExpenseEntity,
  VendorEntity,
  TaskEntity,
  ProjectEntity,
  PaymentEntity,
  TaskStatusEntity,
  ExpenseStatusEntity,
  GroupEntity,
  GroupItemResponse,
  GroupListResponse,
  DocumentEntity,
  DocumentListResponse,
  DocumentItemResponse,
  TaxRateEntity,
  TaxRateItemResponse,
  TaxRateListResponse,
  // STARTER: serializers - do not remove comment
  ScheduleEntity,
  ScheduleListResponse,
  ScheduleItemResponse,
  TransactionRuleEntity,
  TransactionRuleListResponse,
  TransactionRuleItemResponse,
  TransactionEntity,
  TransactionListResponse,
  TransactionItemResponse,
  TransactionStatusEntity,
  BankAccountEntity,
  BankAccountListResponse,
  BankAccountItemResponse,
  InvoiceListResponse,
  InvoiceItemResponse,
  SubscriptionEntity,
  SubscriptionListResponse,
  SubscriptionItemResponse,
  TaskStatusEntity,
  TaskStatusListResponse,
  TaskStatusItemResponse,
  ExpenseCategoryEntity,
  ExpenseCategoryListResponse,
  ExpenseCategoryItemResponse,
  WebhookEntity,
  WebhookListResponse,
  WebhookItemResponse,
  TokenEntity,
  TokenListResponse,
  TokenItemResponse,
  PaymentTermEntity,
  PaymentTermListResponse,
  PaymentTermItemResponse,
  DesignEntity,
  DesignListResponse,
  DesignItemResponse,
  InvoiceEntity,
  PaymentableEntity,
  UserEntity,
  UserListResponse,
  UserItemResponse,
  CompanyGatewayEntity,
  CompanyGatewayListResponse,
  CompanyGatewayItemResponse,
  GatewayEntity,
  GatewayTokenListResponse,
  GatewayTokenItemResponse,
  UserCompanyItemResponse,
  DesignPreviewRequest,
  HealthCheckResponse,
  SystemLogEntity,
  PreImportResponse,
  ImportRequest,
  ImportRequestMapping,
  UserTwoFactorResponse,
  PdfPreviewRequest,
  TaxDataEntity,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
