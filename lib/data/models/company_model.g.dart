// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompanyEntity> _$companyEntitySerializer =
    new _$CompanyEntitySerializer();
Serializer<PaymentTermEntity> _$paymentTermEntitySerializer =
    new _$PaymentTermEntitySerializer();
Serializer<GatewayEntity> _$gatewayEntitySerializer =
    new _$GatewayEntitySerializer();
Serializer<UserEntity> _$userEntitySerializer = new _$UserEntitySerializer();
Serializer<UserCompanyEntity> _$userCompanyEntitySerializer =
    new _$UserCompanyEntitySerializer();
Serializer<TokenEntity> _$tokenEntitySerializer = new _$TokenEntitySerializer();
Serializer<SettingsEntity> _$settingsEntitySerializer =
    new _$SettingsEntitySerializer();
Serializer<UserItemResponse> _$userItemResponseSerializer =
    new _$UserItemResponseSerializer();
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
      'company_key',
      serializers.serialize(object.companyKey,
          specifiedType: const FullType(String)),
      'groups',
      serializers.serialize(object.groups,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GroupEntity)])),
      'taskStatusMap',
      serializers.serialize(object.taskStatusMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(TaskStatusEntity)
          ])),
      'custom_fields',
      serializers.serialize(object.customFields,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(SettingsEntity)),
    ];
    if (object.enableCustomSurchargeTaxes1 != null) {
      result
        ..add('custom_invoice_taxes1')
        ..add(serializers.serialize(object.enableCustomSurchargeTaxes1,
            specifiedType: const FullType(bool)));
    }
    if (object.enableCustomSurchargeTaxes2 != null) {
      result
        ..add('custom_invoice_taxes2')
        ..add(serializers.serialize(object.enableCustomSurchargeTaxes2,
            specifiedType: const FullType(bool)));
    }
    if (object.enableCustomSurchargeTaxes3 != null) {
      result
        ..add('custom_invoice_taxes3')
        ..add(serializers.serialize(object.enableCustomSurchargeTaxes3,
            specifiedType: const FullType(bool)));
    }
    if (object.enableCustomSurchargeTaxes4 != null) {
      result
        ..add('custom_invoice_taxes4')
        ..add(serializers.serialize(object.enableCustomSurchargeTaxes4,
            specifiedType: const FullType(bool)));
    }
    if (object.sizeId != null) {
      result
        ..add('size_id')
        ..add(serializers.serialize(object.sizeId,
            specifiedType: const FullType(String)));
    }
    if (object.industryId != null) {
      result
        ..add('industry_id')
        ..add(serializers.serialize(object.industryId,
            specifiedType: const FullType(String)));
    }
    if (object.portalMode != null) {
      result
        ..add('portal_mode')
        ..add(serializers.serialize(object.portalMode,
            specifiedType: const FullType(String)));
    }
    if (object.updateProducts != null) {
      result
        ..add('update_products')
        ..add(serializers.serialize(object.updateProducts,
            specifiedType: const FullType(bool)));
    }
    if (object.convertProductExchangeRate != null) {
      result
        ..add('convert_products')
        ..add(serializers.serialize(object.convertProductExchangeRate,
            specifiedType: const FullType(bool)));
    }
    if (object.fillProducts != null) {
      result
        ..add('fill_products')
        ..add(serializers.serialize(object.fillProducts,
            specifiedType: const FullType(bool)));
    }
    if (object.plan != null) {
      result
        ..add('plan')
        ..add(serializers.serialize(object.plan,
            specifiedType: const FullType(String)));
    }
    if (object.appUrl != null) {
      result
        ..add('default_url')
        ..add(serializers.serialize(object.appUrl,
            specifiedType: const FullType(String)));
    }
    if (object.startOfWeek != null) {
      result
        ..add('start_of_week')
        ..add(serializers.serialize(object.startOfWeek,
            specifiedType: const FullType(int)));
    }
    if (object.financialYearStart != null) {
      result
        ..add('financial_year_start')
        ..add(serializers.serialize(object.financialYearStart,
            specifiedType: const FullType(int)));
    }
    if (object.taxRates != null) {
      result
        ..add('tax_rates')
        ..add(serializers.serialize(object.taxRates,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TaxRateEntity)])));
    }
    if (object.taskStatuses != null) {
      result
        ..add('task_statuses')
        ..add(serializers.serialize(object.taskStatuses,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TaskStatusEntity)])));
    }
    if (object.companyGateways != null) {
      result
        ..add('company_gateways')
        ..add(serializers.serialize(object.companyGateways,
            specifiedType: const FullType(
                BuiltList, const [const FullType(CompanyGatewayEntity)])));
    }
    if (object.expenseCategories != null) {
      result
        ..add('expense_categories')
        ..add(serializers.serialize(object.expenseCategories,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ExpenseCategoryEntity)])));
    }
    if (object.expenseCategoryMap != null) {
      result
        ..add('expenseCategoryMap')
        ..add(serializers.serialize(object.expenseCategoryMap,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(ExpenseCategoryEntity)
            ])));
    }
    if (object.users != null) {
      result
        ..add('users')
        ..add(serializers.serialize(object.users,
            specifiedType:
                const FullType(BuiltList, const [const FullType(UserEntity)])));
    }
    if (object.userMap != null) {
      result
        ..add('userMap')
        ..add(serializers.serialize(object.userMap,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(UserEntity)])));
    }
    if (object.enabledModules != null) {
      result
        ..add('enabled_modules')
        ..add(serializers.serialize(object.enabledModules,
            specifiedType: const FullType(int)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.isOwner != null) {
      result
        ..add('is_owner')
        ..add(serializers.serialize(object.isOwner,
            specifiedType: const FullType(bool)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
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
        case 'custom_invoice_taxes1':
          result.enableCustomSurchargeTaxes1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_invoice_taxes2':
          result.enableCustomSurchargeTaxes2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_invoice_taxes3':
          result.enableCustomSurchargeTaxes3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_invoice_taxes4':
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
        case 'portal_mode':
          result.portalMode = serializers.deserialize(value,
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
        case 'plan':
          result.plan = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_key':
          result.companyKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'default_url':
          result.appUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'start_of_week':
          result.startOfWeek = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'financial_year_start':
          result.financialYearStart = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'groups':
          result.groups.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GroupEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'tax_rates':
          result.taxRates.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaxRateEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'task_statuses':
          result.taskStatuses.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaskStatusEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'taskStatusMap':
          result.taskStatusMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TaskStatusEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'company_gateways':
          result.companyGateways.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CompanyGatewayEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'expense_categories':
          result.expenseCategories.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseCategoryEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'expenseCategoryMap':
          result.expenseCategoryMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(ExpenseCategoryEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(UserEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'userMap':
          result.userMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(UserEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'custom_fields':
          result.customFields.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(String)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
              specifiedType: const FullType(SettingsEntity)) as SettingsEntity);
          break;
        case 'enabled_modules':
          result.enabledModules = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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

class _$PaymentTermEntitySerializer
    implements StructuredSerializer<PaymentTermEntity> {
  @override
  final Iterable<Type> types = const [PaymentTermEntity, _$PaymentTermEntity];
  @override
  final String wireName = 'PaymentTermEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentTermEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.numDays != null) {
      result
        ..add('num_days')
        ..add(serializers.serialize(object.numDays,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PaymentTermEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTermEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'num_days':
          result.numDays = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'sort_order',
      serializers.serialize(object.sortOrder,
          specifiedType: const FullType(int)),
      'fields',
      serializers.serialize(object.fields,
          specifiedType: const FullType(String)),
    ];
    if (object.id != null) {
      result
        ..add('key')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
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
        case 'sort_order':
          result.sortOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$UserEntitySerializer implements StructuredSerializer<UserEntity> {
  @override
  final Iterable<Type> types = const [UserEntity, _$UserEntity];
  @override
  final String wireName = 'UserEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, UserEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'first_name',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'last_name',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  UserEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
      'is_owner',
      serializers.serialize(object.isOwner,
          specifiedType: const FullType(bool)),
      'is_admin',
      serializers.serialize(object.isAdmin,
          specifiedType: const FullType(bool)),
      'company',
      serializers.serialize(object.company,
          specifiedType: const FullType(CompanyEntity)),
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(UserEntity)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(TokenEntity)),
      'permissions_HIDDEN',
      serializers.serialize(object.permissionsMap,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(String), const FullType(bool)])),
    ];

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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_admin':
          result.isAdmin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'permissions_HIDDEN':
          result.permissionsMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(bool)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$TokenEntitySerializer implements StructuredSerializer<TokenEntity> {
  @override
  final Iterable<Type> types = const [TokenEntity, _$TokenEntity];
  @override
  final String wireName = 'TokenEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, TokenEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TokenEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
            specifiedType: const FullType(int)));
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
    if (object.showTasksInPortal != null) {
      result
        ..add('show_tasks_in_portal')
        ..add(serializers.serialize(object.showTasksInPortal,
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
    if (object.lockSentInvoices != null) {
      result
        ..add('lock_sent_invoices')
        ..add(serializers.serialize(object.lockSentInvoices,
            specifiedType: const FullType(bool)));
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
    if (object.autoConvertInvoice != null) {
      result
        ..add('auto_convert_quote')
        ..add(serializers.serialize(object.autoConvertInvoice,
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
    if (object.recurringInvoiceNumberPrefix != null) {
      result
        ..add('recurring_invoice_number_prefix')
        ..add(serializers.serialize(object.recurringInvoiceNumberPrefix,
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
    if (object.enableInvoiceTaxes != null) {
      result
        ..add('invoice_taxes')
        ..add(serializers.serialize(object.enableInvoiceTaxes,
            specifiedType: const FullType(bool)));
    }
    if (object.enableInvoiceItemTaxes != null) {
      result
        ..add('invoice_item_taxes')
        ..add(serializers.serialize(object.enableInvoiceItemTaxes,
            specifiedType: const FullType(bool)));
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
    if (object.defaultInvoiceFooter != null) {
      result
        ..add('invoice_footer')
        ..add(serializers.serialize(object.defaultInvoiceFooter,
            specifiedType: const FullType(String)));
    }
    if (object.invoiceLabels != null) {
      result
        ..add('invoice_labels')
        ..add(serializers.serialize(object.invoiceLabels,
            specifiedType: const FullType(String)));
    }
    if (object.showInvoiceItemTaxes != null) {
      result
        ..add('show_item_taxes')
        ..add(serializers.serialize(object.showInvoiceItemTaxes,
            specifiedType: const FullType(bool)));
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
    if (object.enableSecondTaxRate != null) {
      result
        ..add('enable_second_tax_rate')
        ..add(serializers.serialize(object.enableSecondTaxRate,
            specifiedType: const FullType(bool)));
    }
    if (object.invoiceFields != null) {
      result
        ..add('invoice_fields')
        ..add(serializers.serialize(object.invoiceFields,
            specifiedType: const FullType(String)));
    }
    if (object.emailFooter != null) {
      result
        ..add('email_footer')
        ..add(serializers.serialize(object.emailFooter,
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
    if (object.emailSubjectPayment != null) {
      result
        ..add('email_subject_payment')
        ..add(serializers.serialize(object.emailSubjectPayment,
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
    if (object.emailBodyPayment != null) {
      result
        ..add('email_template_payment')
        ..add(serializers.serialize(object.emailBodyPayment,
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
    if (object.enablePortalPassword != null) {
      result
        ..add('enable_portal_password')
        ..add(serializers.serialize(object.enablePortalPassword,
            specifiedType: const FullType(bool)));
    }
    if (object.sendPortalPassword != null) {
      result
        ..add('send_portal_password')
        ..add(serializers.serialize(object.sendPortalPassword,
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
    if (object.customPaymentTerms != null) {
      result
        ..add('custom_payment_terms')
        ..add(serializers.serialize(object.customPaymentTerms,
            specifiedType: const FullType(
                BuiltList, const [const FullType(PaymentTermEntity)])));
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
              specifiedType: const FullType(int)) as int;
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
        case 'show_tasks_in_portal':
          result.showTasksInPortal = serializers.deserialize(value,
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
        case 'lock_sent_invoices':
          result.lockSentInvoices = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
          result.autoConvertInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'inclusive_taxes':
          result.enableInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'translations':
          result.translations.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(String)
              ])) as BuiltMap<dynamic, dynamic>);
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
        case 'invoice_number_pattern':
          result.invoiceNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_number_counter':
          result.invoiceNumberCounter = serializers.deserialize(value,
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
        case 'recurring_invoice_number_prefix':
          result.recurringInvoiceNumberPrefix = serializers.deserialize(value,
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
        case 'invoice_terms':
          result.defaultInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_terms':
          result.defaultQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_taxes':
          result.enableInvoiceTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_item_taxes':
          result.enableInvoiceItemTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_design_id':
          result.defaultInvoiceDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_design_id':
          result.defaultQuoteDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_footer':
          result.defaultInvoiceFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_labels':
          result.invoiceLabels = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'show_item_taxes':
          result.showInvoiceItemTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'enable_second_tax_rate':
          result.enableSecondTaxRate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_fields':
          result.invoiceFields = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_footer':
          result.emailFooter = serializers.deserialize(value,
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
        case 'email_subject_payment':
          result.emailSubjectPayment = serializers.deserialize(value,
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
        case 'email_template_payment':
          result.emailBodyPayment = serializers.deserialize(value,
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
        case 'enable_portal_password':
          result.enablePortalPassword = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'send_portal_password':
          result.sendPortalPassword = serializers.deserialize(value,
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
        case 'custom_payment_terms':
          result.customPaymentTerms.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTermEntity)]))
              as BuiltList<dynamic>);
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

class _$UserItemResponseSerializer
    implements StructuredSerializer<UserItemResponse> {
  @override
  final Iterable<Type> types = const [UserItemResponse, _$UserItemResponse];
  @override
  final String wireName = 'UserItemResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, UserItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(UserEntity)),
    ];

    return result;
  }

  @override
  UserItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity)) as UserEntity);
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
  final String portalMode;
  @override
  final bool updateProducts;
  @override
  final bool convertProductExchangeRate;
  @override
  final bool fillProducts;
  @override
  final String plan;
  @override
  final String companyKey;
  @override
  final String appUrl;
  @override
  final int startOfWeek;
  @override
  final int financialYearStart;
  @override
  final BuiltList<GroupEntity> groups;
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
  final BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap;
  @override
  final BuiltList<UserEntity> users;
  @override
  final BuiltMap<String, UserEntity> userMap;
  @override
  final BuiltMap<String, String> customFields;
  @override
  final SettingsEntity settings;
  @override
  final int enabledModules;
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
  final bool isOwner;
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
      this.portalMode,
      this.updateProducts,
      this.convertProductExchangeRate,
      this.fillProducts,
      this.plan,
      this.companyKey,
      this.appUrl,
      this.startOfWeek,
      this.financialYearStart,
      this.groups,
      this.taxRates,
      this.taskStatuses,
      this.taskStatusMap,
      this.companyGateways,
      this.expenseCategories,
      this.expenseCategoryMap,
      this.users,
      this.userMap,
      this.customFields,
      this.settings,
      this.enabledModules,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (companyKey == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'companyKey');
    }
    if (groups == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'groups');
    }
    if (taskStatusMap == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'taskStatusMap');
    }
    if (customFields == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'customFields');
    }
    if (settings == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'settings');
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
        portalMode == other.portalMode &&
        updateProducts == other.updateProducts &&
        convertProductExchangeRate == other.convertProductExchangeRate &&
        fillProducts == other.fillProducts &&
        plan == other.plan &&
        companyKey == other.companyKey &&
        appUrl == other.appUrl &&
        startOfWeek == other.startOfWeek &&
        financialYearStart == other.financialYearStart &&
        groups == other.groups &&
        taxRates == other.taxRates &&
        taskStatuses == other.taskStatuses &&
        taskStatusMap == other.taskStatusMap &&
        companyGateways == other.companyGateways &&
        expenseCategories == other.expenseCategories &&
        expenseCategoryMap == other.expenseCategoryMap &&
        users == other.users &&
        userMap == other.userMap &&
        customFields == other.customFields &&
        settings == other.settings &&
        enabledModules == other.enabledModules &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        isOwner == other.isOwner &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, enableCustomSurchargeTaxes1.hashCode), enableCustomSurchargeTaxes2.hashCode), enableCustomSurchargeTaxes3.hashCode), enableCustomSurchargeTaxes4.hashCode), sizeId.hashCode), industryId.hashCode), portalMode.hashCode), updateProducts.hashCode), convertProductExchangeRate.hashCode), fillProducts.hashCode), plan.hashCode), companyKey.hashCode), appUrl.hashCode), startOfWeek.hashCode), financialYearStart.hashCode),
                                                                                groups.hashCode),
                                                                            taxRates.hashCode),
                                                                        taskStatuses.hashCode),
                                                                    taskStatusMap.hashCode),
                                                                companyGateways.hashCode),
                                                            expenseCategories.hashCode),
                                                        expenseCategoryMap.hashCode),
                                                    users.hashCode),
                                                userMap.hashCode),
                                            customFields.hashCode),
                                        settings.hashCode),
                                    enabledModules.hashCode),
                                isChanged.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
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
          ..add('portalMode', portalMode)
          ..add('updateProducts', updateProducts)
          ..add('convertProductExchangeRate', convertProductExchangeRate)
          ..add('fillProducts', fillProducts)
          ..add('plan', plan)
          ..add('companyKey', companyKey)
          ..add('appUrl', appUrl)
          ..add('startOfWeek', startOfWeek)
          ..add('financialYearStart', financialYearStart)
          ..add('groups', groups)
          ..add('taxRates', taxRates)
          ..add('taskStatuses', taskStatuses)
          ..add('taskStatusMap', taskStatusMap)
          ..add('companyGateways', companyGateways)
          ..add('expenseCategories', expenseCategories)
          ..add('expenseCategoryMap', expenseCategoryMap)
          ..add('users', users)
          ..add('userMap', userMap)
          ..add('customFields', customFields)
          ..add('settings', settings)
          ..add('enabledModules', enabledModules)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
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

  String _portalMode;
  String get portalMode => _$this._portalMode;
  set portalMode(String portalMode) => _$this._portalMode = portalMode;

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

  String _plan;
  String get plan => _$this._plan;
  set plan(String plan) => _$this._plan = plan;

  String _companyKey;
  String get companyKey => _$this._companyKey;
  set companyKey(String companyKey) => _$this._companyKey = companyKey;

  String _appUrl;
  String get appUrl => _$this._appUrl;
  set appUrl(String appUrl) => _$this._appUrl = appUrl;

  int _startOfWeek;
  int get startOfWeek => _$this._startOfWeek;
  set startOfWeek(int startOfWeek) => _$this._startOfWeek = startOfWeek;

  int _financialYearStart;
  int get financialYearStart => _$this._financialYearStart;
  set financialYearStart(int financialYearStart) =>
      _$this._financialYearStart = financialYearStart;

  ListBuilder<GroupEntity> _groups;
  ListBuilder<GroupEntity> get groups =>
      _$this._groups ??= new ListBuilder<GroupEntity>();
  set groups(ListBuilder<GroupEntity> groups) => _$this._groups = groups;

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

  MapBuilder<String, ExpenseCategoryEntity> _expenseCategoryMap;
  MapBuilder<String, ExpenseCategoryEntity> get expenseCategoryMap =>
      _$this._expenseCategoryMap ??=
          new MapBuilder<String, ExpenseCategoryEntity>();
  set expenseCategoryMap(
          MapBuilder<String, ExpenseCategoryEntity> expenseCategoryMap) =>
      _$this._expenseCategoryMap = expenseCategoryMap;

  ListBuilder<UserEntity> _users;
  ListBuilder<UserEntity> get users =>
      _$this._users ??= new ListBuilder<UserEntity>();
  set users(ListBuilder<UserEntity> users) => _$this._users = users;

  MapBuilder<String, UserEntity> _userMap;
  MapBuilder<String, UserEntity> get userMap =>
      _$this._userMap ??= new MapBuilder<String, UserEntity>();
  set userMap(MapBuilder<String, UserEntity> userMap) =>
      _$this._userMap = userMap;

  MapBuilder<String, String> _customFields;
  MapBuilder<String, String> get customFields =>
      _$this._customFields ??= new MapBuilder<String, String>();
  set customFields(MapBuilder<String, String> customFields) =>
      _$this._customFields = customFields;

  SettingsEntityBuilder _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder settings) => _$this._settings = settings;

  int _enabledModules;
  int get enabledModules => _$this._enabledModules;
  set enabledModules(int enabledModules) =>
      _$this._enabledModules = enabledModules;

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

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  CompanyEntityBuilder();

  CompanyEntityBuilder get _$this {
    if (_$v != null) {
      _enableCustomSurchargeTaxes1 = _$v.enableCustomSurchargeTaxes1;
      _enableCustomSurchargeTaxes2 = _$v.enableCustomSurchargeTaxes2;
      _enableCustomSurchargeTaxes3 = _$v.enableCustomSurchargeTaxes3;
      _enableCustomSurchargeTaxes4 = _$v.enableCustomSurchargeTaxes4;
      _sizeId = _$v.sizeId;
      _industryId = _$v.industryId;
      _portalMode = _$v.portalMode;
      _updateProducts = _$v.updateProducts;
      _convertProductExchangeRate = _$v.convertProductExchangeRate;
      _fillProducts = _$v.fillProducts;
      _plan = _$v.plan;
      _companyKey = _$v.companyKey;
      _appUrl = _$v.appUrl;
      _startOfWeek = _$v.startOfWeek;
      _financialYearStart = _$v.financialYearStart;
      _groups = _$v.groups?.toBuilder();
      _taxRates = _$v.taxRates?.toBuilder();
      _taskStatuses = _$v.taskStatuses?.toBuilder();
      _taskStatusMap = _$v.taskStatusMap?.toBuilder();
      _companyGateways = _$v.companyGateways?.toBuilder();
      _expenseCategories = _$v.expenseCategories?.toBuilder();
      _expenseCategoryMap = _$v.expenseCategoryMap?.toBuilder();
      _users = _$v.users?.toBuilder();
      _userMap = _$v.userMap?.toBuilder();
      _customFields = _$v.customFields?.toBuilder();
      _settings = _$v.settings?.toBuilder();
      _enabledModules = _$v.enabledModules;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _isOwner = _$v.isOwner;
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
              portalMode: portalMode,
              updateProducts: updateProducts,
              convertProductExchangeRate: convertProductExchangeRate,
              fillProducts: fillProducts,
              plan: plan,
              companyKey: companyKey,
              appUrl: appUrl,
              startOfWeek: startOfWeek,
              financialYearStart: financialYearStart,
              groups: groups.build(),
              taxRates: _taxRates?.build(),
              taskStatuses: _taskStatuses?.build(),
              taskStatusMap: taskStatusMap.build(),
              companyGateways: _companyGateways?.build(),
              expenseCategories: _expenseCategories?.build(),
              expenseCategoryMap: _expenseCategoryMap?.build(),
              users: _users?.build(),
              userMap: _userMap?.build(),
              customFields: customFields.build(),
              settings: settings.build(),
              enabledModules: enabledModules,
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              isOwner: isOwner,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'groups';
        groups.build();
        _$failedField = 'taxRates';
        _taxRates?.build();
        _$failedField = 'taskStatuses';
        _taskStatuses?.build();
        _$failedField = 'taskStatusMap';
        taskStatusMap.build();
        _$failedField = 'companyGateways';
        _companyGateways?.build();
        _$failedField = 'expenseCategories';
        _expenseCategories?.build();
        _$failedField = 'expenseCategoryMap';
        _expenseCategoryMap?.build();
        _$failedField = 'users';
        _users?.build();
        _$failedField = 'userMap';
        _userMap?.build();
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

class _$PaymentTermEntity extends PaymentTermEntity {
  @override
  final int numDays;
  @override
  final int archivedAt;
  @override
  final String id;

  factory _$PaymentTermEntity(
          [void Function(PaymentTermEntityBuilder) updates]) =>
      (new PaymentTermEntityBuilder()..update(updates)).build();

  _$PaymentTermEntity._({this.numDays, this.archivedAt, this.id}) : super._();

  @override
  PaymentTermEntity rebuild(void Function(PaymentTermEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTermEntityBuilder toBuilder() =>
      new PaymentTermEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTermEntity &&
        numDays == other.numDays &&
        archivedAt == other.archivedAt &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, numDays.hashCode), archivedAt.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTermEntity')
          ..add('numDays', numDays)
          ..add('archivedAt', archivedAt)
          ..add('id', id))
        .toString();
  }
}

class PaymentTermEntityBuilder
    implements Builder<PaymentTermEntity, PaymentTermEntityBuilder> {
  _$PaymentTermEntity _$v;

  int _numDays;
  int get numDays => _$this._numDays;
  set numDays(int numDays) => _$this._numDays = numDays;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  PaymentTermEntityBuilder();

  PaymentTermEntityBuilder get _$this {
    if (_$v != null) {
      _numDays = _$v.numDays;
      _archivedAt = _$v.archivedAt;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTermEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentTermEntity;
  }

  @override
  void update(void Function(PaymentTermEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTermEntity build() {
    final _$result = _$v ??
        new _$PaymentTermEntity._(
            numDays: numDays, archivedAt: archivedAt, id: id);
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
  final int sortOrder;
  @override
  final String fields;

  factory _$GatewayEntity([void Function(GatewayEntityBuilder) updates]) =>
      (new GatewayEntityBuilder()..update(updates)).build();

  _$GatewayEntity._({this.id, this.name, this.sortOrder, this.fields})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'name');
    }
    if (sortOrder == null) {
      throw new BuiltValueNullFieldError('GatewayEntity', 'sortOrder');
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
        sortOrder == other.sortOrder &&
        fields == other.fields;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), name.hashCode), sortOrder.hashCode),
        fields.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GatewayEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('sortOrder', sortOrder)
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

  int _sortOrder;
  int get sortOrder => _$this._sortOrder;
  set sortOrder(int sortOrder) => _$this._sortOrder = sortOrder;

  String _fields;
  String get fields => _$this._fields;
  set fields(String fields) => _$this._fields = fields;

  GatewayEntityBuilder();

  GatewayEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _sortOrder = _$v.sortOrder;
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
    final _$result = _$v ??
        new _$GatewayEntity._(
            id: id, name: name, sortOrder: sortOrder, fields: fields);
    replace(_$result);
    return _$result;
  }
}

