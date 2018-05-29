import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entities.g.dart';

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
