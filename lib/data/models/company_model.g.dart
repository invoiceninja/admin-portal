// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompanyEntity> _$companyEntitySerializer =
    new _$CompanyEntitySerializer();
Serializer<GatewayEntity> _$gatewayEntitySerializer =
    new _$GatewayEntitySerializer();
Serializer<GatewayOptionsEntity> _$gatewayOptionsEntitySerializer =
    new _$GatewayOptionsEntitySerializer();
Serializer<UserCompanyEntity> _$userCompanyEntitySerializer =
    new _$UserCompanyEntitySerializer();
Serializer<UserSettingsEntity> _$userSettingsEntitySerializer =
    new _$UserSettingsEntitySerializer();
Serializer<ReportSettingsEntity> _$reportSettingsEntitySerializer =
    new _$ReportSettingsEntitySerializer();
Serializer<CompanyItemResponse> _$companyItemResponseSerializer =
    new _$CompanyItemResponseSerializer();
Serializer<RegistrationFieldEntity> _$registrationFieldEntitySerializer =
    new _$RegistrationFieldEntitySerializer();

class _$CompanyEntitySerializer implements StructuredSerializer<CompanyEntity> {
  @override
  final Iterable<Type> types = const [CompanyEntity, _$CompanyEntity];
  @override
  final String wireName = 'CompanyEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, CompanyEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'custom_surcharge_taxes1',
      serializers.serialize(object.enableCustomSurchargeTaxes1,
          specifiedType: const FullType(bool)),
      'custom_surcharge_taxes2',
      serializers.serialize(object.enableCustomSurchargeTaxes2,
          specifiedType: const FullType(bool)),
      'custom_surcharge_taxes3',
      serializers.serialize(object.enableCustomSurchargeTaxes3,
          specifiedType: const FullType(bool)),
      'custom_surcharge_taxes4',
      serializers.serialize(object.enableCustomSurchargeTaxes4,
          specifiedType: const FullType(bool)),
      'size_id',
      serializers.serialize(object.sizeId,
          specifiedType: const FullType(String)),
      'industry_id',
      serializers.serialize(object.industryId,
          specifiedType: const FullType(String)),
      'subdomain',
      serializers.serialize(object.subdomain,
          specifiedType: const FullType(String)),
      'portal_mode',
      serializers.serialize(object.portalMode,
          specifiedType: const FullType(String)),
      'portal_domain',
      serializers.serialize(object.portalDomain,
          specifiedType: const FullType(String)),
      'update_products',
      serializers.serialize(object.updateProducts,
          specifiedType: const FullType(bool)),
      'convert_products',
      serializers.serialize(object.convertProductExchangeRate,
          specifiedType: const FullType(bool)),
      'convert_rate_to_client',
      serializers.serialize(object.convertRateToClient,
          specifiedType: const FullType(bool)),
      'fill_products',
      serializers.serialize(object.fillProducts,
          specifiedType: const FullType(bool)),
      'enable_product_cost',
      serializers.serialize(object.enableProductCost,
          specifiedType: const FullType(bool)),
      'enable_product_quantity',
      serializers.serialize(object.enableProductQuantity,
          specifiedType: const FullType(bool)),
      'enable_product_discount',
      serializers.serialize(object.enableProductDiscount,
          specifiedType: const FullType(bool)),
      'default_task_is_date_based',
      serializers.serialize(object.defaultTaskIsDateBased,
          specifiedType: const FullType(bool)),
      'default_quantity',
      serializers.serialize(object.defaultQuantity,
          specifiedType: const FullType(bool)),
      'show_product_details',
      serializers.serialize(object.showProductDetails,
          specifiedType: const FullType(bool)),
      'client_can_register',
      serializers.serialize(object.clientCanRegister,
          specifiedType: const FullType(bool)),
      'is_large',
      serializers.serialize(object.isLarge,
          specifiedType: const FullType(bool)),
      'is_disabled',
      serializers.serialize(object.isDisabled,
          specifiedType: const FullType(bool)),
      'enable_shop_api',
      serializers.serialize(object.enableShopApi,
          specifiedType: const FullType(bool)),
      'company_key',
      serializers.serialize(object.companyKey,
          specifiedType: const FullType(String)),
      'first_day_of_week',
      serializers.serialize(object.firstDayOfWeek,
          specifiedType: const FullType(String)),
      'first_month_of_year',
      serializers.serialize(object.firstMonthOfYear,
          specifiedType: const FullType(String)),
      'enabled_tax_rates',
      serializers.serialize(object.numberOfInvoiceTaxRates,
          specifiedType: const FullType(int)),
      'enabled_item_tax_rates',
      serializers.serialize(object.numberOfItemTaxRates,
          specifiedType: const FullType(int)),
      'expense_inclusive_taxes',
      serializers.serialize(object.expenseInclusiveTaxes,
          specifiedType: const FullType(bool)),
      'session_timeout',
      serializers.serialize(object.sessionTimeout,
          specifiedType: const FullType(int)),
      'default_password_timeout',
      serializers.serialize(object.passwordTimeout,
          specifiedType: const FullType(int)),
      'oauth_password_required',
      serializers.serialize(object.oauthPasswordRequired,
          specifiedType: const FullType(bool)),
      'markdown_enabled',
      serializers.serialize(object.markdownEnabled,
          specifiedType: const FullType(bool)),
      'markdown_email_enabled',
      serializers.serialize(object.markdownEmailEnabled,
          specifiedType: const FullType(bool)),
      'use_comma_as_decimal_place',
      serializers.serialize(object.useCommaAsDecimalPlace,
          specifiedType: const FullType(bool)),
      'report_include_drafts',
      serializers.serialize(object.reportIncludeDrafts,
          specifiedType: const FullType(bool)),
      'groups',
      serializers.serialize(object.groups,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GroupEntity)])),
      'activities',
      serializers.serialize(object.activities,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ActivityEntity)])),
      'tax_rates',
      serializers.serialize(object.taxRates,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TaxRateEntity)])),
      'task_statuses',
      serializers.serialize(object.taskStatuses,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TaskStatusEntity)])),
      'taskStatusMap',
      serializers.serialize(object.taskStatusMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(TaskStatusEntity)
          ])),
      'company_gateways',
      serializers.serialize(object.companyGateways,
          specifiedType: const FullType(
              BuiltList, const [const FullType(CompanyGatewayEntity)])),
      'expense_categories',
      serializers.serialize(object.expenseCategories,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ExpenseCategoryEntity)])),
      'users',
      serializers.serialize(object.users,
          specifiedType:
              const FullType(BuiltList, const [const FullType(UserEntity)])),
      'clients',
      serializers.serialize(object.clients,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ClientEntity)])),
      'products',
      serializers.serialize(object.products,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ProductEntity)])),
      'invoices',
      serializers.serialize(object.invoices,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
      'recurring_invoices',
      serializers.serialize(object.recurringInvoices,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
      'recurring_expenses',
      serializers.serialize(object.recurringExpenses,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ExpenseEntity)])),
      'payments',
      serializers.serialize(object.payments,
          specifiedType:
              const FullType(BuiltList, const [const FullType(PaymentEntity)])),
      'quotes',
      serializers.serialize(object.quotes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
      'credits',
      serializers.serialize(object.credits,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
      'tasks',
      serializers.serialize(object.tasks,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TaskEntity)])),
      'projects',
      serializers.serialize(object.projects,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ProjectEntity)])),
      'expenses',
      serializers.serialize(object.expenses,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ExpenseEntity)])),
      'vendors',
      serializers.serialize(object.vendors,
          specifiedType:
              const FullType(BuiltList, const [const FullType(VendorEntity)])),
      'designs',
      serializers.serialize(object.designs,
          specifiedType:
              const FullType(BuiltList, const [const FullType(DesignEntity)])),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
      'tokens_hashed',
      serializers.serialize(object.tokens,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TokenEntity)])),
      'webhooks',
      serializers.serialize(object.webhooks,
          specifiedType:
              const FullType(BuiltList, const [const FullType(WebhookEntity)])),
      'subscriptions',
      serializers.serialize(object.subscriptions,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SubscriptionEntity)])),
      'payment_terms',
      serializers.serialize(object.paymentTerms,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTermEntity)])),
      'system_logs',
      serializers.serialize(object.systemLogs,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SystemLogEntity)])),
      'client_registration_fields',
      serializers.serialize(object.clientRegistrationFields,
          specifiedType: const FullType(
              BuiltList, const [const FullType(RegistrationFieldEntity)])),
      'custom_fields',
      serializers.serialize(object.customFields,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'slack_webhook_url',
      serializers.serialize(object.slackWebhookUrl,
          specifiedType: const FullType(String)),
      'google_analytics_key',
      serializers.serialize(object.googleAnalyticsKey,
          specifiedType: const FullType(String)),
      'mark_expenses_invoiceable',
      serializers.serialize(object.markExpensesInvoiceable,
          specifiedType: const FullType(bool)),
      'mark_expenses_paid',
      serializers.serialize(object.markExpensesPaid,
          specifiedType: const FullType(bool)),
      'invoice_expense_documents',
      serializers.serialize(object.invoiceExpenseDocuments,
          specifiedType: const FullType(bool)),
      'invoice_task_documents',
      serializers.serialize(object.invoiceTaskDocuments,
          specifiedType: const FullType(bool)),
      'invoice_task_timelog',
      serializers.serialize(object.invoiceTaskTimelog,
          specifiedType: const FullType(bool)),
      'invoice_task_datelog',
      serializers.serialize(object.invoiceTaskDatelog,
          specifiedType: const FullType(bool)),
      'auto_start_tasks',
      serializers.serialize(object.autoStartTasks,
          specifiedType: const FullType(bool)),
      'show_tasks_table',
      serializers.serialize(object.showTasksTable,
          specifiedType: const FullType(bool)),
      'show_task_end_date',
      serializers.serialize(object.showTaskEndDate,
          specifiedType: const FullType(bool)),
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(SettingsEntity)),
      'enabled_modules',
      serializers.serialize(object.enabledModules,
          specifiedType: const FullType(int)),
      'calculate_expense_tax_by_amount',
      serializers.serialize(object.calculateExpenseTaxByAmount,
          specifiedType: const FullType(bool)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.entityType;
    if (value != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(EntityType)));
    }
    return result;
  }

  @override
  CompanyEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'custom_surcharge_taxes1':
          result.enableCustomSurchargeTaxes1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_surcharge_taxes2':
          result.enableCustomSurchargeTaxes2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_surcharge_taxes3':
          result.enableCustomSurchargeTaxes3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_surcharge_taxes4':
          result.enableCustomSurchargeTaxes4 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'size_id':
          result.sizeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'industry_id':
          result.industryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subdomain':
          result.subdomain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_mode':
          result.portalMode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_domain':
          result.portalDomain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'update_products':
          result.updateProducts = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'convert_products':
          result.convertProductExchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'convert_rate_to_client':
          result.convertRateToClient = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'fill_products':
          result.fillProducts = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_product_cost':
          result.enableProductCost = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_product_quantity':
          result.enableProductQuantity = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_product_discount':
          result.enableProductDiscount = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'default_task_is_date_based':
          result.defaultTaskIsDateBased = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'default_quantity':
          result.defaultQuantity = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_product_details':
          result.showProductDetails = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_can_register':
          result.clientCanRegister = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_large':
          result.isLarge = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_disabled':
          result.isDisabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_shop_api':
          result.enableShopApi = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'company_key':
          result.companyKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'first_day_of_week':
          result.firstDayOfWeek = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'first_month_of_year':
          result.firstMonthOfYear = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'enabled_tax_rates':
          result.numberOfInvoiceTaxRates = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'enabled_item_tax_rates':
          result.numberOfItemTaxRates = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'expense_inclusive_taxes':
          result.expenseInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'session_timeout':
          result.sessionTimeout = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'default_password_timeout':
          result.passwordTimeout = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'oauth_password_required':
          result.oauthPasswordRequired = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'markdown_enabled':
          result.markdownEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'markdown_email_enabled':
          result.markdownEmailEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'use_comma_as_decimal_place':
          result.useCommaAsDecimalPlace = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'report_include_drafts':
          result.reportIncludeDrafts = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'groups':
          result.groups.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GroupEntity)]))
              as BuiltList<Object>);
          break;
        case 'activities':
          result.activities.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ActivityEntity)]))
              as BuiltList<Object>);
          break;
        case 'tax_rates':
          result.taxRates.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaxRateEntity)]))
              as BuiltList<Object>);
          break;
        case 'task_statuses':
          result.taskStatuses.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaskStatusEntity)]))
              as BuiltList<Object>);
          break;
        case 'taskStatusMap':
          result.taskStatusMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TaskStatusEntity)
              ])));
          break;
        case 'company_gateways':
          result.companyGateways.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CompanyGatewayEntity)]))
              as BuiltList<Object>);
          break;
        case 'expense_categories':
          result.expenseCategories.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseCategoryEntity)]))
              as BuiltList<Object>);
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(UserEntity)]))
              as BuiltList<Object>);
          break;
        case 'clients':
          result.clients.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ClientEntity)]))
              as BuiltList<Object>);
          break;
        case 'products':
          result.products.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProductEntity)]))
              as BuiltList<Object>);
          break;
        case 'invoices':
          result.invoices.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))
              as BuiltList<Object>);
          break;
        case 'recurring_invoices':
          result.recurringInvoices.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))
              as BuiltList<Object>);
          break;
        case 'recurring_expenses':
          result.recurringExpenses.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseEntity)]))
              as BuiltList<Object>);
          break;
        case 'payments':
          result.payments.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentEntity)]))
              as BuiltList<Object>);
          break;
        case 'quotes':
          result.quotes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))
              as BuiltList<Object>);
          break;
        case 'credits':
          result.credits.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))
              as BuiltList<Object>);
          break;
        case 'tasks':
          result.tasks.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaskEntity)]))
              as BuiltList<Object>);
          break;
        case 'projects':
          result.projects.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProjectEntity)]))
              as BuiltList<Object>);
          break;
        case 'expenses':
          result.expenses.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseEntity)]))
              as BuiltList<Object>);
          break;
        case 'vendors':
          result.vendors.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(VendorEntity)]))
              as BuiltList<Object>);
          break;
        case 'designs':
          result.designs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DesignEntity)]))
              as BuiltList<Object>);
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))
              as BuiltList<Object>);
          break;
        case 'tokens_hashed':
          result.tokens.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TokenEntity)]))
              as BuiltList<Object>);
          break;
        case 'webhooks':
          result.webhooks.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(WebhookEntity)]))
              as BuiltList<Object>);
          break;
        case 'subscriptions':
          result.subscriptions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SubscriptionEntity)]))
              as BuiltList<Object>);
          break;
        case 'payment_terms':
          result.paymentTerms.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTermEntity)]))
              as BuiltList<Object>);
          break;
        case 'system_logs':
          result.systemLogs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SystemLogEntity)]))
              as BuiltList<Object>);
          break;
        case 'client_registration_fields':
          result.clientRegistrationFields.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(RegistrationFieldEntity)
              ])) as BuiltList<Object>);
          break;
        case 'custom_fields':
          result.customFields.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'slack_webhook_url':
          result.slackWebhookUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'google_analytics_key':
          result.googleAnalyticsKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mark_expenses_invoiceable':
          result.markExpensesInvoiceable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'mark_expenses_paid':
          result.markExpensesPaid = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_expense_documents':
          result.invoiceExpenseDocuments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_task_documents':
          result.invoiceTaskDocuments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_task_timelog':
          result.invoiceTaskTimelog = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_task_datelog':
          result.invoiceTaskDatelog = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_start_tasks':
          result.autoStartTasks = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_tasks_table':
          result.showTasksTable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_task_end_date':
          result.showTaskEndDate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
              specifiedType: const FullType(SettingsEntity)) as SettingsEntity);
          break;
        case 'enabled_modules':
          result.enabledModules = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'calculate_expense_tax_by_amount':
          result.calculateExpenseTaxByAmount = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'entity_type':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GatewayEntitySerializer implements StructuredSerializer<GatewayEntity> {
  @override
  final Iterable<Type> types = const [GatewayEntity, _$GatewayEntity];
  @override
  final String wireName = 'GatewayEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, GatewayEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'key',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'is_offsite',
      serializers.serialize(object.isOffsite,
          specifiedType: const FullType(bool)),
      'visible',
      serializers.serialize(object.isVisible,
          specifiedType: const FullType(bool)),
      'sort_order',
      serializers.serialize(object.sortOrder,
          specifiedType: const FullType(int)),
      'default_gateway_type_id',
      serializers.serialize(object.defaultGatewayTypeId,
          specifiedType: const FullType(String)),
      'site_url',
      serializers.serialize(object.siteUrl,
          specifiedType: const FullType(String)),
      'options',
      serializers.serialize(object.options,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(GatewayOptionsEntity)
          ])),
      'fields',
      serializers.serialize(object.fields,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GatewayEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GatewayEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'key':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_offsite':
          result.isOffsite = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'visible':
          result.isVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'sort_order':
          result.sortOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'default_gateway_type_id':
          result.defaultGatewayTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'site_url':
          result.siteUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'options':
          result.options.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(GatewayOptionsEntity)
              ])));
          break;
        case 'fields':
          result.fields = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GatewayOptionsEntitySerializer
    implements StructuredSerializer<GatewayOptionsEntity> {
  @override
  final Iterable<Type> types = const [
    GatewayOptionsEntity,
    _$GatewayOptionsEntity
  ];
  @override
  final String wireName = 'GatewayOptionsEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, GatewayOptionsEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'refund',
      serializers.serialize(object.supportRefunds,
          specifiedType: const FullType(bool)),
      'token_billing',
      serializers.serialize(object.supportTokenBilling,
          specifiedType: const FullType(bool)),
    ];
    Object value;
    value = object.webhooks;
    if (value != null) {
      result
        ..add('webhooks')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  GatewayOptionsEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GatewayOptionsEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'refund':
          result.supportRefunds = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'token_billing':
          result.supportTokenBilling = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'webhooks':
          result.webhooks.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$UserCompanyEntitySerializer
    implements StructuredSerializer<UserCompanyEntity> {
  @override
  final Iterable<Type> types = const [UserCompanyEntity, _$UserCompanyEntity];
  @override
  final String wireName = 'UserCompanyEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, UserCompanyEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'is_admin',
      serializers.serialize(object.isAdmin,
          specifiedType: const FullType(bool)),
      'is_owner',
      serializers.serialize(object.isOwner,
          specifiedType: const FullType(bool)),
      'permissions_updated_at',
      serializers.serialize(object.permissionsUpdatedAt,
          specifiedType: const FullType(int)),
      'permissions',
      serializers.serialize(object.permissions,
          specifiedType: const FullType(String)),
      'ninja_portal_url',
      serializers.serialize(object.ninjaPortalUrl,
          specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.notifications;
    if (value != null) {
      result
        ..add('notifications')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)])
            ])));
    }
    value = object.company;
    if (value != null) {
      result
        ..add('company')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(CompanyEntity)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UserEntity)));
    }
    value = object.token;
    if (value != null) {
      result
        ..add('token')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(TokenEntity)));
    }
    value = object.account;
    if (value != null) {
      result
        ..add('account')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(AccountEntity)));
    }
    value = object.settings;
    if (value != null) {
      result
        ..add('settings')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UserSettingsEntity)));
    }
    return result;
  }

  @override
  UserCompanyEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserCompanyEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'is_admin':
          result.isAdmin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'permissions_updated_at':
          result.permissionsUpdatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'permissions':
          result.permissions = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notifications':
          result.notifications.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ])));
          break;
        case 'company':
          result.company.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyEntity)) as CompanyEntity);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity)) as UserEntity);
          break;
        case 'token':
          result.token.replace(serializers.deserialize(value,
              specifiedType: const FullType(TokenEntity)) as TokenEntity);
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
              specifiedType: const FullType(AccountEntity)) as AccountEntity);
          break;
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserSettingsEntity))
              as UserSettingsEntity);
          break;
        case 'ninja_portal_url':
          result.ninjaPortalUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserSettingsEntitySerializer
    implements StructuredSerializer<UserSettingsEntity> {
  @override
  final Iterable<Type> types = const [UserSettingsEntity, _$UserSettingsEntity];
  @override
  final String wireName = 'UserSettingsEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, UserSettingsEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'table_columns',
      serializers.serialize(object.tableColumns,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(String)])
          ])),
      'report_settings',
      serializers.serialize(object.reportSettings,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(ReportSettingsEntity)
          ])),
      'number_years_active',
      serializers.serialize(object.numberYearsActive,
          specifiedType: const FullType(int)),
      'include_deleted_clients',
      serializers.serialize(object.includeDeletedClients,
          specifiedType: const FullType(bool)),
    ];
    Object value;
    value = object.accentColor;
    if (value != null) {
      result
        ..add('accent_color')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserSettingsEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserSettingsEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'accent_color':
          result.accentColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'table_columns':
          result.tableColumns.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ])));
          break;
        case 'report_settings':
          result.reportSettings.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(ReportSettingsEntity)
              ])));
          break;
        case 'number_years_active':
          result.numberYearsActive = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'include_deleted_clients':
          result.includeDeletedClients = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ReportSettingsEntitySerializer
    implements StructuredSerializer<ReportSettingsEntity> {
  @override
  final Iterable<Type> types = const [
    ReportSettingsEntity,
    _$ReportSettingsEntity
  ];
  @override
  final String wireName = 'ReportSettingsEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ReportSettingsEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'sort_column',
      serializers.serialize(object.sortColumn,
          specifiedType: const FullType(String)),
      'sort_ascending',
      serializers.serialize(object.sortAscending,
          specifiedType: const FullType(bool)),
      'sort_totals_index',
      serializers.serialize(object.sortTotalsIndex,
          specifiedType: const FullType(int)),
      'sort_totals_ascending',
      serializers.serialize(object.sortTotalsAscending,
          specifiedType: const FullType(bool)),
      'columns',
      serializers.serialize(object.columns,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  ReportSettingsEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReportSettingsEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'sort_column':
          result.sortColumn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sort_ascending':
          result.sortAscending = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'sort_totals_index':
          result.sortTotalsIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sort_totals_ascending':
          result.sortTotalsAscending = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'columns':
          result.columns.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyItemResponseSerializer
    implements StructuredSerializer<CompanyItemResponse> {
  @override
  final Iterable<Type> types = const [
    CompanyItemResponse,
    _$CompanyItemResponse
  ];
  @override
  final String wireName = 'CompanyItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CompanyItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CompanyEntity)),
    ];

    return result;
  }

  @override
  CompanyItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyEntity)) as CompanyEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$RegistrationFieldEntitySerializer
    implements StructuredSerializer<RegistrationFieldEntity> {
  @override
  final Iterable<Type> types = const [
    RegistrationFieldEntity,
    _$RegistrationFieldEntity
  ];
  @override
  final String wireName = 'RegistrationFieldEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, RegistrationFieldEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'key',
      serializers.serialize(object.key, specifiedType: const FullType(String)),
      'required',
      serializers.serialize(object.required,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  RegistrationFieldEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RegistrationFieldEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'key':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'required':
          result.required = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyEntity extends CompanyEntity {
  @override
  final bool enableCustomSurchargeTaxes1;
  @override
  final bool enableCustomSurchargeTaxes2;
  @override
  final bool enableCustomSurchargeTaxes3;
  @override
  final bool enableCustomSurchargeTaxes4;
  @override
  final String sizeId;
  @override
  final String industryId;
  @override
  final String subdomain;
  @override
  final String portalMode;
  @override
  final String portalDomain;
  @override
  final bool updateProducts;
  @override
  final bool convertProductExchangeRate;
  @override
  final bool convertRateToClient;
  @override
  final bool fillProducts;
  @override
  final bool enableProductCost;
  @override
  final bool enableProductQuantity;
  @override
  final bool enableProductDiscount;
  @override
  final bool defaultTaskIsDateBased;
  @override
  final bool defaultQuantity;
  @override
  final bool showProductDetails;
  @override
  final bool clientCanRegister;
  @override
  final bool isLarge;
  @override
  final bool isDisabled;
  @override
  final bool enableShopApi;
  @override
  final String companyKey;
  @override
  final String firstDayOfWeek;
  @override
  final String firstMonthOfYear;
  @override
  final int numberOfInvoiceTaxRates;
  @override
  final int numberOfItemTaxRates;
  @override
  final bool expenseInclusiveTaxes;
  @override
  final int sessionTimeout;
  @override
  final int passwordTimeout;
  @override
  final bool oauthPasswordRequired;
  @override
  final bool markdownEnabled;
  @override
  final bool markdownEmailEnabled;
  @override
  final bool useCommaAsDecimalPlace;
  @override
  final bool reportIncludeDrafts;
  @override
  final BuiltList<GroupEntity> groups;
  @override
  final BuiltList<ActivityEntity> activities;
  @override
  final BuiltList<TaxRateEntity> taxRates;
  @override
  final BuiltList<TaskStatusEntity> taskStatuses;
  @override
  final BuiltMap<String, TaskStatusEntity> taskStatusMap;
  @override
  final BuiltList<CompanyGatewayEntity> companyGateways;
  @override
  final BuiltList<ExpenseCategoryEntity> expenseCategories;
  @override
  final BuiltList<UserEntity> users;
  @override
  final BuiltList<ClientEntity> clients;
  @override
  final BuiltList<ProductEntity> products;
  @override
  final BuiltList<InvoiceEntity> invoices;
  @override
  final BuiltList<InvoiceEntity> recurringInvoices;
  @override
  final BuiltList<ExpenseEntity> recurringExpenses;
  @override
  final BuiltList<PaymentEntity> payments;
  @override
  final BuiltList<InvoiceEntity> quotes;
  @override
  final BuiltList<InvoiceEntity> credits;
  @override
  final BuiltList<TaskEntity> tasks;
  @override
  final BuiltList<ProjectEntity> projects;
  @override
  final BuiltList<ExpenseEntity> expenses;
  @override
  final BuiltList<VendorEntity> vendors;
  @override
  final BuiltList<DesignEntity> designs;
  @override
  final BuiltList<DocumentEntity> documents;
  @override
  final BuiltList<TokenEntity> tokens;
  @override
  final BuiltList<WebhookEntity> webhooks;
  @override
  final BuiltList<SubscriptionEntity> subscriptions;
  @override
  final BuiltList<PaymentTermEntity> paymentTerms;
  @override
  final BuiltList<SystemLogEntity> systemLogs;
  @override
  final BuiltList<RegistrationFieldEntity> clientRegistrationFields;
  @override
  final BuiltMap<String, String> customFields;
  @override
  final String slackWebhookUrl;
  @override
  final String googleAnalyticsKey;
  @override
  final bool markExpensesInvoiceable;
  @override
  final bool markExpensesPaid;
  @override
  final bool invoiceExpenseDocuments;
  @override
  final bool invoiceTaskDocuments;
  @override
  final bool invoiceTaskTimelog;
  @override
  final bool invoiceTaskDatelog;
  @override
  final bool autoStartTasks;
  @override
  final bool showTasksTable;
  @override
  final bool showTaskEndDate;
  @override
  final SettingsEntity settings;
  @override
  final int enabledModules;
  @override
  final bool calculateExpenseTaxByAmount;
  @override
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final String createdUserId;
  @override
  final String assignedUserId;
  @override
  final EntityType entityType;
  @override
  final String id;

  factory _$CompanyEntity([void Function(CompanyEntityBuilder) updates]) =>
      (new CompanyEntityBuilder()..update(updates)).build();

  _$CompanyEntity._(
      {this.enableCustomSurchargeTaxes1,
      this.enableCustomSurchargeTaxes2,
      this.enableCustomSurchargeTaxes3,
      this.enableCustomSurchargeTaxes4,
      this.sizeId,
      this.industryId,
      this.subdomain,
      this.portalMode,
      this.portalDomain,
      this.updateProducts,
      this.convertProductExchangeRate,
      this.convertRateToClient,
      this.fillProducts,
      this.enableProductCost,
      this.enableProductQuantity,
      this.enableProductDiscount,
      this.defaultTaskIsDateBased,
      this.defaultQuantity,
      this.showProductDetails,
      this.clientCanRegister,
      this.isLarge,
      this.isDisabled,
      this.enableShopApi,
      this.companyKey,
      this.firstDayOfWeek,
      this.firstMonthOfYear,
      this.numberOfInvoiceTaxRates,
      this.numberOfItemTaxRates,
      this.expenseInclusiveTaxes,
      this.sessionTimeout,
      this.passwordTimeout,
      this.oauthPasswordRequired,
      this.markdownEnabled,
      this.markdownEmailEnabled,
      this.useCommaAsDecimalPlace,
      this.reportIncludeDrafts,
      this.groups,
      this.activities,
      this.taxRates,
      this.taskStatuses,
      this.taskStatusMap,
      this.companyGateways,
      this.expenseCategories,
      this.users,
      this.clients,
      this.products,
      this.invoices,
      this.recurringInvoices,
      this.recurringExpenses,
      this.payments,
      this.quotes,
      this.credits,
      this.tasks,
      this.projects,
      this.expenses,
      this.vendors,
      this.designs,
      this.documents,
      this.tokens,
      this.webhooks,
      this.subscriptions,
      this.paymentTerms,
      this.systemLogs,
      this.clientRegistrationFields,
      this.customFields,
      this.slackWebhookUrl,
      this.googleAnalyticsKey,
      this.markExpensesInvoiceable,
      this.markExpensesPaid,
      this.invoiceExpenseDocuments,
      this.invoiceTaskDocuments,
      this.invoiceTaskTimelog,
      this.invoiceTaskDatelog,
      this.autoStartTasks,
      this.showTasksTable,
      this.showTaskEndDate,
      this.settings,
      this.enabledModules,
      this.calculateExpenseTaxByAmount,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.entityType,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(enableCustomSurchargeTaxes1,
        'CompanyEntity', 'enableCustomSurchargeTaxes1');
    BuiltValueNullFieldError.checkNotNull(enableCustomSurchargeTaxes2,
        'CompanyEntity', 'enableCustomSurchargeTaxes2');
    BuiltValueNullFieldError.checkNotNull(enableCustomSurchargeTaxes3,
        'CompanyEntity', 'enableCustomSurchargeTaxes3');
    BuiltValueNullFieldError.checkNotNull(enableCustomSurchargeTaxes4,
        'CompanyEntity', 'enableCustomSurchargeTaxes4');
    BuiltValueNullFieldError.checkNotNull(sizeId, 'CompanyEntity', 'sizeId');
    BuiltValueNullFieldError.checkNotNull(
        industryId, 'CompanyEntity', 'industryId');
    BuiltValueNullFieldError.checkNotNull(
        subdomain, 'CompanyEntity', 'subdomain');
    BuiltValueNullFieldError.checkNotNull(
        portalMode, 'CompanyEntity', 'portalMode');
    BuiltValueNullFieldError.checkNotNull(
        portalDomain, 'CompanyEntity', 'portalDomain');
    BuiltValueNullFieldError.checkNotNull(
        updateProducts, 'CompanyEntity', 'updateProducts');
    BuiltValueNullFieldError.checkNotNull(convertProductExchangeRate,
        'CompanyEntity', 'convertProductExchangeRate');
    BuiltValueNullFieldError.checkNotNull(
        convertRateToClient, 'CompanyEntity', 'convertRateToClient');
    BuiltValueNullFieldError.checkNotNull(
        fillProducts, 'CompanyEntity', 'fillProducts');
    BuiltValueNullFieldError.checkNotNull(
        enableProductCost, 'CompanyEntity', 'enableProductCost');
    BuiltValueNullFieldError.checkNotNull(
        enableProductQuantity, 'CompanyEntity', 'enableProductQuantity');
    BuiltValueNullFieldError.checkNotNull(
        enableProductDiscount, 'CompanyEntity', 'enableProductDiscount');
    BuiltValueNullFieldError.checkNotNull(
        defaultTaskIsDateBased, 'CompanyEntity', 'defaultTaskIsDateBased');
    BuiltValueNullFieldError.checkNotNull(
        defaultQuantity, 'CompanyEntity', 'defaultQuantity');
    BuiltValueNullFieldError.checkNotNull(
        showProductDetails, 'CompanyEntity', 'showProductDetails');
    BuiltValueNullFieldError.checkNotNull(
        clientCanRegister, 'CompanyEntity', 'clientCanRegister');
    BuiltValueNullFieldError.checkNotNull(isLarge, 'CompanyEntity', 'isLarge');
    BuiltValueNullFieldError.checkNotNull(
        isDisabled, 'CompanyEntity', 'isDisabled');
    BuiltValueNullFieldError.checkNotNull(
        enableShopApi, 'CompanyEntity', 'enableShopApi');
    BuiltValueNullFieldError.checkNotNull(
        companyKey, 'CompanyEntity', 'companyKey');
    BuiltValueNullFieldError.checkNotNull(
        firstDayOfWeek, 'CompanyEntity', 'firstDayOfWeek');
    BuiltValueNullFieldError.checkNotNull(
        firstMonthOfYear, 'CompanyEntity', 'firstMonthOfYear');
    BuiltValueNullFieldError.checkNotNull(
        numberOfInvoiceTaxRates, 'CompanyEntity', 'numberOfInvoiceTaxRates');
    BuiltValueNullFieldError.checkNotNull(
        numberOfItemTaxRates, 'CompanyEntity', 'numberOfItemTaxRates');
    BuiltValueNullFieldError.checkNotNull(
        expenseInclusiveTaxes, 'CompanyEntity', 'expenseInclusiveTaxes');
    BuiltValueNullFieldError.checkNotNull(
        sessionTimeout, 'CompanyEntity', 'sessionTimeout');
    BuiltValueNullFieldError.checkNotNull(
        passwordTimeout, 'CompanyEntity', 'passwordTimeout');
    BuiltValueNullFieldError.checkNotNull(
        oauthPasswordRequired, 'CompanyEntity', 'oauthPasswordRequired');
    BuiltValueNullFieldError.checkNotNull(
        markdownEnabled, 'CompanyEntity', 'markdownEnabled');
    BuiltValueNullFieldError.checkNotNull(
        markdownEmailEnabled, 'CompanyEntity', 'markdownEmailEnabled');
    BuiltValueNullFieldError.checkNotNull(
        useCommaAsDecimalPlace, 'CompanyEntity', 'useCommaAsDecimalPlace');
    BuiltValueNullFieldError.checkNotNull(
        reportIncludeDrafts, 'CompanyEntity', 'reportIncludeDrafts');
    BuiltValueNullFieldError.checkNotNull(groups, 'CompanyEntity', 'groups');
    BuiltValueNullFieldError.checkNotNull(
        activities, 'CompanyEntity', 'activities');
    BuiltValueNullFieldError.checkNotNull(
        taxRates, 'CompanyEntity', 'taxRates');
    BuiltValueNullFieldError.checkNotNull(
        taskStatuses, 'CompanyEntity', 'taskStatuses');
    BuiltValueNullFieldError.checkNotNull(
        taskStatusMap, 'CompanyEntity', 'taskStatusMap');
    BuiltValueNullFieldError.checkNotNull(
        companyGateways, 'CompanyEntity', 'companyGateways');
    BuiltValueNullFieldError.checkNotNull(
        expenseCategories, 'CompanyEntity', 'expenseCategories');
    BuiltValueNullFieldError.checkNotNull(users, 'CompanyEntity', 'users');
    BuiltValueNullFieldError.checkNotNull(clients, 'CompanyEntity', 'clients');
    BuiltValueNullFieldError.checkNotNull(
        products, 'CompanyEntity', 'products');
    BuiltValueNullFieldError.checkNotNull(
        invoices, 'CompanyEntity', 'invoices');
    BuiltValueNullFieldError.checkNotNull(
        recurringInvoices, 'CompanyEntity', 'recurringInvoices');
    BuiltValueNullFieldError.checkNotNull(
        recurringExpenses, 'CompanyEntity', 'recurringExpenses');
    BuiltValueNullFieldError.checkNotNull(
        payments, 'CompanyEntity', 'payments');
    BuiltValueNullFieldError.checkNotNull(quotes, 'CompanyEntity', 'quotes');
    BuiltValueNullFieldError.checkNotNull(credits, 'CompanyEntity', 'credits');
    BuiltValueNullFieldError.checkNotNull(tasks, 'CompanyEntity', 'tasks');
    BuiltValueNullFieldError.checkNotNull(
        projects, 'CompanyEntity', 'projects');
    BuiltValueNullFieldError.checkNotNull(
        expenses, 'CompanyEntity', 'expenses');
    BuiltValueNullFieldError.checkNotNull(vendors, 'CompanyEntity', 'vendors');
    BuiltValueNullFieldError.checkNotNull(designs, 'CompanyEntity', 'designs');
    BuiltValueNullFieldError.checkNotNull(
        documents, 'CompanyEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(tokens, 'CompanyEntity', 'tokens');
    BuiltValueNullFieldError.checkNotNull(
        webhooks, 'CompanyEntity', 'webhooks');
    BuiltValueNullFieldError.checkNotNull(
        subscriptions, 'CompanyEntity', 'subscriptions');
    BuiltValueNullFieldError.checkNotNull(
        paymentTerms, 'CompanyEntity', 'paymentTerms');
    BuiltValueNullFieldError.checkNotNull(
        systemLogs, 'CompanyEntity', 'systemLogs');
    BuiltValueNullFieldError.checkNotNull(
        clientRegistrationFields, 'CompanyEntity', 'clientRegistrationFields');
    BuiltValueNullFieldError.checkNotNull(
        customFields, 'CompanyEntity', 'customFields');
    BuiltValueNullFieldError.checkNotNull(
        slackWebhookUrl, 'CompanyEntity', 'slackWebhookUrl');
    BuiltValueNullFieldError.checkNotNull(
        googleAnalyticsKey, 'CompanyEntity', 'googleAnalyticsKey');
    BuiltValueNullFieldError.checkNotNull(
        markExpensesInvoiceable, 'CompanyEntity', 'markExpensesInvoiceable');
    BuiltValueNullFieldError.checkNotNull(
        markExpensesPaid, 'CompanyEntity', 'markExpensesPaid');
    BuiltValueNullFieldError.checkNotNull(
        invoiceExpenseDocuments, 'CompanyEntity', 'invoiceExpenseDocuments');
    BuiltValueNullFieldError.checkNotNull(
        invoiceTaskDocuments, 'CompanyEntity', 'invoiceTaskDocuments');
    BuiltValueNullFieldError.checkNotNull(
        invoiceTaskTimelog, 'CompanyEntity', 'invoiceTaskTimelog');
    BuiltValueNullFieldError.checkNotNull(
        invoiceTaskDatelog, 'CompanyEntity', 'invoiceTaskDatelog');
    BuiltValueNullFieldError.checkNotNull(
        autoStartTasks, 'CompanyEntity', 'autoStartTasks');
    BuiltValueNullFieldError.checkNotNull(
        showTasksTable, 'CompanyEntity', 'showTasksTable');
    BuiltValueNullFieldError.checkNotNull(
        showTaskEndDate, 'CompanyEntity', 'showTaskEndDate');
    BuiltValueNullFieldError.checkNotNull(
        settings, 'CompanyEntity', 'settings');
    BuiltValueNullFieldError.checkNotNull(
        enabledModules, 'CompanyEntity', 'enabledModules');
    BuiltValueNullFieldError.checkNotNull(calculateExpenseTaxByAmount,
        'CompanyEntity', 'calculateExpenseTaxByAmount');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'CompanyEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'CompanyEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'CompanyEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'CompanyEntity', 'id');
  }

  @override
  CompanyEntity rebuild(void Function(CompanyEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyEntityBuilder toBuilder() => new CompanyEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyEntity &&
        enableCustomSurchargeTaxes1 == other.enableCustomSurchargeTaxes1 &&
        enableCustomSurchargeTaxes2 == other.enableCustomSurchargeTaxes2 &&
        enableCustomSurchargeTaxes3 == other.enableCustomSurchargeTaxes3 &&
        enableCustomSurchargeTaxes4 == other.enableCustomSurchargeTaxes4 &&
        sizeId == other.sizeId &&
        industryId == other.industryId &&
        subdomain == other.subdomain &&
        portalMode == other.portalMode &&
        portalDomain == other.portalDomain &&
        updateProducts == other.updateProducts &&
        convertProductExchangeRate == other.convertProductExchangeRate &&
        convertRateToClient == other.convertRateToClient &&
        fillProducts == other.fillProducts &&
        enableProductCost == other.enableProductCost &&
        enableProductQuantity == other.enableProductQuantity &&
        enableProductDiscount == other.enableProductDiscount &&
        defaultTaskIsDateBased == other.defaultTaskIsDateBased &&
        defaultQuantity == other.defaultQuantity &&
        showProductDetails == other.showProductDetails &&
        clientCanRegister == other.clientCanRegister &&
        isLarge == other.isLarge &&
        isDisabled == other.isDisabled &&
        enableShopApi == other.enableShopApi &&
        companyKey == other.companyKey &&
        firstDayOfWeek == other.firstDayOfWeek &&
        firstMonthOfYear == other.firstMonthOfYear &&
        numberOfInvoiceTaxRates == other.numberOfInvoiceTaxRates &&
        numberOfItemTaxRates == other.numberOfItemTaxRates &&
        expenseInclusiveTaxes == other.expenseInclusiveTaxes &&
        sessionTimeout == other.sessionTimeout &&
        passwordTimeout == other.passwordTimeout &&
        oauthPasswordRequired == other.oauthPasswordRequired &&
        markdownEnabled == other.markdownEnabled &&
        markdownEmailEnabled == other.markdownEmailEnabled &&
        useCommaAsDecimalPlace == other.useCommaAsDecimalPlace &&
        reportIncludeDrafts == other.reportIncludeDrafts &&
        groups == other.groups &&
        activities == other.activities &&
        taxRates == other.taxRates &&
        taskStatuses == other.taskStatuses &&
        taskStatusMap == other.taskStatusMap &&
        companyGateways == other.companyGateways &&
        expenseCategories == other.expenseCategories &&
        users == other.users &&
        clients == other.clients &&
        products == other.products &&
        invoices == other.invoices &&
        recurringInvoices == other.recurringInvoices &&
        recurringExpenses == other.recurringExpenses &&
        payments == other.payments &&
        quotes == other.quotes &&
        credits == other.credits &&
        tasks == other.tasks &&
        projects == other.projects &&
        expenses == other.expenses &&
        vendors == other.vendors &&
        designs == other.designs &&
        documents == other.documents &&
        tokens == other.tokens &&
        webhooks == other.webhooks &&
        subscriptions == other.subscriptions &&
        paymentTerms == other.paymentTerms &&
        systemLogs == other.systemLogs &&
        clientRegistrationFields == other.clientRegistrationFields &&
        customFields == other.customFields &&
        slackWebhookUrl == other.slackWebhookUrl &&
        googleAnalyticsKey == other.googleAnalyticsKey &&
        markExpensesInvoiceable == other.markExpensesInvoiceable &&
        markExpensesPaid == other.markExpensesPaid &&
        invoiceExpenseDocuments == other.invoiceExpenseDocuments &&
        invoiceTaskDocuments == other.invoiceTaskDocuments &&
        invoiceTaskTimelog == other.invoiceTaskTimelog &&
        invoiceTaskDatelog == other.invoiceTaskDatelog &&
        autoStartTasks == other.autoStartTasks &&
        showTasksTable == other.showTasksTable &&
        showTaskEndDate == other.showTaskEndDate &&
        settings == other.settings &&
        enabledModules == other.enabledModules &&
        calculateExpenseTaxByAmount == other.calculateExpenseTaxByAmount &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        entityType == other.entityType &&
        id == other.id;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, enableCustomSurchargeTaxes1.hashCode), enableCustomSurchargeTaxes2.hashCode), enableCustomSurchargeTaxes3.hashCode), enableCustomSurchargeTaxes4.hashCode), sizeId.hashCode), industryId.hashCode), subdomain.hashCode), portalMode.hashCode), portalDomain.hashCode), updateProducts.hashCode), convertProductExchangeRate.hashCode), convertRateToClient.hashCode), fillProducts.hashCode), enableProductCost.hashCode), enableProductQuantity.hashCode), enableProductDiscount.hashCode), defaultTaskIsDateBased.hashCode), defaultQuantity.hashCode), showProductDetails.hashCode), clientCanRegister.hashCode), isLarge.hashCode), isDisabled.hashCode), enableShopApi.hashCode), companyKey.hashCode), firstDayOfWeek.hashCode), firstMonthOfYear.hashCode), numberOfInvoiceTaxRates.hashCode), numberOfItemTaxRates.hashCode), expenseInclusiveTaxes.hashCode), sessionTimeout.hashCode), passwordTimeout.hashCode), oauthPasswordRequired.hashCode), markdownEnabled.hashCode), markdownEmailEnabled.hashCode), useCommaAsDecimalPlace.hashCode), reportIncludeDrafts.hashCode), groups.hashCode), activities.hashCode), taxRates.hashCode), taskStatuses.hashCode), taskStatusMap.hashCode), companyGateways.hashCode), expenseCategories.hashCode), users.hashCode), clients.hashCode), products.hashCode), invoices.hashCode), recurringInvoices.hashCode), recurringExpenses.hashCode), payments.hashCode), quotes.hashCode), credits.hashCode), tasks.hashCode), projects.hashCode), expenses.hashCode), vendors.hashCode), designs.hashCode), documents.hashCode), tokens.hashCode), webhooks.hashCode), subscriptions.hashCode), paymentTerms.hashCode), systemLogs.hashCode), clientRegistrationFields.hashCode), customFields.hashCode), slackWebhookUrl.hashCode), googleAnalyticsKey.hashCode), markExpensesInvoiceable.hashCode), markExpensesPaid.hashCode),
                                                                                invoiceExpenseDocuments.hashCode),
                                                                            invoiceTaskDocuments.hashCode),
                                                                        invoiceTaskTimelog.hashCode),
                                                                    invoiceTaskDatelog.hashCode),
                                                                autoStartTasks.hashCode),
                                                            showTasksTable.hashCode),
                                                        showTaskEndDate.hashCode),
                                                    settings.hashCode),
                                                enabledModules.hashCode),
                                            calculateExpenseTaxByAmount.hashCode),
                                        isChanged.hashCode),
                                    createdAt.hashCode),
                                updatedAt.hashCode),
                            archivedAt.hashCode),
                        isDeleted.hashCode),
                    createdUserId.hashCode),
                assignedUserId.hashCode),
            entityType.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyEntity')
          ..add('enableCustomSurchargeTaxes1', enableCustomSurchargeTaxes1)
          ..add('enableCustomSurchargeTaxes2', enableCustomSurchargeTaxes2)
          ..add('enableCustomSurchargeTaxes3', enableCustomSurchargeTaxes3)
          ..add('enableCustomSurchargeTaxes4', enableCustomSurchargeTaxes4)
          ..add('sizeId', sizeId)
          ..add('industryId', industryId)
          ..add('subdomain', subdomain)
          ..add('portalMode', portalMode)
          ..add('portalDomain', portalDomain)
          ..add('updateProducts', updateProducts)
          ..add('convertProductExchangeRate', convertProductExchangeRate)
          ..add('convertRateToClient', convertRateToClient)
          ..add('fillProducts', fillProducts)
          ..add('enableProductCost', enableProductCost)
          ..add('enableProductQuantity', enableProductQuantity)
          ..add('enableProductDiscount', enableProductDiscount)
          ..add('defaultTaskIsDateBased', defaultTaskIsDateBased)
          ..add('defaultQuantity', defaultQuantity)
          ..add('showProductDetails', showProductDetails)
          ..add('clientCanRegister', clientCanRegister)
          ..add('isLarge', isLarge)
          ..add('isDisabled', isDisabled)
          ..add('enableShopApi', enableShopApi)
          ..add('companyKey', companyKey)
          ..add('firstDayOfWeek', firstDayOfWeek)
          ..add('firstMonthOfYear', firstMonthOfYear)
          ..add('numberOfInvoiceTaxRates', numberOfInvoiceTaxRates)
          ..add('numberOfItemTaxRates', numberOfItemTaxRates)
          ..add('expenseInclusiveTaxes', expenseInclusiveTaxes)
          ..add('sessionTimeout', sessionTimeout)
          ..add('passwordTimeout', passwordTimeout)
          ..add('oauthPasswordRequired', oauthPasswordRequired)
          ..add('markdownEnabled', markdownEnabled)
          ..add('markdownEmailEnabled', markdownEmailEnabled)
          ..add('useCommaAsDecimalPlace', useCommaAsDecimalPlace)
          ..add('reportIncludeDrafts', reportIncludeDrafts)
          ..add('groups', groups)
          ..add('activities', activities)
          ..add('taxRates', taxRates)
          ..add('taskStatuses', taskStatuses)
          ..add('taskStatusMap', taskStatusMap)
          ..add('companyGateways', companyGateways)
          ..add('expenseCategories', expenseCategories)
          ..add('users', users)
          ..add('clients', clients)
          ..add('products', products)
          ..add('invoices', invoices)
          ..add('recurringInvoices', recurringInvoices)
          ..add('recurringExpenses', recurringExpenses)
          ..add('payments', payments)
          ..add('quotes', quotes)
          ..add('credits', credits)
          ..add('tasks', tasks)
          ..add('projects', projects)
          ..add('expenses', expenses)
          ..add('vendors', vendors)
          ..add('designs', designs)
          ..add('documents', documents)
          ..add('tokens', tokens)
          ..add('webhooks', webhooks)
          ..add('subscriptions', subscriptions)
          ..add('paymentTerms', paymentTerms)
          ..add('systemLogs', systemLogs)
          ..add('clientRegistrationFields', clientRegistrationFields)
          ..add('customFields', customFields)
          ..add('slackWebhookUrl', slackWebhookUrl)
          ..add('googleAnalyticsKey', googleAnalyticsKey)
          ..add('markExpensesInvoiceable', markExpensesInvoiceable)
          ..add('markExpensesPaid', markExpensesPaid)
          ..add('invoiceExpenseDocuments', invoiceExpenseDocuments)
          ..add('invoiceTaskDocuments', invoiceTaskDocuments)
          ..add('invoiceTaskTimelog', invoiceTaskTimelog)
          ..add('invoiceTaskDatelog', invoiceTaskDatelog)
          ..add('autoStartTasks', autoStartTasks)
          ..add('showTasksTable', showTasksTable)
          ..add('showTaskEndDate', showTaskEndDate)
          ..add('settings', settings)
          ..add('enabledModules', enabledModules)
          ..add('calculateExpenseTaxByAmount', calculateExpenseTaxByAmount)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('entityType', entityType)
          ..add('id', id))
        .toString();
  }
}