class _$UserEntity extends UserEntity {
  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phone;

  factory _$UserEntity([void Function(UserEntityBuilder) updates]) =>
      (new UserEntityBuilder()..update(updates)).build();

  _$UserEntity._(
      {this.id, this.firstName, this.lastName, this.email, this.phone})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'id');
    }
    if (firstName == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'firstName');
    }
    if (lastName == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'lastName');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'email');
    }
    if (phone == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'phone');
    }
  }

  @override
  UserEntity rebuild(void Function(UserEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEntityBuilder toBuilder() => new UserEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserEntity &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        phone == other.phone;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), firstName.hashCode),
                lastName.hashCode),
            email.hashCode),
        phone.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserEntity')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('phone', phone))
        .toString();
  }
}

class UserEntityBuilder implements Builder<UserEntity, UserEntityBuilder> {
  _$UserEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  UserEntityBuilder();

  UserEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _email = _$v.email;
      _phone = _$v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserEntity;
  }

  @override
  void update(void Function(UserEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserEntity build() {
    final _$result = _$v ??
        new _$UserEntity._(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone);
    replace(_$result);
    return _$result;
  }
}

class _$UserCompanyEntity extends UserCompanyEntity {
  @override
  final bool isOwner;
  @override
  final bool isAdmin;
  @override
  final CompanyEntity company;
  @override
  final UserEntity user;
  @override
  final TokenEntity token;
  @override
  final BuiltMap<String, bool> permissionsMap;

  factory _$UserCompanyEntity(
          [void Function(UserCompanyEntityBuilder) updates]) =>
      (new UserCompanyEntityBuilder()..update(updates)).build();

  _$UserCompanyEntity._(
      {this.isOwner,
      this.isAdmin,
      this.company,
      this.user,
      this.token,
      this.permissionsMap})
      : super._() {
    if (isOwner == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'isOwner');
    }
    if (isAdmin == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'isAdmin');
    }
    if (company == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'company');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'user');
    }
    if (token == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'token');
    }
    if (permissionsMap == null) {
      throw new BuiltValueNullFieldError('UserCompanyEntity', 'permissionsMap');
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
        isOwner == other.isOwner &&
        isAdmin == other.isAdmin &&
        company == other.company &&
        user == other.user &&
        token == other.token &&
        permissionsMap == other.permissionsMap;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, isOwner.hashCode), isAdmin.hashCode),
                    company.hashCode),
                user.hashCode),
            token.hashCode),
        permissionsMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserCompanyEntity')
          ..add('isOwner', isOwner)
          ..add('isAdmin', isAdmin)
          ..add('company', company)
          ..add('user', user)
          ..add('token', token)
          ..add('permissionsMap', permissionsMap))
        .toString();
  }
}

