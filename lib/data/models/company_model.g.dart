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
Serializer<SettingsEntity> _$settingsEntitySerializer =
    new _$SettingsEntitySerializer();
Serializer<CompanyItemResponse> _$companyItemResponseSerializer =
    new _$CompanyItemResponseSerializer();

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
      'payment_terms',
      serializers.serialize(object.paymentTerms,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTermEntity)])),
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
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.createdUserId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.createdUserId,
            specifiedType: const FullType(String)));
    }
    if (object.assignedUserId != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(object.assignedUserId,
            specifiedType: const FullType(String)));
    }
    if (object.entityType != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(object.entityType,
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
      final dynamic value = iterator.current;
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
        case 'payment_terms':
          result.paymentTerms.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTermEntity)]))
              as BuiltList<Object>);
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
      final dynamic value = iterator.current;
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
    if (object.webhooks != null) {
      result
        ..add('webhooks')
        ..add(serializers.serialize(object.webhooks,
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
      final dynamic value = iterator.current;
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
    ];
    if (object.notifications != null) {
      result
        ..add('notifications')
        ..add(serializers.serialize(object.notifications,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)])
            ])));
    }
    if (object.company != null) {
      result
        ..add('company')
        ..add(serializers.serialize(object.company,
            specifiedType: const FullType(CompanyEntity)));
    }
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(UserEntity)));
    }
    if (object.token != null) {
      result
        ..add('token')
        ..add(serializers.serialize(object.token,
            specifiedType: const FullType(TokenEntity)));
    }
    if (object.account != null) {
      result
        ..add('account')
        ..add(serializers.serialize(object.account,
            specifiedType: const FullType(AccountEntity)));
    }
    if (object.settings != null) {
      result
        ..add('settings')
        ..add(serializers.serialize(object.settings,
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
      final dynamic value = iterator.current;
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
    ];
    if (object.accentColor != null) {
      result
        ..add('accent_color')
        ..add(serializers.serialize(object.accentColor,
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
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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

class _$SettingsEntitySerializer
    implements StructuredSerializer<SettingsEntity> {
  @override
  final Iterable<Type> types = const [SettingsEntity, _$SettingsEntity];
  @override
  final String wireName = 'SettingsEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, SettingsEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.timezoneId != null) {
      result
        ..add('timezone_id')
        ..add(serializers.serialize(object.timezoneId,
            specifiedType: const FullType(String)));
    }
    if (object.dateFormatId != null) {
      result
        ..add('date_format_id')
        ..add(serializers.serialize(object.dateFormatId,
            specifiedType: const FullType(String)));
    }
    if (object.enableMilitaryTime != null) {
      result
        ..add('military_time')
        ..add(serializers.serialize(object.enableMilitaryTime,
            specifiedType: const FullType(bool)));
    }
    if (object.languageId != null) {
      result
        ..add('language_id')
        ..add(serializers.serialize(object.languageId,
            specifiedType: const FullType(String)));
    }
    if (object.showCurrencyCode != null) {
      result
        ..add('show_currency_code')
        ..add(serializers.serialize(object.showCurrencyCode,
            specifiedType: const FullType(bool)));
    }
    if (object.currencyId != null) {
      result
        ..add('currency_id')
        ..add(serializers.serialize(object.currencyId,
            specifiedType: const FullType(String)));
    }
    if (object.customValue1 != null) {
      result
        ..add('custom_value1')
        ..add(serializers.serialize(object.customValue1,
            specifiedType: const FullType(String)));
    }
    if (object.customValue2 != null) {
      result
        ..add('custom_value2')
        ..add(serializers.serialize(object.customValue2,
            specifiedType: const FullType(String)));
    }
    if (object.customValue3 != null) {
      result
        ..add('custom_value3')
        ..add(serializers.serialize(object.customValue3,
            specifiedType: const FullType(String)));
    }
    if (object.customValue4 != null) {
      result
        ..add('custom_value4')
        ..add(serializers.serialize(object.customValue4,
            specifiedType: const FullType(String)));
    }
    if (object.defaultPaymentTerms != null) {
      result
        ..add('payment_terms')
        ..add(serializers.serialize(object.defaultPaymentTerms,
            specifiedType: const FullType(String)));
    }
    if (object.companyGatewayIds != null) {
      result
        ..add('company_gateway_ids')
        ..add(serializers.serialize(object.companyGatewayIds,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaskRate != null) {
      result
        ..add('default_task_rate')
        ..add(serializers.serialize(object.defaultTaskRate,
            specifiedType: const FullType(double)));
    }
    if (object.sendReminders != null) {
      result
        ..add('send_reminders')
        ..add(serializers.serialize(object.sendReminders,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortal != null) {
      result
        ..add('enable_client_portal')
        ..add(serializers.serialize(object.enablePortal,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortalDashboard != null) {
      result
        ..add('enable_client_portal_dashboard')
        ..add(serializers.serialize(object.enablePortalDashboard,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortalTasks != null) {
      result
        ..add('enable_client_portal_tasks')
        ..add(serializers.serialize(object.enablePortalTasks,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortalUploads != null) {
      result
        ..add('client_portal_enable_uploads')
        ..add(serializers.serialize(object.enablePortalUploads,
            specifiedType: const FullType(bool)));
    }
    if (object.emailStyle != null) {
      result
        ..add('email_style')
        ..add(serializers.serialize(object.emailStyle,
            specifiedType: const FullType(String)));
    }
    if (object.replyToEmail != null) {
      result
        ..add('reply_to_email')
        ..add(serializers.serialize(object.replyToEmail,
            specifiedType: const FullType(String)));
    }
    if (object.replyToName != null) {
      result
        ..add('reply_to_name')
        ..add(serializers.serialize(object.replyToName,
            specifiedType: const FullType(String)));
    }
    if (object.bccEmail != null) {
      result
        ..add('bcc_email')
        ..add(serializers.serialize(object.bccEmail,
            specifiedType: const FullType(String)));
    }
    if (object.pdfEmailAttachment != null) {
      result
        ..add('pdf_email_attachment')
        ..add(serializers.serialize(object.pdfEmailAttachment,
            specifiedType: const FullType(bool)));
    }
    if (object.ublEmailAttachment != null) {
      result
        ..add('ubl_email_attachment')
        ..add(serializers.serialize(object.ublEmailAttachment,
            specifiedType: const FullType(bool)));
    }
    if (object.documentEmailAttachment != null) {
      result
        ..add('document_email_attachment')
        ..add(serializers.serialize(object.documentEmailAttachment,
            specifiedType: const FullType(bool)));
    }
    if (object.emailStyleCustom != null) {
      result
        ..add('email_style_custom')
        ..add(serializers.serialize(object.emailStyleCustom,
            specifiedType: const FullType(String)));
    }
    if (object.customMessageDashboard != null) {
      result
        ..add('custom_message_dashboard')
        ..add(serializers.serialize(object.customMessageDashboard,
            specifiedType: const FullType(String)));
    }
    if (object.customMessageUnpaidInvoice != null) {
      result
        ..add('custom_message_unpaid_invoice')
        ..add(serializers.serialize(object.customMessageUnpaidInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.customMessagePaidInvoice != null) {
      result
        ..add('custom_message_paid_invoice')
        ..add(serializers.serialize(object.customMessagePaidInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.customMessageUnapprovedQuote != null) {
      result
        ..add('custom_message_unapproved_quote')
        ..add(serializers.serialize(object.customMessageUnapprovedQuote,
            specifiedType: const FullType(String)));
    }
    if (object.autoArchiveInvoice != null) {
      result
        ..add('auto_archive_invoice')
        ..add(serializers.serialize(object.autoArchiveInvoice,
            specifiedType: const FullType(bool)));
    }
    if (object.autoArchiveQuote != null) {
      result
        ..add('auto_archive_quote')
        ..add(serializers.serialize(object.autoArchiveQuote,
            specifiedType: const FullType(bool)));
    }
    if (object.autoEmailInvoice != null) {
      result
        ..add('auto_email_invoice')
        ..add(serializers.serialize(object.autoEmailInvoice,
            specifiedType: const FullType(bool)));
    }
    if (object.autoConvertQuote != null) {
      result
        ..add('auto_convert_quote')
        ..add(serializers.serialize(object.autoConvertQuote,
            specifiedType: const FullType(bool)));
    }
    if (object.enableInclusiveTaxes != null) {
      result
        ..add('inclusive_taxes')
        ..add(serializers.serialize(object.enableInclusiveTaxes,
            specifiedType: const FullType(bool)));
    }
    if (object.translations != null) {
      result
        ..add('translations')
        ..add(serializers.serialize(object.translations,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])));
    }
    if (object.taskNumberPattern != null) {
      result
        ..add('task_number_pattern')
        ..add(serializers.serialize(object.taskNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.taskNumberCounter != null) {
      result
        ..add('task_number_counter')
        ..add(serializers.serialize(object.taskNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.expenseNumberPattern != null) {
      result
        ..add('expense_number_pattern')
        ..add(serializers.serialize(object.expenseNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.expenseNumberCounter != null) {
      result
        ..add('expense_number_counter')
        ..add(serializers.serialize(object.expenseNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.vendorNumberPattern != null) {
      result
        ..add('vendor_number_pattern')
        ..add(serializers.serialize(object.vendorNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.vendorNumberCounter != null) {
      result
        ..add('vendor_number_counter')
        ..add(serializers.serialize(object.vendorNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.ticketNumberPattern != null) {
      result
        ..add('ticket_number_pattern')
        ..add(serializers.serialize(object.ticketNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.ticketNumberCounter != null) {
      result
        ..add('ticket_number_counter')
        ..add(serializers.serialize(object.ticketNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.paymentNumberPattern != null) {
      result
        ..add('payment_number_pattern')
        ..add(serializers.serialize(object.paymentNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.paymentNumberCounter != null) {
      result
        ..add('payment_number_counter')
        ..add(serializers.serialize(object.paymentNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.projectNumberPattern != null) {
      result
        ..add('project_number_pattern')
        ..add(serializers.serialize(object.projectNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.projectNumberCounter != null) {
      result
        ..add('project_number_counter')
        ..add(serializers.serialize(object.projectNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.invoiceNumberPattern != null) {
      result
        ..add('invoice_number_pattern')
        ..add(serializers.serialize(object.invoiceNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.invoiceNumberCounter != null) {
      result
        ..add('invoice_number_counter')
        ..add(serializers.serialize(object.invoiceNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.recurringInvoiceNumberPattern != null) {
      result
        ..add('recurring_invoice_number_pattern')
        ..add(serializers.serialize(object.recurringInvoiceNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.recurringInvoiceNumberCounter != null) {
      result
        ..add('recurring_invoice_number_counter')
        ..add(serializers.serialize(object.recurringInvoiceNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.quoteNumberPattern != null) {
      result
        ..add('quote_number_pattern')
        ..add(serializers.serialize(object.quoteNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.quoteNumberCounter != null) {
      result
        ..add('quote_number_counter')
        ..add(serializers.serialize(object.quoteNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.clientNumberPattern != null) {
      result
        ..add('client_number_pattern')
        ..add(serializers.serialize(object.clientNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.clientNumberCounter != null) {
      result
        ..add('client_number_counter')
        ..add(serializers.serialize(object.clientNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.creditNumberPattern != null) {
      result
        ..add('credit_number_pattern')
        ..add(serializers.serialize(object.creditNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.creditNumberCounter != null) {
      result
        ..add('credit_number_counter')
        ..add(serializers.serialize(object.creditNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.recurringNumberPrefix != null) {
      result
        ..add('recurring_number_prefix')
        ..add(serializers.serialize(object.recurringNumberPrefix,
            specifiedType: const FullType(String)));
    }
    if (object.resetCounterFrequencyId != null) {
      result
        ..add('reset_counter_frequency_id')
        ..add(serializers.serialize(object.resetCounterFrequencyId,
            specifiedType: const FullType(String)));
    }
    if (object.resetCounterDate != null) {
      result
        ..add('reset_counter_date')
        ..add(serializers.serialize(object.resetCounterDate,
            specifiedType: const FullType(String)));
    }
    if (object.counterPadding != null) {
      result
        ..add('counter_padding')
        ..add(serializers.serialize(object.counterPadding,
            specifiedType: const FullType(int)));
    }
    if (object.sharedInvoiceQuoteCounter != null) {
      result
        ..add('shared_invoice_quote_counter')
        ..add(serializers.serialize(object.sharedInvoiceQuoteCounter,
            specifiedType: const FullType(bool)));
    }
    if (object.sharedInvoiceCreditCounter != null) {
      result
        ..add('shared_invoice_credit_counter')
        ..add(serializers.serialize(object.sharedInvoiceCreditCounter,
            specifiedType: const FullType(bool)));
    }
    if (object.defaultInvoiceTerms != null) {
      result
        ..add('invoice_terms')
        ..add(serializers.serialize(object.defaultInvoiceTerms,
            specifiedType: const FullType(String)));
    }
    if (object.defaultQuoteTerms != null) {
      result
        ..add('quote_terms')
        ..add(serializers.serialize(object.defaultQuoteTerms,
            specifiedType: const FullType(String)));
    }
    if (object.defaultQuoteFooter != null) {
      result
        ..add('quote_footer')
        ..add(serializers.serialize(object.defaultQuoteFooter,
            specifiedType: const FullType(String)));
    }
    if (object.defaultCreditTerms != null) {
      result
        ..add('credit_terms')
        ..add(serializers.serialize(object.defaultCreditTerms,
            specifiedType: const FullType(String)));
    }
    if (object.defaultCreditFooter != null) {
      result
        ..add('credit_footer')
        ..add(serializers.serialize(object.defaultCreditFooter,
            specifiedType: const FullType(String)));
    }
    if (object.defaultInvoiceDesignId != null) {
      result
        ..add('invoice_design_id')
        ..add(serializers.serialize(object.defaultInvoiceDesignId,
            specifiedType: const FullType(String)));
    }
    if (object.defaultQuoteDesignId != null) {
      result
        ..add('quote_design_id')
        ..add(serializers.serialize(object.defaultQuoteDesignId,
            specifiedType: const FullType(String)));
    }
    if (object.defaultCreditDesignId != null) {
      result
        ..add('credit_design_id')
        ..add(serializers.serialize(object.defaultCreditDesignId,
            specifiedType: const FullType(String)));
    }
    if (object.defaultInvoiceFooter != null) {
      result
        ..add('invoice_footer')
        ..add(serializers.serialize(object.defaultInvoiceFooter,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxName1 != null) {
      result
        ..add('tax_name1')
        ..add(serializers.serialize(object.defaultTaxName1,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxRate1 != null) {
      result
        ..add('tax_rate1')
        ..add(serializers.serialize(object.defaultTaxRate1,
            specifiedType: const FullType(double)));
    }
    if (object.defaultTaxName2 != null) {
      result
        ..add('tax_name2')
        ..add(serializers.serialize(object.defaultTaxName2,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxRate2 != null) {
      result
        ..add('tax_rate2')
        ..add(serializers.serialize(object.defaultTaxRate2,
            specifiedType: const FullType(double)));
    }
    if (object.defaultTaxName3 != null) {
      result
        ..add('tax_name3')
        ..add(serializers.serialize(object.defaultTaxName3,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxRate3 != null) {
      result
        ..add('tax_rate3')
        ..add(serializers.serialize(object.defaultTaxRate3,
            specifiedType: const FullType(double)));
    }
    if (object.defaultPaymentTypeId != null) {
      result
        ..add('payment_type_id')
        ..add(serializers.serialize(object.defaultPaymentTypeId,
            specifiedType: const FullType(String)));
    }
    if (object.pdfVariables != null) {
      result
        ..add('pdf_variables')
        ..add(serializers.serialize(object.pdfVariables,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)])
            ])));
    }
    if (object.emailSignature != null) {
      result
        ..add('email_signature')
        ..add(serializers.serialize(object.emailSignature,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectInvoice != null) {
      result
        ..add('email_subject_invoice')
        ..add(serializers.serialize(object.emailSubjectInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectQuote != null) {
      result
        ..add('email_subject_quote')
        ..add(serializers.serialize(object.emailSubjectQuote,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCredit != null) {
      result
        ..add('email_subject_credit')
        ..add(serializers.serialize(object.emailSubjectCredit,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectPayment != null) {
      result
        ..add('email_subject_payment')
        ..add(serializers.serialize(object.emailSubjectPayment,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectPaymentPartial != null) {
      result
        ..add('email_subject_payment_partial')
        ..add(serializers.serialize(object.emailSubjectPaymentPartial,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyInvoice != null) {
      result
        ..add('email_template_invoice')
        ..add(serializers.serialize(object.emailBodyInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyQuote != null) {
      result
        ..add('email_template_quote')
        ..add(serializers.serialize(object.emailBodyQuote,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCredit != null) {
      result
        ..add('email_template_credit')
        ..add(serializers.serialize(object.emailBodyCredit,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyPayment != null) {
      result
        ..add('email_template_payment')
        ..add(serializers.serialize(object.emailBodyPayment,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyPaymentPartial != null) {
      result
        ..add('email_template_payment_partial')
        ..add(serializers.serialize(object.emailBodyPaymentPartial,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectReminder1 != null) {
      result
        ..add('email_subject_reminder1')
        ..add(serializers.serialize(object.emailSubjectReminder1,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectReminder2 != null) {
      result
        ..add('email_subject_reminder2')
        ..add(serializers.serialize(object.emailSubjectReminder2,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectReminder3 != null) {
      result
        ..add('email_subject_reminder3')
        ..add(serializers.serialize(object.emailSubjectReminder3,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminder1 != null) {
      result
        ..add('email_template_reminder1')
        ..add(serializers.serialize(object.emailBodyReminder1,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminder2 != null) {
      result
        ..add('email_template_reminder2')
        ..add(serializers.serialize(object.emailBodyReminder2,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminder3 != null) {
      result
        ..add('email_template_reminder3')
        ..add(serializers.serialize(object.emailBodyReminder3,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCustom1 != null) {
      result
        ..add('email_subject_custom1')
        ..add(serializers.serialize(object.emailSubjectCustom1,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCustom1 != null) {
      result
        ..add('email_template_custom1')
        ..add(serializers.serialize(object.emailBodyCustom1,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCustom2 != null) {
      result
        ..add('email_subject_custom2')
        ..add(serializers.serialize(object.emailSubjectCustom2,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCustom2 != null) {
      result
        ..add('email_template_custom2')
        ..add(serializers.serialize(object.emailBodyCustom2,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCustom3 != null) {
      result
        ..add('email_subject_custom3')
        ..add(serializers.serialize(object.emailSubjectCustom3,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCustom3 != null) {
      result
        ..add('email_template_custom3')
        ..add(serializers.serialize(object.emailBodyCustom3,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectStatement != null) {
      result
        ..add('email_subject_statement')
        ..add(serializers.serialize(object.emailSubjectStatement,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyStatement != null) {
      result
        ..add('email_template_statement')
        ..add(serializers.serialize(object.emailBodyStatement,
            specifiedType: const FullType(String)));
    }
    if (object.enablePortalPassword != null) {
      result
        ..add('enable_client_portal_password')
        ..add(serializers.serialize(object.enablePortalPassword,
            specifiedType: const FullType(bool)));
    }
    if (object.signatureOnPdf != null) {
      result
        ..add('signature_on_pdf')
        ..add(serializers.serialize(object.signatureOnPdf,
            specifiedType: const FullType(bool)));
    }
    if (object.enableEmailMarkup != null) {
      result
        ..add('enable_email_markup')
        ..add(serializers.serialize(object.enableEmailMarkup,
            specifiedType: const FullType(bool)));
    }
    if (object.showAcceptInvoiceTerms != null) {
      result
        ..add('show_accept_invoice_terms')
        ..add(serializers.serialize(object.showAcceptInvoiceTerms,
            specifiedType: const FullType(bool)));
    }
    if (object.showAcceptQuoteTerms != null) {
      result
        ..add('show_accept_quote_terms')
        ..add(serializers.serialize(object.showAcceptQuoteTerms,
            specifiedType: const FullType(bool)));
    }
    if (object.requireInvoiceSignature != null) {
      result
        ..add('require_invoice_signature')
        ..add(serializers.serialize(object.requireInvoiceSignature,
            specifiedType: const FullType(bool)));
    }
    if (object.requireQuoteSignature != null) {
      result
        ..add('require_quote_signature')
        ..add(serializers.serialize(object.requireQuoteSignature,
            specifiedType: const FullType(bool)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.companyLogo != null) {
      result
        ..add('company_logo')
        ..add(serializers.serialize(object.companyLogo,
            specifiedType: const FullType(String)));
    }
    if (object.website != null) {
      result
        ..add('website')
        ..add(serializers.serialize(object.website,
            specifiedType: const FullType(String)));
    }
    if (object.address1 != null) {
      result
        ..add('address1')
        ..add(serializers.serialize(object.address1,
            specifiedType: const FullType(String)));
    }
    if (object.address2 != null) {
      result
        ..add('address2')
        ..add(serializers.serialize(object.address2,
            specifiedType: const FullType(String)));
    }
    if (object.city != null) {
      result
        ..add('city')
        ..add(serializers.serialize(object.city,
            specifiedType: const FullType(String)));
    }
    if (object.state != null) {
      result
        ..add('state')
        ..add(serializers.serialize(object.state,
            specifiedType: const FullType(String)));
    }
    if (object.postalCode != null) {
      result
        ..add('postal_code')
        ..add(serializers.serialize(object.postalCode,
            specifiedType: const FullType(String)));
    }
    if (object.phone != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(object.phone,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.countryId != null) {
      result
        ..add('country_id')
        ..add(serializers.serialize(object.countryId,
            specifiedType: const FullType(String)));
    }
    if (object.vatNumber != null) {
      result
        ..add('vat_number')
        ..add(serializers.serialize(object.vatNumber,
            specifiedType: const FullType(String)));
    }
    if (object.idNumber != null) {
      result
        ..add('id_number')
        ..add(serializers.serialize(object.idNumber,
            specifiedType: const FullType(String)));
    }
    if (object.pageSize != null) {
      result
        ..add('page_size')
        ..add(serializers.serialize(object.pageSize,
            specifiedType: const FullType(String)));
    }
    if (object.fontSize != null) {
      result
        ..add('font_size')
        ..add(serializers.serialize(object.fontSize,
            specifiedType: const FullType(int)));
    }
    if (object.primaryColor != null) {
      result
        ..add('primary_color')
        ..add(serializers.serialize(object.primaryColor,
            specifiedType: const FullType(String)));
    }
    if (object.secondaryColor != null) {
      result
        ..add('secondary_color')
        ..add(serializers.serialize(object.secondaryColor,
            specifiedType: const FullType(String)));
    }
    if (object.primaryFont != null) {
      result
        ..add('primary_font')
        ..add(serializers.serialize(object.primaryFont,
            specifiedType: const FullType(String)));
    }
    if (object.secondaryFont != null) {
      result
        ..add('secondary_font')
        ..add(serializers.serialize(object.secondaryFont,
            specifiedType: const FullType(String)));
    }
    if (object.hidePaidToDate != null) {
      result
        ..add('hide_paid_to_date')
        ..add(serializers.serialize(object.hidePaidToDate,
            specifiedType: const FullType(bool)));
    }
    if (object.embedDocuments != null) {
      result
        ..add('embed_documents')
        ..add(serializers.serialize(object.embedDocuments,
            specifiedType: const FullType(bool)));
    }
    if (object.allPagesHeader != null) {
      result
        ..add('all_pages_header')
        ..add(serializers.serialize(object.allPagesHeader,
            specifiedType: const FullType(bool)));
    }
    if (object.allPagesFooter != null) {
      result
        ..add('all_pages_footer')
        ..add(serializers.serialize(object.allPagesFooter,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminder1 != null) {
      result
        ..add('enable_reminder1')
        ..add(serializers.serialize(object.enableReminder1,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminder2 != null) {
      result
        ..add('enable_reminder2')
        ..add(serializers.serialize(object.enableReminder2,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminder3 != null) {
      result
        ..add('enable_reminder3')
        ..add(serializers.serialize(object.enableReminder3,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminderEndless != null) {
      result
        ..add('enable_reminder_endless')
        ..add(serializers.serialize(object.enableReminderEndless,
            specifiedType: const FullType(bool)));
    }
    if (object.numDaysReminder1 != null) {
      result
        ..add('num_days_reminder1')
        ..add(serializers.serialize(object.numDaysReminder1,
            specifiedType: const FullType(int)));
    }
    if (object.numDaysReminder2 != null) {
      result
        ..add('num_days_reminder2')
        ..add(serializers.serialize(object.numDaysReminder2,
            specifiedType: const FullType(int)));
    }
    if (object.numDaysReminder3 != null) {
      result
        ..add('num_days_reminder3')
        ..add(serializers.serialize(object.numDaysReminder3,
            specifiedType: const FullType(int)));
    }
    if (object.scheduleReminder1 != null) {
      result
        ..add('schedule_reminder1')
        ..add(serializers.serialize(object.scheduleReminder1,
            specifiedType: const FullType(String)));
    }
    if (object.scheduleReminder2 != null) {
      result
        ..add('schedule_reminder2')
        ..add(serializers.serialize(object.scheduleReminder2,
            specifiedType: const FullType(String)));
    }
    if (object.scheduleReminder3 != null) {
      result
        ..add('schedule_reminder3')
        ..add(serializers.serialize(object.scheduleReminder3,
            specifiedType: const FullType(String)));
    }
    if (object.endlessReminderFrequencyId != null) {
      result
        ..add('endless_reminder_frequency_id')
        ..add(serializers.serialize(object.endlessReminderFrequencyId,
            specifiedType: const FullType(String)));
    }
    if (object.lateFeeAmount1 != null) {
      result
        ..add('late_fee_amount1')
        ..add(serializers.serialize(object.lateFeeAmount1,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeeAmount2 != null) {
      result
        ..add('late_fee_amount2')
        ..add(serializers.serialize(object.lateFeeAmount2,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeeAmount3 != null) {
      result
        ..add('late_fee_amount3')
        ..add(serializers.serialize(object.lateFeeAmount3,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeeAmountEndless != null) {
      result
        ..add('late_fee_endless_amount')
        ..add(serializers.serialize(object.lateFeeAmountEndless,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercent1 != null) {
      result
        ..add('late_fee_percent1')
        ..add(serializers.serialize(object.lateFeePercent1,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercent2 != null) {
      result
        ..add('late_fee_percent2')
        ..add(serializers.serialize(object.lateFeePercent2,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercent3 != null) {
      result
        ..add('late_fee_percent3')
        ..add(serializers.serialize(object.lateFeePercent3,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercentEndless != null) {
      result
        ..add('late_fee_endless_percent')
        ..add(serializers.serialize(object.lateFeePercentEndless,
            specifiedType: const FullType(double)));
    }
    if (object.emailSubjectReminderEndless != null) {
      result
        ..add('email_subject_reminder_endless')
        ..add(serializers.serialize(object.emailSubjectReminderEndless,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminderEndless != null) {
      result
        ..add('email_template_reminder_endless')
        ..add(serializers.serialize(object.emailBodyReminderEndless,
            specifiedType: const FullType(String)));
    }
    if (object.clientOnlinePaymentNotification != null) {
      result
        ..add('client_online_payment_notification')
        ..add(serializers.serialize(object.clientOnlinePaymentNotification,
            specifiedType: const FullType(bool)));
    }
    if (object.clientManualPaymentNotification != null) {
      result
        ..add('client_manual_payment_notification')
        ..add(serializers.serialize(object.clientManualPaymentNotification,
            specifiedType: const FullType(bool)));
    }
    if (object.counterNumberApplied != null) {
      result
        ..add('counter_number_applied')
        ..add(serializers.serialize(object.counterNumberApplied,
            specifiedType: const FullType(String)));
    }
    if (object.emailSendingMethod != null) {
      result
        ..add('email_sending_method')
        ..add(serializers.serialize(object.emailSendingMethod,
            specifiedType: const FullType(String)));
    }
    if (object.gmailSendingUserId != null) {
      result
        ..add('gmail_sending_user_id')
        ..add(serializers.serialize(object.gmailSendingUserId,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalTerms != null) {
      result
        ..add('client_portal_terms')
        ..add(serializers.serialize(object.clientPortalTerms,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalPrivacy != null) {
      result
        ..add('client_portal_privacy_policy')
        ..add(serializers.serialize(object.clientPortalPrivacy,
            specifiedType: const FullType(String)));
    }
    if (object.lockInvoices != null) {
      result
        ..add('lock_invoices')
        ..add(serializers.serialize(object.lockInvoices,
            specifiedType: const FullType(String)));
    }
    if (object.autoBill != null) {
      result
        ..add('auto_bill')
        ..add(serializers.serialize(object.autoBill,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalAllowUnderPayment != null) {
      result
        ..add('client_portal_allow_under_payment')
        ..add(serializers.serialize(object.clientPortalAllowUnderPayment,
            specifiedType: const FullType(bool)));
    }
    if (object.clientPortalAllowOverPayment != null) {
      result
        ..add('client_portal_allow_over_payment')
        ..add(serializers.serialize(object.clientPortalAllowOverPayment,
            specifiedType: const FullType(bool)));
    }
    if (object.autoBillDate != null) {
      result
        ..add('auto_bill_date')
        ..add(serializers.serialize(object.autoBillDate,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalUnderPaymentMinimum != null) {
      result
        ..add('client_portal_under_payment_minimum')
        ..add(serializers.serialize(object.clientPortalUnderPaymentMinimum,
            specifiedType: const FullType(double)));
    }
    if (object.useCreditsPayment != null) {
      result
        ..add('use_credits_payment')
        ..add(serializers.serialize(object.useCreditsPayment,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomHeader != null) {
      result
        ..add('portal_custom_head')
        ..add(serializers.serialize(object.clientPortalCustomHeader,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomCss != null) {
      result
        ..add('portal_custom_css')
        ..add(serializers.serialize(object.clientPortalCustomCss,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomFooter != null) {
      result
        ..add('portal_custom_footer')
        ..add(serializers.serialize(object.clientPortalCustomFooter,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomJs != null) {
      result
        ..add('portal_custom_js')
        ..add(serializers.serialize(object.clientPortalCustomJs,
            specifiedType: const FullType(String)));
    }
    if (object.hideEmptyColumnsOnPdf != null) {
      result
        ..add('hide_empty_columns_on_pdf')
        ..add(serializers.serialize(object.hideEmptyColumnsOnPdf,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign1 != null) {
      result
        ..add('has_custom_design1_HIDDEN')
        ..add(serializers.serialize(object.hasCustomDesign1,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign2 != null) {
      result
        ..add('has_custom_design2_HIDDEN')
        ..add(serializers.serialize(object.hasCustomDesign2,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign3 != null) {
      result
        ..add('has_custom_design3_HIDDEN')
        ..add(serializers.serialize(object.hasCustomDesign3,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  SettingsEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'timezone_id':
          result.timezoneId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date_format_id':
          result.dateFormatId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'military_time':
          result.enableMilitaryTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'language_id':
          result.languageId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'show_currency_code':
          result.showCurrencyCode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_terms':
          result.defaultPaymentTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_gateway_ids':
          result.companyGatewayIds = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'default_task_rate':
          result.defaultTaskRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'send_reminders':
          result.sendReminders = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_client_portal':
          result.enablePortal = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_client_portal_dashboard':
          result.enablePortalDashboard = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_client_portal_tasks':
          result.enablePortalTasks = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_portal_enable_uploads':
          result.enablePortalUploads = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'email_style':
          result.emailStyle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reply_to_email':
          result.replyToEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reply_to_name':
          result.replyToName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bcc_email':
          result.bccEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pdf_email_attachment':
          result.pdfEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'ubl_email_attachment':
          result.ublEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'document_email_attachment':
          result.documentEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'email_style_custom':
          result.emailStyleCustom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_dashboard':
          result.customMessageDashboard = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_unpaid_invoice':
          result.customMessageUnpaidInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_paid_invoice':
          result.customMessagePaidInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_unapproved_quote':
          result.customMessageUnapprovedQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'auto_archive_invoice':
          result.autoArchiveInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_archive_quote':
          result.autoArchiveQuote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_email_invoice':
          result.autoEmailInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_convert_quote':
          result.autoConvertQuote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'inclusive_taxes':
          result.enableInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'translations':
          result.translations.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'task_number_pattern':
          result.taskNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'task_number_counter':
          result.taskNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'expense_number_pattern':
          result.expenseNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expense_number_counter':
          result.expenseNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'vendor_number_pattern':
          result.vendorNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor_number_counter':
          result.vendorNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'ticket_number_pattern':
          result.ticketNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ticket_number_counter':
          result.ticketNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'payment_number_pattern':
          result.paymentNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_number_counter':
          result.paymentNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'project_number_pattern':
          result.projectNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_number_counter':
          result.projectNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_number_pattern':
          result.invoiceNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_number_counter':
          result.invoiceNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'recurring_invoice_number_pattern':
          result.recurringInvoiceNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'recurring_invoice_number_counter':
          result.recurringInvoiceNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'quote_number_pattern':
          result.quoteNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_number_counter':
          result.quoteNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'client_number_pattern':
          result.clientNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_number_counter':
          result.clientNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'credit_number_pattern':
          result.creditNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_number_counter':
          result.creditNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'recurring_number_prefix':
          result.recurringNumberPrefix = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reset_counter_frequency_id':
          result.resetCounterFrequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reset_counter_date':
          result.resetCounterDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'counter_padding':
          result.counterPadding = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'shared_invoice_quote_counter':
          result.sharedInvoiceQuoteCounter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'shared_invoice_credit_counter':
          result.sharedInvoiceCreditCounter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_terms':
          result.defaultInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_terms':
          result.defaultQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_footer':
          result.defaultQuoteFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_terms':
          result.defaultCreditTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_footer':
          result.defaultCreditFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_design_id':
          result.defaultInvoiceDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_design_id':
          result.defaultQuoteDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_design_id':
          result.defaultCreditDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_footer':
          result.defaultInvoiceFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_name1':
          result.defaultTaxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate1':
          result.defaultTaxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name2':
          result.defaultTaxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate2':
          result.defaultTaxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name3':
          result.defaultTaxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate3':
          result.defaultTaxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'payment_type_id':
          result.defaultPaymentTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pdf_variables':
          result.pdfVariables.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ])));
          break;
        case 'email_signature':
          result.emailSignature = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_invoice':
          result.emailSubjectInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_quote':
          result.emailSubjectQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_credit':
          result.emailSubjectCredit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_payment':
          result.emailSubjectPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_payment_partial':
          result.emailSubjectPaymentPartial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_invoice':
          result.emailBodyInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_quote':
          result.emailBodyQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_credit':
          result.emailBodyCredit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_payment':
          result.emailBodyPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_payment_partial':
          result.emailBodyPaymentPartial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder1':
          result.emailSubjectReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder2':
          result.emailSubjectReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder3':
          result.emailSubjectReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder1':
          result.emailBodyReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder2':
          result.emailBodyReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder3':
          result.emailBodyReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_custom1':
          result.emailSubjectCustom1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_custom1':
          result.emailBodyCustom1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_custom2':
          result.emailSubjectCustom2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_custom2':
          result.emailBodyCustom2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_custom3':
          result.emailSubjectCustom3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_custom3':
          result.emailBodyCustom3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_statement':
          result.emailSubjectStatement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_statement':
          result.emailBodyStatement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'enable_client_portal_password':
          result.enablePortalPassword = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'signature_on_pdf':
          result.signatureOnPdf = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_email_markup':
          result.enableEmailMarkup = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_accept_invoice_terms':
          result.showAcceptInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_accept_quote_terms':
          result.showAcceptQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_invoice_signature':
          result.requireInvoiceSignature = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_quote_signature':
          result.requireQuoteSignature = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_logo':
          result.companyLogo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address1':
          result.address1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address2':
          result.address2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postal_code':
          result.postalCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_id':
          result.countryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vat_number':
          result.vatNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id_number':
          result.idNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'page_size':
          result.pageSize = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'font_size':
          result.fontSize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'primary_color':
          result.primaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'secondary_color':
          result.secondaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'primary_font':
          result.primaryFont = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'secondary_font':
          result.secondaryFont = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hide_paid_to_date':
          result.hidePaidToDate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'embed_documents':
          result.embedDocuments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'all_pages_header':
          result.allPagesHeader = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'all_pages_footer':
          result.allPagesFooter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder1':
          result.enableReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder2':
          result.enableReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder3':
          result.enableReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder_endless':
          result.enableReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'num_days_reminder1':
          result.numDaysReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_days_reminder2':
          result.numDaysReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_days_reminder3':
          result.numDaysReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'schedule_reminder1':
          result.scheduleReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'schedule_reminder2':
          result.scheduleReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'schedule_reminder3':
          result.scheduleReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'endless_reminder_frequency_id':
          result.endlessReminderFrequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'late_fee_amount1':
          result.lateFeeAmount1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_amount2':
          result.lateFeeAmount2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_amount3':
          result.lateFeeAmount3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_endless_amount':
          result.lateFeeAmountEndless = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_percent1':
          result.lateFeePercent1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_percent2':
          result.lateFeePercent2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_percent3':
          result.lateFeePercent3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_endless_percent':
          result.lateFeePercentEndless = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'email_subject_reminder_endless':
          result.emailSubjectReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder_endless':
          result.emailBodyReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_online_payment_notification':
          result.clientOnlinePaymentNotification = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_manual_payment_notification':
          result.clientManualPaymentNotification = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'counter_number_applied':
          result.counterNumberApplied = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_sending_method':
          result.emailSendingMethod = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gmail_sending_user_id':
          result.gmailSendingUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_terms':
          result.clientPortalTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_privacy_policy':
          result.clientPortalPrivacy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lock_invoices':
          result.lockInvoices = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'auto_bill':
          result.autoBill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_allow_under_payment':
          result.clientPortalAllowUnderPayment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_portal_allow_over_payment':
          result.clientPortalAllowOverPayment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_bill_date':
          result.autoBillDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_under_payment_minimum':
          result.clientPortalUnderPaymentMinimum = serializers.deserialize(
              value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'use_credits_payment':
          result.useCreditsPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_head':
          result.clientPortalCustomHeader = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_css':
          result.clientPortalCustomCss = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_footer':
          result.clientPortalCustomFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_js':
          result.clientPortalCustomJs = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hide_empty_columns_on_pdf':
          result.hideEmptyColumnsOnPdf = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design1_HIDDEN':
          result.hasCustomDesign1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design2_HIDDEN':
          result.hasCustomDesign2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design3_HIDDEN':
          result.hasCustomDesign3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
      final dynamic value = iterator.current;
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
  final BuiltList<PaymentTermEntity> paymentTerms;
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
      this.paymentTerms,
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
    if (enableCustomSurchargeTaxes1 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomSurchargeTaxes1');
    }
    if (enableCustomSurchargeTaxes2 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomSurchargeTaxes2');
    }
    if (enableCustomSurchargeTaxes3 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomSurchargeTaxes3');
    }
    if (enableCustomSurchargeTaxes4 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomSurchargeTaxes4');
    }
    if (sizeId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'sizeId');
    }
    if (industryId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'industryId');
    }
    if (subdomain == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'subdomain');
    }
    if (portalMode == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'portalMode');
    }
    if (portalDomain == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'portalDomain');
    }
    if (updateProducts == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'updateProducts');
    }
    if (convertProductExchangeRate == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'convertProductExchangeRate');
    }
    if (fillProducts == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'fillProducts');
    }
    if (enableProductCost == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'enableProductCost');
    }
    if (enableProductQuantity == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableProductQuantity');
    }
    if (enableProductDiscount == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableProductDiscount');
    }
    if (defaultTaskIsDateBased == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultTaskIsDateBased');
    }
    if (defaultQuantity == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultQuantity');
    }
    if (showProductDetails == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'showProductDetails');
    }
    if (clientCanRegister == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'clientCanRegister');
    }
    if (isLarge == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'isLarge');
    }
    if (isDisabled == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'isDisabled');
    }
    if (enableShopApi == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'enableShopApi');
    }
    if (companyKey == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'companyKey');
    }
    if (firstDayOfWeek == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'firstDayOfWeek');
    }
    if (firstMonthOfYear == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'firstMonthOfYear');
    }
    if (numberOfInvoiceTaxRates == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'numberOfInvoiceTaxRates');
    }
    if (numberOfItemTaxRates == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'numberOfItemTaxRates');
    }
    if (expenseInclusiveTaxes == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'expenseInclusiveTaxes');
    }
    if (sessionTimeout == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'sessionTimeout');
    }
    if (passwordTimeout == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'passwordTimeout');
    }
    if (oauthPasswordRequired == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'oauthPasswordRequired');
    }
    if (groups == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'groups');
    }
    if (activities == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'activities');
    }
    if (taxRates == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'taxRates');
    }
    if (taskStatuses == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'taskStatuses');
    }
    if (taskStatusMap == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'taskStatusMap');
    }
    if (companyGateways == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'companyGateways');
    }
    if (expenseCategories == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'expenseCategories');
    }
    if (users == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'users');
    }
    if (clients == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'clients');
    }
    if (products == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'products');
    }
    if (invoices == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'invoices');
    }
    if (recurringInvoices == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'recurringInvoices');
    }
    if (payments == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'payments');
    }
    if (quotes == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'quotes');
    }
    if (credits == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'credits');
    }
    if (tasks == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'tasks');
    }
    if (projects == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'projects');
    }
    if (expenses == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'expenses');
    }
    if (vendors == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'vendors');
    }
    if (designs == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'designs');
    }
    if (documents == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'documents');
    }
    if (tokens == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'tokens');
    }
    if (webhooks == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'webhooks');
    }
    if (paymentTerms == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'paymentTerms');
    }
    if (customFields == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'customFields');
    }
    if (slackWebhookUrl == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'slackWebhookUrl');
    }
    if (googleAnalyticsKey == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'googleAnalyticsKey');
    }
    if (markExpensesInvoiceable == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'markExpensesInvoiceable');
    }
    if (markExpensesPaid == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'markExpensesPaid');
    }
    if (invoiceExpenseDocuments == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'invoiceExpenseDocuments');
    }
    if (invoiceTaskDocuments == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'invoiceTaskDocuments');
    }
    if (invoiceTaskTimelog == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'invoiceTaskTimelog');
    }
    if (invoiceTaskDatelog == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'invoiceTaskDatelog');
    }
    if (autoStartTasks == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'autoStartTasks');
    }
    if (showTasksTable == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'showTasksTable');
    }
    if (settings == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'settings');
    }
    if (enabledModules == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'enabledModules');
    }
    if (calculateExpenseTaxByAmount == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'calculateExpenseTaxByAmount');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'id');
    }
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
        paymentTerms == other.paymentTerms &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, enableCustomSurchargeTaxes1.hashCode), enableCustomSurchargeTaxes2.hashCode), enableCustomSurchargeTaxes3.hashCode), enableCustomSurchargeTaxes4.hashCode), sizeId.hashCode), industryId.hashCode), subdomain.hashCode), portalMode.hashCode), portalDomain.hashCode), updateProducts.hashCode), convertProductExchangeRate.hashCode), fillProducts.hashCode), enableProductCost.hashCode), enableProductQuantity.hashCode), enableProductDiscount.hashCode), defaultTaskIsDateBased.hashCode), defaultQuantity.hashCode), showProductDetails.hashCode), clientCanRegister.hashCode), isLarge.hashCode), isDisabled.hashCode), enableShopApi.hashCode), companyKey.hashCode), firstDayOfWeek.hashCode), firstMonthOfYear.hashCode), numberOfInvoiceTaxRates.hashCode), numberOfItemTaxRates.hashCode), expenseInclusiveTaxes.hashCode), sessionTimeout.hashCode), passwordTimeout.hashCode), oauthPasswordRequired.hashCode), groups.hashCode), activities.hashCode), taxRates.hashCode), taskStatuses.hashCode), taskStatusMap.hashCode), companyGateways.hashCode), expenseCategories.hashCode), users.hashCode), clients.hashCode), products.hashCode), invoices.hashCode), recurringInvoices.hashCode), payments.hashCode), quotes.hashCode), credits.hashCode), tasks.hashCode), projects.hashCode), expenses.hashCode), vendors.hashCode), designs.hashCode), documents.hashCode), tokens.hashCode), webhooks.hashCode), paymentTerms.hashCode), customFields.hashCode), slackWebhookUrl.hashCode), googleAnalyticsKey.hashCode), markExpensesInvoiceable.hashCode),
                                                                                markExpensesPaid.hashCode),
                                                                            invoiceExpenseDocuments.hashCode),
                                                                        invoiceTaskDocuments.hashCode),
                                                                    invoiceTaskTimelog.hashCode),
                                                                invoiceTaskDatelog.hashCode),
                                                            autoStartTasks.hashCode),
                                                        showTasksTable.hashCode),
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
          ..add('paymentTerms', paymentTerms)
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

  ListBuilder<PaymentTermEntity> _paymentTerms;
  ListBuilder<PaymentTermEntity> get paymentTerms =>
      _$this._paymentTerms ??= new ListBuilder<PaymentTermEntity>();
  set paymentTerms(ListBuilder<PaymentTermEntity> paymentTerms) =>
      _$this._paymentTerms = paymentTerms;

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
    if (_$v != null) {
      _enableCustomSurchargeTaxes1 = _$v.enableCustomSurchargeTaxes1;
      _enableCustomSurchargeTaxes2 = _$v.enableCustomSurchargeTaxes2;
      _enableCustomSurchargeTaxes3 = _$v.enableCustomSurchargeTaxes3;
      _enableCustomSurchargeTaxes4 = _$v.enableCustomSurchargeTaxes4;
      _sizeId = _$v.sizeId;
      _industryId = _$v.industryId;
      _subdomain = _$v.subdomain;
      _portalMode = _$v.portalMode;
      _portalDomain = _$v.portalDomain;
      _updateProducts = _$v.updateProducts;
      _convertProductExchangeRate = _$v.convertProductExchangeRate;
      _fillProducts = _$v.fillProducts;
      _enableProductCost = _$v.enableProductCost;
      _enableProductQuantity = _$v.enableProductQuantity;
      _enableProductDiscount = _$v.enableProductDiscount;
      _defaultTaskIsDateBased = _$v.defaultTaskIsDateBased;
      _defaultQuantity = _$v.defaultQuantity;
      _showProductDetails = _$v.showProductDetails;
      _clientCanRegister = _$v.clientCanRegister;
      _isLarge = _$v.isLarge;
      _isDisabled = _$v.isDisabled;
      _enableShopApi = _$v.enableShopApi;
      _companyKey = _$v.companyKey;
      _firstDayOfWeek = _$v.firstDayOfWeek;
      _firstMonthOfYear = _$v.firstMonthOfYear;
      _numberOfInvoiceTaxRates = _$v.numberOfInvoiceTaxRates;
      _numberOfItemTaxRates = _$v.numberOfItemTaxRates;
      _expenseInclusiveTaxes = _$v.expenseInclusiveTaxes;
      _sessionTimeout = _$v.sessionTimeout;
      _passwordTimeout = _$v.passwordTimeout;
      _oauthPasswordRequired = _$v.oauthPasswordRequired;
      _groups = _$v.groups?.toBuilder();
      _activities = _$v.activities?.toBuilder();
      _taxRates = _$v.taxRates?.toBuilder();
      _taskStatuses = _$v.taskStatuses?.toBuilder();
      _taskStatusMap = _$v.taskStatusMap?.toBuilder();
      _companyGateways = _$v.companyGateways?.toBuilder();
      _expenseCategories = _$v.expenseCategories?.toBuilder();
      _users = _$v.users?.toBuilder();
      _clients = _$v.clients?.toBuilder();
      _products = _$v.products?.toBuilder();
      _invoices = _$v.invoices?.toBuilder();
      _recurringInvoices = _$v.recurringInvoices?.toBuilder();
      _payments = _$v.payments?.toBuilder();
      _quotes = _$v.quotes?.toBuilder();
      _credits = _$v.credits?.toBuilder();
      _tasks = _$v.tasks?.toBuilder();
      _projects = _$v.projects?.toBuilder();
      _expenses = _$v.expenses?.toBuilder();
      _vendors = _$v.vendors?.toBuilder();
      _designs = _$v.designs?.toBuilder();
      _documents = _$v.documents?.toBuilder();
      _tokens = _$v.tokens?.toBuilder();
      _webhooks = _$v.webhooks?.toBuilder();
      _paymentTerms = _$v.paymentTerms?.toBuilder();
      _customFields = _$v.customFields?.toBuilder();
      _slackWebhookUrl = _$v.slackWebhookUrl;
      _googleAnalyticsKey = _$v.googleAnalyticsKey;
      _markExpensesInvoiceable = _$v.markExpensesInvoiceable;
      _markExpensesPaid = _$v.markExpensesPaid;
      _invoiceExpenseDocuments = _$v.invoiceExpenseDocuments;
      _invoiceTaskDocuments = _$v.invoiceTaskDocuments;
      _invoiceTaskTimelog = _$v.invoiceTaskTimelog;
      _invoiceTaskDatelog = _$v.invoiceTaskDatelog;
      _autoStartTasks = _$v.autoStartTasks;
      _showTasksTable = _$v.showTasksTable;
      _settings = _$v.settings?.toBuilder();
      _enabledModules = _$v.enabledModules;
      _calculateExpenseTaxByAmount = _$v.calculateExpenseTaxByAmount;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _entityType = _$v.entityType;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              enableCustomSurchargeTaxes1: enableCustomSurchargeTaxes1,
              enableCustomSurchargeTaxes2: enableCustomSurchargeTaxes2,
              enableCustomSurchargeTaxes3: enableCustomSurchargeTaxes3,
              enableCustomSurchargeTaxes4: enableCustomSurchargeTaxes4,
              sizeId: sizeId,
              industryId: industryId,
              subdomain: subdomain,
              portalMode: portalMode,
              portalDomain: portalDomain,
              updateProducts: updateProducts,
              convertProductExchangeRate: convertProductExchangeRate,
              fillProducts: fillProducts,
              enableProductCost: enableProductCost,
              enableProductQuantity: enableProductQuantity,
              enableProductDiscount: enableProductDiscount,
              defaultTaskIsDateBased: defaultTaskIsDateBased,
              defaultQuantity: defaultQuantity,
              showProductDetails: showProductDetails,
              clientCanRegister: clientCanRegister,
              isLarge: isLarge,
              isDisabled: isDisabled,
              enableShopApi: enableShopApi,
              companyKey: companyKey,
              firstDayOfWeek: firstDayOfWeek,
              firstMonthOfYear: firstMonthOfYear,
              numberOfInvoiceTaxRates: numberOfInvoiceTaxRates,
              numberOfItemTaxRates: numberOfItemTaxRates,
              expenseInclusiveTaxes: expenseInclusiveTaxes,
              sessionTimeout: sessionTimeout,
              passwordTimeout: passwordTimeout,
              oauthPasswordRequired: oauthPasswordRequired,
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
              paymentTerms: paymentTerms.build(),
              customFields: customFields.build(),
              slackWebhookUrl: slackWebhookUrl,
              googleAnalyticsKey: googleAnalyticsKey,
              markExpensesInvoiceable: markExpensesInvoiceable,
              markExpensesPaid: markExpensesPaid,
              invoiceExpenseDocuments: invoiceExpenseDocuments,
              invoiceTaskDocuments: invoiceTaskDocuments,
              invoiceTaskTimelog: invoiceTaskTimelog,
              invoiceTaskDatelog: invoiceTaskDatelog,
              autoStartTasks: autoStartTasks,
              showTasksTable: showTasksTable,
              settings: settings.build(),
              enabledModules: enabledModules,
              calculateExpenseTaxByAmount: calculateExpenseTaxByAmount,
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              entityType: entityType,
              id: id);
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
        _$failedField = 'paymentTerms';
        paymentTerms.build();
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
      this.options,
      this.fields})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'name');
    }
    if (isOffsite == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'isOffsite');
    }
    if (isVisible == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'isVisible');
    }
    if (sortOrder == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'sortOrder');
    }
    if (defaultGatewayTypeId == null) {
      throw new BuiltValueNullFieldError(
          'GatewayEntity', 'defaultGatewayTypeId');
    }
    if (options == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'options');
    }
    if (fields == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'fields');
    }
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
                        $jc($jc($jc(0, id.hashCode), name.hashCode),
                            isOffsite.hashCode),
                        isVisible.hashCode),
                    sortOrder.hashCode),
                defaultGatewayTypeId.hashCode),
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

  MapBuilder<String, GatewayOptionsEntity> _options;
  MapBuilder<String, GatewayOptionsEntity> get options =>
      _$this._options ??= new MapBuilder<String, GatewayOptionsEntity>();
  set options(MapBuilder<String, GatewayOptionsEntity> options) =>
      _$this._options = options;

  String _fields;
  String get fields => _$this._fields;
  set fields(String fields) => _$this._fields = fields;

  GatewayEntityBuilder();

  GatewayEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _isOffsite = _$v.isOffsite;
      _isVisible = _$v.isVisible;
      _sortOrder = _$v.sortOrder;
      _defaultGatewayTypeId = _$v.defaultGatewayTypeId;
      _options = _$v.options?.toBuilder();
      _fields = _$v.fields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              id: id,
              name: name,
              isOffsite: isOffsite,
              isVisible: isVisible,
              sortOrder: sortOrder,
              defaultGatewayTypeId: defaultGatewayTypeId,
              options: options.build(),
              fields: fields);
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
    if (supportRefunds == null) {
      throw new BuiltValueNullFieldError(
          'GatewayOptionsEntity', 'supportRefunds');
    }
    if (supportTokenBilling == null) {
      throw new BuiltValueNullFieldError(
          'GatewayOptionsEntity', 'supportTokenBilling');
    }
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
    if (_$v != null) {
      _supportRefunds = _$v.supportRefunds;
      _supportTokenBilling = _$v.supportTokenBilling;
      _webhooks = _$v.webhooks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GatewayOptionsEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              supportRefunds: supportRefunds,
              supportTokenBilling: supportTokenBilling,
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
      this.settings})
      : super._() {
    if (isAdmin == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'isAdmin');
    }
    if (isOwner == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'isOwner');
    }
    if (permissionsUpdatedAt == null) {
      throw new BuiltValueNullFieldError(
          'UserCompanyEntity', 'permissionsUpdatedAt');
    }
    if (permissions == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'permissions');
    }
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
        settings == other.settings;
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
                                    $jc($jc(0, isAdmin.hashCode),
                                        isOwner.hashCode),
                                    permissionsUpdatedAt.hashCode),
                                permissions.hashCode),
                            notifications.hashCode),
                        company.hashCode),
                    user.hashCode),
                token.hashCode),
            account.hashCode),
        settings.hashCode));
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
          ..add('settings', settings))
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

  UserCompanyEntityBuilder() {
    UserCompanyEntity._initializeBuilder(this);
  }

  UserCompanyEntityBuilder get _$this {
    if (_$v != null) {
      _isAdmin = _$v.isAdmin;
      _isOwner = _$v.isOwner;
      _permissionsUpdatedAt = _$v.permissionsUpdatedAt;
      _permissions = _$v.permissions;
      _notifications = _$v.notifications?.toBuilder();
      _company = _$v.company?.toBuilder();
      _user = _$v.user?.toBuilder();
      _token = _$v.token?.toBuilder();
      _account = _$v.account?.toBuilder();
      _settings = _$v.settings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCompanyEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              isAdmin: isAdmin,
              isOwner: isOwner,
              permissionsUpdatedAt: permissionsUpdatedAt,
              permissions: permissions,
              notifications: _notifications?.build(),
              company: _company?.build(),
              user: _user?.build(),
              token: _token?.build(),
              account: _account?.build(),
              settings: _settings?.build());
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

  factory _$UserSettingsEntity(
          [void Function(UserSettingsEntityBuilder) updates]) =>
      (new UserSettingsEntityBuilder()..update(updates)).build();

  _$UserSettingsEntity._(
      {this.accentColor, this.tableColumns, this.reportSettings})
      : super._() {
    if (tableColumns == null) {
      throw new BuiltValueNullFieldError('UserSettingsEntity', 'tableColumns');
    }
    if (reportSettings == null) {
      throw new BuiltValueNullFieldError(
          'UserSettingsEntity', 'reportSettings');
    }
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
        reportSettings == other.reportSettings;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc(0, accentColor.hashCode), tableColumns.hashCode),
        reportSettings.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserSettingsEntity')
          ..add('accentColor', accentColor)
          ..add('tableColumns', tableColumns)
          ..add('reportSettings', reportSettings))
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

  UserSettingsEntityBuilder();

  UserSettingsEntityBuilder get _$this {
    if (_$v != null) {
      _accentColor = _$v.accentColor;
      _tableColumns = _$v.tableColumns?.toBuilder();
      _reportSettings = _$v.reportSettings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserSettingsEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              reportSettings: reportSettings.build());
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
    if (sortColumn == null) {
      throw new BuiltValueNullFieldError('ReportSettingsEntity', 'sortColumn');
    }
    if (sortAscending == null) {
      throw new BuiltValueNullFieldError(
          'ReportSettingsEntity', 'sortAscending');
    }
    if (sortTotalsIndex == null) {
      throw new BuiltValueNullFieldError(
          'ReportSettingsEntity', 'sortTotalsIndex');
    }
    if (sortTotalsAscending == null) {
      throw new BuiltValueNullFieldError(
          'ReportSettingsEntity', 'sortTotalsAscending');
    }
    if (columns == null) {
      throw new BuiltValueNullFieldError('ReportSettingsEntity', 'columns');
    }
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
    if (_$v != null) {
      _sortColumn = _$v.sortColumn;
      _sortAscending = _$v.sortAscending;
      _sortTotalsIndex = _$v.sortTotalsIndex;
      _sortTotalsAscending = _$v.sortTotalsAscending;
      _columns = _$v.columns?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportSettingsEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              sortColumn: sortColumn,
              sortAscending: sortAscending,
              sortTotalsIndex: sortTotalsIndex,
              sortTotalsAscending: sortTotalsAscending,
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

class _$SettingsEntity extends SettingsEntity {
  @override
  final String timezoneId;
  @override
  final String dateFormatId;
  @override
  final bool enableMilitaryTime;
  @override
  final String languageId;
  @override
  final bool showCurrencyCode;
  @override
  final String currencyId;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final String defaultPaymentTerms;
  @override
  final String companyGatewayIds;
  @override
  final double defaultTaskRate;
  @override
  final bool sendReminders;
  @override
  final bool enablePortal;
  @override
  final bool enablePortalDashboard;
  @override
  final bool enablePortalTasks;
  @override
  final bool enablePortalUploads;
  @override
  final String emailStyle;
  @override
  final String replyToEmail;
  @override
  final String replyToName;
  @override
  final String bccEmail;
  @override
  final bool pdfEmailAttachment;
  @override
  final bool ublEmailAttachment;
  @override
  final bool documentEmailAttachment;
  @override
  final String emailStyleCustom;
  @override
  final String customMessageDashboard;
  @override
  final String customMessageUnpaidInvoice;
  @override
  final String customMessagePaidInvoice;
  @override
  final String customMessageUnapprovedQuote;
  @override
  final bool autoArchiveInvoice;
  @override
  final bool autoArchiveQuote;
  @override
  final bool autoEmailInvoice;
  @override
  final bool autoConvertQuote;
  @override
  final bool enableInclusiveTaxes;
  @override
  final BuiltMap<String, String> translations;
  @override
  final String taskNumberPattern;
  @override
  final int taskNumberCounter;
  @override
  final String expenseNumberPattern;
  @override
  final int expenseNumberCounter;
  @override
  final String vendorNumberPattern;
  @override
  final int vendorNumberCounter;
  @override
  final String ticketNumberPattern;
  @override
  final int ticketNumberCounter;
  @override
  final String paymentNumberPattern;
  @override
  final int paymentNumberCounter;
  @override
  final String projectNumberPattern;
  @override
  final int projectNumberCounter;
  @override
  final String invoiceNumberPattern;
  @override
  final int invoiceNumberCounter;
  @override
  final String recurringInvoiceNumberPattern;
  @override
  final int recurringInvoiceNumberCounter;
  @override
  final String quoteNumberPattern;
  @override
  final int quoteNumberCounter;
  @override
  final String clientNumberPattern;
  @override
  final int clientNumberCounter;
  @override
  final String creditNumberPattern;
  @override
  final int creditNumberCounter;
  @override
  final String recurringNumberPrefix;
  @override
  final String resetCounterFrequencyId;
  @override
  final String resetCounterDate;
  @override
  final int counterPadding;
  @override
  final bool sharedInvoiceQuoteCounter;
  @override
  final bool sharedInvoiceCreditCounter;
  @override
  final String defaultInvoiceTerms;
  @override
  final String defaultQuoteTerms;
  @override
  final String defaultQuoteFooter;
  @override
  final String defaultCreditTerms;
  @override
  final String defaultCreditFooter;
  @override
  final String defaultInvoiceDesignId;
  @override
  final String defaultQuoteDesignId;
  @override
  final String defaultCreditDesignId;
  @override
  final String defaultInvoiceFooter;
  @override
  final String defaultTaxName1;
  @override
  final double defaultTaxRate1;
  @override
  final String defaultTaxName2;
  @override
  final double defaultTaxRate2;
  @override
  final String defaultTaxName3;
  @override
  final double defaultTaxRate3;
  @override
  final String defaultPaymentTypeId;
  @override
  final BuiltMap<String, BuiltList<String>> pdfVariables;
  @override
  final String emailSignature;
  @override
  final String emailSubjectInvoice;
  @override
  final String emailSubjectQuote;
  @override
  final String emailSubjectCredit;
  @override
  final String emailSubjectPayment;
  @override
  final String emailSubjectPaymentPartial;
  @override
  final String emailBodyInvoice;
  @override
  final String emailBodyQuote;
  @override
  final String emailBodyCredit;
  @override
  final String emailBodyPayment;
  @override
  final String emailBodyPaymentPartial;
  @override
  final String emailSubjectReminder1;
  @override
  final String emailSubjectReminder2;
  @override
  final String emailSubjectReminder3;
  @override
  final String emailBodyReminder1;
  @override
  final String emailBodyReminder2;
  @override
  final String emailBodyReminder3;
  @override
  final String emailSubjectCustom1;
  @override
  final String emailBodyCustom1;
  @override
  final String emailSubjectCustom2;
  @override
  final String emailBodyCustom2;
  @override
  final String emailSubjectCustom3;
  @override
  final String emailBodyCustom3;
  @override
  final String emailSubjectStatement;
  @override
  final String emailBodyStatement;
  @override
  final bool enablePortalPassword;
  @override
  final bool signatureOnPdf;
  @override
  final bool enableEmailMarkup;
  @override
  final bool showAcceptInvoiceTerms;
  @override
  final bool showAcceptQuoteTerms;
  @override
  final bool requireInvoiceSignature;
  @override
  final bool requireQuoteSignature;
  @override
  final String name;
  @override
  final String companyLogo;
  @override
  final String website;
  @override
  final String address1;
  @override
  final String address2;
  @override
  final String city;
  @override
  final String state;
  @override
  final String postalCode;
  @override
  final String phone;
  @override
  final String email;
  @override
  final String countryId;
  @override
  final String vatNumber;
  @override
  final String idNumber;
  @override
  final String pageSize;
  @override
  final int fontSize;
  @override
  final String primaryColor;
  @override
  final String secondaryColor;
  @override
  final String primaryFont;
  @override
  final String secondaryFont;
  @override
  final bool hidePaidToDate;
  @override
  final bool embedDocuments;
  @override
  final bool allPagesHeader;
  @override
  final bool allPagesFooter;
  @override
  final bool enableReminder1;
  @override
  final bool enableReminder2;
  @override
  final bool enableReminder3;
  @override
  final bool enableReminderEndless;
  @override
  final int numDaysReminder1;
  @override
  final int numDaysReminder2;
  @override
  final int numDaysReminder3;
  @override
  final String scheduleReminder1;
  @override
  final String scheduleReminder2;
  @override
  final String scheduleReminder3;
  @override
  final String endlessReminderFrequencyId;
  @override
  final double lateFeeAmount1;
  @override
  final double lateFeeAmount2;
  @override
  final double lateFeeAmount3;
  @override
  final double lateFeeAmountEndless;
  @override
  final double lateFeePercent1;
  @override
  final double lateFeePercent2;
  @override
  final double lateFeePercent3;
  @override
  final double lateFeePercentEndless;
  @override
  final String emailSubjectReminderEndless;
  @override
  final String emailBodyReminderEndless;
  @override
  final bool clientOnlinePaymentNotification;
  @override
  final bool clientManualPaymentNotification;
  @override
  final String counterNumberApplied;
  @override
  final String emailSendingMethod;
  @override
  final String gmailSendingUserId;
  @override
  final String clientPortalTerms;
  @override
  final String clientPortalPrivacy;
  @override
  final String lockInvoices;
  @override
  final String autoBill;
  @override
  final bool clientPortalAllowUnderPayment;
  @override
  final bool clientPortalAllowOverPayment;
  @override
  final String autoBillDate;
  @override
  final double clientPortalUnderPaymentMinimum;
  @override
  final String useCreditsPayment;
  @override
  final String clientPortalCustomHeader;
  @override
  final String clientPortalCustomCss;
  @override
  final String clientPortalCustomFooter;
  @override
  final String clientPortalCustomJs;
  @override
  final bool hideEmptyColumnsOnPdf;
  @override
  final bool hasCustomDesign1;
  @override
  final bool hasCustomDesign2;
  @override
  final bool hasCustomDesign3;

  factory _$SettingsEntity([void Function(SettingsEntityBuilder) updates]) =>
      (new SettingsEntityBuilder()..update(updates)).build();

  _$SettingsEntity._(
      {this.timezoneId,
      this.dateFormatId,
      this.enableMilitaryTime,
      this.languageId,
      this.showCurrencyCode,
      this.currencyId,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.defaultPaymentTerms,
      this.companyGatewayIds,
      this.defaultTaskRate,
      this.sendReminders,
      this.enablePortal,
      this.enablePortalDashboard,
      this.enablePortalTasks,
      this.enablePortalUploads,
      this.emailStyle,
      this.replyToEmail,
      this.replyToName,
      this.bccEmail,
      this.pdfEmailAttachment,
      this.ublEmailAttachment,
      this.documentEmailAttachment,
      this.emailStyleCustom,
      this.customMessageDashboard,
      this.customMessageUnpaidInvoice,
      this.customMessagePaidInvoice,
      this.customMessageUnapprovedQuote,
      this.autoArchiveInvoice,
      this.autoArchiveQuote,
      this.autoEmailInvoice,
      this.autoConvertQuote,
      this.enableInclusiveTaxes,
      this.translations,
      this.taskNumberPattern,
      this.taskNumberCounter,
      this.expenseNumberPattern,
      this.expenseNumberCounter,
      this.vendorNumberPattern,
      this.vendorNumberCounter,
      this.ticketNumberPattern,
      this.ticketNumberCounter,
      this.paymentNumberPattern,
      this.paymentNumberCounter,
      this.projectNumberPattern,
      this.projectNumberCounter,
      this.invoiceNumberPattern,
      this.invoiceNumberCounter,
      this.recurringInvoiceNumberPattern,
      this.recurringInvoiceNumberCounter,
      this.quoteNumberPattern,
      this.quoteNumberCounter,
      this.clientNumberPattern,
      this.clientNumberCounter,
      this.creditNumberPattern,
      this.creditNumberCounter,
      this.recurringNumberPrefix,
      this.resetCounterFrequencyId,
      this.resetCounterDate,
      this.counterPadding,
      this.sharedInvoiceQuoteCounter,
      this.sharedInvoiceCreditCounter,
      this.defaultInvoiceTerms,
      this.defaultQuoteTerms,
      this.defaultQuoteFooter,
      this.defaultCreditTerms,
      this.defaultCreditFooter,
      this.defaultInvoiceDesignId,
      this.defaultQuoteDesignId,
      this.defaultCreditDesignId,
      this.defaultInvoiceFooter,
      this.defaultTaxName1,
      this.defaultTaxRate1,
      this.defaultTaxName2,
      this.defaultTaxRate2,
      this.defaultTaxName3,
      this.defaultTaxRate3,
      this.defaultPaymentTypeId,
      this.pdfVariables,
      this.emailSignature,
      this.emailSubjectInvoice,
      this.emailSubjectQuote,
      this.emailSubjectCredit,
      this.emailSubjectPayment,
      this.emailSubjectPaymentPartial,
      this.emailBodyInvoice,
      this.emailBodyQuote,
      this.emailBodyCredit,
      this.emailBodyPayment,
      this.emailBodyPaymentPartial,
      this.emailSubjectReminder1,
      this.emailSubjectReminder2,
      this.emailSubjectReminder3,
      this.emailBodyReminder1,
      this.emailBodyReminder2,
      this.emailBodyReminder3,
      this.emailSubjectCustom1,
      this.emailBodyCustom1,
      this.emailSubjectCustom2,
      this.emailBodyCustom2,
      this.emailSubjectCustom3,
      this.emailBodyCustom3,
      this.emailSubjectStatement,
      this.emailBodyStatement,
      this.enablePortalPassword,
      this.signatureOnPdf,
      this.enableEmailMarkup,
      this.showAcceptInvoiceTerms,
      this.showAcceptQuoteTerms,
      this.requireInvoiceSignature,
      this.requireQuoteSignature,
      this.name,
      this.companyLogo,
      this.website,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postalCode,
      this.phone,
      this.email,
      this.countryId,
      this.vatNumber,
      this.idNumber,
      this.pageSize,
      this.fontSize,
      this.primaryColor,
      this.secondaryColor,
      this.primaryFont,
      this.secondaryFont,
      this.hidePaidToDate,
      this.embedDocuments,
      this.allPagesHeader,
      this.allPagesFooter,
      this.enableReminder1,
      this.enableReminder2,
      this.enableReminder3,
      this.enableReminderEndless,
      this.numDaysReminder1,
      this.numDaysReminder2,
      this.numDaysReminder3,
      this.scheduleReminder1,
      this.scheduleReminder2,
      this.scheduleReminder3,
      this.endlessReminderFrequencyId,
      this.lateFeeAmount1,
      this.lateFeeAmount2,
      this.lateFeeAmount3,
      this.lateFeeAmountEndless,
      this.lateFeePercent1,
      this.lateFeePercent2,
      this.lateFeePercent3,
      this.lateFeePercentEndless,
      this.emailSubjectReminderEndless,
      this.emailBodyReminderEndless,
      this.clientOnlinePaymentNotification,
      this.clientManualPaymentNotification,
      this.counterNumberApplied,
      this.emailSendingMethod,
      this.gmailSendingUserId,
      this.clientPortalTerms,
      this.clientPortalPrivacy,
      this.lockInvoices,
      this.autoBill,
      this.clientPortalAllowUnderPayment,
      this.clientPortalAllowOverPayment,
      this.autoBillDate,
      this.clientPortalUnderPaymentMinimum,
      this.useCreditsPayment,
      this.clientPortalCustomHeader,
      this.clientPortalCustomCss,
      this.clientPortalCustomFooter,
      this.clientPortalCustomJs,
      this.hideEmptyColumnsOnPdf,
      this.hasCustomDesign1,
      this.hasCustomDesign2,
      this.hasCustomDesign3})
      : super._();

  @override
  SettingsEntity rebuild(void Function(SettingsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsEntityBuilder toBuilder() =>
      new SettingsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsEntity &&
        timezoneId == other.timezoneId &&
        dateFormatId == other.dateFormatId &&
        enableMilitaryTime == other.enableMilitaryTime &&
        languageId == other.languageId &&
        showCurrencyCode == other.showCurrencyCode &&
        currencyId == other.currencyId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        defaultPaymentTerms == other.defaultPaymentTerms &&
        companyGatewayIds == other.companyGatewayIds &&
        defaultTaskRate == other.defaultTaskRate &&
        sendReminders == other.sendReminders &&
        enablePortal == other.enablePortal &&
        enablePortalDashboard == other.enablePortalDashboard &&
        enablePortalTasks == other.enablePortalTasks &&
        enablePortalUploads == other.enablePortalUploads &&
        emailStyle == other.emailStyle &&
        replyToEmail == other.replyToEmail &&
        replyToName == other.replyToName &&
        bccEmail == other.bccEmail &&
        pdfEmailAttachment == other.pdfEmailAttachment &&
        ublEmailAttachment == other.ublEmailAttachment &&
        documentEmailAttachment == other.documentEmailAttachment &&
        emailStyleCustom == other.emailStyleCustom &&
        customMessageDashboard == other.customMessageDashboard &&
        customMessageUnpaidInvoice == other.customMessageUnpaidInvoice &&
        customMessagePaidInvoice == other.customMessagePaidInvoice &&
        customMessageUnapprovedQuote == other.customMessageUnapprovedQuote &&
        autoArchiveInvoice == other.autoArchiveInvoice &&
        autoArchiveQuote == other.autoArchiveQuote &&
        autoEmailInvoice == other.autoEmailInvoice &&
        autoConvertQuote == other.autoConvertQuote &&
        enableInclusiveTaxes == other.enableInclusiveTaxes &&
        translations == other.translations &&
        taskNumberPattern == other.taskNumberPattern &&
        taskNumberCounter == other.taskNumberCounter &&
        expenseNumberPattern == other.expenseNumberPattern &&
        expenseNumberCounter == other.expenseNumberCounter &&
        vendorNumberPattern == other.vendorNumberPattern &&
        vendorNumberCounter == other.vendorNumberCounter &&
        ticketNumberPattern == other.ticketNumberPattern &&
        ticketNumberCounter == other.ticketNumberCounter &&
        paymentNumberPattern == other.paymentNumberPattern &&
        paymentNumberCounter == other.paymentNumberCounter &&
        projectNumberPattern == other.projectNumberPattern &&
        projectNumberCounter == other.projectNumberCounter &&
        invoiceNumberPattern == other.invoiceNumberPattern &&
        invoiceNumberCounter == other.invoiceNumberCounter &&
        recurringInvoiceNumberPattern == other.recurringInvoiceNumberPattern &&
        recurringInvoiceNumberCounter == other.recurringInvoiceNumberCounter &&
        quoteNumberPattern == other.quoteNumberPattern &&
        quoteNumberCounter == other.quoteNumberCounter &&
        clientNumberPattern == other.clientNumberPattern &&
        clientNumberCounter == other.clientNumberCounter &&
        creditNumberPattern == other.creditNumberPattern &&
        creditNumberCounter == other.creditNumberCounter &&
        recurringNumberPrefix == other.recurringNumberPrefix &&
        resetCounterFrequencyId == other.resetCounterFrequencyId &&
        resetCounterDate == other.resetCounterDate &&
        counterPadding == other.counterPadding &&
        sharedInvoiceQuoteCounter == other.sharedInvoiceQuoteCounter &&
        sharedInvoiceCreditCounter == other.sharedInvoiceCreditCounter &&
        defaultInvoiceTerms == other.defaultInvoiceTerms &&
        defaultQuoteTerms == other.defaultQuoteTerms &&
        defaultQuoteFooter == other.defaultQuoteFooter &&
        defaultCreditTerms == other.defaultCreditTerms &&
        defaultCreditFooter == other.defaultCreditFooter &&
        defaultInvoiceDesignId == other.defaultInvoiceDesignId &&
        defaultQuoteDesignId == other.defaultQuoteDesignId &&
        defaultCreditDesignId == other.defaultCreditDesignId &&
        defaultInvoiceFooter == other.defaultInvoiceFooter &&
        defaultTaxName1 == other.defaultTaxName1 &&
        defaultTaxRate1 == other.defaultTaxRate1 &&
        defaultTaxName2 == other.defaultTaxName2 &&
        defaultTaxRate2 == other.defaultTaxRate2 &&
        defaultTaxName3 == other.defaultTaxName3 &&
        defaultTaxRate3 == other.defaultTaxRate3 &&
        defaultPaymentTypeId == other.defaultPaymentTypeId &&
        pdfVariables == other.pdfVariables &&
        emailSignature == other.emailSignature &&
        emailSubjectInvoice == other.emailSubjectInvoice &&
        emailSubjectQuote == other.emailSubjectQuote &&
        emailSubjectCredit == other.emailSubjectCredit &&
        emailSubjectPayment == other.emailSubjectPayment &&
        emailSubjectPaymentPartial == other.emailSubjectPaymentPartial &&
        emailBodyInvoice == other.emailBodyInvoice &&
        emailBodyQuote == other.emailBodyQuote &&
        emailBodyCredit == other.emailBodyCredit &&
        emailBodyPayment == other.emailBodyPayment &&
        emailBodyPaymentPartial == other.emailBodyPaymentPartial &&
        emailSubjectReminder1 == other.emailSubjectReminder1 &&
        emailSubjectReminder2 == other.emailSubjectReminder2 &&
        emailSubjectReminder3 == other.emailSubjectReminder3 &&
        emailBodyReminder1 == other.emailBodyReminder1 &&
        emailBodyReminder2 == other.emailBodyReminder2 &&
        emailBodyReminder3 == other.emailBodyReminder3 &&
        emailSubjectCustom1 == other.emailSubjectCustom1 &&
        emailBodyCustom1 == other.emailBodyCustom1 &&
        emailSubjectCustom2 == other.emailSubjectCustom2 &&
        emailBodyCustom2 == other.emailBodyCustom2 &&
        emailSubjectCustom3 == other.emailSubjectCustom3 &&
        emailBodyCustom3 == other.emailBodyCustom3 &&
        emailSubjectStatement == other.emailSubjectStatement &&
        emailBodyStatement == other.emailBodyStatement &&
        enablePortalPassword == other.enablePortalPassword &&
        signatureOnPdf == other.signatureOnPdf &&
        enableEmailMarkup == other.enableEmailMarkup &&
        showAcceptInvoiceTerms == other.showAcceptInvoiceTerms &&
        showAcceptQuoteTerms == other.showAcceptQuoteTerms &&
        requireInvoiceSignature == other.requireInvoiceSignature &&
        requireQuoteSignature == other.requireQuoteSignature &&
        name == other.name &&
        companyLogo == other.companyLogo &&
        website == other.website &&
        address1 == other.address1 &&
        address2 == other.address2 &&
        city == other.city &&
        state == other.state &&
        postalCode == other.postalCode &&
        phone == other.phone &&
        email == other.email &&
        countryId == other.countryId &&
        vatNumber == other.vatNumber &&
        idNumber == other.idNumber &&
        pageSize == other.pageSize &&
        fontSize == other.fontSize &&
        primaryColor == other.primaryColor &&
        secondaryColor == other.secondaryColor &&
        primaryFont == other.primaryFont &&
        secondaryFont == other.secondaryFont &&
        hidePaidToDate == other.hidePaidToDate &&
        embedDocuments == other.embedDocuments &&
        allPagesHeader == other.allPagesHeader &&
        allPagesFooter == other.allPagesFooter &&
        enableReminder1 == other.enableReminder1 &&
        enableReminder2 == other.enableReminder2 &&
        enableReminder3 == other.enableReminder3 &&
        enableReminderEndless == other.enableReminderEndless &&
        numDaysReminder1 == other.numDaysReminder1 &&
        numDaysReminder2 == other.numDaysReminder2 &&
        numDaysReminder3 == other.numDaysReminder3 &&
        scheduleReminder1 == other.scheduleReminder1 &&
        scheduleReminder2 == other.scheduleReminder2 &&
        scheduleReminder3 == other.scheduleReminder3 &&
        endlessReminderFrequencyId == other.endlessReminderFrequencyId &&
        lateFeeAmount1 == other.lateFeeAmount1 &&
        lateFeeAmount2 == other.lateFeeAmount2 &&
        lateFeeAmount3 == other.lateFeeAmount3 &&
        lateFeeAmountEndless == other.lateFeeAmountEndless &&
        lateFeePercent1 == other.lateFeePercent1 &&
        lateFeePercent2 == other.lateFeePercent2 &&
        lateFeePercent3 == other.lateFeePercent3 &&
        lateFeePercentEndless == other.lateFeePercentEndless &&
        emailSubjectReminderEndless == other.emailSubjectReminderEndless &&
        emailBodyReminderEndless == other.emailBodyReminderEndless &&
        clientOnlinePaymentNotification ==
            other.clientOnlinePaymentNotification &&
        clientManualPaymentNotification ==
            other.clientManualPaymentNotification &&
        counterNumberApplied == other.counterNumberApplied &&
        emailSendingMethod == other.emailSendingMethod &&
        gmailSendingUserId == other.gmailSendingUserId &&
        clientPortalTerms == other.clientPortalTerms &&
        clientPortalPrivacy == other.clientPortalPrivacy &&
        lockInvoices == other.lockInvoices &&
        autoBill == other.autoBill &&
        clientPortalAllowUnderPayment == other.clientPortalAllowUnderPayment &&
        clientPortalAllowOverPayment == other.clientPortalAllowOverPayment &&
        autoBillDate == other.autoBillDate &&
        clientPortalUnderPaymentMinimum ==
            other.clientPortalUnderPaymentMinimum &&
        useCreditsPayment == other.useCreditsPayment &&
        clientPortalCustomHeader == other.clientPortalCustomHeader &&
        clientPortalCustomCss == other.clientPortalCustomCss &&
        clientPortalCustomFooter == other.clientPortalCustomFooter &&
        clientPortalCustomJs == other.clientPortalCustomJs &&
        hideEmptyColumnsOnPdf == other.hideEmptyColumnsOnPdf &&
        hasCustomDesign1 == other.hasCustomDesign1 &&
        hasCustomDesign2 == other.hasCustomDesign2 &&
        hasCustomDesign3 == other.hasCustomDesign3;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, timezoneId.hashCode), dateFormatId.hashCode), enableMilitaryTime.hashCode), languageId.hashCode), showCurrencyCode.hashCode), currencyId.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), defaultPaymentTerms.hashCode), companyGatewayIds.hashCode), defaultTaskRate.hashCode), sendReminders.hashCode), enablePortal.hashCode), enablePortalDashboard.hashCode), enablePortalTasks.hashCode), enablePortalUploads.hashCode), emailStyle.hashCode), replyToEmail.hashCode), replyToName.hashCode), bccEmail.hashCode), pdfEmailAttachment.hashCode), ublEmailAttachment.hashCode), documentEmailAttachment.hashCode), emailStyleCustom.hashCode), customMessageDashboard.hashCode), customMessageUnpaidInvoice.hashCode), customMessagePaidInvoice.hashCode), customMessageUnapprovedQuote.hashCode), autoArchiveInvoice.hashCode), autoArchiveQuote.hashCode), autoEmailInvoice.hashCode), autoConvertQuote.hashCode), enableInclusiveTaxes.hashCode), translations.hashCode), taskNumberPattern.hashCode), taskNumberCounter.hashCode), expenseNumberPattern.hashCode), expenseNumberCounter.hashCode), vendorNumberPattern.hashCode), vendorNumberCounter.hashCode), ticketNumberPattern.hashCode), ticketNumberCounter.hashCode), paymentNumberPattern.hashCode), paymentNumberCounter.hashCode), projectNumberPattern.hashCode), projectNumberCounter.hashCode), invoiceNumberPattern.hashCode), invoiceNumberCounter.hashCode), recurringInvoiceNumberPattern.hashCode), recurringInvoiceNumberCounter.hashCode), quoteNumberPattern.hashCode), quoteNumberCounter.hashCode), clientNumberPattern.hashCode), clientNumberCounter.hashCode), creditNumberPattern.hashCode), creditNumberCounter.hashCode), recurringNumberPrefix.hashCode), resetCounterFrequencyId.hashCode), resetCounterDate.hashCode), counterPadding.hashCode), sharedInvoiceQuoteCounter.hashCode), sharedInvoiceCreditCounter.hashCode), defaultInvoiceTerms.hashCode), defaultQuoteTerms.hashCode), defaultQuoteFooter.hashCode), defaultCreditTerms.hashCode), defaultCreditFooter.hashCode), defaultInvoiceDesignId.hashCode), defaultQuoteDesignId.hashCode), defaultCreditDesignId.hashCode), defaultInvoiceFooter.hashCode), defaultTaxName1.hashCode), defaultTaxRate1.hashCode), defaultTaxName2.hashCode), defaultTaxRate2.hashCode), defaultTaxName3.hashCode), defaultTaxRate3.hashCode), defaultPaymentTypeId.hashCode), pdfVariables.hashCode), emailSignature.hashCode), emailSubjectInvoice.hashCode), emailSubjectQuote.hashCode), emailSubjectCredit.hashCode), emailSubjectPayment.hashCode), emailSubjectPaymentPartial.hashCode), emailBodyInvoice.hashCode), emailBodyQuote.hashCode), emailBodyCredit.hashCode), emailBodyPayment.hashCode), emailBodyPaymentPartial.hashCode), emailSubjectReminder1.hashCode), emailSubjectReminder2.hashCode), emailSubjectReminder3.hashCode), emailBodyReminder1.hashCode), emailBodyReminder2.hashCode), emailBodyReminder3.hashCode), emailSubjectCustom1.hashCode), emailBodyCustom1.hashCode), emailSubjectCustom2.hashCode), emailBodyCustom2.hashCode), emailSubjectCustom3.hashCode), emailBodyCustom3.hashCode), emailSubjectStatement.hashCode), emailBodyStatement.hashCode), enablePortalPassword.hashCode), signatureOnPdf.hashCode), enableEmailMarkup.hashCode), showAcceptInvoiceTerms.hashCode), showAcceptQuoteTerms.hashCode), requireInvoiceSignature.hashCode), requireQuoteSignature.hashCode), name.hashCode), companyLogo.hashCode), website.hashCode), address1.hashCode), address2.hashCode), city.hashCode), state.hashCode), postalCode.hashCode), phone.hashCode), email.hashCode), countryId.hashCode), vatNumber.hashCode), idNumber.hashCode), pageSize.hashCode), fontSize.hashCode), primaryColor.hashCode), secondaryColor.hashCode), primaryFont.hashCode), secondaryFont.hashCode), hidePaidToDate.hashCode), embedDocuments.hashCode), allPagesHeader.hashCode), allPagesFooter.hashCode), enableReminder1.hashCode), enableReminder2.hashCode), enableReminder3.hashCode), enableReminderEndless.hashCode), numDaysReminder1.hashCode), numDaysReminder2.hashCode), numDaysReminder3.hashCode), scheduleReminder1.hashCode), scheduleReminder2.hashCode), scheduleReminder3.hashCode), endlessReminderFrequencyId.hashCode), lateFeeAmount1.hashCode), lateFeeAmount2.hashCode), lateFeeAmount3.hashCode), lateFeeAmountEndless.hashCode), lateFeePercent1.hashCode), lateFeePercent2.hashCode), lateFeePercent3.hashCode), lateFeePercentEndless.hashCode), emailSubjectReminderEndless.hashCode), emailBodyReminderEndless.hashCode), clientOnlinePaymentNotification.hashCode), clientManualPaymentNotification.hashCode), counterNumberApplied.hashCode),
                                                                                emailSendingMethod.hashCode),
                                                                            gmailSendingUserId.hashCode),
                                                                        clientPortalTerms.hashCode),
                                                                    clientPortalPrivacy.hashCode),
                                                                lockInvoices.hashCode),
                                                            autoBill.hashCode),
                                                        clientPortalAllowUnderPayment.hashCode),
                                                    clientPortalAllowOverPayment.hashCode),
                                                autoBillDate.hashCode),
                                            clientPortalUnderPaymentMinimum.hashCode),
                                        useCreditsPayment.hashCode),
                                    clientPortalCustomHeader.hashCode),
                                clientPortalCustomCss.hashCode),
                            clientPortalCustomFooter.hashCode),
                        clientPortalCustomJs.hashCode),
                    hideEmptyColumnsOnPdf.hashCode),
                hasCustomDesign1.hashCode),
            hasCustomDesign2.hashCode),
        hasCustomDesign3.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsEntity')
          ..add('timezoneId', timezoneId)
          ..add('dateFormatId', dateFormatId)
          ..add('enableMilitaryTime', enableMilitaryTime)
          ..add('languageId', languageId)
          ..add('showCurrencyCode', showCurrencyCode)
          ..add('currencyId', currencyId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('defaultPaymentTerms', defaultPaymentTerms)
          ..add('companyGatewayIds', companyGatewayIds)
          ..add('defaultTaskRate', defaultTaskRate)
          ..add('sendReminders', sendReminders)
          ..add('enablePortal', enablePortal)
          ..add('enablePortalDashboard', enablePortalDashboard)
          ..add('enablePortalTasks', enablePortalTasks)
          ..add('enablePortalUploads', enablePortalUploads)
          ..add('emailStyle', emailStyle)
          ..add('replyToEmail', replyToEmail)
          ..add('replyToName', replyToName)
          ..add('bccEmail', bccEmail)
          ..add('pdfEmailAttachment', pdfEmailAttachment)
          ..add('ublEmailAttachment', ublEmailAttachment)
          ..add('documentEmailAttachment', documentEmailAttachment)
          ..add('emailStyleCustom', emailStyleCustom)
          ..add('customMessageDashboard', customMessageDashboard)
          ..add('customMessageUnpaidInvoice', customMessageUnpaidInvoice)
          ..add('customMessagePaidInvoice', customMessagePaidInvoice)
          ..add('customMessageUnapprovedQuote', customMessageUnapprovedQuote)
          ..add('autoArchiveInvoice', autoArchiveInvoice)
          ..add('autoArchiveQuote', autoArchiveQuote)
          ..add('autoEmailInvoice', autoEmailInvoice)
          ..add('autoConvertQuote', autoConvertQuote)
          ..add('enableInclusiveTaxes', enableInclusiveTaxes)
          ..add('translations', translations)
          ..add('taskNumberPattern', taskNumberPattern)
          ..add('taskNumberCounter', taskNumberCounter)
          ..add('expenseNumberPattern', expenseNumberPattern)
          ..add('expenseNumberCounter', expenseNumberCounter)
          ..add('vendorNumberPattern', vendorNumberPattern)
          ..add('vendorNumberCounter', vendorNumberCounter)
          ..add('ticketNumberPattern', ticketNumberPattern)
          ..add('ticketNumberCounter', ticketNumberCounter)
          ..add('paymentNumberPattern', paymentNumberPattern)
          ..add('paymentNumberCounter', paymentNumberCounter)
          ..add('projectNumberPattern', projectNumberPattern)
          ..add('projectNumberCounter', projectNumberCounter)
          ..add('invoiceNumberPattern', invoiceNumberPattern)
          ..add('invoiceNumberCounter', invoiceNumberCounter)
          ..add('recurringInvoiceNumberPattern', recurringInvoiceNumberPattern)
          ..add('recurringInvoiceNumberCounter', recurringInvoiceNumberCounter)
          ..add('quoteNumberPattern', quoteNumberPattern)
          ..add('quoteNumberCounter', quoteNumberCounter)
          ..add('clientNumberPattern', clientNumberPattern)
          ..add('clientNumberCounter', clientNumberCounter)
          ..add('creditNumberPattern', creditNumberPattern)
          ..add('creditNumberCounter', creditNumberCounter)
          ..add('recurringNumberPrefix', recurringNumberPrefix)
          ..add('resetCounterFrequencyId', resetCounterFrequencyId)
          ..add('resetCounterDate', resetCounterDate)
          ..add('counterPadding', counterPadding)
          ..add('sharedInvoiceQuoteCounter', sharedInvoiceQuoteCounter)
          ..add('sharedInvoiceCreditCounter', sharedInvoiceCreditCounter)
          ..add('defaultInvoiceTerms', defaultInvoiceTerms)
          ..add('defaultQuoteTerms', defaultQuoteTerms)
          ..add('defaultQuoteFooter', defaultQuoteFooter)
          ..add('defaultCreditTerms', defaultCreditTerms)
          ..add('defaultCreditFooter', defaultCreditFooter)
          ..add('defaultInvoiceDesignId', defaultInvoiceDesignId)
          ..add('defaultQuoteDesignId', defaultQuoteDesignId)
          ..add('defaultCreditDesignId', defaultCreditDesignId)
          ..add('defaultInvoiceFooter', defaultInvoiceFooter)
          ..add('defaultTaxName1', defaultTaxName1)
          ..add('defaultTaxRate1', defaultTaxRate1)
          ..add('defaultTaxName2', defaultTaxName2)
          ..add('defaultTaxRate2', defaultTaxRate2)
          ..add('defaultTaxName3', defaultTaxName3)
          ..add('defaultTaxRate3', defaultTaxRate3)
          ..add('defaultPaymentTypeId', defaultPaymentTypeId)
          ..add('pdfVariables', pdfVariables)
          ..add('emailSignature', emailSignature)
          ..add('emailSubjectInvoice', emailSubjectInvoice)
          ..add('emailSubjectQuote', emailSubjectQuote)
          ..add('emailSubjectCredit', emailSubjectCredit)
          ..add('emailSubjectPayment', emailSubjectPayment)
          ..add('emailSubjectPaymentPartial', emailSubjectPaymentPartial)
          ..add('emailBodyInvoice', emailBodyInvoice)
          ..add('emailBodyQuote', emailBodyQuote)
          ..add('emailBodyCredit', emailBodyCredit)
          ..add('emailBodyPayment', emailBodyPayment)
          ..add('emailBodyPaymentPartial', emailBodyPaymentPartial)
          ..add('emailSubjectReminder1', emailSubjectReminder1)
          ..add('emailSubjectReminder2', emailSubjectReminder2)
          ..add('emailSubjectReminder3', emailSubjectReminder3)
          ..add('emailBodyReminder1', emailBodyReminder1)
          ..add('emailBodyReminder2', emailBodyReminder2)
          ..add('emailBodyReminder3', emailBodyReminder3)
          ..add('emailSubjectCustom1', emailSubjectCustom1)
          ..add('emailBodyCustom1', emailBodyCustom1)
          ..add('emailSubjectCustom2', emailSubjectCustom2)
          ..add('emailBodyCustom2', emailBodyCustom2)
          ..add('emailSubjectCustom3', emailSubjectCustom3)
          ..add('emailBodyCustom3', emailBodyCustom3)
          ..add('emailSubjectStatement', emailSubjectStatement)
          ..add('emailBodyStatement', emailBodyStatement)
          ..add('enablePortalPassword', enablePortalPassword)
          ..add('signatureOnPdf', signatureOnPdf)
          ..add('enableEmailMarkup', enableEmailMarkup)
          ..add('showAcceptInvoiceTerms', showAcceptInvoiceTerms)
          ..add('showAcceptQuoteTerms', showAcceptQuoteTerms)
          ..add('requireInvoiceSignature', requireInvoiceSignature)
          ..add('requireQuoteSignature', requireQuoteSignature)
          ..add('name', name)
          ..add('companyLogo', companyLogo)
          ..add('website', website)
          ..add('address1', address1)
          ..add('address2', address2)
          ..add('city', city)
          ..add('state', state)
          ..add('postalCode', postalCode)
          ..add('phone', phone)
          ..add('email', email)
          ..add('countryId', countryId)
          ..add('vatNumber', vatNumber)
          ..add('idNumber', idNumber)
          ..add('pageSize', pageSize)
          ..add('fontSize', fontSize)
          ..add('primaryColor', primaryColor)
          ..add('secondaryColor', secondaryColor)
          ..add('primaryFont', primaryFont)
          ..add('secondaryFont', secondaryFont)
          ..add('hidePaidToDate', hidePaidToDate)
          ..add('embedDocuments', embedDocuments)
          ..add('allPagesHeader', allPagesHeader)
          ..add('allPagesFooter', allPagesFooter)
          ..add('enableReminder1', enableReminder1)
          ..add('enableReminder2', enableReminder2)
          ..add('enableReminder3', enableReminder3)
          ..add('enableReminderEndless', enableReminderEndless)
          ..add('numDaysReminder1', numDaysReminder1)
          ..add('numDaysReminder2', numDaysReminder2)
          ..add('numDaysReminder3', numDaysReminder3)
          ..add('scheduleReminder1', scheduleReminder1)
          ..add('scheduleReminder2', scheduleReminder2)
          ..add('scheduleReminder3', scheduleReminder3)
          ..add('endlessReminderFrequencyId', endlessReminderFrequencyId)
          ..add('lateFeeAmount1', lateFeeAmount1)
          ..add('lateFeeAmount2', lateFeeAmount2)
          ..add('lateFeeAmount3', lateFeeAmount3)
          ..add('lateFeeAmountEndless', lateFeeAmountEndless)
          ..add('lateFeePercent1', lateFeePercent1)
          ..add('lateFeePercent2', lateFeePercent2)
          ..add('lateFeePercent3', lateFeePercent3)
          ..add('lateFeePercentEndless', lateFeePercentEndless)
          ..add('emailSubjectReminderEndless', emailSubjectReminderEndless)
          ..add('emailBodyReminderEndless', emailBodyReminderEndless)
          ..add('clientOnlinePaymentNotification',
              clientOnlinePaymentNotification)
          ..add('clientManualPaymentNotification',
              clientManualPaymentNotification)
          ..add('counterNumberApplied', counterNumberApplied)
          ..add('emailSendingMethod', emailSendingMethod)
          ..add('gmailSendingUserId', gmailSendingUserId)
          ..add('clientPortalTerms', clientPortalTerms)
          ..add('clientPortalPrivacy', clientPortalPrivacy)
          ..add('lockInvoices', lockInvoices)
          ..add('autoBill', autoBill)
          ..add('clientPortalAllowUnderPayment', clientPortalAllowUnderPayment)
          ..add('clientPortalAllowOverPayment', clientPortalAllowOverPayment)
          ..add('autoBillDate', autoBillDate)
          ..add('clientPortalUnderPaymentMinimum',
              clientPortalUnderPaymentMinimum)
          ..add('useCreditsPayment', useCreditsPayment)
          ..add('clientPortalCustomHeader', clientPortalCustomHeader)
          ..add('clientPortalCustomCss', clientPortalCustomCss)
          ..add('clientPortalCustomFooter', clientPortalCustomFooter)
          ..add('clientPortalCustomJs', clientPortalCustomJs)
          ..add('hideEmptyColumnsOnPdf', hideEmptyColumnsOnPdf)
          ..add('hasCustomDesign1', hasCustomDesign1)
          ..add('hasCustomDesign2', hasCustomDesign2)
          ..add('hasCustomDesign3', hasCustomDesign3))
        .toString();
  }
}

