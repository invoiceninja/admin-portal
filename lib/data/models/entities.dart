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

  String get name;

  //@BuiltValueField(wireName: 'account_key')
  //String get companyKey;

  String get token;

  @nullable
  String get plan;

  @BuiltValueField(wireName: 'logo_url')
  String get logoUrl;

  factory CompanyEntity() {
    return _$CompanyEntity._(
      name: '',
      token: '',
      logoUrl: '',
    );
  }

  CompanyEntity._();
  //factory CompanyEntity([updates(CompanyEntityBuilder b)]) = _$CompanyEntity;
  static Serializer<CompanyEntity> get serializer => _$companyEntitySerializer;
}


abstract class DashboardResponse implements Built<DashboardResponse, DashboardResponseBuilder> {

  DashboardEntity get data;

  DashboardResponse._();
  factory DashboardResponse([updates(DashboardResponseBuilder b)]) = _$DashboardResponse;
  static Serializer<DashboardResponse> get serializer => _$dashboardResponseSerializer;
}


abstract class DashboardEntity implements Built<DashboardEntity, DashboardEntityBuilder> {
  double get paidToDate;
  int get paidToDateCurrency;
  double get balances;
  int get balancesCurrency;
  double get averageInvoice;
  int get averageInvoiceCurrency;
  int get invoicesSent;
  int get activeClients;


  factory DashboardEntity() {
    return _$DashboardEntity._(
      paidToDate: 0.0,
      paidToDateCurrency: 1,
      balances: 0.0,
      balancesCurrency: 1,
      averageInvoice: 0.0,
      averageInvoiceCurrency: 1,
      invoicesSent: 0,
      activeClients: 0,
    );
  }


  DashboardEntity._();
  //factory DashboardEntity([updates(DashboardEntityBuilder b)]) = _$DashboardEntity;
  static Serializer<DashboardEntity> get serializer => _$dashboardEntitySerializer;
}