class CompanyEntityBuilder
    implements Builder<CompanyEntity, CompanyEntityBuilder> {
  _$CompanyEntity _$v;

  bool _enableCustomSurchargeTaxes1;
  bool get enableCustomSurchargeTaxes1 => _$this._enableCustomSurchargeTaxes1;
  set enableCustomSurchargeTaxes1(bool enableCustomSurchargeTaxes1) =>
      _$this._enableCustomSurchargeTaxes1 = enableCustomSurchargeTaxes1;

  bool _enableCustomSurchargeTaxes2;
  bool get enableCustomSurchargeTaxes2 => _$this._enableCustomSurchargeTaxes2;
  set enableCustomSurchargeTaxes2(bool enableCustomSurchargeTaxes2) =>
      _$this._enableCustomSurchargeTaxes2 = enableCustomSurchargeTaxes2;

  bool _enableCustomSurchargeTaxes3;
  bool get enableCustomSurchargeTaxes3 => _$this._enableCustomSurchargeTaxes3;
  set enableCustomSurchargeTaxes3(bool enableCustomSurchargeTaxes3) =>
      _$this._enableCustomSurchargeTaxes3 = enableCustomSurchargeTaxes3;

  bool _enableCustomSurchargeTaxes4;
  bool get enableCustomSurchargeTaxes4 => _$this._enableCustomSurchargeTaxes4;
  set enableCustomSurchargeTaxes4(bool enableCustomSurchargeTaxes4) =>
      _$this._enableCustomSurchargeTaxes4 = enableCustomSurchargeTaxes4;

  String _sizeId;
  String get sizeId => _$this._sizeId;
  set sizeId(String sizeId) => _$this._sizeId = sizeId;

  String _industryId;
  String get industryId => _$this._industryId;
  set industryId(String industryId) => _$this._industryId = industryId;

  String _subdomain;
  String get subdomain => _$this._subdomain;
  set subdomain(String subdomain) => _$this._subdomain = subdomain;

  String _portalMode;
  String get portalMode => _$this._portalMode;
  set portalMode(String portalMode) => _$this._portalMode = portalMode;

  String _portalDomain;
  String get portalDomain => _$this._portalDomain;
  set portalDomain(String portalDomain) => _$this._portalDomain = portalDomain;

  bool _updateProducts;
  bool get updateProducts => _$this._updateProducts;
  set updateProducts(bool updateProducts) =>
      _$this._updateProducts = updateProducts;

  bool _convertProductExchangeRate;
  bool get convertProductExchangeRate => _$this._convertProductExchangeRate;
  set convertProductExchangeRate(bool convertProductExchangeRate) =>
      _$this._convertProductExchangeRate = convertProductExchangeRate;

  bool _convertRateToClient;
  bool get convertRateToClient => _$this._convertRateToClient;
  set convertRateToClient(bool convertRateToClient) =>
      _$this._convertRateToClient = convertRateToClient;

  bool _fillProducts;
  bool get fillProducts => _$this._fillProducts;
  set fillProducts(bool fillProducts) => _$this._fillProducts = fillProducts;

  bool _enableProductCost;
  bool get enableProductCost => _$this._enableProductCost;
  set enableProductCost(bool enableProductCost) =>
      _$this._enableProductCost = enableProductCost;

  bool _enableProductQuantity;
  bool get enableProductQuantity => _$this._enableProductQuantity;
  set enableProductQuantity(bool enableProductQuantity) =>
      _$this._enableProductQuantity = enableProductQuantity;

  bool _enableProductDiscount;
  bool get enableProductDiscount => _$this._enableProductDiscount;
  set enableProductDiscount(bool enableProductDiscount) =>
      _$this._enableProductDiscount = enableProductDiscount;

  bool _defaultTaskIsDateBased;
  bool get defaultTaskIsDateBased => _$this._defaultTaskIsDateBased;
  set defaultTaskIsDateBased(bool defaultTaskIsDateBased) =>
      _$this._defaultTaskIsDateBased = defaultTaskIsDateBased;

  bool _defaultQuantity;
  bool get defaultQuantity => _$this._defaultQuantity;
  set defaultQuantity(bool defaultQuantity) =>
      _$this._defaultQuantity = defaultQuantity;

  bool _showProductDetails;
  bool get showProductDetails => _$this._showProductDetails;
  set showProductDetails(bool showProductDetails) =>
      _$this._showProductDetails = showProductDetails;

  bool _clientCanRegister;
  bool get clientCanRegister => _$this._clientCanRegister;
  set clientCanRegister(bool clientCanRegister) =>
      _$this._clientCanRegister = clientCanRegister;

  bool _isLarge;
  bool get isLarge => _$this._isLarge;
  set isLarge(bool isLarge) => _$this._isLarge = isLarge;

  bool _isDisabled;
  bool get isDisabled => _$this._isDisabled;
  set isDisabled(bool isDisabled) => _$this._isDisabled = isDisabled;

  bool _enableShopApi;
  bool get enableShopApi => _$this._enableShopApi;
  set enableShopApi(bool enableShopApi) =>
      _$this._enableShopApi = enableShopApi;

  String _companyKey;
  String get companyKey => _$this._companyKey;
  set companyKey(String companyKey) => _$this._companyKey = companyKey;

  String _firstDayOfWeek;
  String get firstDayOfWeek => _$this._firstDayOfWeek;
  set firstDayOfWeek(String firstDayOfWeek) =>
      _$this._firstDayOfWeek = firstDayOfWeek;

  String _firstMonthOfYear;
  String get firstMonthOfYear => _$this._firstMonthOfYear;
  set firstMonthOfYear(String firstMonthOfYear) =>
      _$this._firstMonthOfYear = firstMonthOfYear;

  int _numberOfInvoiceTaxRates;
  int get numberOfInvoiceTaxRates => _$this._numberOfInvoiceTaxRates;
  set numberOfInvoiceTaxRates(int numberOfInvoiceTaxRates) =>
      _$this._numberOfInvoiceTaxRates = numberOfInvoiceTaxRates;

  int _numberOfItemTaxRates;
  int get numberOfItemTaxRates => _$this._numberOfItemTaxRates;
  set numberOfItemTaxRates(int numberOfItemTaxRates) =>
      _$this._numberOfItemTaxRates = numberOfItemTaxRates;

  bool _expenseInclusiveTaxes;
  bool get expenseInclusiveTaxes => _$this._expenseInclusiveTaxes;
  set expenseInclusiveTaxes(bool expenseInclusiveTaxes) =>
      _$this._expenseInclusiveTaxes = expenseInclusiveTaxes;

  int _sessionTimeout;
  int get sessionTimeout => _$this._sessionTimeout;
  set sessionTimeout(int sessionTimeout) =>
      _$this._sessionTimeout = sessionTimeout;

  int _passwordTimeout;
  int get passwordTimeout => _$this._passwordTimeout;
  set passwordTimeout(int passwordTimeout) =>
      _$this._passwordTimeout = passwordTimeout;

  bool _oauthPasswordRequired;
  bool get oauthPasswordRequired => _$this._oauthPasswordRequired;
  set oauthPasswordRequired(bool oauthPasswordRequired) =>
      _$this._oauthPasswordRequired = oauthPasswordRequired;

  bool _markdownEnabled;
  bool get markdownEnabled => _$this._markdownEnabled;
  set markdownEnabled(bool markdownEnabled) =>
      _$this._markdownEnabled = markdownEnabled;

  bool _markdownEmailEnabled;
  bool get markdownEmailEnabled => _$this._markdownEmailEnabled;
  set markdownEmailEnabled(bool markdownEmailEnabled) =>
      _$this._markdownEmailEnabled = markdownEmailEnabled;

  bool _useCommaAsDecimalPlace;
  bool get useCommaAsDecimalPlace => _$this._useCommaAsDecimalPlace;
  set useCommaAsDecimalPlace(bool useCommaAsDecimalPlace) =>
      _$this._useCommaAsDecimalPlace = useCommaAsDecimalPlace;

  bool _reportIncludeDrafts;
  bool get reportIncludeDrafts => _$this._reportIncludeDrafts;
  set reportIncludeDrafts(bool reportIncludeDrafts) =>
      _$this._reportIncludeDrafts = reportIncludeDrafts;

  ListBuilder<GroupEntity> _groups;
  ListBuilder<GroupEntity> get groups =>
      _$this._groups ??= new ListBuilder<GroupEntity>();
  set groups(ListBuilder<GroupEntity> groups) => _$this._groups = groups;

  ListBuilder<ActivityEntity> _activities;
  ListBuilder<ActivityEntity> get activities =>
      _$this._activities ??= new ListBuilder<ActivityEntity>();
  set activities(ListBuilder<ActivityEntity> activities) =>
      _$this._activities = activities;

  ListBuilder<TaxRateEntity> _taxRates;
  ListBuilder<TaxRateEntity> get taxRates =>
      _$this._taxRates ??= new ListBuilder<TaxRateEntity>();
  set taxRates(ListBuilder<TaxRateEntity> taxRates) =>
      _$this._taxRates = taxRates;

  ListBuilder<TaskStatusEntity> _taskStatuses;
  ListBuilder<TaskStatusEntity> get taskStatuses =>
      _$this._taskStatuses ??= new ListBuilder<TaskStatusEntity>();
  set taskStatuses(ListBuilder<TaskStatusEntity> taskStatuses) =>
      _$this._taskStatuses = taskStatuses;

  MapBuilder<String, TaskStatusEntity> _taskStatusMap;
  MapBuilder<String, TaskStatusEntity> get taskStatusMap =>
      _$this._taskStatusMap ??= new MapBuilder<String, TaskStatusEntity>();
  set taskStatusMap(MapBuilder<String, TaskStatusEntity> taskStatusMap) =>
      _$this._taskStatusMap = taskStatusMap;

  ListBuilder<CompanyGatewayEntity> _companyGateways;
  ListBuilder<CompanyGatewayEntity> get companyGateways =>
      _$this._companyGateways ??= new ListBuilder<CompanyGatewayEntity>();
  set companyGateways(ListBuilder<CompanyGatewayEntity> companyGateways) =>
      _$this._companyGateways = companyGateways;

  ListBuilder<ExpenseCategoryEntity> _expenseCategories;
  ListBuilder<ExpenseCategoryEntity> get expenseCategories =>
      _$this._expenseCategories ??= new ListBuilder<ExpenseCategoryEntity>();
  set expenseCategories(ListBuilder<ExpenseCategoryEntity> expenseCategories) =>
      _$this._expenseCategories = expenseCategories;

  ListBuilder<UserEntity> _users;
  ListBuilder<UserEntity> get users =>
      _$this._users ??= new ListBuilder<UserEntity>();
  set users(ListBuilder<UserEntity> users) => _$this._users = users;

  ListBuilder<ClientEntity> _clients;
  ListBuilder<ClientEntity> get clients =>
      _$this._clients ??= new ListBuilder<ClientEntity>();
  set clients(ListBuilder<ClientEntity> clients) => _$this._clients = clients;

  ListBuilder<ProductEntity> _products;
  ListBuilder<ProductEntity> get products =>
      _$this._products ??= new ListBuilder<ProductEntity>();
  set products(ListBuilder<ProductEntity> products) =>
      _$this._products = products;

  ListBuilder<InvoiceEntity> _invoices;
  ListBuilder<InvoiceEntity> get invoices =>
      _$this._invoices ??= new ListBuilder<InvoiceEntity>();
  set invoices(ListBuilder<InvoiceEntity> invoices) =>
      _$this._invoices = invoices;

  ListBuilder<InvoiceEntity> _recurringInvoices;
  ListBuilder<InvoiceEntity> get recurringInvoices =>
      _$this._recurringInvoices ??= new ListBuilder<InvoiceEntity>();
  set recurringInvoices(ListBuilder<InvoiceEntity> recurringInvoices) =>
      _$this._recurringInvoices = recurringInvoices;

  ListBuilder<ExpenseEntity> _recurringExpenses;
  ListBuilder<ExpenseEntity> get recurringExpenses =>
      _$this._recurringExpenses ??= new ListBuilder<ExpenseEntity>();
  set recurringExpenses(ListBuilder<ExpenseEntity> recurringExpenses) =>
      _$this._recurringExpenses = recurringExpenses;

  ListBuilder<PaymentEntity> _payments;
  ListBuilder<PaymentEntity> get payments =>
      _$this._payments ??= new ListBuilder<PaymentEntity>();
  set payments(ListBuilder<PaymentEntity> payments) =>
      _$this._payments = payments;

  ListBuilder<InvoiceEntity> _quotes;
  ListBuilder<InvoiceEntity> get quotes =>
      _$this._quotes ??= new ListBuilder<InvoiceEntity>();
  set quotes(ListBuilder<InvoiceEntity> quotes) => _$this._quotes = quotes;

  ListBuilder<InvoiceEntity> _credits;
  ListBuilder<InvoiceEntity> get credits =>
      _$this._credits ??= new ListBuilder<InvoiceEntity>();
  set credits(ListBuilder<InvoiceEntity> credits) => _$this._credits = credits;

  ListBuilder<TaskEntity> _tasks;
  ListBuilder<TaskEntity> get tasks =>
      _$this._tasks ??= new ListBuilder<TaskEntity>();
  set tasks(ListBuilder<TaskEntity> tasks) => _$this._tasks = tasks;

  ListBuilder<ProjectEntity> _projects;
  ListBuilder<ProjectEntity> get projects =>
      _$this._projects ??= new ListBuilder<ProjectEntity>();
  set projects(ListBuilder<ProjectEntity> projects) =>
      _$this._projects = projects;

  ListBuilder<ExpenseEntity> _expenses;
  ListBuilder<ExpenseEntity> get expenses =>
      _$this._expenses ??= new ListBuilder<ExpenseEntity>();
  set expenses(ListBuilder<ExpenseEntity> expenses) =>
      _$this._expenses = expenses;

  ListBuilder<VendorEntity> _vendors;
  ListBuilder<VendorEntity> get vendors =>
      _$this._vendors ??= new ListBuilder<VendorEntity>();
  set vendors(ListBuilder<VendorEntity> vendors) => _$this._vendors = vendors;

  ListBuilder<DesignEntity> _designs;
  ListBuilder<DesignEntity> get designs =>
      _$this._designs ??= new ListBuilder<DesignEntity>();
  set designs(ListBuilder<DesignEntity> designs) => _$this._designs = designs;

  ListBuilder<DocumentEntity> _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity> documents) =>
      _$this._documents = documents;

  ListBuilder<TokenEntity> _tokens;
  ListBuilder<TokenEntity> get tokens =>
      _$this._tokens ??= new ListBuilder<TokenEntity>();
  set tokens(ListBuilder<TokenEntity> tokens) => _$this._tokens = tokens;

  ListBuilder<WebhookEntity> _webhooks;
  ListBuilder<WebhookEntity> get webhooks =>
      _$this._webhooks ??= new ListBuilder<WebhookEntity>();
  set webhooks(ListBuilder<WebhookEntity> webhooks) =>
      _$this._webhooks = webhooks;

  ListBuilder<SubscriptionEntity> _subscriptions;
  ListBuilder<SubscriptionEntity> get subscriptions =>
      _$this._subscriptions ??= new ListBuilder<SubscriptionEntity>();
  set subscriptions(ListBuilder<SubscriptionEntity> subscriptions) =>
      _$this._subscriptions = subscriptions;

  ListBuilder<PaymentTermEntity> _paymentTerms;
  ListBuilder<PaymentTermEntity> get paymentTerms =>
      _$this._paymentTerms ??= new ListBuilder<PaymentTermEntity>();
  set paymentTerms(ListBuilder<PaymentTermEntity> paymentTerms) =>
      _$this._paymentTerms = paymentTerms;

  ListBuilder<SystemLogEntity> _systemLogs;
  ListBuilder<SystemLogEntity> get systemLogs =>
      _$this._systemLogs ??= new ListBuilder<SystemLogEntity>();
  set systemLogs(ListBuilder<SystemLogEntity> systemLogs) =>
      _$this._systemLogs = systemLogs;

  ListBuilder<RegistrationFieldEntity> _clientRegistrationFields;
  ListBuilder<RegistrationFieldEntity> get clientRegistrationFields =>
      _$this._clientRegistrationFields ??=
          new ListBuilder<RegistrationFieldEntity>();
  set clientRegistrationFields(
          ListBuilder<RegistrationFieldEntity> clientRegistrationFields) =>
      _$this._clientRegistrationFields = clientRegistrationFields;

  MapBuilder<String, String> _customFields;
  MapBuilder<String, String> get customFields =>
      _$this._customFields ??= new MapBuilder<String, String>();
  set customFields(MapBuilder<String, String> customFields) =>
      _$this._customFields = customFields;

  String _slackWebhookUrl;
  String get slackWebhookUrl => _$this._slackWebhookUrl;
  set slackWebhookUrl(String slackWebhookUrl) =>
      _$this._slackWebhookUrl = slackWebhookUrl;

  String _googleAnalyticsKey;
  String get googleAnalyticsKey => _$this._googleAnalyticsKey;
  set googleAnalyticsKey(String googleAnalyticsKey) =>
      _$this._googleAnalyticsKey = googleAnalyticsKey;

  bool _markExpensesInvoiceable;
  bool get markExpensesInvoiceable => _$this._markExpensesInvoiceable;
  set markExpensesInvoiceable(bool markExpensesInvoiceable) =>
      _$this._markExpensesInvoiceable = markExpensesInvoiceable;

  bool _markExpensesPaid;
  bool get markExpensesPaid => _$this._markExpensesPaid;
  set markExpensesPaid(bool markExpensesPaid) =>
      _$this._markExpensesPaid = markExpensesPaid;

  bool _invoiceExpenseDocuments;
  bool get invoiceExpenseDocuments => _$this._invoiceExpenseDocuments;
  set invoiceExpenseDocuments(bool invoiceExpenseDocuments) =>
      _$this._invoiceExpenseDocuments = invoiceExpenseDocuments;

  bool _invoiceTaskDocuments;
  bool get invoiceTaskDocuments => _$this._invoiceTaskDocuments;
  set invoiceTaskDocuments(bool invoiceTaskDocuments) =>
      _$this._invoiceTaskDocuments = invoiceTaskDocuments;

  bool _invoiceTaskTimelog;
  bool get invoiceTaskTimelog => _$this._invoiceTaskTimelog;
  set invoiceTaskTimelog(bool invoiceTaskTimelog) =>
      _$this._invoiceTaskTimelog = invoiceTaskTimelog;

  bool _invoiceTaskDatelog;
  bool get invoiceTaskDatelog => _$this._invoiceTaskDatelog;
  set invoiceTaskDatelog(bool invoiceTaskDatelog) =>
      _$this._invoiceTaskDatelog = invoiceTaskDatelog;

  bool _autoStartTasks;
  bool get autoStartTasks => _$this._autoStartTasks;
  set autoStartTasks(bool autoStartTasks) =>
      _$this._autoStartTasks = autoStartTasks;

  bool _showTasksTable;
  bool get showTasksTable => _$this._showTasksTable;
  set showTasksTable(bool showTasksTable) =>
      _$this._showTasksTable = showTasksTable;

  bool _showTaskEndDate;
  bool get showTaskEndDate => _$this._showTaskEndDate;
  set showTaskEndDate(bool showTaskEndDate) =>
      _$this._showTaskEndDate = showTaskEndDate;

  SettingsEntityBuilder _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder settings) => _$this._settings = settings;

  int _enabledModules;
  int get enabledModules => _$this._enabledModules;
  set enabledModules(int enabledModules) =>
      _$this._enabledModules = enabledModules;

  bool _calculateExpenseTaxByAmount;
  bool get calculateExpenseTaxByAmount => _$this._calculateExpenseTaxByAmount;
  set calculateExpenseTaxByAmount(bool calculateExpenseTaxByAmount) =>
      _$this._calculateExpenseTaxByAmount = calculateExpenseTaxByAmount;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  String _createdUserId;
  String get createdUserId => _$this._createdUserId;
  set createdUserId(String createdUserId) =>
      _$this._createdUserId = createdUserId;

  String _assignedUserId;
  String get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  EntityType _entityType;
  EntityType get entityType => _$this._entityType;
  set entityType(EntityType entityType) => _$this._entityType = entityType;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  CompanyEntityBuilder() {
    CompanyEntity._initializeBuilder(this);
  }

  CompanyEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enableCustomSurchargeTaxes1 = $v.enableCustomSurchargeTaxes1;
      _enableCustomSurchargeTaxes2 = $v.enableCustomSurchargeTaxes2;
      _enableCustomSurchargeTaxes3 = $v.enableCustomSurchargeTaxes3;
      _enableCustomSurchargeTaxes4 = $v.enableCustomSurchargeTaxes4;
      _sizeId = $v.sizeId;
      _industryId = $v.industryId;
      _subdomain = $v.subdomain;
      _portalMode = $v.portalMode;
      _portalDomain = $v.portalDomain;
      _updateProducts = $v.updateProducts;
      _convertProductExchangeRate = $v.convertProductExchangeRate;
      _convertRateToClient = $v.convertRateToClient;
      _fillProducts = $v.fillProducts;
      _enableProductCost = $v.enableProductCost;
      _enableProductQuantity = $v.enableProductQuantity;
      _enableProductDiscount = $v.enableProductDiscount;
      _defaultTaskIsDateBased = $v.defaultTaskIsDateBased;
      _defaultQuantity = $v.defaultQuantity;
      _showProductDetails = $v.showProductDetails;
      _clientCanRegister = $v.clientCanRegister;
      _isLarge = $v.isLarge;
      _isDisabled = $v.isDisabled;
      _enableShopApi = $v.enableShopApi;
      _companyKey = $v.companyKey;
      _firstDayOfWeek = $v.firstDayOfWeek;
      _firstMonthOfYear = $v.firstMonthOfYear;
      _numberOfInvoiceTaxRates = $v.numberOfInvoiceTaxRates;
      _numberOfItemTaxRates = $v.numberOfItemTaxRates;
      _expenseInclusiveTaxes = $v.expenseInclusiveTaxes;
      _sessionTimeout = $v.sessionTimeout;
      _passwordTimeout = $v.passwordTimeout;
      _oauthPasswordRequired = $v.oauthPasswordRequired;
      _markdownEnabled = $v.markdownEnabled;
      _markdownEmailEnabled = $v.markdownEmailEnabled;
      _useCommaAsDecimalPlace = $v.useCommaAsDecimalPlace;
      _reportIncludeDrafts = $v.reportIncludeDrafts;
      _groups = $v.groups.toBuilder();
      _activities = $v.activities.toBuilder();
      _taxRates = $v.taxRates.toBuilder();
      _taskStatuses = $v.taskStatuses.toBuilder();
      _taskStatusMap = $v.taskStatusMap.toBuilder();
      _companyGateways = $v.companyGateways.toBuilder();
      _expenseCategories = $v.expenseCategories.toBuilder();
      _users = $v.users.toBuilder();
      _clients = $v.clients.toBuilder();
      _products = $v.products.toBuilder();
      _invoices = $v.invoices.toBuilder();
      _recurringInvoices = $v.recurringInvoices.toBuilder();
      _recurringExpenses = $v.recurringExpenses.toBuilder();
      _payments = $v.payments.toBuilder();
      _quotes = $v.quotes.toBuilder();
      _credits = $v.credits.toBuilder();
      _tasks = $v.tasks.toBuilder();
      _projects = $v.projects.toBuilder();
      _expenses = $v.expenses.toBuilder();
      _vendors = $v.vendors.toBuilder();
      _designs = $v.designs.toBuilder();
      _documents = $v.documents.toBuilder();
      _tokens = $v.tokens.toBuilder();
      _webhooks = $v.webhooks.toBuilder();
      _subscriptions = $v.subscriptions.toBuilder();
      _paymentTerms = $v.paymentTerms.toBuilder();
      _systemLogs = $v.systemLogs.toBuilder();
      _clientRegistrationFields = $v.clientRegistrationFields.toBuilder();
      _customFields = $v.customFields.toBuilder();
      _slackWebhookUrl = $v.slackWebhookUrl;
      _googleAnalyticsKey = $v.googleAnalyticsKey;
      _markExpensesInvoiceable = $v.markExpensesInvoiceable;
      _markExpensesPaid = $v.markExpensesPaid;
      _invoiceExpenseDocuments = $v.invoiceExpenseDocuments;
      _invoiceTaskDocuments = $v.invoiceTaskDocuments;
      _invoiceTaskTimelog = $v.invoiceTaskTimelog;
      _invoiceTaskDatelog = $v.invoiceTaskDatelog;
      _autoStartTasks = $v.autoStartTasks;
      _showTasksTable = $v.showTasksTable;
      _showTaskEndDate = $v.showTaskEndDate;
      _settings = $v.settings.toBuilder();
      _enabledModules = $v.enabledModules;
      _calculateExpenseTaxByAmount = $v.calculateExpenseTaxByAmount;
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _entityType = $v.entityType;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompanyEntity;
  }

  @override
  void update(void Function(CompanyEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyEntity build() {
    _$CompanyEntity _$result;
    try {
      _$result = _$v ??
          new _$CompanyEntity._(
              enableCustomSurchargeTaxes1: BuiltValueNullFieldError.checkNotNull(
                  enableCustomSurchargeTaxes1,
                  'CompanyEntity',
                  'enableCustomSurchargeTaxes1'),
              enableCustomSurchargeTaxes2: BuiltValueNullFieldError.checkNotNull(
                  enableCustomSurchargeTaxes2,
                  'CompanyEntity',
                  'enableCustomSurchargeTaxes2'),
              enableCustomSurchargeTaxes3: BuiltValueNullFieldError.checkNotNull(
                  enableCustomSurchargeTaxes3,
                  'CompanyEntity',
                  'enableCustomSurchargeTaxes3'),
              enableCustomSurchargeTaxes4:
                  BuiltValueNullFieldError.checkNotNull(
                      enableCustomSurchargeTaxes4,
                      'CompanyEntity',
                      'enableCustomSurchargeTaxes4'),
              sizeId: BuiltValueNullFieldError.checkNotNull(
                  sizeId, 'CompanyEntity', 'sizeId'),
              industryId: BuiltValueNullFieldError.checkNotNull(industryId, 'CompanyEntity', 'industryId'),
              subdomain: BuiltValueNullFieldError.checkNotNull(subdomain, 'CompanyEntity', 'subdomain'),
              portalMode: BuiltValueNullFieldError.checkNotNull(portalMode, 'CompanyEntity', 'portalMode'),
              portalDomain: BuiltValueNullFieldError.checkNotNull(portalDomain, 'CompanyEntity', 'portalDomain'),
              updateProducts: BuiltValueNullFieldError.checkNotNull(updateProducts, 'CompanyEntity', 'updateProducts'),
              convertProductExchangeRate: BuiltValueNullFieldError.checkNotNull(convertProductExchangeRate, 'CompanyEntity', 'convertProductExchangeRate'),
              convertRateToClient: BuiltValueNullFieldError.checkNotNull(convertRateToClient, 'CompanyEntity', 'convertRateToClient'),
              fillProducts: BuiltValueNullFieldError.checkNotNull(fillProducts, 'CompanyEntity', 'fillProducts'),
              enableProductCost: BuiltValueNullFieldError.checkNotNull(enableProductCost, 'CompanyEntity', 'enableProductCost'),
              enableProductQuantity: BuiltValueNullFieldError.checkNotNull(enableProductQuantity, 'CompanyEntity', 'enableProductQuantity'),
              enableProductDiscount: BuiltValueNullFieldError.checkNotNull(enableProductDiscount, 'CompanyEntity', 'enableProductDiscount'),
              defaultTaskIsDateBased: BuiltValueNullFieldError.checkNotNull(defaultTaskIsDateBased, 'CompanyEntity', 'defaultTaskIsDateBased'),
              defaultQuantity: BuiltValueNullFieldError.checkNotNull(defaultQuantity, 'CompanyEntity', 'defaultQuantity'),
              showProductDetails: BuiltValueNullFieldError.checkNotNull(showProductDetails, 'CompanyEntity', 'showProductDetails'),
              clientCanRegister: BuiltValueNullFieldError.checkNotNull(clientCanRegister, 'CompanyEntity', 'clientCanRegister'),
              isLarge: BuiltValueNullFieldError.checkNotNull(isLarge, 'CompanyEntity', 'isLarge'),
              isDisabled: BuiltValueNullFieldError.checkNotNull(isDisabled, 'CompanyEntity', 'isDisabled'),
              enableShopApi: BuiltValueNullFieldError.checkNotNull(enableShopApi, 'CompanyEntity', 'enableShopApi'),
              companyKey: BuiltValueNullFieldError.checkNotNull(companyKey, 'CompanyEntity', 'companyKey'),
              firstDayOfWeek: BuiltValueNullFieldError.checkNotNull(firstDayOfWeek, 'CompanyEntity', 'firstDayOfWeek'),
              firstMonthOfYear: BuiltValueNullFieldError.checkNotNull(firstMonthOfYear, 'CompanyEntity', 'firstMonthOfYear'),
              numberOfInvoiceTaxRates: BuiltValueNullFieldError.checkNotNull(numberOfInvoiceTaxRates, 'CompanyEntity', 'numberOfInvoiceTaxRates'),
              numberOfItemTaxRates: BuiltValueNullFieldError.checkNotNull(numberOfItemTaxRates, 'CompanyEntity', 'numberOfItemTaxRates'),
              expenseInclusiveTaxes: BuiltValueNullFieldError.checkNotNull(expenseInclusiveTaxes, 'CompanyEntity', 'expenseInclusiveTaxes'),
              sessionTimeout: BuiltValueNullFieldError.checkNotNull(sessionTimeout, 'CompanyEntity', 'sessionTimeout'),
              passwordTimeout: BuiltValueNullFieldError.checkNotNull(passwordTimeout, 'CompanyEntity', 'passwordTimeout'),
              oauthPasswordRequired: BuiltValueNullFieldError.checkNotNull(oauthPasswordRequired, 'CompanyEntity', 'oauthPasswordRequired'),
              markdownEnabled: BuiltValueNullFieldError.checkNotNull(markdownEnabled, 'CompanyEntity', 'markdownEnabled'),
              markdownEmailEnabled: BuiltValueNullFieldError.checkNotNull(markdownEmailEnabled, 'CompanyEntity', 'markdownEmailEnabled'),
              useCommaAsDecimalPlace: BuiltValueNullFieldError.checkNotNull(useCommaAsDecimalPlace, 'CompanyEntity', 'useCommaAsDecimalPlace'),
              reportIncludeDrafts: BuiltValueNullFieldError.checkNotNull(reportIncludeDrafts, 'CompanyEntity', 'reportIncludeDrafts'),
              groups: groups.build(),
              activities: activities.build(),
              taxRates: taxRates.build(),
              taskStatuses: taskStatuses.build(),
              taskStatusMap: taskStatusMap.build(),
              companyGateways: companyGateways.build(),
              expenseCategories: expenseCategories.build(),
              users: users.build(),
              clients: clients.build(),
              products: products.build(),
              invoices: invoices.build(),
              recurringInvoices: recurringInvoices.build(),
              recurringExpenses: recurringExpenses.build(),
              payments: payments.build(),
              quotes: quotes.build(),
              credits: credits.build(),
              tasks: tasks.build(),
              projects: projects.build(),
              expenses: expenses.build(),
              vendors: vendors.build(),
              designs: designs.build(),
              documents: documents.build(),
              tokens: tokens.build(),
              webhooks: webhooks.build(),
              subscriptions: subscriptions.build(),
              paymentTerms: paymentTerms.build(),
              systemLogs: systemLogs.build(),
              clientRegistrationFields: clientRegistrationFields.build(),
              customFields: customFields.build(),
              slackWebhookUrl: BuiltValueNullFieldError.checkNotNull(slackWebhookUrl, 'CompanyEntity', 'slackWebhookUrl'),
              googleAnalyticsKey: BuiltValueNullFieldError.checkNotNull(googleAnalyticsKey, 'CompanyEntity', 'googleAnalyticsKey'),
              markExpensesInvoiceable: BuiltValueNullFieldError.checkNotNull(markExpensesInvoiceable, 'CompanyEntity', 'markExpensesInvoiceable'),
              markExpensesPaid: BuiltValueNullFieldError.checkNotNull(markExpensesPaid, 'CompanyEntity', 'markExpensesPaid'),
              invoiceExpenseDocuments: BuiltValueNullFieldError.checkNotNull(invoiceExpenseDocuments, 'CompanyEntity', 'invoiceExpenseDocuments'),
              invoiceTaskDocuments: BuiltValueNullFieldError.checkNotNull(invoiceTaskDocuments, 'CompanyEntity', 'invoiceTaskDocuments'),
              invoiceTaskTimelog: BuiltValueNullFieldError.checkNotNull(invoiceTaskTimelog, 'CompanyEntity', 'invoiceTaskTimelog'),
              invoiceTaskDatelog: BuiltValueNullFieldError.checkNotNull(invoiceTaskDatelog, 'CompanyEntity', 'invoiceTaskDatelog'),
              autoStartTasks: BuiltValueNullFieldError.checkNotNull(autoStartTasks, 'CompanyEntity', 'autoStartTasks'),
              showTasksTable: BuiltValueNullFieldError.checkNotNull(showTasksTable, 'CompanyEntity', 'showTasksTable'),
              showTaskEndDate: BuiltValueNullFieldError.checkNotNull(showTaskEndDate, 'CompanyEntity', 'showTaskEndDate'),
              settings: settings.build(),
              enabledModules: BuiltValueNullFieldError.checkNotNull(enabledModules, 'CompanyEntity', 'enabledModules'),
              calculateExpenseTaxByAmount: BuiltValueNullFieldError.checkNotNull(calculateExpenseTaxByAmount, 'CompanyEntity', 'calculateExpenseTaxByAmount'),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, 'CompanyEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, 'CompanyEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, 'CompanyEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              entityType: entityType,
              id: BuiltValueNullFieldError.checkNotNull(id, 'CompanyEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'groups';
        groups.build();
        _$failedField = 'activities';
        activities.build();
        _$failedField = 'taxRates';
        taxRates.build();
        _$failedField = 'taskStatuses';
        taskStatuses.build();
        _$failedField = 'taskStatusMap';
        taskStatusMap.build();
        _$failedField = 'companyGateways';
        companyGateways.build();
        _$failedField = 'expenseCategories';
        expenseCategories.build();
        _$failedField = 'users';
        users.build();
        _$failedField = 'clients';
        clients.build();
        _$failedField = 'products';
        products.build();
        _$failedField = 'invoices';
        invoices.build();
        _$failedField = 'recurringInvoices';
        recurringInvoices.build();
        _$failedField = 'recurringExpenses';
        recurringExpenses.build();
        _$failedField = 'payments';
        payments.build();
        _$failedField = 'quotes';
        quotes.build();
        _$failedField = 'credits';
        credits.build();
        _$failedField = 'tasks';
        tasks.build();
        _$failedField = 'projects';
        projects.build();
        _$failedField = 'expenses';
        expenses.build();
        _$failedField = 'vendors';
        vendors.build();
        _$failedField = 'designs';
        designs.build();
        _$failedField = 'documents';
        documents.build();
        _$failedField = 'tokens';
        tokens.build();
        _$failedField = 'webhooks';
        webhooks.build();
        _$failedField = 'subscriptions';
        subscriptions.build();
        _$failedField = 'paymentTerms';
        paymentTerms.build();
        _$failedField = 'systemLogs';
        systemLogs.build();
        _$failedField = 'clientRegistrationFields';
        clientRegistrationFields.build();
        _$failedField = 'customFields';
        customFields.build();

        _$failedField = 'settings';
        settings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GatewayEntity extends GatewayEntity {
  @override
  final String id;
  @override
  final String name;
  @override
  final bool isOffsite;
  @override
  final bool isVisible;
  @override
  final int sortOrder;
  @override
  final String defaultGatewayTypeId;
  @override
  final String siteUrl;
  @override
  final BuiltMap<String, GatewayOptionsEntity> options;
  @override
  final String fields;

  factory _$GatewayEntity([void Function(GatewayEntityBuilder) updates]) =>
      (new GatewayEntityBuilder()..update(updates)).build();

  _$GatewayEntity._(
      {this.id,
      this.name,
      this.isOffsite,
      this.isVisible,
      this.sortOrder,
      this.defaultGatewayTypeId,
      this.siteUrl,
      this.options,
      this.fields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'GatewayEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(name, 'GatewayEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        isOffsite, 'GatewayEntity', 'isOffsite');
    BuiltValueNullFieldError.checkNotNull(
        isVisible, 'GatewayEntity', 'isVisible');
    BuiltValueNullFieldError.checkNotNull(
        sortOrder, 'GatewayEntity', 'sortOrder');
    BuiltValueNullFieldError.checkNotNull(
        defaultGatewayTypeId, 'GatewayEntity', 'defaultGatewayTypeId');
    BuiltValueNullFieldError.checkNotNull(siteUrl, 'GatewayEntity', 'siteUrl');
    BuiltValueNullFieldError.checkNotNull(options, 'GatewayEntity', 'options');
    BuiltValueNullFieldError.checkNotNull(fields, 'GatewayEntity', 'fields');
  }

  @override
  GatewayEntity rebuild(void Function(GatewayEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GatewayEntityBuilder toBuilder() => new GatewayEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GatewayEntity &&
        id == other.id &&
        name == other.name &&
        isOffsite == other.isOffsite &&
        isVisible == other.isVisible &&
        sortOrder == other.sortOrder &&
        defaultGatewayTypeId == other.defaultGatewayTypeId &&
        siteUrl == other.siteUrl &&
        options == other.options &&
        fields == other.fields;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, id.hashCode), name.hashCode),
                                isOffsite.hashCode),
                            isVisible.hashCode),
                        sortOrder.hashCode),
                    defaultGatewayTypeId.hashCode),
                siteUrl.hashCode),
            options.hashCode),
        fields.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GatewayEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('isOffsite', isOffsite)
          ..add('isVisible', isVisible)
          ..add('sortOrder', sortOrder)
          ..add('defaultGatewayTypeId', defaultGatewayTypeId)
          ..add('siteUrl', siteUrl)
          ..add('options', options)
          ..add('fields', fields))
        .toString();
  }
}