class SettingsEntityBuilder
    implements Builder<SettingsEntity, SettingsEntityBuilder> {
  _$SettingsEntity _$v;

  String _timezoneId;
  String get timezoneId => _$this._timezoneId;
  set timezoneId(String timezoneId) => _$this._timezoneId = timezoneId;

  String _dateFormatId;
  String get dateFormatId => _$this._dateFormatId;
  set dateFormatId(String dateFormatId) => _$this._dateFormatId = dateFormatId;

  bool _enableMilitaryTime;
  bool get enableMilitaryTime => _$this._enableMilitaryTime;
  set enableMilitaryTime(bool enableMilitaryTime) =>
      _$this._enableMilitaryTime = enableMilitaryTime;

  String _languageId;
  String get languageId => _$this._languageId;
  set languageId(String languageId) => _$this._languageId = languageId;

  bool _showCurrencyCode;
  bool get showCurrencyCode => _$this._showCurrencyCode;
  set showCurrencyCode(bool showCurrencyCode) =>
      _$this._showCurrencyCode = showCurrencyCode;

  String _currencyId;
  String get currencyId => _$this._currencyId;
  set currencyId(String currencyId) => _$this._currencyId = currencyId;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  String _defaultPaymentTerms;
  String get defaultPaymentTerms => _$this._defaultPaymentTerms;
  set defaultPaymentTerms(String defaultPaymentTerms) =>
      _$this._defaultPaymentTerms = defaultPaymentTerms;

  String _companyGatewayIds;
  String get companyGatewayIds => _$this._companyGatewayIds;
  set companyGatewayIds(String companyGatewayIds) =>
      _$this._companyGatewayIds = companyGatewayIds;

  double _defaultTaskRate;
  double get defaultTaskRate => _$this._defaultTaskRate;
  set defaultTaskRate(double defaultTaskRate) =>
      _$this._defaultTaskRate = defaultTaskRate;

  bool _sendReminders;
  bool get sendReminders => _$this._sendReminders;
  set sendReminders(bool sendReminders) =>
      _$this._sendReminders = sendReminders;

  bool _enablePortal;
  bool get enablePortal => _$this._enablePortal;
  set enablePortal(bool enablePortal) => _$this._enablePortal = enablePortal;

  bool _enablePortalDashboard;
  bool get enablePortalDashboard => _$this._enablePortalDashboard;
  set enablePortalDashboard(bool enablePortalDashboard) =>
      _$this._enablePortalDashboard = enablePortalDashboard;

  bool _enablePortalTasks;
  bool get enablePortalTasks => _$this._enablePortalTasks;
  set enablePortalTasks(bool enablePortalTasks) =>
      _$this._enablePortalTasks = enablePortalTasks;

  bool _enablePortalUploads;
  bool get enablePortalUploads => _$this._enablePortalUploads;
  set enablePortalUploads(bool enablePortalUploads) =>
      _$this._enablePortalUploads = enablePortalUploads;

  String _emailStyle;
  String get emailStyle => _$this._emailStyle;
  set emailStyle(String emailStyle) => _$this._emailStyle = emailStyle;

  String _replyToEmail;
  String get replyToEmail => _$this._replyToEmail;
  set replyToEmail(String replyToEmail) => _$this._replyToEmail = replyToEmail;

  String _replyToName;
  String get replyToName => _$this._replyToName;
  set replyToName(String replyToName) => _$this._replyToName = replyToName;

  String _bccEmail;
  String get bccEmail => _$this._bccEmail;
  set bccEmail(String bccEmail) => _$this._bccEmail = bccEmail;

  bool _pdfEmailAttachment;
  bool get pdfEmailAttachment => _$this._pdfEmailAttachment;
  set pdfEmailAttachment(bool pdfEmailAttachment) =>
      _$this._pdfEmailAttachment = pdfEmailAttachment;

  bool _ublEmailAttachment;
  bool get ublEmailAttachment => _$this._ublEmailAttachment;
  set ublEmailAttachment(bool ublEmailAttachment) =>
      _$this._ublEmailAttachment = ublEmailAttachment;

  bool _documentEmailAttachment;
  bool get documentEmailAttachment => _$this._documentEmailAttachment;
  set documentEmailAttachment(bool documentEmailAttachment) =>
      _$this._documentEmailAttachment = documentEmailAttachment;

  String _emailStyleCustom;
  String get emailStyleCustom => _$this._emailStyleCustom;
  set emailStyleCustom(String emailStyleCustom) =>
      _$this._emailStyleCustom = emailStyleCustom;

  String _customMessageDashboard;
  String get customMessageDashboard => _$this._customMessageDashboard;
  set customMessageDashboard(String customMessageDashboard) =>
      _$this._customMessageDashboard = customMessageDashboard;

  String _customMessageUnpaidInvoice;
  String get customMessageUnpaidInvoice => _$this._customMessageUnpaidInvoice;
  set customMessageUnpaidInvoice(String customMessageUnpaidInvoice) =>
      _$this._customMessageUnpaidInvoice = customMessageUnpaidInvoice;

  String _customMessagePaidInvoice;
  String get customMessagePaidInvoice => _$this._customMessagePaidInvoice;
  set customMessagePaidInvoice(String customMessagePaidInvoice) =>
      _$this._customMessagePaidInvoice = customMessagePaidInvoice;

  String _customMessageUnapprovedQuote;
  String get customMessageUnapprovedQuote =>
      _$this._customMessageUnapprovedQuote;
  set customMessageUnapprovedQuote(String customMessageUnapprovedQuote) =>
      _$this._customMessageUnapprovedQuote = customMessageUnapprovedQuote;

  bool _autoArchiveInvoice;
  bool get autoArchiveInvoice => _$this._autoArchiveInvoice;
  set autoArchiveInvoice(bool autoArchiveInvoice) =>
      _$this._autoArchiveInvoice = autoArchiveInvoice;

  bool _autoArchiveQuote;
  bool get autoArchiveQuote => _$this._autoArchiveQuote;
  set autoArchiveQuote(bool autoArchiveQuote) =>
      _$this._autoArchiveQuote = autoArchiveQuote;

  bool _autoEmailInvoice;
  bool get autoEmailInvoice => _$this._autoEmailInvoice;
  set autoEmailInvoice(bool autoEmailInvoice) =>
      _$this._autoEmailInvoice = autoEmailInvoice;

  bool _autoConvertQuote;
  bool get autoConvertQuote => _$this._autoConvertQuote;
  set autoConvertQuote(bool autoConvertQuote) =>
      _$this._autoConvertQuote = autoConvertQuote;

  bool _enableInclusiveTaxes;
  bool get enableInclusiveTaxes => _$this._enableInclusiveTaxes;
  set enableInclusiveTaxes(bool enableInclusiveTaxes) =>
      _$this._enableInclusiveTaxes = enableInclusiveTaxes;

  MapBuilder<String, String> _translations;
  MapBuilder<String, String> get translations =>
      _$this._translations ??= new MapBuilder<String, String>();
  set translations(MapBuilder<String, String> translations) =>
      _$this._translations = translations;

  String _taskNumberPattern;
  String get taskNumberPattern => _$this._taskNumberPattern;
  set taskNumberPattern(String taskNumberPattern) =>
      _$this._taskNumberPattern = taskNumberPattern;

  int _taskNumberCounter;
  int get taskNumberCounter => _$this._taskNumberCounter;
  set taskNumberCounter(int taskNumberCounter) =>
      _$this._taskNumberCounter = taskNumberCounter;

  String _expenseNumberPattern;
  String get expenseNumberPattern => _$this._expenseNumberPattern;
  set expenseNumberPattern(String expenseNumberPattern) =>
      _$this._expenseNumberPattern = expenseNumberPattern;

  int _expenseNumberCounter;
  int get expenseNumberCounter => _$this._expenseNumberCounter;
  set expenseNumberCounter(int expenseNumberCounter) =>
      _$this._expenseNumberCounter = expenseNumberCounter;

  String _vendorNumberPattern;
  String get vendorNumberPattern => _$this._vendorNumberPattern;
  set vendorNumberPattern(String vendorNumberPattern) =>
      _$this._vendorNumberPattern = vendorNumberPattern;

  int _vendorNumberCounter;
  int get vendorNumberCounter => _$this._vendorNumberCounter;
  set vendorNumberCounter(int vendorNumberCounter) =>
      _$this._vendorNumberCounter = vendorNumberCounter;

  String _ticketNumberPattern;
  String get ticketNumberPattern => _$this._ticketNumberPattern;
  set ticketNumberPattern(String ticketNumberPattern) =>
      _$this._ticketNumberPattern = ticketNumberPattern;

  int _ticketNumberCounter;
  int get ticketNumberCounter => _$this._ticketNumberCounter;
  set ticketNumberCounter(int ticketNumberCounter) =>
      _$this._ticketNumberCounter = ticketNumberCounter;

  String _paymentNumberPattern;
  String get paymentNumberPattern => _$this._paymentNumberPattern;
  set paymentNumberPattern(String paymentNumberPattern) =>
      _$this._paymentNumberPattern = paymentNumberPattern;

  int _paymentNumberCounter;
  int get paymentNumberCounter => _$this._paymentNumberCounter;
  set paymentNumberCounter(int paymentNumberCounter) =>
      _$this._paymentNumberCounter = paymentNumberCounter;

  String _projectNumberPattern;
  String get projectNumberPattern => _$this._projectNumberPattern;
  set projectNumberPattern(String projectNumberPattern) =>
      _$this._projectNumberPattern = projectNumberPattern;

  int _projectNumberCounter;
  int get projectNumberCounter => _$this._projectNumberCounter;
  set projectNumberCounter(int projectNumberCounter) =>
      _$this._projectNumberCounter = projectNumberCounter;

  String _invoiceNumberPattern;
  String get invoiceNumberPattern => _$this._invoiceNumberPattern;
  set invoiceNumberPattern(String invoiceNumberPattern) =>
      _$this._invoiceNumberPattern = invoiceNumberPattern;

  int _invoiceNumberCounter;
  int get invoiceNumberCounter => _$this._invoiceNumberCounter;
  set invoiceNumberCounter(int invoiceNumberCounter) =>
      _$this._invoiceNumberCounter = invoiceNumberCounter;

  String _recurringInvoiceNumberPattern;
  String get recurringInvoiceNumberPattern =>
      _$this._recurringInvoiceNumberPattern;
  set recurringInvoiceNumberPattern(String recurringInvoiceNumberPattern) =>
      _$this._recurringInvoiceNumberPattern = recurringInvoiceNumberPattern;

  int _recurringInvoiceNumberCounter;
  int get recurringInvoiceNumberCounter =>
      _$this._recurringInvoiceNumberCounter;
  set recurringInvoiceNumberCounter(int recurringInvoiceNumberCounter) =>
      _$this._recurringInvoiceNumberCounter = recurringInvoiceNumberCounter;

  String _quoteNumberPattern;
  String get quoteNumberPattern => _$this._quoteNumberPattern;
  set quoteNumberPattern(String quoteNumberPattern) =>
      _$this._quoteNumberPattern = quoteNumberPattern;

  int _quoteNumberCounter;
  int get quoteNumberCounter => _$this._quoteNumberCounter;
  set quoteNumberCounter(int quoteNumberCounter) =>
      _$this._quoteNumberCounter = quoteNumberCounter;

  String _clientNumberPattern;
  String get clientNumberPattern => _$this._clientNumberPattern;
  set clientNumberPattern(String clientNumberPattern) =>
      _$this._clientNumberPattern = clientNumberPattern;

  int _clientNumberCounter;
  int get clientNumberCounter => _$this._clientNumberCounter;
  set clientNumberCounter(int clientNumberCounter) =>
      _$this._clientNumberCounter = clientNumberCounter;

  String _creditNumberPattern;
  String get creditNumberPattern => _$this._creditNumberPattern;
  set creditNumberPattern(String creditNumberPattern) =>
      _$this._creditNumberPattern = creditNumberPattern;

  int _creditNumberCounter;
  int get creditNumberCounter => _$this._creditNumberCounter;
  set creditNumberCounter(int creditNumberCounter) =>
      _$this._creditNumberCounter = creditNumberCounter;

  String _recurringNumberPrefix;
  String get recurringNumberPrefix => _$this._recurringNumberPrefix;
  set recurringNumberPrefix(String recurringNumberPrefix) =>
      _$this._recurringNumberPrefix = recurringNumberPrefix;

  String _resetCounterFrequencyId;
  String get resetCounterFrequencyId => _$this._resetCounterFrequencyId;
  set resetCounterFrequencyId(String resetCounterFrequencyId) =>
      _$this._resetCounterFrequencyId = resetCounterFrequencyId;

  String _resetCounterDate;
  String get resetCounterDate => _$this._resetCounterDate;
  set resetCounterDate(String resetCounterDate) =>
      _$this._resetCounterDate = resetCounterDate;

  int _counterPadding;
  int get counterPadding => _$this._counterPadding;
  set counterPadding(int counterPadding) =>
      _$this._counterPadding = counterPadding;

  bool _sharedInvoiceQuoteCounter;
  bool get sharedInvoiceQuoteCounter => _$this._sharedInvoiceQuoteCounter;
  set sharedInvoiceQuoteCounter(bool sharedInvoiceQuoteCounter) =>
      _$this._sharedInvoiceQuoteCounter = sharedInvoiceQuoteCounter;

  bool _sharedInvoiceCreditCounter;
  bool get sharedInvoiceCreditCounter => _$this._sharedInvoiceCreditCounter;
  set sharedInvoiceCreditCounter(bool sharedInvoiceCreditCounter) =>
      _$this._sharedInvoiceCreditCounter = sharedInvoiceCreditCounter;

  String _defaultInvoiceTerms;
  String get defaultInvoiceTerms => _$this._defaultInvoiceTerms;
  set defaultInvoiceTerms(String defaultInvoiceTerms) =>
      _$this._defaultInvoiceTerms = defaultInvoiceTerms;

  String _defaultQuoteTerms;
  String get defaultQuoteTerms => _$this._defaultQuoteTerms;
  set defaultQuoteTerms(String defaultQuoteTerms) =>
      _$this._defaultQuoteTerms = defaultQuoteTerms;

  String _defaultQuoteFooter;
  String get defaultQuoteFooter => _$this._defaultQuoteFooter;
  set defaultQuoteFooter(String defaultQuoteFooter) =>
      _$this._defaultQuoteFooter = defaultQuoteFooter;

  String _defaultCreditTerms;
  String get defaultCreditTerms => _$this._defaultCreditTerms;
  set defaultCreditTerms(String defaultCreditTerms) =>
      _$this._defaultCreditTerms = defaultCreditTerms;

  String _defaultCreditFooter;
  String get defaultCreditFooter => _$this._defaultCreditFooter;
  set defaultCreditFooter(String defaultCreditFooter) =>
      _$this._defaultCreditFooter = defaultCreditFooter;

  String _defaultInvoiceDesignId;
  String get defaultInvoiceDesignId => _$this._defaultInvoiceDesignId;
  set defaultInvoiceDesignId(String defaultInvoiceDesignId) =>
      _$this._defaultInvoiceDesignId = defaultInvoiceDesignId;

  String _defaultQuoteDesignId;
  String get defaultQuoteDesignId => _$this._defaultQuoteDesignId;
  set defaultQuoteDesignId(String defaultQuoteDesignId) =>
      _$this._defaultQuoteDesignId = defaultQuoteDesignId;

  String _defaultCreditDesignId;
  String get defaultCreditDesignId => _$this._defaultCreditDesignId;
  set defaultCreditDesignId(String defaultCreditDesignId) =>
      _$this._defaultCreditDesignId = defaultCreditDesignId;

  String _defaultInvoiceFooter;
  String get defaultInvoiceFooter => _$this._defaultInvoiceFooter;
  set defaultInvoiceFooter(String defaultInvoiceFooter) =>
      _$this._defaultInvoiceFooter = defaultInvoiceFooter;

  String _defaultTaxName1;
  String get defaultTaxName1 => _$this._defaultTaxName1;
  set defaultTaxName1(String defaultTaxName1) =>
      _$this._defaultTaxName1 = defaultTaxName1;

  double _defaultTaxRate1;
  double get defaultTaxRate1 => _$this._defaultTaxRate1;
  set defaultTaxRate1(double defaultTaxRate1) =>
      _$this._defaultTaxRate1 = defaultTaxRate1;

  String _defaultTaxName2;
  String get defaultTaxName2 => _$this._defaultTaxName2;
  set defaultTaxName2(String defaultTaxName2) =>
      _$this._defaultTaxName2 = defaultTaxName2;

  double _defaultTaxRate2;
  double get defaultTaxRate2 => _$this._defaultTaxRate2;
  set defaultTaxRate2(double defaultTaxRate2) =>
      _$this._defaultTaxRate2 = defaultTaxRate2;

  String _defaultTaxName3;
  String get defaultTaxName3 => _$this._defaultTaxName3;
  set defaultTaxName3(String defaultTaxName3) =>
      _$this._defaultTaxName3 = defaultTaxName3;

  double _defaultTaxRate3;
  double get defaultTaxRate3 => _$this._defaultTaxRate3;
  set defaultTaxRate3(double defaultTaxRate3) =>
      _$this._defaultTaxRate3 = defaultTaxRate3;

  String _defaultPaymentTypeId;
  String get defaultPaymentTypeId => _$this._defaultPaymentTypeId;
  set defaultPaymentTypeId(String defaultPaymentTypeId) =>
      _$this._defaultPaymentTypeId = defaultPaymentTypeId;

  MapBuilder<String, BuiltList<String>> _pdfVariables;
  MapBuilder<String, BuiltList<String>> get pdfVariables =>
      _$this._pdfVariables ??= new MapBuilder<String, BuiltList<String>>();
  set pdfVariables(MapBuilder<String, BuiltList<String>> pdfVariables) =>
      _$this._pdfVariables = pdfVariables;

  String _emailSignature;
  String get emailSignature => _$this._emailSignature;
  set emailSignature(String emailSignature) =>
      _$this._emailSignature = emailSignature;

  String _emailSubjectInvoice;
  String get emailSubjectInvoice => _$this._emailSubjectInvoice;
  set emailSubjectInvoice(String emailSubjectInvoice) =>
      _$this._emailSubjectInvoice = emailSubjectInvoice;

  String _emailSubjectQuote;
  String get emailSubjectQuote => _$this._emailSubjectQuote;
  set emailSubjectQuote(String emailSubjectQuote) =>
      _$this._emailSubjectQuote = emailSubjectQuote;

  String _emailSubjectCredit;
  String get emailSubjectCredit => _$this._emailSubjectCredit;
  set emailSubjectCredit(String emailSubjectCredit) =>
      _$this._emailSubjectCredit = emailSubjectCredit;

  String _emailSubjectPayment;
  String get emailSubjectPayment => _$this._emailSubjectPayment;
  set emailSubjectPayment(String emailSubjectPayment) =>
      _$this._emailSubjectPayment = emailSubjectPayment;

  String _emailSubjectPaymentPartial;
  String get emailSubjectPaymentPartial => _$this._emailSubjectPaymentPartial;
  set emailSubjectPaymentPartial(String emailSubjectPaymentPartial) =>
      _$this._emailSubjectPaymentPartial = emailSubjectPaymentPartial;

  String _emailBodyInvoice;
  String get emailBodyInvoice => _$this._emailBodyInvoice;
  set emailBodyInvoice(String emailBodyInvoice) =>
      _$this._emailBodyInvoice = emailBodyInvoice;

  String _emailBodyQuote;
  String get emailBodyQuote => _$this._emailBodyQuote;
  set emailBodyQuote(String emailBodyQuote) =>
      _$this._emailBodyQuote = emailBodyQuote;

  String _emailBodyCredit;
  String get emailBodyCredit => _$this._emailBodyCredit;
  set emailBodyCredit(String emailBodyCredit) =>
      _$this._emailBodyCredit = emailBodyCredit;

  String _emailBodyPayment;
  String get emailBodyPayment => _$this._emailBodyPayment;
  set emailBodyPayment(String emailBodyPayment) =>
      _$this._emailBodyPayment = emailBodyPayment;

  String _emailBodyPaymentPartial;
  String get emailBodyPaymentPartial => _$this._emailBodyPaymentPartial;
  set emailBodyPaymentPartial(String emailBodyPaymentPartial) =>
      _$this._emailBodyPaymentPartial = emailBodyPaymentPartial;

  String _emailSubjectReminder1;
  String get emailSubjectReminder1 => _$this._emailSubjectReminder1;
  set emailSubjectReminder1(String emailSubjectReminder1) =>
      _$this._emailSubjectReminder1 = emailSubjectReminder1;

  String _emailSubjectReminder2;
  String get emailSubjectReminder2 => _$this._emailSubjectReminder2;
  set emailSubjectReminder2(String emailSubjectReminder2) =>
      _$this._emailSubjectReminder2 = emailSubjectReminder2;

  String _emailSubjectReminder3;
  String get emailSubjectReminder3 => _$this._emailSubjectReminder3;
  set emailSubjectReminder3(String emailSubjectReminder3) =>
      _$this._emailSubjectReminder3 = emailSubjectReminder3;

  String _emailBodyReminder1;
  String get emailBodyReminder1 => _$this._emailBodyReminder1;
  set emailBodyReminder1(String emailBodyReminder1) =>
      _$this._emailBodyReminder1 = emailBodyReminder1;

  String _emailBodyReminder2;
  String get emailBodyReminder2 => _$this._emailBodyReminder2;
  set emailBodyReminder2(String emailBodyReminder2) =>
      _$this._emailBodyReminder2 = emailBodyReminder2;

  String _emailBodyReminder3;
  String get emailBodyReminder3 => _$this._emailBodyReminder3;
  set emailBodyReminder3(String emailBodyReminder3) =>
      _$this._emailBodyReminder3 = emailBodyReminder3;

  String _emailSubjectCustom1;
  String get emailSubjectCustom1 => _$this._emailSubjectCustom1;
  set emailSubjectCustom1(String emailSubjectCustom1) =>
      _$this._emailSubjectCustom1 = emailSubjectCustom1;

  String _emailBodyCustom1;
  String get emailBodyCustom1 => _$this._emailBodyCustom1;
  set emailBodyCustom1(String emailBodyCustom1) =>
      _$this._emailBodyCustom1 = emailBodyCustom1;

  String _emailSubjectCustom2;
  String get emailSubjectCustom2 => _$this._emailSubjectCustom2;
  set emailSubjectCustom2(String emailSubjectCustom2) =>
      _$this._emailSubjectCustom2 = emailSubjectCustom2;

  String _emailBodyCustom2;
  String get emailBodyCustom2 => _$this._emailBodyCustom2;
  set emailBodyCustom2(String emailBodyCustom2) =>
      _$this._emailBodyCustom2 = emailBodyCustom2;

  String _emailSubjectCustom3;
  String get emailSubjectCustom3 => _$this._emailSubjectCustom3;
  set emailSubjectCustom3(String emailSubjectCustom3) =>
      _$this._emailSubjectCustom3 = emailSubjectCustom3;

  String _emailBodyCustom3;
  String get emailBodyCustom3 => _$this._emailBodyCustom3;
  set emailBodyCustom3(String emailBodyCustom3) =>
      _$this._emailBodyCustom3 = emailBodyCustom3;

  String _emailSubjectStatement;
  String get emailSubjectStatement => _$this._emailSubjectStatement;
  set emailSubjectStatement(String emailSubjectStatement) =>
      _$this._emailSubjectStatement = emailSubjectStatement;

  String _emailBodyStatement;
  String get emailBodyStatement => _$this._emailBodyStatement;
  set emailBodyStatement(String emailBodyStatement) =>
      _$this._emailBodyStatement = emailBodyStatement;

  bool _enablePortalPassword;
  bool get enablePortalPassword => _$this._enablePortalPassword;
  set enablePortalPassword(bool enablePortalPassword) =>
      _$this._enablePortalPassword = enablePortalPassword;

  bool _signatureOnPdf;
  bool get signatureOnPdf => _$this._signatureOnPdf;
  set signatureOnPdf(bool signatureOnPdf) =>
      _$this._signatureOnPdf = signatureOnPdf;

  bool _enableEmailMarkup;
  bool get enableEmailMarkup => _$this._enableEmailMarkup;
  set enableEmailMarkup(bool enableEmailMarkup) =>
      _$this._enableEmailMarkup = enableEmailMarkup;

  bool _showAcceptInvoiceTerms;
  bool get showAcceptInvoiceTerms => _$this._showAcceptInvoiceTerms;
  set showAcceptInvoiceTerms(bool showAcceptInvoiceTerms) =>
      _$this._showAcceptInvoiceTerms = showAcceptInvoiceTerms;

  bool _showAcceptQuoteTerms;
  bool get showAcceptQuoteTerms => _$this._showAcceptQuoteTerms;
  set showAcceptQuoteTerms(bool showAcceptQuoteTerms) =>
      _$this._showAcceptQuoteTerms = showAcceptQuoteTerms;

  bool _requireInvoiceSignature;
  bool get requireInvoiceSignature => _$this._requireInvoiceSignature;
  set requireInvoiceSignature(bool requireInvoiceSignature) =>
      _$this._requireInvoiceSignature = requireInvoiceSignature;

  bool _requireQuoteSignature;
  bool get requireQuoteSignature => _$this._requireQuoteSignature;
  set requireQuoteSignature(bool requireQuoteSignature) =>
      _$this._requireQuoteSignature = requireQuoteSignature;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _companyLogo;
  String get companyLogo => _$this._companyLogo;
  set companyLogo(String companyLogo) => _$this._companyLogo = companyLogo;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _address1;
  String get address1 => _$this._address1;
  set address1(String address1) => _$this._address1 = address1;

  String _address2;
  String get address2 => _$this._address2;
  set address2(String address2) => _$this._address2 = address2;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _state;
  String get state => _$this._state;
  set state(String state) => _$this._state = state;

  String _postalCode;
  String get postalCode => _$this._postalCode;
  set postalCode(String postalCode) => _$this._postalCode = postalCode;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _countryId;
  String get countryId => _$this._countryId;
  set countryId(String countryId) => _$this._countryId = countryId;

  String _vatNumber;
  String get vatNumber => _$this._vatNumber;
  set vatNumber(String vatNumber) => _$this._vatNumber = vatNumber;

  String _idNumber;
  String get idNumber => _$this._idNumber;
  set idNumber(String idNumber) => _$this._idNumber = idNumber;

  String _pageSize;
  String get pageSize => _$this._pageSize;
  set pageSize(String pageSize) => _$this._pageSize = pageSize;

  int _fontSize;
  int get fontSize => _$this._fontSize;
  set fontSize(int fontSize) => _$this._fontSize = fontSize;

  String _primaryColor;
  String get primaryColor => _$this._primaryColor;
  set primaryColor(String primaryColor) => _$this._primaryColor = primaryColor;

  String _secondaryColor;
  String get secondaryColor => _$this._secondaryColor;
  set secondaryColor(String secondaryColor) =>
      _$this._secondaryColor = secondaryColor;

  String _primaryFont;
  String get primaryFont => _$this._primaryFont;
  set primaryFont(String primaryFont) => _$this._primaryFont = primaryFont;

  String _secondaryFont;
  String get secondaryFont => _$this._secondaryFont;
  set secondaryFont(String secondaryFont) =>
      _$this._secondaryFont = secondaryFont;

  bool _hidePaidToDate;
  bool get hidePaidToDate => _$this._hidePaidToDate;
  set hidePaidToDate(bool hidePaidToDate) =>
      _$this._hidePaidToDate = hidePaidToDate;

  bool _embedDocuments;
  bool get embedDocuments => _$this._embedDocuments;
  set embedDocuments(bool embedDocuments) =>
      _$this._embedDocuments = embedDocuments;

  bool _allPagesHeader;
  bool get allPagesHeader => _$this._allPagesHeader;
  set allPagesHeader(bool allPagesHeader) =>
      _$this._allPagesHeader = allPagesHeader;

  bool _allPagesFooter;
  bool get allPagesFooter => _$this._allPagesFooter;
  set allPagesFooter(bool allPagesFooter) =>
      _$this._allPagesFooter = allPagesFooter;

  bool _enableReminder1;
  bool get enableReminder1 => _$this._enableReminder1;
  set enableReminder1(bool enableReminder1) =>
      _$this._enableReminder1 = enableReminder1;

  bool _enableReminder2;
  bool get enableReminder2 => _$this._enableReminder2;
  set enableReminder2(bool enableReminder2) =>
      _$this._enableReminder2 = enableReminder2;

  bool _enableReminder3;
  bool get enableReminder3 => _$this._enableReminder3;
  set enableReminder3(bool enableReminder3) =>
      _$this._enableReminder3 = enableReminder3;

  bool _enableReminderEndless;
  bool get enableReminderEndless => _$this._enableReminderEndless;
  set enableReminderEndless(bool enableReminderEndless) =>
      _$this._enableReminderEndless = enableReminderEndless;

  int _numDaysReminder1;
  int get numDaysReminder1 => _$this._numDaysReminder1;
  set numDaysReminder1(int numDaysReminder1) =>
      _$this._numDaysReminder1 = numDaysReminder1;

  int _numDaysReminder2;
  int get numDaysReminder2 => _$this._numDaysReminder2;
  set numDaysReminder2(int numDaysReminder2) =>
      _$this._numDaysReminder2 = numDaysReminder2;

  int _numDaysReminder3;
  int get numDaysReminder3 => _$this._numDaysReminder3;
  set numDaysReminder3(int numDaysReminder3) =>
      _$this._numDaysReminder3 = numDaysReminder3;

  String _scheduleReminder1;
  String get scheduleReminder1 => _$this._scheduleReminder1;
  set scheduleReminder1(String scheduleReminder1) =>
      _$this._scheduleReminder1 = scheduleReminder1;

  String _scheduleReminder2;
  String get scheduleReminder2 => _$this._scheduleReminder2;
  set scheduleReminder2(String scheduleReminder2) =>
      _$this._scheduleReminder2 = scheduleReminder2;

  String _scheduleReminder3;
  String get scheduleReminder3 => _$this._scheduleReminder3;
  set scheduleReminder3(String scheduleReminder3) =>
      _$this._scheduleReminder3 = scheduleReminder3;

  String _endlessReminderFrequencyId;
  String get endlessReminderFrequencyId => _$this._endlessReminderFrequencyId;
  set endlessReminderFrequencyId(String endlessReminderFrequencyId) =>
      _$this._endlessReminderFrequencyId = endlessReminderFrequencyId;

  double _lateFeeAmount1;
  double get lateFeeAmount1 => _$this._lateFeeAmount1;
  set lateFeeAmount1(double lateFeeAmount1) =>
      _$this._lateFeeAmount1 = lateFeeAmount1;

  double _lateFeeAmount2;
  double get lateFeeAmount2 => _$this._lateFeeAmount2;
  set lateFeeAmount2(double lateFeeAmount2) =>
      _$this._lateFeeAmount2 = lateFeeAmount2;

  double _lateFeeAmount3;
  double get lateFeeAmount3 => _$this._lateFeeAmount3;
  set lateFeeAmount3(double lateFeeAmount3) =>
      _$this._lateFeeAmount3 = lateFeeAmount3;

  double _lateFeeAmountEndless;
  double get lateFeeAmountEndless => _$this._lateFeeAmountEndless;
  set lateFeeAmountEndless(double lateFeeAmountEndless) =>
      _$this._lateFeeAmountEndless = lateFeeAmountEndless;

  double _lateFeePercent1;
  double get lateFeePercent1 => _$this._lateFeePercent1;
  set lateFeePercent1(double lateFeePercent1) =>
      _$this._lateFeePercent1 = lateFeePercent1;

  double _lateFeePercent2;
  double get lateFeePercent2 => _$this._lateFeePercent2;
  set lateFeePercent2(double lateFeePercent2) =>
      _$this._lateFeePercent2 = lateFeePercent2;

  double _lateFeePercent3;
  double get lateFeePercent3 => _$this._lateFeePercent3;
  set lateFeePercent3(double lateFeePercent3) =>
      _$this._lateFeePercent3 = lateFeePercent3;

  double _lateFeePercentEndless;
  double get lateFeePercentEndless => _$this._lateFeePercentEndless;
  set lateFeePercentEndless(double lateFeePercentEndless) =>
      _$this._lateFeePercentEndless = lateFeePercentEndless;

  String _emailSubjectReminderEndless;
  String get emailSubjectReminderEndless => _$this._emailSubjectReminderEndless;
  set emailSubjectReminderEndless(String emailSubjectReminderEndless) =>
      _$this._emailSubjectReminderEndless = emailSubjectReminderEndless;

  String _emailBodyReminderEndless;
  String get emailBodyReminderEndless => _$this._emailBodyReminderEndless;
  set emailBodyReminderEndless(String emailBodyReminderEndless) =>
      _$this._emailBodyReminderEndless = emailBodyReminderEndless;

  bool _clientOnlinePaymentNotification;
  bool get clientOnlinePaymentNotification =>
      _$this._clientOnlinePaymentNotification;
  set clientOnlinePaymentNotification(bool clientOnlinePaymentNotification) =>
      _$this._clientOnlinePaymentNotification = clientOnlinePaymentNotification;

  bool _clientManualPaymentNotification;
  bool get clientManualPaymentNotification =>
      _$this._clientManualPaymentNotification;
  set clientManualPaymentNotification(bool clientManualPaymentNotification) =>
      _$this._clientManualPaymentNotification = clientManualPaymentNotification;

  String _counterNumberApplied;
  String get counterNumberApplied => _$this._counterNumberApplied;
  set counterNumberApplied(String counterNumberApplied) =>
      _$this._counterNumberApplied = counterNumberApplied;

  String _emailSendingMethod;
  String get emailSendingMethod => _$this._emailSendingMethod;
  set emailSendingMethod(String emailSendingMethod) =>
      _$this._emailSendingMethod = emailSendingMethod;

  String _gmailSendingUserId;
  String get gmailSendingUserId => _$this._gmailSendingUserId;
  set gmailSendingUserId(String gmailSendingUserId) =>
      _$this._gmailSendingUserId = gmailSendingUserId;

  String _clientPortalTerms;
  String get clientPortalTerms => _$this._clientPortalTerms;
  set clientPortalTerms(String clientPortalTerms) =>
      _$this._clientPortalTerms = clientPortalTerms;

  String _clientPortalPrivacy;
  String get clientPortalPrivacy => _$this._clientPortalPrivacy;
  set clientPortalPrivacy(String clientPortalPrivacy) =>
      _$this._clientPortalPrivacy = clientPortalPrivacy;

  String _lockInvoices;
  String get lockInvoices => _$this._lockInvoices;
  set lockInvoices(String lockInvoices) => _$this._lockInvoices = lockInvoices;

  String _autoBill;
  String get autoBill => _$this._autoBill;
  set autoBill(String autoBill) => _$this._autoBill = autoBill;

  bool _clientPortalAllowUnderPayment;
  bool get clientPortalAllowUnderPayment =>
      _$this._clientPortalAllowUnderPayment;
  set clientPortalAllowUnderPayment(bool clientPortalAllowUnderPayment) =>
      _$this._clientPortalAllowUnderPayment = clientPortalAllowUnderPayment;

  bool _clientPortalAllowOverPayment;
  bool get clientPortalAllowOverPayment => _$this._clientPortalAllowOverPayment;
  set clientPortalAllowOverPayment(bool clientPortalAllowOverPayment) =>
      _$this._clientPortalAllowOverPayment = clientPortalAllowOverPayment;

  String _autoBillDate;
  String get autoBillDate => _$this._autoBillDate;
  set autoBillDate(String autoBillDate) => _$this._autoBillDate = autoBillDate;

  double _clientPortalUnderPaymentMinimum;
  double get clientPortalUnderPaymentMinimum =>
      _$this._clientPortalUnderPaymentMinimum;
  set clientPortalUnderPaymentMinimum(double clientPortalUnderPaymentMinimum) =>
      _$this._clientPortalUnderPaymentMinimum = clientPortalUnderPaymentMinimum;

  String _useCreditsPayment;
  String get useCreditsPayment => _$this._useCreditsPayment;
  set useCreditsPayment(String useCreditsPayment) =>
      _$this._useCreditsPayment = useCreditsPayment;

  String _clientPortalCustomHeader;
  String get clientPortalCustomHeader => _$this._clientPortalCustomHeader;
  set clientPortalCustomHeader(String clientPortalCustomHeader) =>
      _$this._clientPortalCustomHeader = clientPortalCustomHeader;

  String _clientPortalCustomCss;
  String get clientPortalCustomCss => _$this._clientPortalCustomCss;
  set clientPortalCustomCss(String clientPortalCustomCss) =>
      _$this._clientPortalCustomCss = clientPortalCustomCss;

  String _clientPortalCustomFooter;
  String get clientPortalCustomFooter => _$this._clientPortalCustomFooter;
  set clientPortalCustomFooter(String clientPortalCustomFooter) =>
      _$this._clientPortalCustomFooter = clientPortalCustomFooter;

  String _clientPortalCustomJs;
  String get clientPortalCustomJs => _$this._clientPortalCustomJs;
  set clientPortalCustomJs(String clientPortalCustomJs) =>
      _$this._clientPortalCustomJs = clientPortalCustomJs;

  bool _hideEmptyColumnsOnPdf;
  bool get hideEmptyColumnsOnPdf => _$this._hideEmptyColumnsOnPdf;
  set hideEmptyColumnsOnPdf(bool hideEmptyColumnsOnPdf) =>
      _$this._hideEmptyColumnsOnPdf = hideEmptyColumnsOnPdf;

  bool _hasCustomDesign1;
  bool get hasCustomDesign1 => _$this._hasCustomDesign1;
  set hasCustomDesign1(bool hasCustomDesign1) =>
      _$this._hasCustomDesign1 = hasCustomDesign1;

  bool _hasCustomDesign2;
  bool get hasCustomDesign2 => _$this._hasCustomDesign2;
  set hasCustomDesign2(bool hasCustomDesign2) =>
      _$this._hasCustomDesign2 = hasCustomDesign2;

  bool _hasCustomDesign3;
  bool get hasCustomDesign3 => _$this._hasCustomDesign3;
  set hasCustomDesign3(bool hasCustomDesign3) =>
      _$this._hasCustomDesign3 = hasCustomDesign3;

  SettingsEntityBuilder();

  SettingsEntityBuilder get _$this {
    if (_$v != null) {
      _timezoneId = _$v.timezoneId;
      _dateFormatId = _$v.dateFormatId;
      _enableMilitaryTime = _$v.enableMilitaryTime;
      _languageId = _$v.languageId;
      _showCurrencyCode = _$v.showCurrencyCode;
      _currencyId = _$v.currencyId;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _defaultPaymentTerms = _$v.defaultPaymentTerms;
      _companyGatewayIds = _$v.companyGatewayIds;
      _defaultTaskRate = _$v.defaultTaskRate;
      _sendReminders = _$v.sendReminders;
      _enablePortal = _$v.enablePortal;
      _enablePortalDashboard = _$v.enablePortalDashboard;
      _enablePortalTasks = _$v.enablePortalTasks;
      _enablePortalUploads = _$v.enablePortalUploads;
      _emailStyle = _$v.emailStyle;
      _replyToEmail = _$v.replyToEmail;
      _replyToName = _$v.replyToName;
      _bccEmail = _$v.bccEmail;
      _pdfEmailAttachment = _$v.pdfEmailAttachment;
      _ublEmailAttachment = _$v.ublEmailAttachment;
      _documentEmailAttachment = _$v.documentEmailAttachment;
      _emailStyleCustom = _$v.emailStyleCustom;
      _customMessageDashboard = _$v.customMessageDashboard;
      _customMessageUnpaidInvoice = _$v.customMessageUnpaidInvoice;
      _customMessagePaidInvoice = _$v.customMessagePaidInvoice;
      _customMessageUnapprovedQuote = _$v.customMessageUnapprovedQuote;
      _autoArchiveInvoice = _$v.autoArchiveInvoice;
      _autoArchiveQuote = _$v.autoArchiveQuote;
      _autoEmailInvoice = _$v.autoEmailInvoice;
      _autoConvertQuote = _$v.autoConvertQuote;
      _enableInclusiveTaxes = _$v.enableInclusiveTaxes;
      _translations = _$v.translations?.toBuilder();
      _taskNumberPattern = _$v.taskNumberPattern;
      _taskNumberCounter = _$v.taskNumberCounter;
      _expenseNumberPattern = _$v.expenseNumberPattern;
      _expenseNumberCounter = _$v.expenseNumberCounter;
      _vendorNumberPattern = _$v.vendorNumberPattern;
      _vendorNumberCounter = _$v.vendorNumberCounter;
      _ticketNumberPattern = _$v.ticketNumberPattern;
      _ticketNumberCounter = _$v.ticketNumberCounter;
      _paymentNumberPattern = _$v.paymentNumberPattern;
      _paymentNumberCounter = _$v.paymentNumberCounter;
      _projectNumberPattern = _$v.projectNumberPattern;
      _projectNumberCounter = _$v.projectNumberCounter;
      _invoiceNumberPattern = _$v.invoiceNumberPattern;
      _invoiceNumberCounter = _$v.invoiceNumberCounter;
      _recurringInvoiceNumberPattern = _$v.recurringInvoiceNumberPattern;
      _recurringInvoiceNumberCounter = _$v.recurringInvoiceNumberCounter;
      _quoteNumberPattern = _$v.quoteNumberPattern;
      _quoteNumberCounter = _$v.quoteNumberCounter;
      _clientNumberPattern = _$v.clientNumberPattern;
      _clientNumberCounter = _$v.clientNumberCounter;
      _creditNumberPattern = _$v.creditNumberPattern;
      _creditNumberCounter = _$v.creditNumberCounter;
      _recurringNumberPrefix = _$v.recurringNumberPrefix;
      _resetCounterFrequencyId = _$v.resetCounterFrequencyId;
      _resetCounterDate = _$v.resetCounterDate;
      _counterPadding = _$v.counterPadding;
      _sharedInvoiceQuoteCounter = _$v.sharedInvoiceQuoteCounter;
      _sharedInvoiceCreditCounter = _$v.sharedInvoiceCreditCounter;
      _defaultInvoiceTerms = _$v.defaultInvoiceTerms;
      _defaultQuoteTerms = _$v.defaultQuoteTerms;
      _defaultQuoteFooter = _$v.defaultQuoteFooter;
      _defaultCreditTerms = _$v.defaultCreditTerms;
      _defaultCreditFooter = _$v.defaultCreditFooter;
      _defaultInvoiceDesignId = _$v.defaultInvoiceDesignId;
      _defaultQuoteDesignId = _$v.defaultQuoteDesignId;
      _defaultCreditDesignId = _$v.defaultCreditDesignId;
      _defaultInvoiceFooter = _$v.defaultInvoiceFooter;
      _defaultTaxName1 = _$v.defaultTaxName1;
      _defaultTaxRate1 = _$v.defaultTaxRate1;
      _defaultTaxName2 = _$v.defaultTaxName2;
      _defaultTaxRate2 = _$v.defaultTaxRate2;
      _defaultTaxName3 = _$v.defaultTaxName3;
      _defaultTaxRate3 = _$v.defaultTaxRate3;
      _defaultPaymentTypeId = _$v.defaultPaymentTypeId;
      _pdfVariables = _$v.pdfVariables?.toBuilder();
      _emailSignature = _$v.emailSignature;
      _emailSubjectInvoice = _$v.emailSubjectInvoice;
      _emailSubjectQuote = _$v.emailSubjectQuote;
      _emailSubjectCredit = _$v.emailSubjectCredit;
      _emailSubjectPayment = _$v.emailSubjectPayment;
      _emailSubjectPaymentPartial = _$v.emailSubjectPaymentPartial;
      _emailBodyInvoice = _$v.emailBodyInvoice;
      _emailBodyQuote = _$v.emailBodyQuote;
      _emailBodyCredit = _$v.emailBodyCredit;
      _emailBodyPayment = _$v.emailBodyPayment;
      _emailBodyPaymentPartial = _$v.emailBodyPaymentPartial;
      _emailSubjectReminder1 = _$v.emailSubjectReminder1;
      _emailSubjectReminder2 = _$v.emailSubjectReminder2;
      _emailSubjectReminder3 = _$v.emailSubjectReminder3;
      _emailBodyReminder1 = _$v.emailBodyReminder1;
      _emailBodyReminder2 = _$v.emailBodyReminder2;
      _emailBodyReminder3 = _$v.emailBodyReminder3;
      _emailSubjectCustom1 = _$v.emailSubjectCustom1;
      _emailBodyCustom1 = _$v.emailBodyCustom1;
      _emailSubjectCustom2 = _$v.emailSubjectCustom2;
      _emailBodyCustom2 = _$v.emailBodyCustom2;
      _emailSubjectCustom3 = _$v.emailSubjectCustom3;
      _emailBodyCustom3 = _$v.emailBodyCustom3;
      _emailSubjectStatement = _$v.emailSubjectStatement;
      _emailBodyStatement = _$v.emailBodyStatement;
      _enablePortalPassword = _$v.enablePortalPassword;
      _signatureOnPdf = _$v.signatureOnPdf;
      _enableEmailMarkup = _$v.enableEmailMarkup;
      _showAcceptInvoiceTerms = _$v.showAcceptInvoiceTerms;
      _showAcceptQuoteTerms = _$v.showAcceptQuoteTerms;
      _requireInvoiceSignature = _$v.requireInvoiceSignature;
      _requireQuoteSignature = _$v.requireQuoteSignature;
      _name = _$v.name;
      _companyLogo = _$v.companyLogo;
      _website = _$v.website;
      _address1 = _$v.address1;
      _address2 = _$v.address2;
      _city = _$v.city;
      _state = _$v.state;
      _postalCode = _$v.postalCode;
      _phone = _$v.phone;
      _email = _$v.email;
      _countryId = _$v.countryId;
      _vatNumber = _$v.vatNumber;
      _idNumber = _$v.idNumber;
      _pageSize = _$v.pageSize;
      _fontSize = _$v.fontSize;
      _primaryColor = _$v.primaryColor;
      _secondaryColor = _$v.secondaryColor;
      _primaryFont = _$v.primaryFont;
      _secondaryFont = _$v.secondaryFont;
      _hidePaidToDate = _$v.hidePaidToDate;
      _embedDocuments = _$v.embedDocuments;
      _allPagesHeader = _$v.allPagesHeader;
      _allPagesFooter = _$v.allPagesFooter;
      _enableReminder1 = _$v.enableReminder1;
      _enableReminder2 = _$v.enableReminder2;
      _enableReminder3 = _$v.enableReminder3;
      _enableReminderEndless = _$v.enableReminderEndless;
      _numDaysReminder1 = _$v.numDaysReminder1;
      _numDaysReminder2 = _$v.numDaysReminder2;
      _numDaysReminder3 = _$v.numDaysReminder3;
      _scheduleReminder1 = _$v.scheduleReminder1;
      _scheduleReminder2 = _$v.scheduleReminder2;
      _scheduleReminder3 = _$v.scheduleReminder3;
      _endlessReminderFrequencyId = _$v.endlessReminderFrequencyId;
      _lateFeeAmount1 = _$v.lateFeeAmount1;
      _lateFeeAmount2 = _$v.lateFeeAmount2;
      _lateFeeAmount3 = _$v.lateFeeAmount3;
      _lateFeeAmountEndless = _$v.lateFeeAmountEndless;
      _lateFeePercent1 = _$v.lateFeePercent1;
      _lateFeePercent2 = _$v.lateFeePercent2;
      _lateFeePercent3 = _$v.lateFeePercent3;
      _lateFeePercentEndless = _$v.lateFeePercentEndless;
      _emailSubjectReminderEndless = _$v.emailSubjectReminderEndless;
      _emailBodyReminderEndless = _$v.emailBodyReminderEndless;
      _clientOnlinePaymentNotification = _$v.clientOnlinePaymentNotification;
      _clientManualPaymentNotification = _$v.clientManualPaymentNotification;
      _counterNumberApplied = _$v.counterNumberApplied;
      _emailSendingMethod = _$v.emailSendingMethod;
      _gmailSendingUserId = _$v.gmailSendingUserId;
      _clientPortalTerms = _$v.clientPortalTerms;
      _clientPortalPrivacy = _$v.clientPortalPrivacy;
      _lockInvoices = _$v.lockInvoices;
      _autoBill = _$v.autoBill;
      _clientPortalAllowUnderPayment = _$v.clientPortalAllowUnderPayment;
      _clientPortalAllowOverPayment = _$v.clientPortalAllowOverPayment;
      _autoBillDate = _$v.autoBillDate;
      _clientPortalUnderPaymentMinimum = _$v.clientPortalUnderPaymentMinimum;
      _useCreditsPayment = _$v.useCreditsPayment;
      _clientPortalCustomHeader = _$v.clientPortalCustomHeader;
      _clientPortalCustomCss = _$v.clientPortalCustomCss;
      _clientPortalCustomFooter = _$v.clientPortalCustomFooter;
      _clientPortalCustomJs = _$v.clientPortalCustomJs;
      _hideEmptyColumnsOnPdf = _$v.hideEmptyColumnsOnPdf;
      _hasCustomDesign1 = _$v.hasCustomDesign1;
      _hasCustomDesign2 = _$v.hasCustomDesign2;
      _hasCustomDesign3 = _$v.hasCustomDesign3;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SettingsEntity;
  }

  @override
  void update(void Function(SettingsEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsEntity build() {
    _$SettingsEntity _$result;
    try {
      _$result = _$v ??
          new _$SettingsEntity._(
              timezoneId: timezoneId,
              dateFormatId: dateFormatId,
              enableMilitaryTime: enableMilitaryTime,
              languageId: languageId,
              showCurrencyCode: showCurrencyCode,
              currencyId: currencyId,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              defaultPaymentTerms: defaultPaymentTerms,
              companyGatewayIds: companyGatewayIds,
              defaultTaskRate: defaultTaskRate,
              sendReminders: sendReminders,
              enablePortal: enablePortal,
              enablePortalDashboard: enablePortalDashboard,
              enablePortalTasks: enablePortalTasks,
              enablePortalUploads: enablePortalUploads,
              emailStyle: emailStyle,
              replyToEmail: replyToEmail,
              replyToName: replyToName,
              bccEmail: bccEmail,
              pdfEmailAttachment: pdfEmailAttachment,
              ublEmailAttachment: ublEmailAttachment,
              documentEmailAttachment: documentEmailAttachment,
              emailStyleCustom: emailStyleCustom,
              customMessageDashboard: customMessageDashboard,
              customMessageUnpaidInvoice: customMessageUnpaidInvoice,
              customMessagePaidInvoice: customMessagePaidInvoice,
              customMessageUnapprovedQuote: customMessageUnapprovedQuote,
              autoArchiveInvoice: autoArchiveInvoice,
              autoArchiveQuote: autoArchiveQuote,
              autoEmailInvoice: autoEmailInvoice,
              autoConvertQuote: autoConvertQuote,
              enableInclusiveTaxes: enableInclusiveTaxes,
              translations: _translations?.build(),
              taskNumberPattern: taskNumberPattern,
              taskNumberCounter: taskNumberCounter,
              expenseNumberPattern: expenseNumberPattern,
              expenseNumberCounter: expenseNumberCounter,
              vendorNumberPattern: vendorNumberPattern,
              vendorNumberCounter: vendorNumberCounter,
              ticketNumberPattern: ticketNumberPattern,
              ticketNumberCounter: ticketNumberCounter,
              paymentNumberPattern: paymentNumberPattern,
              paymentNumberCounter: paymentNumberCounter,
              projectNumberPattern: projectNumberPattern,
              projectNumberCounter: projectNumberCounter,
              invoiceNumberPattern: invoiceNumberPattern,
              invoiceNumberCounter: invoiceNumberCounter,
              recurringInvoiceNumberPattern: recurringInvoiceNumberPattern,
              recurringInvoiceNumberCounter: recurringInvoiceNumberCounter,
              quoteNumberPattern: quoteNumberPattern,
              quoteNumberCounter: quoteNumberCounter,
              clientNumberPattern: clientNumberPattern,
              clientNumberCounter: clientNumberCounter,
              creditNumberPattern: creditNumberPattern,
              creditNumberCounter: creditNumberCounter,
              recurringNumberPrefix: recurringNumberPrefix,
              resetCounterFrequencyId: resetCounterFrequencyId,
              resetCounterDate: resetCounterDate,
              counterPadding: counterPadding,
              sharedInvoiceQuoteCounter: sharedInvoiceQuoteCounter,
              sharedInvoiceCreditCounter: sharedInvoiceCreditCounter,
              defaultInvoiceTerms: defaultInvoiceTerms,
              defaultQuoteTerms: defaultQuoteTerms,
              defaultQuoteFooter: defaultQuoteFooter,
              defaultCreditTerms: defaultCreditTerms,
              defaultCreditFooter: defaultCreditFooter,
              defaultInvoiceDesignId: defaultInvoiceDesignId,
              defaultQuoteDesignId: defaultQuoteDesignId,
              defaultCreditDesignId: defaultCreditDesignId,
              defaultInvoiceFooter: defaultInvoiceFooter,
              defaultTaxName1: defaultTaxName1,
              defaultTaxRate1: defaultTaxRate1,
              defaultTaxName2: defaultTaxName2,
              defaultTaxRate2: defaultTaxRate2,
              defaultTaxName3: defaultTaxName3,
              defaultTaxRate3: defaultTaxRate3,
              defaultPaymentTypeId: defaultPaymentTypeId,
              pdfVariables: _pdfVariables?.build(),
              emailSignature: emailSignature,
              emailSubjectInvoice: emailSubjectInvoice,
              emailSubjectQuote: emailSubjectQuote,
              emailSubjectCredit: emailSubjectCredit,
              emailSubjectPayment: emailSubjectPayment,
              emailSubjectPaymentPartial: emailSubjectPaymentPartial,
              emailBodyInvoice: emailBodyInvoice,
              emailBodyQuote: emailBodyQuote,
              emailBodyCredit: emailBodyCredit,
              emailBodyPayment: emailBodyPayment,
              emailBodyPaymentPartial: emailBodyPaymentPartial,
              emailSubjectReminder1: emailSubjectReminder1,
              emailSubjectReminder2: emailSubjectReminder2,
              emailSubjectReminder3: emailSubjectReminder3,
              emailBodyReminder1: emailBodyReminder1,
              emailBodyReminder2: emailBodyReminder2,
              emailBodyReminder3: emailBodyReminder3,
              emailSubjectCustom1: emailSubjectCustom1,
              emailBodyCustom1: emailBodyCustom1,
              emailSubjectCustom2: emailSubjectCustom2,
              emailBodyCustom2: emailBodyCustom2,
              emailSubjectCustom3: emailSubjectCustom3,
              emailBodyCustom3: emailBodyCustom3,
              emailSubjectStatement: emailSubjectStatement,
              emailBodyStatement: emailBodyStatement,
              enablePortalPassword: enablePortalPassword,
              signatureOnPdf: signatureOnPdf,
              enableEmailMarkup: enableEmailMarkup,
              showAcceptInvoiceTerms: showAcceptInvoiceTerms,
              showAcceptQuoteTerms: showAcceptQuoteTerms,
              requireInvoiceSignature: requireInvoiceSignature,
              requireQuoteSignature: requireQuoteSignature,
              name: name,
              companyLogo: companyLogo,
              website: website,
              address1: address1,
              address2: address2,
              city: city,
              state: state,
              postalCode: postalCode,
              phone: phone,
              email: email,
              countryId: countryId,
              vatNumber: vatNumber,
              idNumber: idNumber,
              pageSize: pageSize,
              fontSize: fontSize,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              primaryFont: primaryFont,
              secondaryFont: secondaryFont,
              hidePaidToDate: hidePaidToDate,
              embedDocuments: embedDocuments,
              allPagesHeader: allPagesHeader,
              allPagesFooter: allPagesFooter,
              enableReminder1: enableReminder1,
              enableReminder2: enableReminder2,
              enableReminder3: enableReminder3,
              enableReminderEndless: enableReminderEndless,
              numDaysReminder1: numDaysReminder1,
              numDaysReminder2: numDaysReminder2,
              numDaysReminder3: numDaysReminder3,
              scheduleReminder1: scheduleReminder1,
              scheduleReminder2: scheduleReminder2,
              scheduleReminder3: scheduleReminder3,
              endlessReminderFrequencyId: endlessReminderFrequencyId,
              lateFeeAmount1: lateFeeAmount1,
              lateFeeAmount2: lateFeeAmount2,
              lateFeeAmount3: lateFeeAmount3,
              lateFeeAmountEndless: lateFeeAmountEndless,
              lateFeePercent1: lateFeePercent1,
              lateFeePercent2: lateFeePercent2,
              lateFeePercent3: lateFeePercent3,
              lateFeePercentEndless: lateFeePercentEndless,
              emailSubjectReminderEndless: emailSubjectReminderEndless,
              emailBodyReminderEndless: emailBodyReminderEndless,
              clientOnlinePaymentNotification: clientOnlinePaymentNotification,
              clientManualPaymentNotification: clientManualPaymentNotification,
              counterNumberApplied: counterNumberApplied,
              emailSendingMethod: emailSendingMethod,
              gmailSendingUserId: gmailSendingUserId,
              clientPortalTerms: clientPortalTerms,
              clientPortalPrivacy: clientPortalPrivacy,
              lockInvoices: lockInvoices,
              autoBill: autoBill,
              clientPortalAllowUnderPayment: clientPortalAllowUnderPayment,
              clientPortalAllowOverPayment: clientPortalAllowOverPayment,
              autoBillDate: autoBillDate,
              clientPortalUnderPaymentMinimum: clientPortalUnderPaymentMinimum,
              useCreditsPayment: useCreditsPayment,
              clientPortalCustomHeader: clientPortalCustomHeader,
              clientPortalCustomCss: clientPortalCustomCss,
              clientPortalCustomFooter: clientPortalCustomFooter,
              clientPortalCustomJs: clientPortalCustomJs,
              hideEmptyColumnsOnPdf: hideEmptyColumnsOnPdf,
              hasCustomDesign1: hasCustomDesign1,
              hasCustomDesign2: hasCustomDesign2,
              hasCustomDesign3: hasCustomDesign3);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'translations';
        _translations?.build();

        _$failedField = 'pdfVariables';
        _pdfVariables?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SettingsEntity', _$failedField, e.toString());
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
    if (data == null) {
      throw new BuiltValueNullFieldError('CompanyItemResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
