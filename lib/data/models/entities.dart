import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entities.g.dart';

abstract class LoginResponse implements Built<LoginResponse, LoginResponseBuilder> {

  BuiltList<CompanyEntity> get data;

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

abstract class ProductResponse implements Built<ProductResponse, ProductResponseBuilder> {

  BuiltList<ProductEntity> get data;

  ProductResponse._();
  factory ProductResponse([updates(ProductResponseBuilder b)]) = _$ProductResponse;
  static Serializer<ProductResponse> get serializer => _$productResponseSerializer;
}


abstract class ProductEntity implements Built<ProductEntity, ProductEntityBuilder> {

  int get id;

  @BuiltValueField(wireName: 'product_key')
  String get productKey;
  String get notes;
  double get cost;

  //@JsonKey(name: 'tax_name1')
  //String taxName1;
  //@JsonKey(name: 'tax_rate1')
  //double taxRate1;
  //@JsonKey(name: 'tax_name2')
  //String taxName2;
  //@JsonKey(name: 'tax_rate2')
  //double taxRate2;
  //@JsonKey(name: 'updated_at')
  //int updatedAt;
  //@JsonKey(name: 'archived_at')
  //int archivedAt;
  //@JsonKey(name: 'custom_value1')
  //String customValue1;
  //@JsonKey(name: 'custom_value2')
  //String customValue2;
  //@JsonKey(name: 'is_deleted')
  //bool isDeleted;


  ProductEntity._();
  factory ProductEntity([updates(ProductEntityBuilder b)]) = _$ProductEntity;
  static Serializer<ProductEntity> get serializer => _$productEntitySerializer;
}
