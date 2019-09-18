// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EntityType _$invoice = const EntityType._('invoice');
const EntityType _$recurringInvoice = const EntityType._('recurringInvoice');
const EntityType _$invoiceItem = const EntityType._('invoiceItem');
const EntityType _$quote = const EntityType._('quote');
const EntityType _$product = const EntityType._('product');
const EntityType _$client = const EntityType._('client');
const EntityType _$contact = const EntityType._('contact');
const EntityType _$task = const EntityType._('task');
const EntityType _$project = const EntityType._('project');
const EntityType _$expense = const EntityType._('expense');
const EntityType _$expenseCategory = const EntityType._('expenseCategory');
const EntityType _$vendor = const EntityType._('vendor');
const EntityType _$vendorContact = const EntityType._('vendorContact');
const EntityType _$credit = const EntityType._('credit');
const EntityType _$payment = const EntityType._('payment');
const EntityType _$country = const EntityType._('country');
const EntityType _$currency = const EntityType._('currency');
const EntityType _$language = const EntityType._('language');
const EntityType _$industry = const EntityType._('industry');
const EntityType _$size = const EntityType._('size');
const EntityType _$paymentType = const EntityType._('paymentType');
const EntityType _$taskStatus = const EntityType._('taskStatus');
const EntityType _$document = const EntityType._('document');

