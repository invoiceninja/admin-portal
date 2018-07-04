import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

part 'entities.g.dart';



class EntityType extends EnumClass {
  const EntityType._(String name) : super(name);

  static Serializer<EntityType> get serializer => _$entityTypeSerializer;

  static const EntityType invoice = _$invoice;
  static const EntityType invoiceItem = _$invoiceItem;
  static const EntityType quote = _$quote;
  static const EntityType product = _$product;
  static const EntityType client = _$client;
  static const EntityType contact = _$contact;
  static const EntityType task = _$task;
  static const EntityType project = _$project;
  static const EntityType expense = _$expense;
  static const EntityType vendor = _$vendor;
  static const EntityType credit = _$credit;
  static const EntityType payment = _$payment;
  static const EntityType country = _$country;
  static const EntityType currency = _$currency;
  static const EntityType language = _$language;

  String get plural {
    return toString() + 's';
  }

  static BuiltSet<EntityType> get values => _$typeValues;
  static EntityType valueOf(String name) => _$typeValueOf(name);
}


class EntityState extends EnumClass {

  const EntityState._(String name) : super(name);

  static Serializer<EntityState> get serializer => _$entityStateSerializer;

  static const EntityState active = _$active;
  static const EntityState archived = _$archived;
  static const EntityState deleted = _$deleted;

  static BuiltSet<EntityState> get values => _$values;
  static EntityState valueOf(String name) => _$valueOf(name);
}

abstract class EntityStatus {
  int get id;
  String get name;
}

abstract class SelectableEntity {
  @nullable
  int get id;

  bool matchesSearch(String search) => true;
  String matchesSearchValue(String search) => null;

  String get listDisplayName => 'Error: listDisplayName not set';

  String listDisplayCost(AppState state) => 'Error: listDisplayCost not set';
}

abstract class BaseEntity extends Object with SelectableEntity {

  @nullable
  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  @nullable
  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;

  @nullable
  @BuiltValueField(wireName: 'is_deleted')
  bool get isDeleted;

  String get entityKey => '__${entityType}__${id}__';

  EntityType get entityType => throw 'EntityType not set: ${this}';

  bool get isNew => id == null || id < 0;
  bool get isActive => archivedAt == null;
  bool get isArchived => archivedAt != null && ! isDeleted;

  bool matchesStates(BuiltList<EntityState> states) {
    if (states.isEmpty) {
      return true;
    }

    if (states.contains(EntityState.active) && isActive) {
      return true;
    }

    if (states.contains(EntityState.archived) && isArchived) {
      return true;
    }

    if (states.contains(EntityState.deleted) && isDeleted) {
      return true;
    }

    return false;
  }
}

abstract class ConvertToInvoiceItem {
  InvoiceItemEntity get asInvoiceItem;
}


abstract class ErrorMessage implements Built<ErrorMessage, ErrorMessageBuilder> {

  factory ErrorMessage([void updates(ErrorMessageBuilder b)]) = _$ErrorMessage;
  ErrorMessage._();

  String get message;

  static Serializer<ErrorMessage> get serializer => _$errorMessageSerializer;
}


abstract class LoginResponse implements Built<LoginResponse, LoginResponseBuilder> {

  factory LoginResponse([void updates(LoginResponseBuilder b)]) = _$LoginResponse;
  LoginResponse._();

  LoginResponseData get data;

  @nullable
  ErrorMessage get error;

  static Serializer<LoginResponse> get serializer => _$loginResponseSerializer;
}

abstract class LoginResponseData implements Built<LoginResponseData, LoginResponseDataBuilder> {

  factory LoginResponseData([void updates(LoginResponseDataBuilder b)]) = _$LoginResponseData;
  LoginResponseData._();

  BuiltList<CompanyEntity> get accounts;
  String get version;
  StaticData get static;

  static Serializer<LoginResponseData> get serializer => _$loginResponseDataSerializer;
}

abstract class StaticData implements Built<StaticData, StaticDataBuilder> {

  factory StaticData([void updates(StaticDataBuilder b)]) = _$StaticData;
  StaticData._();

  BuiltList<CurrencyEntity> get currencies;
  BuiltList<SizeEntity> get sizes;
  BuiltList<IndustryEntity> get industries;
  BuiltList<TimezoneEntity> get timezones;
  BuiltList<DateFormatEntity> get dateFormats;
  BuiltList<DatetimeFormatEntity> get datetimeFormats;
  BuiltList<LanguageEntity> get languages;
  BuiltList<PaymentTypeEntity> get paymentTypes;
  BuiltList<CountryEntity> get countries;
  BuiltList<InvoiceStatusEntity> get invoiceStatus;
  BuiltList<FrequencyEntity> get frequencies;

  static Serializer<StaticData> get serializer => _$staticDataSerializer;
}



abstract class DashboardResponse implements Built<DashboardResponse, DashboardResponseBuilder> {

  factory DashboardResponse([void updates(DashboardResponseBuilder b)]) = _$DashboardResponse;
  DashboardResponse._();

  DashboardEntity get data;

  static Serializer<DashboardResponse> get serializer => _$dashboardResponseSerializer;
}

class CustomFieldType {
  static const String product1 = 'product1';
  static const String product2 = 'product2';
  static const String client1 = 'client1';
  static const String client2 = 'client2';
  static const String contact1 = 'contact1';
  static const String contact2 = 'contact2';
  static const String task1 = 'task1';
  static const String task2 = 'task2';
  static const String project1 = 'project1';
  static const String project2 = 'project2';
  static const String expense1 = 'expense1';
  static const String expense2 = 'expense2';
  static const String vendor1 = 'vendor1';
  static const String vendor2 = 'vendor2';
  static const String invoice1 = 'invoice_text1';
  static const String invoice2 = 'invoice_text2';
  static const String surcharge1 = 'invoice1';
  static const String surcharge2 = 'invoice2';
}

abstract class DashboardEntity implements Built<DashboardEntity, DashboardEntityBuilder> {

  factory DashboardEntity([void updates(DashboardEntityBuilder b)]) = _$DashboardEntity;
  DashboardEntity._();

  @nullable
  double get paidToDate;

  @nullable
  int get paidToDateCurrency;

  @nullable
  double get balances;

  @nullable
  int get balancesCurrency;

  @nullable
  double get averageInvoice;

  @nullable
  int get averageInvoiceCurrency;

  @nullable
  int get invoicesSent;

  @nullable
  int get activeClients;

  static Serializer<DashboardEntity> get serializer => _$dashboardEntitySerializer;
}