class UserCompanyEntityBuilder
    implements Builder<UserCompanyEntity, UserCompanyEntityBuilder> {
  _$UserCompanyEntity _$v;

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  bool _isAdmin;
  bool get isAdmin => _$this._isAdmin;
  set isAdmin(bool isAdmin) => _$this._isAdmin = isAdmin;

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

  MapBuilder<String, bool> _permissionsMap;
  MapBuilder<String, bool> get permissionsMap =>
      _$this._permissionsMap ??= new MapBuilder<String, bool>();
  set permissionsMap(MapBuilder<String, bool> permissionsMap) =>
      _$this._permissionsMap = permissionsMap;

  UserCompanyEntityBuilder();

  UserCompanyEntityBuilder get _$this {
    if (_$v != null) {
      _isOwner = _$v.isOwner;
      _isAdmin = _$v.isAdmin;
      _company = _$v.company?.toBuilder();
      _user = _$v.user?.toBuilder();
      _token = _$v.token?.toBuilder();
      _permissionsMap = _$v.permissionsMap?.toBuilder();
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
              isOwner: isOwner,
              isAdmin: isAdmin,
              company: company.build(),
              user: user.build(),
              token: token.build(),
              permissionsMap: permissionsMap.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'company';
        company.build();
        _$failedField = 'user';
        user.build();
        _$failedField = 'token';
        token.build();
        _$failedField = 'permissionsMap';
        permissionsMap.build();
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

class _$TokenEntity extends TokenEntity {
  @override
  final String token;
  @override
  final String name;

  factory _$TokenEntity([void Function(TokenEntityBuilder) updates]) =>
      (new TokenEntityBuilder()..update(updates)).build();

  _$TokenEntity._({this.token, this.name}) : super._() {
    if (token == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'token');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TokenEntity', 'name');
    }
  }

  @override
  TokenEntity rebuild(void Function(TokenEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenEntityBuilder toBuilder() => new TokenEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenEntity && token == other.token && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, token.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TokenEntity')
          ..add('token', token)
          ..add('name', name))
        .toString();
  }
}

class TokenEntityBuilder implements Builder<TokenEntity, TokenEntityBuilder> {
  _$TokenEntity _$v;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  TokenEntityBuilder();

  TokenEntityBuilder get _$this {
    if (_$v != null) {
      _token = _$v.token;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TokenEntity;
  }

  @override
  void update(void Function(TokenEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TokenEntity build() {
    final _$result = _$v ?? new _$TokenEntity._(token: token, name: name);
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
  final int defaultPaymentTerms;
  @override
  final String companyGatewayIds;
  @override
  final double defaultTaskRate;
  @override
  final bool sendReminders;
  @override
  final bool showTasksInPortal;
  @override
  final String emailStyle;
  @override
  final String replyToEmail;
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
  final bool lockSentInvoices;
  @override
  final bool autoArchiveInvoice;
  @override
  final bool autoArchiveQuote;
  @override
  final bool autoEmailInvoice;
  @override
  final bool autoConvertInvoice;
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
  final String invoiceNumberPattern;
  @override
  final int invoiceNumberCounter;
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
  final String recurringInvoiceNumberPrefix;
  @override
  final String resetCounterFrequencyId;
  @override
  final String resetCounterDate;
  @override
  final int counterPadding;
  @override
  final bool sharedInvoiceQuoteCounter;
  @override
  final String defaultInvoiceTerms;
  @override
  final String defaultQuoteTerms;
  @override
  final bool enableInvoiceTaxes;
  @override
  final bool enableInvoiceItemTaxes;
  @override
  final String defaultInvoiceDesignId;
  @override
  final String defaultQuoteDesignId;
  @override
  final String defaultInvoiceFooter;
  @override
  final String invoiceLabels;
  @override
  final bool showInvoiceItemTaxes;
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
  final bool enableSecondTaxRate;
  @override
  final String invoiceFields;
  @override
  final String emailFooter;
  @override
  final String emailSubjectInvoice;
  @override
  final String emailSubjectQuote;
  @override
  final String emailSubjectPayment;
  @override
  final String emailBodyInvoice;
  @override
  final String emailBodyQuote;
  @override
  final String emailBodyPayment;
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
  final bool enablePortalPassword;
  @override
  final bool sendPortalPassword;
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
  final BuiltList<PaymentTermEntity> customPaymentTerms;
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
      this.showTasksInPortal,
      this.emailStyle,
      this.replyToEmail,
      this.bccEmail,
      this.pdfEmailAttachment,
      this.ublEmailAttachment,
      this.documentEmailAttachment,
      this.emailStyleCustom,
      this.customMessageDashboard,
      this.customMessageUnpaidInvoice,
      this.customMessagePaidInvoice,
      this.customMessageUnapprovedQuote,
      this.lockSentInvoices,
      this.autoArchiveInvoice,
      this.autoArchiveQuote,
      this.autoEmailInvoice,
      this.autoConvertInvoice,
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
      this.invoiceNumberPattern,
      this.invoiceNumberCounter,
      this.quoteNumberPattern,
      this.quoteNumberCounter,
      this.clientNumberPattern,
      this.clientNumberCounter,
      this.creditNumberPattern,
      this.creditNumberCounter,
      this.recurringInvoiceNumberPrefix,
      this.resetCounterFrequencyId,
      this.resetCounterDate,
      this.counterPadding,
      this.sharedInvoiceQuoteCounter,
      this.defaultInvoiceTerms,
      this.defaultQuoteTerms,
      this.enableInvoiceTaxes,
      this.enableInvoiceItemTaxes,
      this.defaultInvoiceDesignId,
      this.defaultQuoteDesignId,
      this.defaultInvoiceFooter,
      this.invoiceLabels,
      this.showInvoiceItemTaxes,
      this.defaultTaxName1,
      this.defaultTaxRate1,
      this.defaultTaxName2,
      this.defaultTaxRate2,
      this.defaultTaxName3,
      this.defaultTaxRate3,
      this.defaultPaymentTypeId,
      this.enableSecondTaxRate,
      this.invoiceFields,
      this.emailFooter,
      this.emailSubjectInvoice,
      this.emailSubjectQuote,
      this.emailSubjectPayment,
      this.emailBodyInvoice,
      this.emailBodyQuote,
      this.emailBodyPayment,
      this.emailSubjectReminder1,
      this.emailSubjectReminder2,
      this.emailSubjectReminder3,
      this.emailBodyReminder1,
      this.emailBodyReminder2,
      this.emailBodyReminder3,
      this.enablePortalPassword,
      this.sendPortalPassword,
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
      this.customPaymentTerms,
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
        showTasksInPortal == other.showTasksInPortal &&
        emailStyle == other.emailStyle &&
        replyToEmail == other.replyToEmail &&
        bccEmail == other.bccEmail &&
        pdfEmailAttachment == other.pdfEmailAttachment &&
        ublEmailAttachment == other.ublEmailAttachment &&
        documentEmailAttachment == other.documentEmailAttachment &&
        emailStyleCustom == other.emailStyleCustom &&
        customMessageDashboard == other.customMessageDashboard &&
        customMessageUnpaidInvoice == other.customMessageUnpaidInvoice &&
        customMessagePaidInvoice == other.customMessagePaidInvoice &&
        customMessageUnapprovedQuote == other.customMessageUnapprovedQuote &&
        lockSentInvoices == other.lockSentInvoices &&
        autoArchiveInvoice == other.autoArchiveInvoice &&
        autoArchiveQuote == other.autoArchiveQuote &&
        autoEmailInvoice == other.autoEmailInvoice &&
        autoConvertInvoice == other.autoConvertInvoice &&
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
        invoiceNumberPattern == other.invoiceNumberPattern &&
        invoiceNumberCounter == other.invoiceNumberCounter &&
        quoteNumberPattern == other.quoteNumberPattern &&
        quoteNumberCounter == other.quoteNumberCounter &&
        clientNumberPattern == other.clientNumberPattern &&
        clientNumberCounter == other.clientNumberCounter &&
        creditNumberPattern == other.creditNumberPattern &&
        creditNumberCounter == other.creditNumberCounter &&
        recurringInvoiceNumberPrefix == other.recurringInvoiceNumberPrefix &&
        resetCounterFrequencyId == other.resetCounterFrequencyId &&
        resetCounterDate == other.resetCounterDate &&
        counterPadding == other.counterPadding &&
        sharedInvoiceQuoteCounter == other.sharedInvoiceQuoteCounter &&
        defaultInvoiceTerms == other.defaultInvoiceTerms &&
        defaultQuoteTerms == other.defaultQuoteTerms &&
        enableInvoiceTaxes == other.enableInvoiceTaxes &&
        enableInvoiceItemTaxes == other.enableInvoiceItemTaxes &&
        defaultInvoiceDesignId == other.defaultInvoiceDesignId &&
        defaultQuoteDesignId == other.defaultQuoteDesignId &&
        defaultInvoiceFooter == other.defaultInvoiceFooter &&
        invoiceLabels == other.invoiceLabels &&
        showInvoiceItemTaxes == other.showInvoiceItemTaxes &&
        defaultTaxName1 == other.defaultTaxName1 &&
        defaultTaxRate1 == other.defaultTaxRate1 &&
        defaultTaxName2 == other.defaultTaxName2 &&
        defaultTaxRate2 == other.defaultTaxRate2 &&
        defaultTaxName3 == other.defaultTaxName3 &&
        defaultTaxRate3 == other.defaultTaxRate3 &&
        defaultPaymentTypeId == other.defaultPaymentTypeId &&
        enableSecondTaxRate == other.enableSecondTaxRate &&
        invoiceFields == other.invoiceFields &&
        emailFooter == other.emailFooter &&
        emailSubjectInvoice == other.emailSubjectInvoice &&
        emailSubjectQuote == other.emailSubjectQuote &&
        emailSubjectPayment == other.emailSubjectPayment &&
        emailBodyInvoice == other.emailBodyInvoice &&
        emailBodyQuote == other.emailBodyQuote &&
        emailBodyPayment == other.emailBodyPayment &&
        emailSubjectReminder1 == other.emailSubjectReminder1 &&
        emailSubjectReminder2 == other.emailSubjectReminder2 &&
        emailSubjectReminder3 == other.emailSubjectReminder3 &&
        emailBodyReminder1 == other.emailBodyReminder1 &&
        emailBodyReminder2 == other.emailBodyReminder2 &&
        emailBodyReminder3 == other.emailBodyReminder3 &&
        enablePortalPassword == other.enablePortalPassword &&
        sendPortalPassword == other.sendPortalPassword &&
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
        customPaymentTerms == other.customPaymentTerms &&
        hasCustomDesign1 == other.hasCustomDesign1 &&
        hasCustomDesign2 == other.hasCustomDesign2 &&
        hasCustomDesign3 == other.hasCustomDesign3;
  }

  @override
  int get hashCode {
    return $jf($jc(
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, timezoneId.hashCode), dateFormatId.hashCode), enableMilitaryTime.hashCode), languageId.hashCode), showCurrencyCode.hashCode), currencyId.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), defaultPaymentTerms.hashCode), companyGatewayIds.hashCode), defaultTaskRate.hashCode), sendReminders.hashCode), showTasksInPortal.hashCode), emailStyle.hashCode), replyToEmail.hashCode), bccEmail.hashCode), pdfEmailAttachment.hashCode), ublEmailAttachment.hashCode), documentEmailAttachment.hashCode), emailStyleCustom.hashCode), customMessageDashboard.hashCode), customMessageUnpaidInvoice.hashCode), customMessagePaidInvoice.hashCode), customMessageUnapprovedQuote.hashCode), lockSentInvoices.hashCode), autoArchiveInvoice.hashCode), autoArchiveQuote.hashCode), autoEmailInvoice.hashCode), autoConvertInvoice.hashCode), enableInclusiveTaxes.hashCode), translations.hashCode), taskNumberPattern.hashCode), taskNumberCounter.hashCode), expenseNumberPattern.hashCode), expenseNumberCounter.hashCode), vendorNumberPattern.hashCode), vendorNumberCounter.hashCode), ticketNumberPattern.hashCode), ticketNumberCounter.hashCode), paymentNumberPattern.hashCode), paymentNumberCounter.hashCode), invoiceNumberPattern.hashCode), invoiceNumberCounter.hashCode), quoteNumberPattern.hashCode), quoteNumberCounter.hashCode), clientNumberPattern.hashCode), clientNumberCounter.hashCode), creditNumberPattern.hashCode), creditNumberCounter.hashCode), recurringInvoiceNumberPrefix.hashCode), resetCounterFrequencyId.hashCode), resetCounterDate.hashCode), counterPadding.hashCode), sharedInvoiceQuoteCounter.hashCode), defaultInvoiceTerms.hashCode), defaultQuoteTerms.hashCode), enableInvoiceTaxes.hashCode), enableInvoiceItemTaxes.hashCode), defaultInvoiceDesignId.hashCode), defaultQuoteDesignId.hashCode), defaultInvoiceFooter.hashCode), invoiceLabels.hashCode), showInvoiceItemTaxes.hashCode), defaultTaxName1.hashCode), defaultTaxRate1.hashCode), defaultTaxName2.hashCode), defaultTaxRate2.hashCode), defaultTaxName3.hashCode), defaultTaxRate3.hashCode), defaultPaymentTypeId.hashCode), enableSecondTaxRate.hashCode), invoiceFields.hashCode), emailFooter.hashCode), emailSubjectInvoice.hashCode), emailSubjectQuote.hashCode), emailSubjectPayment.hashCode), emailBodyInvoice.hashCode), emailBodyQuote.hashCode), emailBodyPayment.hashCode), emailSubjectReminder1.hashCode), emailSubjectReminder2.hashCode), emailSubjectReminder3.hashCode), emailBodyReminder1.hashCode), emailBodyReminder2.hashCode), emailBodyReminder3.hashCode), enablePortalPassword.hashCode), sendPortalPassword.hashCode), signatureOnPdf.hashCode), enableEmailMarkup.hashCode), showAcceptInvoiceTerms.hashCode), showAcceptQuoteTerms.hashCode),
                                                                                requireInvoiceSignature.hashCode),
                                                                            requireQuoteSignature.hashCode),
                                                                        name.hashCode),
                                                                    companyLogo.hashCode),
                                                                website.hashCode),
                                                            address1.hashCode),
                                                        address2.hashCode),
                                                    city.hashCode),
                                                state.hashCode),
                                            postalCode.hashCode),
                                        phone.hashCode),
                                    email.hashCode),
                                countryId.hashCode),
                            vatNumber.hashCode),
                        idNumber.hashCode),
                    customPaymentTerms.hashCode),
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
          ..add('showTasksInPortal', showTasksInPortal)
          ..add('emailStyle', emailStyle)
          ..add('replyToEmail', replyToEmail)
          ..add('bccEmail', bccEmail)
          ..add('pdfEmailAttachment', pdfEmailAttachment)
          ..add('ublEmailAttachment', ublEmailAttachment)
          ..add('documentEmailAttachment', documentEmailAttachment)
          ..add('emailStyleCustom', emailStyleCustom)
          ..add('customMessageDashboard', customMessageDashboard)
          ..add('customMessageUnpaidInvoice', customMessageUnpaidInvoice)
          ..add('customMessagePaidInvoice', customMessagePaidInvoice)
          ..add('customMessageUnapprovedQuote', customMessageUnapprovedQuote)
          ..add('lockSentInvoices', lockSentInvoices)
          ..add('autoArchiveInvoice', autoArchiveInvoice)
          ..add('autoArchiveQuote', autoArchiveQuote)
          ..add('autoEmailInvoice', autoEmailInvoice)
          ..add('autoConvertInvoice', autoConvertInvoice)
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
          ..add('invoiceNumberPattern', invoiceNumberPattern)
          ..add('invoiceNumberCounter', invoiceNumberCounter)
          ..add('quoteNumberPattern', quoteNumberPattern)
          ..add('quoteNumberCounter', quoteNumberCounter)
          ..add('clientNumberPattern', clientNumberPattern)
          ..add('clientNumberCounter', clientNumberCounter)
          ..add('creditNumberPattern', creditNumberPattern)
          ..add('creditNumberCounter', creditNumberCounter)
          ..add('recurringInvoiceNumberPrefix', recurringInvoiceNumberPrefix)
          ..add('resetCounterFrequencyId', resetCounterFrequencyId)
          ..add('resetCounterDate', resetCounterDate)
          ..add('counterPadding', counterPadding)
          ..add('sharedInvoiceQuoteCounter', sharedInvoiceQuoteCounter)
          ..add('defaultInvoiceTerms', defaultInvoiceTerms)
          ..add('defaultQuoteTerms', defaultQuoteTerms)
          ..add('enableInvoiceTaxes', enableInvoiceTaxes)
          ..add('enableInvoiceItemTaxes', enableInvoiceItemTaxes)
          ..add('defaultInvoiceDesignId', defaultInvoiceDesignId)
          ..add('defaultQuoteDesignId', defaultQuoteDesignId)
          ..add('defaultInvoiceFooter', defaultInvoiceFooter)
          ..add('invoiceLabels', invoiceLabels)
          ..add('showInvoiceItemTaxes', showInvoiceItemTaxes)
          ..add('defaultTaxName1', defaultTaxName1)
          ..add('defaultTaxRate1', defaultTaxRate1)
          ..add('defaultTaxName2', defaultTaxName2)
          ..add('defaultTaxRate2', defaultTaxRate2)
          ..add('defaultTaxName3', defaultTaxName3)
          ..add('defaultTaxRate3', defaultTaxRate3)
          ..add('defaultPaymentTypeId', defaultPaymentTypeId)
          ..add('enableSecondTaxRate', enableSecondTaxRate)
          ..add('invoiceFields', invoiceFields)
          ..add('emailFooter', emailFooter)
          ..add('emailSubjectInvoice', emailSubjectInvoice)
          ..add('emailSubjectQuote', emailSubjectQuote)
          ..add('emailSubjectPayment', emailSubjectPayment)
          ..add('emailBodyInvoice', emailBodyInvoice)
          ..add('emailBodyQuote', emailBodyQuote)
          ..add('emailBodyPayment', emailBodyPayment)
          ..add('emailSubjectReminder1', emailSubjectReminder1)
          ..add('emailSubjectReminder2', emailSubjectReminder2)
          ..add('emailSubjectReminder3', emailSubjectReminder3)
          ..add('emailBodyReminder1', emailBodyReminder1)
          ..add('emailBodyReminder2', emailBodyReminder2)
          ..add('emailBodyReminder3', emailBodyReminder3)
          ..add('enablePortalPassword', enablePortalPassword)
          ..add('sendPortalPassword', sendPortalPassword)
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
          ..add('customPaymentTerms', customPaymentTerms)
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

  int _defaultPaymentTerms;
  int get defaultPaymentTerms => _$this._defaultPaymentTerms;
  set defaultPaymentTerms(int defaultPaymentTerms) =>
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

  bool _showTasksInPortal;
  bool get showTasksInPortal => _$this._showTasksInPortal;
  set showTasksInPortal(bool showTasksInPortal) =>
      _$this._showTasksInPortal = showTasksInPortal;

  String _emailStyle;
  String get emailStyle => _$this._emailStyle;
  set emailStyle(String emailStyle) => _$this._emailStyle = emailStyle;

  String _replyToEmail;
  String get replyToEmail => _$this._replyToEmail;
  set replyToEmail(String replyToEmail) => _$this._replyToEmail = replyToEmail;

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

  bool _lockSentInvoices;
  bool get lockSentInvoices => _$this._lockSentInvoices;
  set lockSentInvoices(bool lockSentInvoices) =>
      _$this._lockSentInvoices = lockSentInvoices;

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

  bool _autoConvertInvoice;
  bool get autoConvertInvoice => _$this._autoConvertInvoice;
  set autoConvertInvoice(bool autoConvertInvoice) =>
      _$this._autoConvertInvoice = autoConvertInvoice;

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

  String _invoiceNumberPattern;
  String get invoiceNumberPattern => _$this._invoiceNumberPattern;
  set invoiceNumberPattern(String invoiceNumberPattern) =>
      _$this._invoiceNumberPattern = invoiceNumberPattern;

  int _invoiceNumberCounter;
  int get invoiceNumberCounter => _$this._invoiceNumberCounter;
  set invoiceNumberCounter(int invoiceNumberCounter) =>
      _$this._invoiceNumberCounter = invoiceNumberCounter;

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

  String _recurringInvoiceNumberPrefix;
  String get recurringInvoiceNumberPrefix =>
      _$this._recurringInvoiceNumberPrefix;
  set recurringInvoiceNumberPrefix(String recurringInvoiceNumberPrefix) =>
      _$this._recurringInvoiceNumberPrefix = recurringInvoiceNumberPrefix;

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

  String _defaultInvoiceTerms;
  String get defaultInvoiceTerms => _$this._defaultInvoiceTerms;
  set defaultInvoiceTerms(String defaultInvoiceTerms) =>
      _$this._defaultInvoiceTerms = defaultInvoiceTerms;

  String _defaultQuoteTerms;
  String get defaultQuoteTerms => _$this._defaultQuoteTerms;
  set defaultQuoteTerms(String defaultQuoteTerms) =>
      _$this._defaultQuoteTerms = defaultQuoteTerms;

  bool _enableInvoiceTaxes;
  bool get enableInvoiceTaxes => _$this._enableInvoiceTaxes;
  set enableInvoiceTaxes(bool enableInvoiceTaxes) =>
      _$this._enableInvoiceTaxes = enableInvoiceTaxes;

  bool _enableInvoiceItemTaxes;
  bool get enableInvoiceItemTaxes => _$this._enableInvoiceItemTaxes;
  set enableInvoiceItemTaxes(bool enableInvoiceItemTaxes) =>
      _$this._enableInvoiceItemTaxes = enableInvoiceItemTaxes;

  String _defaultInvoiceDesignId;
  String get defaultInvoiceDesignId => _$this._defaultInvoiceDesignId;
  set defaultInvoiceDesignId(String defaultInvoiceDesignId) =>
      _$this._defaultInvoiceDesignId = defaultInvoiceDesignId;

  String _defaultQuoteDesignId;
  String get defaultQuoteDesignId => _$this._defaultQuoteDesignId;
  set defaultQuoteDesignId(String defaultQuoteDesignId) =>
      _$this._defaultQuoteDesignId = defaultQuoteDesignId;

  String _defaultInvoiceFooter;
  String get defaultInvoiceFooter => _$this._defaultInvoiceFooter;
  set defaultInvoiceFooter(String defaultInvoiceFooter) =>
      _$this._defaultInvoiceFooter = defaultInvoiceFooter;

  String _invoiceLabels;
  String get invoiceLabels => _$this._invoiceLabels;
  set invoiceLabels(String invoiceLabels) =>
      _$this._invoiceLabels = invoiceLabels;

  bool _showInvoiceItemTaxes;
  bool get showInvoiceItemTaxes => _$this._showInvoiceItemTaxes;
  set showInvoiceItemTaxes(bool showInvoiceItemTaxes) =>
      _$this._showInvoiceItemTaxes = showInvoiceItemTaxes;

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

  bool _enableSecondTaxRate;
  bool get enableSecondTaxRate => _$this._enableSecondTaxRate;
  set enableSecondTaxRate(bool enableSecondTaxRate) =>
      _$this._enableSecondTaxRate = enableSecondTaxRate;

  String _invoiceFields;
  String get invoiceFields => _$this._invoiceFields;
  set invoiceFields(String invoiceFields) =>
      _$this._invoiceFields = invoiceFields;

  String _emailFooter;
  String get emailFooter => _$this._emailFooter;
  set emailFooter(String emailFooter) => _$this._emailFooter = emailFooter;

  String _emailSubjectInvoice;
  String get emailSubjectInvoice => _$this._emailSubjectInvoice;
  set emailSubjectInvoice(String emailSubjectInvoice) =>
      _$this._emailSubjectInvoice = emailSubjectInvoice;

  String _emailSubjectQuote;
  String get emailSubjectQuote => _$this._emailSubjectQuote;
  set emailSubjectQuote(String emailSubjectQuote) =>
      _$this._emailSubjectQuote = emailSubjectQuote;

  String _emailSubjectPayment;
  String get emailSubjectPayment => _$this._emailSubjectPayment;
  set emailSubjectPayment(String emailSubjectPayment) =>
      _$this._emailSubjectPayment = emailSubjectPayment;

  String _emailBodyInvoice;
  String get emailBodyInvoice => _$this._emailBodyInvoice;
  set emailBodyInvoice(String emailBodyInvoice) =>
      _$this._emailBodyInvoice = emailBodyInvoice;

  String _emailBodyQuote;
  String get emailBodyQuote => _$this._emailBodyQuote;
  set emailBodyQuote(String emailBodyQuote) =>
      _$this._emailBodyQuote = emailBodyQuote;

  String _emailBodyPayment;
  String get emailBodyPayment => _$this._emailBodyPayment;
  set emailBodyPayment(String emailBodyPayment) =>
      _$this._emailBodyPayment = emailBodyPayment;

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

  bool _enablePortalPassword;
  bool get enablePortalPassword => _$this._enablePortalPassword;
  set enablePortalPassword(bool enablePortalPassword) =>
      _$this._enablePortalPassword = enablePortalPassword;

  bool _sendPortalPassword;
  bool get sendPortalPassword => _$this._sendPortalPassword;
  set sendPortalPassword(bool sendPortalPassword) =>
      _$this._sendPortalPassword = sendPortalPassword;

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

  ListBuilder<PaymentTermEntity> _customPaymentTerms;
  ListBuilder<PaymentTermEntity> get customPaymentTerms =>
      _$this._customPaymentTerms ??= new ListBuilder<PaymentTermEntity>();
  set customPaymentTerms(ListBuilder<PaymentTermEntity> customPaymentTerms) =>
      _$this._customPaymentTerms = customPaymentTerms;

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
      _showTasksInPortal = _$v.showTasksInPortal;
      _emailStyle = _$v.emailStyle;
      _replyToEmail = _$v.replyToEmail;
      _bccEmail = _$v.bccEmail;
      _pdfEmailAttachment = _$v.pdfEmailAttachment;
      _ublEmailAttachment = _$v.ublEmailAttachment;
      _documentEmailAttachment = _$v.documentEmailAttachment;
      _emailStyleCustom = _$v.emailStyleCustom;
      _customMessageDashboard = _$v.customMessageDashboard;
      _customMessageUnpaidInvoice = _$v.customMessageUnpaidInvoice;
      _customMessagePaidInvoice = _$v.customMessagePaidInvoice;
      _customMessageUnapprovedQuote = _$v.customMessageUnapprovedQuote;
      _lockSentInvoices = _$v.lockSentInvoices;
      _autoArchiveInvoice = _$v.autoArchiveInvoice;
      _autoArchiveQuote = _$v.autoArchiveQuote;
      _autoEmailInvoice = _$v.autoEmailInvoice;
      _autoConvertInvoice = _$v.autoConvertInvoice;
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
      _invoiceNumberPattern = _$v.invoiceNumberPattern;
      _invoiceNumberCounter = _$v.invoiceNumberCounter;
      _quoteNumberPattern = _$v.quoteNumberPattern;
      _quoteNumberCounter = _$v.quoteNumberCounter;
      _clientNumberPattern = _$v.clientNumberPattern;
      _clientNumberCounter = _$v.clientNumberCounter;
      _creditNumberPattern = _$v.creditNumberPattern;
      _creditNumberCounter = _$v.creditNumberCounter;
      _recurringInvoiceNumberPrefix = _$v.recurringInvoiceNumberPrefix;
      _resetCounterFrequencyId = _$v.resetCounterFrequencyId;
      _resetCounterDate = _$v.resetCounterDate;
      _counterPadding = _$v.counterPadding;
      _sharedInvoiceQuoteCounter = _$v.sharedInvoiceQuoteCounter;
      _defaultInvoiceTerms = _$v.defaultInvoiceTerms;
      _defaultQuoteTerms = _$v.defaultQuoteTerms;
      _enableInvoiceTaxes = _$v.enableInvoiceTaxes;
      _enableInvoiceItemTaxes = _$v.enableInvoiceItemTaxes;
      _defaultInvoiceDesignId = _$v.defaultInvoiceDesignId;
      _defaultQuoteDesignId = _$v.defaultQuoteDesignId;
      _defaultInvoiceFooter = _$v.defaultInvoiceFooter;
      _invoiceLabels = _$v.invoiceLabels;
      _showInvoiceItemTaxes = _$v.showInvoiceItemTaxes;
      _defaultTaxName1 = _$v.defaultTaxName1;
      _defaultTaxRate1 = _$v.defaultTaxRate1;
      _defaultTaxName2 = _$v.defaultTaxName2;
      _defaultTaxRate2 = _$v.defaultTaxRate2;
      _defaultTaxName3 = _$v.defaultTaxName3;
      _defaultTaxRate3 = _$v.defaultTaxRate3;
      _defaultPaymentTypeId = _$v.defaultPaymentTypeId;
      _enableSecondTaxRate = _$v.enableSecondTaxRate;
      _invoiceFields = _$v.invoiceFields;
      _emailFooter = _$v.emailFooter;
      _emailSubjectInvoice = _$v.emailSubjectInvoice;
      _emailSubjectQuote = _$v.emailSubjectQuote;
      _emailSubjectPayment = _$v.emailSubjectPayment;
      _emailBodyInvoice = _$v.emailBodyInvoice;
      _emailBodyQuote = _$v.emailBodyQuote;
      _emailBodyPayment = _$v.emailBodyPayment;
      _emailSubjectReminder1 = _$v.emailSubjectReminder1;
      _emailSubjectReminder2 = _$v.emailSubjectReminder2;
      _emailSubjectReminder3 = _$v.emailSubjectReminder3;
      _emailBodyReminder1 = _$v.emailBodyReminder1;
      _emailBodyReminder2 = _$v.emailBodyReminder2;
      _emailBodyReminder3 = _$v.emailBodyReminder3;
      _enablePortalPassword = _$v.enablePortalPassword;
      _sendPortalPassword = _$v.sendPortalPassword;
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
      _customPaymentTerms = _$v.customPaymentTerms?.toBuilder();
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
              showTasksInPortal: showTasksInPortal,
              emailStyle: emailStyle,
              replyToEmail: replyToEmail,
              bccEmail: bccEmail,
              pdfEmailAttachment: pdfEmailAttachment,
              ublEmailAttachment: ublEmailAttachment,
              documentEmailAttachment: documentEmailAttachment,
              emailStyleCustom: emailStyleCustom,
              customMessageDashboard: customMessageDashboard,
              customMessageUnpaidInvoice: customMessageUnpaidInvoice,
              customMessagePaidInvoice: customMessagePaidInvoice,
              customMessageUnapprovedQuote: customMessageUnapprovedQuote,
              lockSentInvoices: lockSentInvoices,
              autoArchiveInvoice: autoArchiveInvoice,
              autoArchiveQuote: autoArchiveQuote,
              autoEmailInvoice: autoEmailInvoice,
              autoConvertInvoice: autoConvertInvoice,
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
              invoiceNumberPattern: invoiceNumberPattern,
              invoiceNumberCounter: invoiceNumberCounter,
              quoteNumberPattern: quoteNumberPattern,
              quoteNumberCounter: quoteNumberCounter,
              clientNumberPattern: clientNumberPattern,
              clientNumberCounter: clientNumberCounter,
              creditNumberPattern: creditNumberPattern,
              creditNumberCounter: creditNumberCounter,
              recurringInvoiceNumberPrefix: recurringInvoiceNumberPrefix,
              resetCounterFrequencyId: resetCounterFrequencyId,
              resetCounterDate: resetCounterDate,
              counterPadding: counterPadding,
              sharedInvoiceQuoteCounter: sharedInvoiceQuoteCounter,
              defaultInvoiceTerms: defaultInvoiceTerms,
              defaultQuoteTerms: defaultQuoteTerms,
              enableInvoiceTaxes: enableInvoiceTaxes,
              enableInvoiceItemTaxes: enableInvoiceItemTaxes,
              defaultInvoiceDesignId: defaultInvoiceDesignId,
              defaultQuoteDesignId: defaultQuoteDesignId,
              defaultInvoiceFooter: defaultInvoiceFooter,
              invoiceLabels: invoiceLabels,
              showInvoiceItemTaxes: showInvoiceItemTaxes,
              defaultTaxName1: defaultTaxName1,
              defaultTaxRate1: defaultTaxRate1,
              defaultTaxName2: defaultTaxName2,
              defaultTaxRate2: defaultTaxRate2,
              defaultTaxName3: defaultTaxName3,
              defaultTaxRate3: defaultTaxRate3,
              defaultPaymentTypeId: defaultPaymentTypeId,
              enableSecondTaxRate: enableSecondTaxRate,
              invoiceFields: invoiceFields,
              emailFooter: emailFooter,
              emailSubjectInvoice: emailSubjectInvoice,
              emailSubjectQuote: emailSubjectQuote,
              emailSubjectPayment: emailSubjectPayment,
              emailBodyInvoice: emailBodyInvoice,
              emailBodyQuote: emailBodyQuote,
              emailBodyPayment: emailBodyPayment,
              emailSubjectReminder1: emailSubjectReminder1,
              emailSubjectReminder2: emailSubjectReminder2,
              emailSubjectReminder3: emailSubjectReminder3,
              emailBodyReminder1: emailBodyReminder1,
              emailBodyReminder2: emailBodyReminder2,
              emailBodyReminder3: emailBodyReminder3,
              enablePortalPassword: enablePortalPassword,
              sendPortalPassword: sendPortalPassword,
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
              customPaymentTerms: _customPaymentTerms?.build(),
              hasCustomDesign1: hasCustomDesign1,
              hasCustomDesign2: hasCustomDesign2,
              hasCustomDesign3: hasCustomDesign3);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'translations';
        _translations?.build();

        _$failedField = 'customPaymentTerms';
        _customPaymentTerms?.build();
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

class _$UserItemResponse extends UserItemResponse {
  @override
  final UserEntity data;

  factory _$UserItemResponse(
          [void Function(UserItemResponseBuilder) updates]) =>
      (new UserItemResponseBuilder()..update(updates)).build();

  _$UserItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('UserItemResponse', 'data');
    }
  }

  @override
  UserItemResponse rebuild(void Function(UserItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserItemResponseBuilder toBuilder() =>
      new UserItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserItemResponse')..add('data', data))
        .toString();
  }
}

class UserItemResponseBuilder
    implements Builder<UserItemResponse, UserItemResponseBuilder> {
  _$UserItemResponse _$v;

  UserEntityBuilder _data;
  UserEntityBuilder get data => _$this._data ??= new UserEntityBuilder();
  set data(UserEntityBuilder data) => _$this._data = data;

  UserItemResponseBuilder();

  UserItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserItemResponse;
  }

  @override
  void update(void Function(UserItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserItemResponse build() {
    _$UserItemResponse _$result;
    try {
      _$result = _$v ?? new _$UserItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserItemResponse', _$failedField, e.toString());
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

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
