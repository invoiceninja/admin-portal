import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';


@JsonSerializable()
class ErrorResponse extends Object with _$ErrorResponseSerializerMixin {

  final String message;

  ErrorResponse(
      this.message,
      );

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}


@JsonSerializable()
class BaseListResponse extends Object with _$BaseListResponseSerializerMixin {

  @JsonKey(name: "data")
  final List<dynamic> data;
  final ErrorResponse error;

  BaseListResponse(
      this.data,
      this.error,
      );

  factory BaseListResponse.fromJson(Map<String, dynamic> json) => _$BaseListResponseFromJson(json);
}

@JsonSerializable()
class BaseItemResponse extends Object with _$BaseItemResponseSerializerMixin {
  //final String message;

  @JsonKey(name: "data")
  final dynamic data;
  final ErrorResponse error;

  BaseItemResponse(
      this.data,
      this.error,
      );

  factory BaseItemResponse.fromJson(Map<String, dynamic> json) => _$BaseItemResponseFromJson(json);
}


@JsonSerializable()
class CompanyEntity extends Object with _$CompanyEntitySerializerMixin {

  final int id;
  String name;

  @JsonKey(name: 'account_key')
  String companyKey;

  String token;
  String plan;

  @JsonKey(name: 'logo_url')
  String logoUrl;

  CompanyEntity(this.id);

  factory CompanyEntity.fromJson(Map<String, dynamic> json) => _$CompanyEntityFromJson(json);

  bool isBlank() => this.token == null;
}


@JsonSerializable()
class DashboardEntity extends Object with _$DashboardEntitySerializerMixin {

  final double paidToDate;
  final int paidToDateCurrency;
  final double balances;
  final int balancesCurrency;
  final double averageInvoice;
  final int averageInvoiceCurrency;
  final int invoicesSent;
  final int activeClients;

  DashboardEntity([
    this.paidToDate = 0.0,
    this.paidToDateCurrency = 1,
    this.balances = 0.0,
    this.balancesCurrency = 1,
    this.averageInvoice = 0.0,
    this.averageInvoiceCurrency = 1,
    this.invoicesSent = 0,
    this.activeClients = 0,
  ]);

  factory DashboardEntity.fromJson(Map<String, dynamic> json) => _$DashboardEntityFromJson(json);
}


@JsonSerializable()
class ProductEntity extends Object with _$ProductEntitySerializerMixin {

  final int id;

  @JsonKey(name: 'product_key')
  String productKey;
  String notes;
  double cost;

  /*
  @JsonKey(name: 'tax_name1')
  String taxName1;
  @JsonKey(name: 'tax_rate1')
  double taxRate1;
  @JsonKey(name: 'tax_name2')
  String taxName2;
  @JsonKey(name: 'tax_rate2')
  double taxRate2;
  @JsonKey(name: 'updated_at')
  int updatedAt;
  @JsonKey(name: 'archived_at')
  int archivedAt;
  @JsonKey(name: 'custom_value1')
  String customValue1;
  @JsonKey(name: 'custom_value2')
  String customValue2;
  @JsonKey(name: 'is_deleted')
  bool isDeleted;
  */

  ProductEntity(this.id);

  factory ProductEntity.fromJson(Map<String, dynamic> json) => _$ProductEntityFromJson(json);
}