class GatewayEntityBuilder
    implements Builder<GatewayEntity, GatewayEntityBuilder> {
  _$GatewayEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _isOffsite;
  bool get isOffsite => _$this._isOffsite;
  set isOffsite(bool isOffsite) => _$this._isOffsite = isOffsite;

  bool _isVisible;
  bool get isVisible => _$this._isVisible;
  set isVisible(bool isVisible) => _$this._isVisible = isVisible;

  int _sortOrder;
  int get sortOrder => _$this._sortOrder;
  set sortOrder(int sortOrder) => _$this._sortOrder = sortOrder;

  String _defaultGatewayTypeId;
  String get defaultGatewayTypeId => _$this._defaultGatewayTypeId;
  set defaultGatewayTypeId(String defaultGatewayTypeId) =>
      _$this._defaultGatewayTypeId = defaultGatewayTypeId;

  String _siteUrl;
  String get siteUrl => _$this._siteUrl;
  set siteUrl(String siteUrl) => _$this._siteUrl = siteUrl;

  MapBuilder<String, GatewayOptionsEntity> _options;
  MapBuilder<String, GatewayOptionsEntity> get options =>
      _$this._options ??= new MapBuilder<String, GatewayOptionsEntity>();
  set options(MapBuilder<String, GatewayOptionsEntity> options) =>
      _$this._options = options;

  String _fields;
  String get fields => _$this._fields;
  set fields(String fields) => _$this._fields = fields;

  GatewayEntityBuilder() {
    GatewayEntity._initializeBuilder(this);
  }

  GatewayEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _isOffsite = $v.isOffsite;
      _isVisible = $v.isVisible;
      _sortOrder = $v.sortOrder;
      _defaultGatewayTypeId = $v.defaultGatewayTypeId;
      _siteUrl = $v.siteUrl;
      _options = $v.options.toBuilder();
      _fields = $v.fields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GatewayEntity;
  }

  @override
  void update(void Function(GatewayEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GatewayEntity build() {
    _$GatewayEntity _$result;
    try {
      _$result = _$v ??
          new _$GatewayEntity._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GatewayEntity', 'id'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'GatewayEntity', 'name'),
              isOffsite: BuiltValueNullFieldError.checkNotNull(
                  isOffsite, 'GatewayEntity', 'isOffsite'),
              isVisible: BuiltValueNullFieldError.checkNotNull(
                  isVisible, 'GatewayEntity', 'isVisible'),
              sortOrder: BuiltValueNullFieldError.checkNotNull(
                  sortOrder, 'GatewayEntity', 'sortOrder'),
              defaultGatewayTypeId: BuiltValueNullFieldError.checkNotNull(
                  defaultGatewayTypeId,
                  'GatewayEntity',
                  'defaultGatewayTypeId'),
              siteUrl: BuiltValueNullFieldError.checkNotNull(
                  siteUrl, 'GatewayEntity', 'siteUrl'),
              options: options.build(),
              fields: BuiltValueNullFieldError.checkNotNull(
                  fields, 'GatewayEntity', 'fields'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'options';
        options.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GatewayEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GatewayOptionsEntity extends GatewayOptionsEntity {
  @override
  final bool supportRefunds;
  @override
  final bool supportTokenBilling;
  @override
  final BuiltList<String> webhooks;

  factory _$GatewayOptionsEntity(
          [void Function(GatewayOptionsEntityBuilder) updates]) =>
      (new GatewayOptionsEntityBuilder()..update(updates)).build();

  _$GatewayOptionsEntity._(
      {this.supportRefunds, this.supportTokenBilling, this.webhooks})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        supportRefunds, 'GatewayOptionsEntity', 'supportRefunds');
    BuiltValueNullFieldError.checkNotNull(
        supportTokenBilling, 'GatewayOptionsEntity', 'supportTokenBilling');
  }

  @override
  GatewayOptionsEntity rebuild(
          void Function(GatewayOptionsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GatewayOptionsEntityBuilder toBuilder() =>
      new GatewayOptionsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GatewayOptionsEntity &&
        supportRefunds == other.supportRefunds &&
        supportTokenBilling == other.supportTokenBilling &&
        webhooks == other.webhooks;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc(0, supportRefunds.hashCode), supportTokenBilling.hashCode),
        webhooks.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GatewayOptionsEntity')
          ..add('supportRefunds', supportRefunds)
          ..add('supportTokenBilling', supportTokenBilling)
          ..add('webhooks', webhooks))
        .toString();
  }
}

class GatewayOptionsEntityBuilder
    implements Builder<GatewayOptionsEntity, GatewayOptionsEntityBuilder> {
  _$GatewayOptionsEntity _$v;

  bool _supportRefunds;
  bool get supportRefunds => _$this._supportRefunds;
  set supportRefunds(bool supportRefunds) =>
      _$this._supportRefunds = supportRefunds;

  bool _supportTokenBilling;
  bool get supportTokenBilling => _$this._supportTokenBilling;
  set supportTokenBilling(bool supportTokenBilling) =>
      _$this._supportTokenBilling = supportTokenBilling;

  ListBuilder<String> _webhooks;
  ListBuilder<String> get webhooks =>
      _$this._webhooks ??= new ListBuilder<String>();
  set webhooks(ListBuilder<String> webhooks) => _$this._webhooks = webhooks;

  GatewayOptionsEntityBuilder();

  GatewayOptionsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _supportRefunds = $v.supportRefunds;
      _supportTokenBilling = $v.supportTokenBilling;
      _webhooks = $v.webhooks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayOptionsEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GatewayOptionsEntity;
  }

  @override
  void update(void Function(GatewayOptionsEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GatewayOptionsEntity build() {
    _$GatewayOptionsEntity _$result;
    try {
      _$result = _$v ??
          new _$GatewayOptionsEntity._(
              supportRefunds: BuiltValueNullFieldError.checkNotNull(
                  supportRefunds, 'GatewayOptionsEntity', 'supportRefunds'),
              supportTokenBilling: BuiltValueNullFieldError.checkNotNull(
                  supportTokenBilling,
                  'GatewayOptionsEntity',
                  'supportTokenBilling'),
              webhooks: _webhooks?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'webhooks';
        _webhooks?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GatewayOptionsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserCompanyEntity extends UserCompanyEntity {
  @override
  final bool isAdmin;
  @override
  final bool isOwner;
  @override
  final int permissionsUpdatedAt;
  @override
  final String permissions;
  @override
  final BuiltMap<String, BuiltList<String>> notifications;
  @override
  final CompanyEntity company;
  @override
  final UserEntity user;
  @override
  final TokenEntity token;
  @override
  final AccountEntity account;
  @override
  final UserSettingsEntity settings;
  @override
  final String ninjaPortalUrl;

  factory _$UserCompanyEntity(
          [void Function(UserCompanyEntityBuilder) updates]) =>
      (new UserCompanyEntityBuilder()..update(updates)).build();

  _$UserCompanyEntity._(
      {this.isAdmin,
      this.isOwner,
      this.permissionsUpdatedAt,
      this.permissions,
      this.notifications,
      this.company,
      this.user,
      this.token,
      this.account,
      this.settings,
      this.ninjaPortalUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isAdmin, 'UserCompanyEntity', 'isAdmin');
    BuiltValueNullFieldError.checkNotNull(
        isOwner, 'UserCompanyEntity', 'isOwner');
    BuiltValueNullFieldError.checkNotNull(
        permissionsUpdatedAt, 'UserCompanyEntity', 'permissionsUpdatedAt');
    BuiltValueNullFieldError.checkNotNull(
        permissions, 'UserCompanyEntity', 'permissions');
    BuiltValueNullFieldError.checkNotNull(
        ninjaPortalUrl, 'UserCompanyEntity', 'ninjaPortalUrl');
  }

  @override
  UserCompanyEntity rebuild(void Function(UserCompanyEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserCompanyEntityBuilder toBuilder() =>
      new UserCompanyEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCompanyEntity &&
        isAdmin == other.isAdmin &&
        isOwner == other.isOwner &&
        permissionsUpdatedAt == other.permissionsUpdatedAt &&
        permissions == other.permissions &&
        notifications == other.notifications &&
        company == other.company &&
        user == other.user &&
        token == other.token &&
        account == other.account &&
        settings == other.settings &&
        ninjaPortalUrl == other.ninjaPortalUrl;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, isAdmin.hashCode),
                                            isOwner.hashCode),
                                        permissionsUpdatedAt.hashCode),
                                    permissions.hashCode),
                                notifications.hashCode),
                            company.hashCode),
                        user.hashCode),
                    token.hashCode),
                account.hashCode),
            settings.hashCode),
        ninjaPortalUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserCompanyEntity')
          ..add('isAdmin', isAdmin)
          ..add('isOwner', isOwner)
          ..add('permissionsUpdatedAt', permissionsUpdatedAt)
          ..add('permissions', permissions)
          ..add('notifications', notifications)
          ..add('company', company)
          ..add('user', user)
          ..add('token', token)
          ..add('account', account)
          ..add('settings', settings)
          ..add('ninjaPortalUrl', ninjaPortalUrl))
        .toString();
  }
}

