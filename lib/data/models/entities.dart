import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entities.g.dart';



class EntityType extends EnumClass {
  static Serializer<EntityType> get serializer => _$entityTypeSerializer;

  static const EntityType invoice = _$invoice;
  static const EntityType quote = _$quote;
  static const EntityType product = _$product;
  static const EntityType client = _$client;
  static const EntityType task = _$task;
  static const EntityType project = _$project;
  static const EntityType expense = _$expense;
  static const EntityType vendor = _$vendor;
  static const EntityType credit = _$credit;
  static const EntityType payment = _$payment;

  const EntityType._(String name) : super(name);

  static BuiltSet<EntityType> get values => _$typeValues;
  static EntityType valueOf(String name) => _$typeValueOf(name);
}


class EntityState extends EnumClass {
  static Serializer<EntityState> get serializer => _$entityStateSerializer;

  static const EntityState active = _$active;
  static const EntityState archived = _$archived;
  static const EntityState deleted = _$deleted;

  const EntityState._(String name) : super(name);

  static BuiltSet<EntityState> get values => _$values;
  static EntityState valueOf(String name) => _$valueOf(name);
}


abstract class BaseEntity {

  @nullable
  int get id;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;

  @nullable
  @BuiltValueField(wireName: 'is_deleted')
  bool get isDeleted;

  bool isActive() {
    return this.archivedAt == null;
  }

  bool isArchived() {
    return this.archivedAt != null && ! isDeleted;
  }

  bool matchesStates(BuiltList<EntityState> states) {
    if (states.length == 0) {
      return true;
    }

    if (states.contains(EntityState.active) && isActive()) {
      return true;
    }

    if (states.contains(EntityState.archived) && isArchived()) {
      return true;
    }

    if (states.contains(EntityState.deleted) && isDeleted) {
      return true;
    }

    return false;
  }
}



abstract class ErrorMessage implements Built<ErrorMessage, ErrorMessageBuilder> {

  String get message;

  ErrorMessage._();
  factory ErrorMessage([updates(ErrorMessageBuilder b)]) = _$ErrorMessage;
  static Serializer<ErrorMessage> get serializer => _$errorMessageSerializer;
}


abstract class LoginResponse implements Built<LoginResponse, LoginResponseBuilder> {

  BuiltList<CompanyEntity> get data;

  @nullable
  ErrorMessage get error;

  LoginResponse._();
  factory LoginResponse([updates(LoginResponseBuilder b)]) = _$LoginResponse;
  static Serializer<LoginResponse> get serializer => _$loginResponseSerializer;
}

abstract class CompanyEntity implements Built<CompanyEntity, CompanyEntityBuilder> {

  @nullable
  String get name;

  //@BuiltValueField(wireName: 'account_key')
  //String get companyKey;

  @nullable
  String get token;

  @nullable
  String get plan;

  @nullable
  @BuiltValueField(wireName: 'logo_url')
  String get logoUrl;

  CompanyEntity._();
  factory CompanyEntity([updates(CompanyEntityBuilder b)]) = _$CompanyEntity;
  static Serializer<CompanyEntity> get serializer => _$companyEntitySerializer;
}


abstract class DashboardResponse implements Built<DashboardResponse, DashboardResponseBuilder> {

  DashboardEntity get data;

  DashboardResponse._();
  factory DashboardResponse([updates(DashboardResponseBuilder b)]) = _$DashboardResponse;
  static Serializer<DashboardResponse> get serializer => _$dashboardResponseSerializer;
}


abstract class DashboardEntity implements Built<DashboardEntity, DashboardEntityBuilder> {

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

  DashboardEntity._();
  factory DashboardEntity([updates(DashboardEntityBuilder b)]) = _$DashboardEntity;
  static Serializer<DashboardEntity> get serializer => _$dashboardEntitySerializer;
}