EntityType _$typeValueOf(String name) {
  switch (name) {
    case 'invoice':
      return _$invoice;
    case 'recurringInvoice':
      return _$recurringInvoice;
    case 'invoiceItem':
      return _$invoiceItem;
    case 'quote':
      return _$quote;
    case 'product':
      return _$product;
    case 'client':
      return _$client;
    case 'contact':
      return _$contact;
    case 'task':
      return _$task;
    case 'project':
      return _$project;
    case 'expense':
      return _$expense;
    case 'expenseCategory':
      return _$expenseCategory;
    case 'vendor':
      return _$vendor;
    case 'vendorContact':
      return _$vendorContact;
    case 'credit':
      return _$credit;
    case 'payment':
      return _$payment;
    case 'country':
      return _$country;
    case 'currency':
      return _$currency;
    case 'language':
      return _$language;
    case 'industry':
      return _$industry;
    case 'size':
      return _$size;
    case 'paymentType':
      return _$paymentType;
    case 'taskStatus':
      return _$taskStatus;
    case 'document':
      return _$document;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityType> _$typeValues =
    new BuiltSet<EntityType>(const <EntityType>[
  _$invoice,
  _$recurringInvoice,
  _$invoiceItem,
  _$quote,
  _$product,
  _$client,
  _$contact,
  _$task,
  _$project,
  _$expense,
  _$expenseCategory,
  _$vendor,
  _$vendorContact,
  _$credit,
  _$payment,
  _$country,
  _$currency,
  _$language,
  _$industry,
  _$size,
  _$paymentType,
  _$taskStatus,
  _$document,
]);

const EntityState _$active = const EntityState._('active');
const EntityState _$archived = const EntityState._('archived');
const EntityState _$deleted = const EntityState._('deleted');

EntityState _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'archived':
      return _$archived;
    case 'deleted':
      return _$deleted;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityState> _$values =
    new BuiltSet<EntityState>(const <EntityState>[
  _$active,
  _$archived,
  _$deleted,
]);

const EmailTemplate _$initial = const EmailTemplate._('initial');
const EmailTemplate _$reminder1 = const EmailTemplate._('reminder1');
const EmailTemplate _$reminder2 = const EmailTemplate._('reminder2');
const EmailTemplate _$reminder3 = const EmailTemplate._('reminder3');

EmailTemplate _$templateValueOf(String name) {
  switch (name) {
    case 'initial':
      return _$initial;
    case 'reminder1':
      return _$reminder1;
    case 'reminder2':
      return _$reminder2;
    case 'reminder3':
      return _$reminder3;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EmailTemplate> _$templateValues =
    new BuiltSet<EmailTemplate>(const <EmailTemplate>[
  _$initial,
  _$reminder1,
  _$reminder2,
  _$reminder3,
]);

const UserPermission _$create = const UserPermission._('create');
const UserPermission _$edit = const UserPermission._('edit');
const UserPermission _$view = const UserPermission._('view');

UserPermission _$permissionValueOf(String name) {
  switch (name) {
    case 'create':
      return _$create;
    case 'edit':
      return _$edit;
    case 'view':
      return _$view;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<UserPermission> _$permissionValues =
    new BuiltSet<UserPermission>(const <UserPermission>[
  _$create,
  _$edit,
  _$view,
]);

Serializer<EntityType> _$entityTypeSerializer = new _$EntityTypeSerializer();
Serializer<EntityState> _$entityStateSerializer = new _$EntityStateSerializer();
Serializer<EmailTemplate> _$emailTemplateSerializer =
    new _$EmailTemplateSerializer();
Serializer<UserPermission> _$userPermissionSerializer =
    new _$UserPermissionSerializer();
Serializer<ErrorMessage> _$errorMessageSerializer =
    new _$ErrorMessageSerializer();
Serializer<LoginResponse> _$loginResponseSerializer =
    new _$LoginResponseSerializer();
Serializer<StaticData> _$staticDataSerializer = new _$StaticDataSerializer();
Serializer<DashboardResponse> _$dashboardResponseSerializer =
    new _$DashboardResponseSerializer();
Serializer<DashboardEntity> _$dashboardEntitySerializer =
    new _$DashboardEntitySerializer();
Serializer<ActivityEntity> _$activityEntitySerializer =
    new _$ActivityEntitySerializer();

class _$EntityTypeSerializer implements PrimitiveSerializer<EntityType> {
  @override
  final Iterable<Type> types = const <Type>[EntityType];
  @override
  final String wireName = 'EntityType';

  @override
  Object serialize(Serializers serializers, EntityType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  EntityType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EntityType.valueOf(serialized as String);
}

class _$EntityStateSerializer implements PrimitiveSerializer<EntityState> {
  @override
  final Iterable<Type> types = const <Type>[EntityState];
  @override
  final String wireName = 'EntityState';

  @override
  Object serialize(Serializers serializers, EntityState object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  EntityState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EntityState.valueOf(serialized as String);
}

class _$EmailTemplateSerializer implements PrimitiveSerializer<EmailTemplate> {
  @override
  final Iterable<Type> types = const <Type>[EmailTemplate];
  @override
  final String wireName = 'EmailTemplate';

  @override
  Object serialize(Serializers serializers, EmailTemplate object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  EmailTemplate deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EmailTemplate.valueOf(serialized as String);
}

class _$UserPermissionSerializer
    implements PrimitiveSerializer<UserPermission> {
  @override
  final Iterable<Type> types = const <Type>[UserPermission];
  @override
  final String wireName = 'UserPermission';

  @override
  Object serialize(Serializers serializers, UserPermission object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  UserPermission deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserPermission.valueOf(serialized as String);
}

class _$ErrorMessageSerializer implements StructuredSerializer<ErrorMessage> {
  @override
  final Iterable<Type> types = const [ErrorMessage, _$ErrorMessage];
  @override
  final String wireName = 'ErrorMessage';

  @override
  Iterable<Object> serialize(Serializers serializers, ErrorMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ErrorMessage deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginResponseSerializer implements StructuredSerializer<LoginResponse> {
  @override
  final Iterable<Type> types = const [LoginResponse, _$LoginResponse];
  @override
  final String wireName = 'LoginResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, LoginResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.userCompanies,
          specifiedType: const FullType(
              BuiltList, const [const FullType(UserCompanyEntity)])),
      'static',
      serializers.serialize(object.static,
          specifiedType: const FullType(StaticData)),
    ];

    return result;
  }

  @override
  LoginResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoginResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.userCompanies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(UserCompanyEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'static':
          result.static.replace(serializers.deserialize(value,
              specifiedType: const FullType(StaticData)) as StaticData);
          break;
      }
    }

    return result.build();
  }
}

class _$StaticDataSerializer implements StructuredSerializer<StaticData> {
  @override
  final Iterable<Type> types = const [StaticData, _$StaticData];
  @override
  final String wireName = 'StaticData';

  @override
  Iterable<Object> serialize(Serializers serializers, StaticData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'currencies',
      serializers.serialize(object.currencies,
          specifiedType: const FullType(
              BuiltList, const [const FullType(CurrencyEntity)])),
      'sizes',
      serializers.serialize(object.sizes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(SizeEntity)])),
      'industries',
      serializers.serialize(object.industries,
          specifiedType: const FullType(
              BuiltList, const [const FullType(IndustryEntity)])),
      'timezones',
      serializers.serialize(object.timezones,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TimezoneEntity)])),
      'dateFormats',
      serializers.serialize(object.dateFormats,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DateFormatEntity)])),
      'datetimeFormats',
      serializers.serialize(object.datetimeFormats,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DatetimeFormatEntity)])),
      'languages',
      serializers.serialize(object.languages,
          specifiedType: const FullType(
              BuiltList, const [const FullType(LanguageEntity)])),
      'paymentTypes',
      serializers.serialize(object.paymentTypes,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTypeEntity)])),
      'countries',
      serializers.serialize(object.countries,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CountryEntity)])),
      'invoiceStatus',
      serializers.serialize(object.invoiceStatus,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceStatusEntity)])),
      'frequencies',
      serializers.serialize(object.frequencies,
          specifiedType: const FullType(
              BuiltList, const [const FullType(FrequencyEntity)])),
    ];

    return result;
  }

  @override
  StaticData deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currencies':
          result.currencies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CurrencyEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'sizes':
          result.sizes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SizeEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'industries':
          result.industries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(IndustryEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'timezones':
          result.timezones.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimezoneEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'dateFormats':
          result.dateFormats.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DateFormatEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'datetimeFormats':
          result.datetimeFormats.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DatetimeFormatEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'languages':
          result.languages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LanguageEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'paymentTypes':
          result.paymentTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTypeEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'countries':
          result.countries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CountryEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'invoiceStatus':
          result.invoiceStatus.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceStatusEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'frequencies':
          result.frequencies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(FrequencyEntity)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardResponseSerializer
    implements StructuredSerializer<DashboardResponse> {
  @override
  final Iterable<Type> types = const [DashboardResponse, _$DashboardResponse];
  @override
  final String wireName = 'DashboardResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, DashboardResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DashboardEntity)),
    ];

    return result;
  }

  @override
  DashboardResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DashboardEntity))
              as DashboardEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardEntitySerializer
    implements StructuredSerializer<DashboardEntity> {
  @override
  final Iterable<Type> types = const [DashboardEntity, _$DashboardEntity];
  @override
  final String wireName = 'DashboardEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, DashboardEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'activities',
      serializers.serialize(object.activities,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ActivityEntity)])),
    ];

    return result;
  }

  @override
  DashboardEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'activities':
          result.activities.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ActivityEntity)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$ActivityEntitySerializer
    implements StructuredSerializer<ActivityEntity> {
  @override
  final Iterable<Type> types = const [ActivityEntity, _$ActivityEntity];
  @override
  final String wireName = 'ActivityEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, ActivityEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'notes',
      serializers.serialize(object.notes,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.key, specifiedType: const FullType(String)),
      'activity_type_id',
      serializers.serialize(object.activityTypeId,
          specifiedType: const FullType(String)),
      'user_id',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
    ];
    if (object.clientId != null) {
      result
        ..add('client_id')
        ..add(serializers.serialize(object.clientId,
            specifiedType: const FullType(String)));
    }
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(String)));
    }
    if (object.paymentId != null) {
      result
        ..add('payment_id')
        ..add(serializers.serialize(object.paymentId,
            specifiedType: const FullType(String)));
    }
    if (object.creditId != null) {
      result
        ..add('credit_id')
        ..add(serializers.serialize(object.creditId,
            specifiedType: const FullType(String)));
    }
    if (object.expenseId != null) {
      result
        ..add('expense_id')
        ..add(serializers.serialize(object.expenseId,
            specifiedType: const FullType(String)));
    }
    if (object.isSystem != null) {
      result
        ..add('is_system')
        ..add(serializers.serialize(object.isSystem,
            specifiedType: const FullType(bool)));
    }
    if (object.contactId != null) {
      result
        ..add('contact_id')
        ..add(serializers.serialize(object.contactId,
            specifiedType: const FullType(String)));
    }
    if (object.taskId != null) {
      result
        ..add('task_id')
        ..add(serializers.serialize(object.taskId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ActivityEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ActivityEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'activity_type_id':
          result.activityTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_id':
          result.paymentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_id':
          result.creditId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'expense_id':
          result.expenseId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_system':
          result.isSystem = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'contact_id':
          result.contactId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'task_id':
          result.taskId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ErrorMessage extends ErrorMessage {
  @override
  final String message;

  factory _$ErrorMessage([void Function(ErrorMessageBuilder) updates]) =>
      (new ErrorMessageBuilder()..update(updates)).build();

  _$ErrorMessage._({this.message}) : super._() {
    if (message == null) {
      throw new BuiltValueNullFieldError('ErrorMessage', 'message');
    }
  }

  @override
  ErrorMessage rebuild(void Function(ErrorMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorMessageBuilder toBuilder() => new ErrorMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorMessage && message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(0, message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ErrorMessage')
          ..add('message', message))
        .toString();
  }
}

class ErrorMessageBuilder
    implements Builder<ErrorMessage, ErrorMessageBuilder> {
  _$ErrorMessage _$v;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ErrorMessageBuilder();

  ErrorMessageBuilder get _$this {
    if (_$v != null) {
      _message = _$v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorMessage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ErrorMessage;
  }

  @override
  void update(void Function(ErrorMessageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorMessage build() {
    final _$result = _$v ?? new _$ErrorMessage._(message: message);
    replace(_$result);
    return _$result;
  }
}

class _$LoginResponse extends LoginResponse {
  @override
  final BuiltList<UserCompanyEntity> userCompanies;
  @override
  final StaticData static;

  factory _$LoginResponse([void Function(LoginResponseBuilder) updates]) =>
      (new LoginResponseBuilder()..update(updates)).build();

  _$LoginResponse._({this.userCompanies, this.static}) : super._() {
    if (userCompanies == null) {
      throw new BuiltValueNullFieldError('LoginResponse', 'userCompanies');
    }
    if (static == null) {
      throw new BuiltValueNullFieldError('LoginResponse', 'static');
    }
  }

  @override
  LoginResponse rebuild(void Function(LoginResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseBuilder toBuilder() => new LoginResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginResponse &&
        userCompanies == other.userCompanies &&
        static == other.static;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, userCompanies.hashCode), static.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginResponse')
          ..add('userCompanies', userCompanies)
          ..add('static', static))
        .toString();
  }
}

class LoginResponseBuilder
    implements Builder<LoginResponse, LoginResponseBuilder> {
  _$LoginResponse _$v;

  ListBuilder<UserCompanyEntity> _userCompanies;
  ListBuilder<UserCompanyEntity> get userCompanies =>
      _$this._userCompanies ??= new ListBuilder<UserCompanyEntity>();
  set userCompanies(ListBuilder<UserCompanyEntity> userCompanies) =>
      _$this._userCompanies = userCompanies;

  StaticDataBuilder _static;
  StaticDataBuilder get static => _$this._static ??= new StaticDataBuilder();
  set static(StaticDataBuilder static) => _$this._static = static;

  LoginResponseBuilder();

  LoginResponseBuilder get _$this {
    if (_$v != null) {
      _userCompanies = _$v.userCompanies?.toBuilder();
      _static = _$v.static?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginResponse;
  }

  @override
  void update(void Function(LoginResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginResponse build() {
    _$LoginResponse _$result;
    try {
      _$result = _$v ??
          new _$LoginResponse._(
              userCompanies: userCompanies.build(), static: static.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userCompanies';
        userCompanies.build();
        _$failedField = 'static';
        static.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoginResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StaticData extends StaticData {
  @override
  final BuiltList<CurrencyEntity> currencies;
  @override
  final BuiltList<SizeEntity> sizes;
  @override
  final BuiltList<IndustryEntity> industries;
  @override
  final BuiltList<TimezoneEntity> timezones;
  @override
  final BuiltList<DateFormatEntity> dateFormats;
  @override
  final BuiltList<DatetimeFormatEntity> datetimeFormats;
  @override
  final BuiltList<LanguageEntity> languages;
  @override
  final BuiltList<PaymentTypeEntity> paymentTypes;
  @override
  final BuiltList<CountryEntity> countries;
  @override
  final BuiltList<InvoiceStatusEntity> invoiceStatus;
  @override
  final BuiltList<FrequencyEntity> frequencies;

  factory _$StaticData([void Function(StaticDataBuilder) updates]) =>
      (new StaticDataBuilder()..update(updates)).build();

  _$StaticData._(
      {this.currencies,
      this.sizes,
      this.industries,
      this.timezones,
      this.dateFormats,
      this.datetimeFormats,
      this.languages,
      this.paymentTypes,
      this.countries,
      this.invoiceStatus,
      this.frequencies})
      : super._() {
    if (currencies == null) {
      throw new BuiltValueNullFieldError('StaticData', 'currencies');
    }
    if (sizes == null) {
      throw new BuiltValueNullFieldError('StaticData', 'sizes');
    }
    if (industries == null) {
      throw new BuiltValueNullFieldError('StaticData', 'industries');
    }
    if (timezones == null) {
      throw new BuiltValueNullFieldError('StaticData', 'timezones');
    }
    if (dateFormats == null) {
      throw new BuiltValueNullFieldError('StaticData', 'dateFormats');
    }
    if (datetimeFormats == null) {
      throw new BuiltValueNullFieldError('StaticData', 'datetimeFormats');
    }
    if (languages == null) {
      throw new BuiltValueNullFieldError('StaticData', 'languages');
    }
    if (paymentTypes == null) {
      throw new BuiltValueNullFieldError('StaticData', 'paymentTypes');
    }
    if (countries == null) {
      throw new BuiltValueNullFieldError('StaticData', 'countries');
    }
    if (invoiceStatus == null) {
      throw new BuiltValueNullFieldError('StaticData', 'invoiceStatus');
    }
    if (frequencies == null) {
      throw new BuiltValueNullFieldError('StaticData', 'frequencies');
    }
  }

  @override
  StaticData rebuild(void Function(StaticDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataBuilder toBuilder() => new StaticDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticData &&
        currencies == other.currencies &&
        sizes == other.sizes &&
        industries == other.industries &&
        timezones == other.timezones &&
        dateFormats == other.dateFormats &&
        datetimeFormats == other.datetimeFormats &&
        languages == other.languages &&
        paymentTypes == other.paymentTypes &&
        countries == other.countries &&
        invoiceStatus == other.invoiceStatus &&
        frequencies == other.frequencies;
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
                                        $jc($jc(0, currencies.hashCode),
                                            sizes.hashCode),
                                        industries.hashCode),
                                    timezones.hashCode),
                                dateFormats.hashCode),
                            datetimeFormats.hashCode),
                        languages.hashCode),
                    paymentTypes.hashCode),
                countries.hashCode),
            invoiceStatus.hashCode),
        frequencies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticData')
          ..add('currencies', currencies)
          ..add('sizes', sizes)
          ..add('industries', industries)
          ..add('timezones', timezones)
          ..add('dateFormats', dateFormats)
          ..add('datetimeFormats', datetimeFormats)
          ..add('languages', languages)
          ..add('paymentTypes', paymentTypes)
          ..add('countries', countries)
          ..add('invoiceStatus', invoiceStatus)
          ..add('frequencies', frequencies))
        .toString();
  }
}

class StaticDataBuilder implements Builder<StaticData, StaticDataBuilder> {
  _$StaticData _$v;

  ListBuilder<CurrencyEntity> _currencies;
  ListBuilder<CurrencyEntity> get currencies =>
      _$this._currencies ??= new ListBuilder<CurrencyEntity>();
  set currencies(ListBuilder<CurrencyEntity> currencies) =>
      _$this._currencies = currencies;

  ListBuilder<SizeEntity> _sizes;
  ListBuilder<SizeEntity> get sizes =>
      _$this._sizes ??= new ListBuilder<SizeEntity>();
  set sizes(ListBuilder<SizeEntity> sizes) => _$this._sizes = sizes;

  ListBuilder<IndustryEntity> _industries;
  ListBuilder<IndustryEntity> get industries =>
      _$this._industries ??= new ListBuilder<IndustryEntity>();
  set industries(ListBuilder<IndustryEntity> industries) =>
      _$this._industries = industries;

  ListBuilder<TimezoneEntity> _timezones;
  ListBuilder<TimezoneEntity> get timezones =>
      _$this._timezones ??= new ListBuilder<TimezoneEntity>();
  set timezones(ListBuilder<TimezoneEntity> timezones) =>
      _$this._timezones = timezones;

  ListBuilder<DateFormatEntity> _dateFormats;
  ListBuilder<DateFormatEntity> get dateFormats =>
      _$this._dateFormats ??= new ListBuilder<DateFormatEntity>();
  set dateFormats(ListBuilder<DateFormatEntity> dateFormats) =>
      _$this._dateFormats = dateFormats;

  ListBuilder<DatetimeFormatEntity> _datetimeFormats;
  ListBuilder<DatetimeFormatEntity> get datetimeFormats =>
      _$this._datetimeFormats ??= new ListBuilder<DatetimeFormatEntity>();
  set datetimeFormats(ListBuilder<DatetimeFormatEntity> datetimeFormats) =>
      _$this._datetimeFormats = datetimeFormats;

  ListBuilder<LanguageEntity> _languages;
  ListBuilder<LanguageEntity> get languages =>
      _$this._languages ??= new ListBuilder<LanguageEntity>();
  set languages(ListBuilder<LanguageEntity> languages) =>
      _$this._languages = languages;

  ListBuilder<PaymentTypeEntity> _paymentTypes;
  ListBuilder<PaymentTypeEntity> get paymentTypes =>
      _$this._paymentTypes ??= new ListBuilder<PaymentTypeEntity>();
  set paymentTypes(ListBuilder<PaymentTypeEntity> paymentTypes) =>
      _$this._paymentTypes = paymentTypes;

  ListBuilder<CountryEntity> _countries;
  ListBuilder<CountryEntity> get countries =>
      _$this._countries ??= new ListBuilder<CountryEntity>();
  set countries(ListBuilder<CountryEntity> countries) =>
      _$this._countries = countries;

  ListBuilder<InvoiceStatusEntity> _invoiceStatus;
  ListBuilder<InvoiceStatusEntity> get invoiceStatus =>
      _$this._invoiceStatus ??= new ListBuilder<InvoiceStatusEntity>();
  set invoiceStatus(ListBuilder<InvoiceStatusEntity> invoiceStatus) =>
      _$this._invoiceStatus = invoiceStatus;

  ListBuilder<FrequencyEntity> _frequencies;
  ListBuilder<FrequencyEntity> get frequencies =>
      _$this._frequencies ??= new ListBuilder<FrequencyEntity>();
  set frequencies(ListBuilder<FrequencyEntity> frequencies) =>
      _$this._frequencies = frequencies;

  StaticDataBuilder();

  StaticDataBuilder get _$this {
    if (_$v != null) {
      _currencies = _$v.currencies?.toBuilder();
      _sizes = _$v.sizes?.toBuilder();
      _industries = _$v.industries?.toBuilder();
      _timezones = _$v.timezones?.toBuilder();
      _dateFormats = _$v.dateFormats?.toBuilder();
      _datetimeFormats = _$v.datetimeFormats?.toBuilder();
      _languages = _$v.languages?.toBuilder();
      _paymentTypes = _$v.paymentTypes?.toBuilder();
      _countries = _$v.countries?.toBuilder();
      _invoiceStatus = _$v.invoiceStatus?.toBuilder();
      _frequencies = _$v.frequencies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StaticData;
  }

  @override
  void update(void Function(StaticDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticData build() {
    _$StaticData _$result;
    try {
      _$result = _$v ??
          new _$StaticData._(
              currencies: currencies.build(),
              sizes: sizes.build(),
              industries: industries.build(),
              timezones: timezones.build(),
              dateFormats: dateFormats.build(),
              datetimeFormats: datetimeFormats.build(),
              languages: languages.build(),
              paymentTypes: paymentTypes.build(),
              countries: countries.build(),
              invoiceStatus: invoiceStatus.build(),
              frequencies: frequencies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currencies';
        currencies.build();
        _$failedField = 'sizes';
        sizes.build();
        _$failedField = 'industries';
        industries.build();
        _$failedField = 'timezones';
        timezones.build();
        _$failedField = 'dateFormats';
        dateFormats.build();
        _$failedField = 'datetimeFormats';
        datetimeFormats.build();
        _$failedField = 'languages';
        languages.build();
        _$failedField = 'paymentTypes';
        paymentTypes.build();
        _$failedField = 'countries';
        countries.build();
        _$failedField = 'invoiceStatus';
        invoiceStatus.build();
        _$failedField = 'frequencies';
        frequencies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StaticData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DashboardResponse extends DashboardResponse {
  @override
  final DashboardEntity data;

  factory _$DashboardResponse(
          [void Function(DashboardResponseBuilder) updates]) =>
      (new DashboardResponseBuilder()..update(updates)).build();

  _$DashboardResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DashboardResponse', 'data');
    }
  }

  @override
  DashboardResponse rebuild(void Function(DashboardResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardResponseBuilder toBuilder() =>
      new DashboardResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardResponse')..add('data', data))
        .toString();
  }
}

class DashboardResponseBuilder
    implements Builder<DashboardResponse, DashboardResponseBuilder> {
  _$DashboardResponse _$v;

  DashboardEntityBuilder _data;
  DashboardEntityBuilder get data =>
      _$this._data ??= new DashboardEntityBuilder();
  set data(DashboardEntityBuilder data) => _$this._data = data;

  DashboardResponseBuilder();

  DashboardResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DashboardResponse;
  }

  @override
  void update(void Function(DashboardResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardResponse build() {
    _$DashboardResponse _$result;
    try {
      _$result = _$v ?? new _$DashboardResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DashboardResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DashboardEntity extends DashboardEntity {
  @override
  final BuiltList<ActivityEntity> activities;

  factory _$DashboardEntity([void Function(DashboardEntityBuilder) updates]) =>
      (new DashboardEntityBuilder()..update(updates)).build();

  _$DashboardEntity._({this.activities}) : super._() {
    if (activities == null) {
      throw new BuiltValueNullFieldError('DashboardEntity', 'activities');
    }
  }

  @override
  DashboardEntity rebuild(void Function(DashboardEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardEntityBuilder toBuilder() =>
      new DashboardEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardEntity && activities == other.activities;
  }

  @override
  int get hashCode {
    return $jf($jc(0, activities.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardEntity')
          ..add('activities', activities))
        .toString();
  }
}

class DashboardEntityBuilder
    implements Builder<DashboardEntity, DashboardEntityBuilder> {
  _$DashboardEntity _$v;

  ListBuilder<ActivityEntity> _activities;
  ListBuilder<ActivityEntity> get activities =>
      _$this._activities ??= new ListBuilder<ActivityEntity>();
  set activities(ListBuilder<ActivityEntity> activities) =>
      _$this._activities = activities;

  DashboardEntityBuilder();

  DashboardEntityBuilder get _$this {
    if (_$v != null) {
      _activities = _$v.activities?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DashboardEntity;
  }

  @override
  void update(void Function(DashboardEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardEntity build() {
    _$DashboardEntity _$result;
    try {
      _$result = _$v ?? new _$DashboardEntity._(activities: activities.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'activities';
        activities.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DashboardEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ActivityEntity extends ActivityEntity {
  @override
  final String notes;
  @override
  final String key;
  @override
  final String activityTypeId;
  @override
  final String clientId;
  @override
  final String userId;
  @override
  final String invoiceId;
  @override
  final String paymentId;
  @override
  final String creditId;
  @override
  final int updatedAt;
  @override
  final String expenseId;
  @override
  final bool isSystem;
  @override
  final String contactId;
  @override
  final String taskId;

  factory _$ActivityEntity([void Function(ActivityEntityBuilder) updates]) =>
      (new ActivityEntityBuilder()..update(updates)).build();

  _$ActivityEntity._(
      {this.notes,
      this.key,
      this.activityTypeId,
      this.clientId,
      this.userId,
      this.invoiceId,
      this.paymentId,
      this.creditId,
      this.updatedAt,
      this.expenseId,
      this.isSystem,
      this.contactId,
      this.taskId})
      : super._() {
    if (notes == null) {
      throw new BuiltValueNullFieldError('ActivityEntity', 'notes');
    }
    if (key == null) {
      throw new BuiltValueNullFieldError('ActivityEntity', 'key');
    }
    if (activityTypeId == null) {
      throw new BuiltValueNullFieldError('ActivityEntity', 'activityTypeId');
    }
    if (userId == null) {
      throw new BuiltValueNullFieldError('ActivityEntity', 'userId');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('ActivityEntity', 'updatedAt');
    }
  }

  @override
  ActivityEntity rebuild(void Function(ActivityEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityEntityBuilder toBuilder() =>
      new ActivityEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityEntity &&
        notes == other.notes &&
        key == other.key &&
        activityTypeId == other.activityTypeId &&
        clientId == other.clientId &&
        userId == other.userId &&
        invoiceId == other.invoiceId &&
        paymentId == other.paymentId &&
        creditId == other.creditId &&
        updatedAt == other.updatedAt &&
        expenseId == other.expenseId &&
        isSystem == other.isSystem &&
        contactId == other.contactId &&
        taskId == other.taskId;
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
                                                $jc($jc(0, notes.hashCode),
                                                    key.hashCode),
                                                activityTypeId.hashCode),
                                            clientId.hashCode),
                                        userId.hashCode),
                                    invoiceId.hashCode),
                                paymentId.hashCode),
                            creditId.hashCode),
                        updatedAt.hashCode),
                    expenseId.hashCode),
                isSystem.hashCode),
            contactId.hashCode),
        taskId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ActivityEntity')
          ..add('notes', notes)
          ..add('key', key)
          ..add('activityTypeId', activityTypeId)
          ..add('clientId', clientId)
          ..add('userId', userId)
          ..add('invoiceId', invoiceId)
          ..add('paymentId', paymentId)
          ..add('creditId', creditId)
          ..add('updatedAt', updatedAt)
          ..add('expenseId', expenseId)
          ..add('isSystem', isSystem)
          ..add('contactId', contactId)
          ..add('taskId', taskId))
        .toString();
  }
}

class ActivityEntityBuilder
    implements Builder<ActivityEntity, ActivityEntityBuilder> {
  _$ActivityEntity _$v;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _activityTypeId;
  String get activityTypeId => _$this._activityTypeId;
  set activityTypeId(String activityTypeId) =>
      _$this._activityTypeId = activityTypeId;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _invoiceId;
  String get invoiceId => _$this._invoiceId;
  set invoiceId(String invoiceId) => _$this._invoiceId = invoiceId;

  String _paymentId;
  String get paymentId => _$this._paymentId;
  set paymentId(String paymentId) => _$this._paymentId = paymentId;

  String _creditId;
  String get creditId => _$this._creditId;
  set creditId(String creditId) => _$this._creditId = creditId;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  String _expenseId;
  String get expenseId => _$this._expenseId;
  set expenseId(String expenseId) => _$this._expenseId = expenseId;

  bool _isSystem;
  bool get isSystem => _$this._isSystem;
  set isSystem(bool isSystem) => _$this._isSystem = isSystem;

  String _contactId;
  String get contactId => _$this._contactId;
  set contactId(String contactId) => _$this._contactId = contactId;

  String _taskId;
  String get taskId => _$this._taskId;
  set taskId(String taskId) => _$this._taskId = taskId;

  ActivityEntityBuilder();

  ActivityEntityBuilder get _$this {
    if (_$v != null) {
      _notes = _$v.notes;
      _key = _$v.key;
      _activityTypeId = _$v.activityTypeId;
      _clientId = _$v.clientId;
      _userId = _$v.userId;
      _invoiceId = _$v.invoiceId;
      _paymentId = _$v.paymentId;
      _creditId = _$v.creditId;
      _updatedAt = _$v.updatedAt;
      _expenseId = _$v.expenseId;
      _isSystem = _$v.isSystem;
      _contactId = _$v.contactId;
      _taskId = _$v.taskId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ActivityEntity;
  }

  @override
  void update(void Function(ActivityEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ActivityEntity build() {
    final _$result = _$v ??
        new _$ActivityEntity._(
            notes: notes,
            key: key,
            activityTypeId: activityTypeId,
            clientId: clientId,
            userId: userId,
            invoiceId: invoiceId,
            paymentId: paymentId,
            creditId: creditId,
            updatedAt: updatedAt,
            expenseId: expenseId,
            isSystem: isSystem,
            contactId: contactId,
            taskId: taskId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