class UserCompanyEntityBuilder
    implements Builder<UserCompanyEntity, UserCompanyEntityBuilder> {
  _$UserCompanyEntity _$v;

  bool _isAdmin;
  bool get isAdmin => _$this._isAdmin;
  set isAdmin(bool isAdmin) => _$this._isAdmin = isAdmin;

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  int _permissionsUpdatedAt;
  int get permissionsUpdatedAt => _$this._permissionsUpdatedAt;
  set permissionsUpdatedAt(int permissionsUpdatedAt) =>
      _$this._permissionsUpdatedAt = permissionsUpdatedAt;

  String _permissions;
  String get permissions => _$this._permissions;
  set permissions(String permissions) => _$this._permissions = permissions;

  MapBuilder<String, BuiltList<String>> _notifications;
  MapBuilder<String, BuiltList<String>> get notifications =>
      _$this._notifications ??= new MapBuilder<String, BuiltList<String>>();
  set notifications(MapBuilder<String, BuiltList<String>> notifications) =>
      _$this._notifications = notifications;

  CompanyEntityBuilder _company;
  CompanyEntityBuilder get company =>
      _$this._company ??= new CompanyEntityBuilder();
  set company(CompanyEntityBuilder company) => _$this._company = company;

  UserEntityBuilder _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder user) => _$this._user = user;

  TokenEntityBuilder _token;
  TokenEntityBuilder get token => _$this._token ??= new TokenEntityBuilder();
  set token(TokenEntityBuilder token) => _$this._token = token;

  AccountEntityBuilder _account;
  AccountEntityBuilder get account =>
      _$this._account ??= new AccountEntityBuilder();
  set account(AccountEntityBuilder account) => _$this._account = account;

  UserSettingsEntityBuilder _settings;
  UserSettingsEntityBuilder get settings =>
      _$this._settings ??= new UserSettingsEntityBuilder();
  set settings(UserSettingsEntityBuilder settings) =>
      _$this._settings = settings;

  String _ninjaPortalUrl;
  String get ninjaPortalUrl => _$this._ninjaPortalUrl;
  set ninjaPortalUrl(String ninjaPortalUrl) =>
      _$this._ninjaPortalUrl = ninjaPortalUrl;

  UserCompanyEntityBuilder() {
    UserCompanyEntity._initializeBuilder(this);
  }

  UserCompanyEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isAdmin = $v.isAdmin;
      _isOwner = $v.isOwner;
      _permissionsUpdatedAt = $v.permissionsUpdatedAt;
      _permissions = $v.permissions;
      _notifications = $v.notifications?.toBuilder();
      _company = $v.company?.toBuilder();
      _user = $v.user?.toBuilder();
      _token = $v.token?.toBuilder();
      _account = $v.account?.toBuilder();
      _settings = $v.settings?.toBuilder();
      _ninjaPortalUrl = $v.ninjaPortalUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCompanyEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserCompanyEntity;
  }

  @override
  void update(void Function(UserCompanyEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserCompanyEntity build() {
    _$UserCompanyEntity _$result;
    try {
      _$result = _$v ??
          new _$UserCompanyEntity._(
              isAdmin: BuiltValueNullFieldError.checkNotNull(
                  isAdmin, 'UserCompanyEntity', 'isAdmin'),
              isOwner: BuiltValueNullFieldError.checkNotNull(
                  isOwner, 'UserCompanyEntity', 'isOwner'),
              permissionsUpdatedAt: BuiltValueNullFieldError.checkNotNull(
                  permissionsUpdatedAt,
                  'UserCompanyEntity',
                  'permissionsUpdatedAt'),
              permissions: BuiltValueNullFieldError.checkNotNull(
                  permissions, 'UserCompanyEntity', 'permissions'),
              notifications: _notifications?.build(),
              company: _company?.build(),
              user: _user?.build(),
              token: _token?.build(),
              account: _account?.build(),
              settings: _settings?.build(),
              ninjaPortalUrl: BuiltValueNullFieldError.checkNotNull(
                  ninjaPortalUrl, 'UserCompanyEntity', 'ninjaPortalUrl'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'notifications';
        _notifications?.build();
        _$failedField = 'company';
        _company?.build();
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'token';
        _token?.build();
        _$failedField = 'account';
        _account?.build();
        _$failedField = 'settings';
        _settings?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserCompanyEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserSettingsEntity extends UserSettingsEntity {
  @override
  final String accentColor;
  @override
  final BuiltMap<String, BuiltList<String>> tableColumns;
  @override
  final BuiltMap<String, ReportSettingsEntity> reportSettings;
  @override
  final int numberYearsActive;
  @override
  final bool includeDeletedClients;

  factory _$UserSettingsEntity(
          [void Function(UserSettingsEntityBuilder) updates]) =>
      (new UserSettingsEntityBuilder()..update(updates)).build();

  _$UserSettingsEntity._(
      {this.accentColor,
      this.tableColumns,
      this.reportSettings,
      this.numberYearsActive,
      this.includeDeletedClients})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        tableColumns, 'UserSettingsEntity', 'tableColumns');
    BuiltValueNullFieldError.checkNotNull(
        reportSettings, 'UserSettingsEntity', 'reportSettings');
    BuiltValueNullFieldError.checkNotNull(
        numberYearsActive, 'UserSettingsEntity', 'numberYearsActive');
    BuiltValueNullFieldError.checkNotNull(
        includeDeletedClients, 'UserSettingsEntity', 'includeDeletedClients');
  }

  @override
  UserSettingsEntity rebuild(
          void Function(UserSettingsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSettingsEntityBuilder toBuilder() =>
      new UserSettingsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSettingsEntity &&
        accentColor == other.accentColor &&
        tableColumns == other.tableColumns &&
        reportSettings == other.reportSettings &&
        numberYearsActive == other.numberYearsActive &&
        includeDeletedClients == other.includeDeletedClients;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc($jc($jc(0, accentColor.hashCode), tableColumns.hashCode),
                reportSettings.hashCode),
            numberYearsActive.hashCode),
        includeDeletedClients.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserSettingsEntity')
          ..add('accentColor', accentColor)
          ..add('tableColumns', tableColumns)
          ..add('reportSettings', reportSettings)
          ..add('numberYearsActive', numberYearsActive)
          ..add('includeDeletedClients', includeDeletedClients))
        .toString();
  }
}

class UserSettingsEntityBuilder
    implements Builder<UserSettingsEntity, UserSettingsEntityBuilder> {
  _$UserSettingsEntity _$v;

  String _accentColor;
  String get accentColor => _$this._accentColor;
  set accentColor(String accentColor) => _$this._accentColor = accentColor;

  MapBuilder<String, BuiltList<String>> _tableColumns;
  MapBuilder<String, BuiltList<String>> get tableColumns =>
      _$this._tableColumns ??= new MapBuilder<String, BuiltList<String>>();
  set tableColumns(MapBuilder<String, BuiltList<String>> tableColumns) =>
      _$this._tableColumns = tableColumns;

  MapBuilder<String, ReportSettingsEntity> _reportSettings;
  MapBuilder<String, ReportSettingsEntity> get reportSettings =>
      _$this._reportSettings ??= new MapBuilder<String, ReportSettingsEntity>();
  set reportSettings(MapBuilder<String, ReportSettingsEntity> reportSettings) =>
      _$this._reportSettings = reportSettings;

  int _numberYearsActive;
  int get numberYearsActive => _$this._numberYearsActive;
  set numberYearsActive(int numberYearsActive) =>
      _$this._numberYearsActive = numberYearsActive;

  bool _includeDeletedClients;
  bool get includeDeletedClients => _$this._includeDeletedClients;
  set includeDeletedClients(bool includeDeletedClients) =>
      _$this._includeDeletedClients = includeDeletedClients;

  UserSettingsEntityBuilder() {
    UserSettingsEntity._initializeBuilder(this);
  }

  UserSettingsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accentColor = $v.accentColor;
      _tableColumns = $v.tableColumns.toBuilder();
      _reportSettings = $v.reportSettings.toBuilder();
      _numberYearsActive = $v.numberYearsActive;
      _includeDeletedClients = $v.includeDeletedClients;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserSettingsEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserSettingsEntity;
  }

  @override
  void update(void Function(UserSettingsEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserSettingsEntity build() {
    _$UserSettingsEntity _$result;
    try {
      _$result = _$v ??
          new _$UserSettingsEntity._(
              accentColor: accentColor,
              tableColumns: tableColumns.build(),
              reportSettings: reportSettings.build(),
              numberYearsActive: BuiltValueNullFieldError.checkNotNull(
                  numberYearsActive, 'UserSettingsEntity', 'numberYearsActive'),
              includeDeletedClients: BuiltValueNullFieldError.checkNotNull(
                  includeDeletedClients,
                  'UserSettingsEntity',
                  'includeDeletedClients'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tableColumns';
        tableColumns.build();
        _$failedField = 'reportSettings';
        reportSettings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserSettingsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ReportSettingsEntity extends ReportSettingsEntity {
  @override
  final String sortColumn;
  @override
  final bool sortAscending;
  @override
  final int sortTotalsIndex;
  @override
  final bool sortTotalsAscending;
  @override
  final BuiltList<String> columns;

  factory _$ReportSettingsEntity(
          [void Function(ReportSettingsEntityBuilder) updates]) =>
      (new ReportSettingsEntityBuilder()..update(updates)).build();

  _$ReportSettingsEntity._(
      {this.sortColumn,
      this.sortAscending,
      this.sortTotalsIndex,
      this.sortTotalsAscending,
      this.columns})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        sortColumn, 'ReportSettingsEntity', 'sortColumn');
    BuiltValueNullFieldError.checkNotNull(
        sortAscending, 'ReportSettingsEntity', 'sortAscending');
    BuiltValueNullFieldError.checkNotNull(
        sortTotalsIndex, 'ReportSettingsEntity', 'sortTotalsIndex');
    BuiltValueNullFieldError.checkNotNull(
        sortTotalsAscending, 'ReportSettingsEntity', 'sortTotalsAscending');
    BuiltValueNullFieldError.checkNotNull(
        columns, 'ReportSettingsEntity', 'columns');
  }

  @override
  ReportSettingsEntity rebuild(
          void Function(ReportSettingsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReportSettingsEntityBuilder toBuilder() =>
      new ReportSettingsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportSettingsEntity &&
        sortColumn == other.sortColumn &&
        sortAscending == other.sortAscending &&
        sortTotalsIndex == other.sortTotalsIndex &&
        sortTotalsAscending == other.sortTotalsAscending &&
        columns == other.columns;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc($jc($jc(0, sortColumn.hashCode), sortAscending.hashCode),
                sortTotalsIndex.hashCode),
            sortTotalsAscending.hashCode),
        columns.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReportSettingsEntity')
          ..add('sortColumn', sortColumn)
          ..add('sortAscending', sortAscending)
          ..add('sortTotalsIndex', sortTotalsIndex)
          ..add('sortTotalsAscending', sortTotalsAscending)
          ..add('columns', columns))
        .toString();
  }
}

class ReportSettingsEntityBuilder
    implements Builder<ReportSettingsEntity, ReportSettingsEntityBuilder> {
  _$ReportSettingsEntity _$v;

  String _sortColumn;
  String get sortColumn => _$this._sortColumn;
  set sortColumn(String sortColumn) => _$this._sortColumn = sortColumn;

  bool _sortAscending;
  bool get sortAscending => _$this._sortAscending;
  set sortAscending(bool sortAscending) =>
      _$this._sortAscending = sortAscending;

  int _sortTotalsIndex;
  int get sortTotalsIndex => _$this._sortTotalsIndex;
  set sortTotalsIndex(int sortTotalsIndex) =>
      _$this._sortTotalsIndex = sortTotalsIndex;

  bool _sortTotalsAscending;
  bool get sortTotalsAscending => _$this._sortTotalsAscending;
  set sortTotalsAscending(bool sortTotalsAscending) =>
      _$this._sortTotalsAscending = sortTotalsAscending;

  ListBuilder<String> _columns;
  ListBuilder<String> get columns =>
      _$this._columns ??= new ListBuilder<String>();
  set columns(ListBuilder<String> columns) => _$this._columns = columns;

  ReportSettingsEntityBuilder() {
    ReportSettingsEntity._initializeBuilder(this);
  }

  ReportSettingsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sortColumn = $v.sortColumn;
      _sortAscending = $v.sortAscending;
      _sortTotalsIndex = $v.sortTotalsIndex;
      _sortTotalsAscending = $v.sortTotalsAscending;
      _columns = $v.columns.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportSettingsEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReportSettingsEntity;
  }

  @override
  void update(void Function(ReportSettingsEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReportSettingsEntity build() {
    _$ReportSettingsEntity _$result;
    try {
      _$result = _$v ??
          new _$ReportSettingsEntity._(
              sortColumn: BuiltValueNullFieldError.checkNotNull(
                  sortColumn, 'ReportSettingsEntity', 'sortColumn'),
              sortAscending: BuiltValueNullFieldError.checkNotNull(
                  sortAscending, 'ReportSettingsEntity', 'sortAscending'),
              sortTotalsIndex: BuiltValueNullFieldError.checkNotNull(
                  sortTotalsIndex, 'ReportSettingsEntity', 'sortTotalsIndex'),
              sortTotalsAscending: BuiltValueNullFieldError.checkNotNull(
                  sortTotalsAscending,
                  'ReportSettingsEntity',
                  'sortTotalsAscending'),
              columns: columns.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'columns';
        columns.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ReportSettingsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CompanyItemResponse extends CompanyItemResponse {
  @override
  final CompanyEntity data;

  factory _$CompanyItemResponse(
          [void Function(CompanyItemResponseBuilder) updates]) =>
      (new CompanyItemResponseBuilder()..update(updates)).build();

  _$CompanyItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'CompanyItemResponse', 'data');
  }

  @override
  CompanyItemResponse rebuild(
          void Function(CompanyItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyItemResponseBuilder toBuilder() =>
      new CompanyItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CompanyItemResponseBuilder
    implements Builder<CompanyItemResponse, CompanyItemResponseBuilder> {
  _$CompanyItemResponse _$v;

  CompanyEntityBuilder _data;
  CompanyEntityBuilder get data => _$this._data ??= new CompanyEntityBuilder();
  set data(CompanyEntityBuilder data) => _$this._data = data;

  CompanyItemResponseBuilder();

  CompanyItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompanyItemResponse;
  }

  @override
  void update(void Function(CompanyItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyItemResponse build() {
    _$CompanyItemResponse _$result;
    try {
      _$result = _$v ?? new _$CompanyItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$RegistrationFieldEntity extends RegistrationFieldEntity {
  @override
  final String key;
  @override
  final bool required;

  factory _$RegistrationFieldEntity(
          [void Function(RegistrationFieldEntityBuilder) updates]) =>
      (new RegistrationFieldEntityBuilder()..update(updates)).build();

  _$RegistrationFieldEntity._({this.key, this.required}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        key, 'RegistrationFieldEntity', 'key');
    BuiltValueNullFieldError.checkNotNull(
        required, 'RegistrationFieldEntity', 'required');
  }

  @override
  RegistrationFieldEntity rebuild(
          void Function(RegistrationFieldEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegistrationFieldEntityBuilder toBuilder() =>
      new RegistrationFieldEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegistrationFieldEntity &&
        key == other.key &&
        required == other.required;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, key.hashCode), required.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RegistrationFieldEntity')
          ..add('key', key)
          ..add('required', required))
        .toString();
  }
}

class RegistrationFieldEntityBuilder
    implements
        Builder<RegistrationFieldEntity, RegistrationFieldEntityBuilder> {
  _$RegistrationFieldEntity _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  bool _required;
  bool get required => _$this._required;
  set required(bool required) => _$this._required = required;

  RegistrationFieldEntityBuilder();

  RegistrationFieldEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _required = $v.required;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegistrationFieldEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegistrationFieldEntity;
  }

  @override
  void update(void Function(RegistrationFieldEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RegistrationFieldEntity build() {
    final _$result = _$v ??
        new _$RegistrationFieldEntity._(
            key: BuiltValueNullFieldError.checkNotNull(
                key, 'RegistrationFieldEntity', 'key'),
            required: BuiltValueNullFieldError.checkNotNull(
                required, 'RegistrationFieldEntity', 'required'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
