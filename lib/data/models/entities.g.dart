// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

BaseListResponse _$BaseListResponseFromJson(Map<String, dynamic> json) =>
    new BaseListResponse(json['data'] as List);

abstract class _$BaseListResponseSerializerMixin {
  List<dynamic> get data;
  Map<String, dynamic> toJson() => <String, dynamic>{'data': data};
}

BaseItemResponse _$BaseItemResponseFromJson(Map<String, dynamic> json) =>
    new BaseItemResponse(json['data']);

abstract class _$BaseItemResponseSerializerMixin {
  dynamic get data;
  Map<String, dynamic> toJson() => <String, dynamic>{'data': data};
}

CompanyEntity _$CompanyEntityFromJson(Map<String, dynamic> json) =>
    new CompanyEntity(json['id'] as int)
      ..name = json['name'] as String
      ..companyKey = json['account_key'] as String
      ..token = json['token'] as String
      ..plan = json['plan'] as String
      ..logoUrl = json['logo_url'] as String;

abstract class _$CompanyEntitySerializerMixin {
  int get id;
  String get name;
  String get companyKey;
  String get token;
  String get plan;
  String get logoUrl;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'account_key': companyKey,
        'token': token,
        'plan': plan,
        'logo_url': logoUrl
      };
}

DashboardEntity _$DashboardEntityFromJson(Map<String, dynamic> json) =>
    new DashboardEntity(
        (json['paidToDate'] as num)?.toDouble(),
        json['paidToDateCurrency'] as int,
        (json['balances'] as num)?.toDouble(),
        json['balancesCurrency'] as int,
        (json['averageInvoice'] as num)?.toDouble(),
        json['averageInvoiceCurrency'] as int,
        json['invoicesSent'] as int,
        json['activeClients'] as int);

abstract class _$DashboardEntitySerializerMixin {
  double get paidToDate;
  int get paidToDateCurrency;
  double get balances;
  int get balancesCurrency;
  double get averageInvoice;
  int get averageInvoiceCurrency;
  int get invoicesSent;
  int get activeClients;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'paidToDate': paidToDate,
        'paidToDateCurrency': paidToDateCurrency,
        'balances': balances,
        'balancesCurrency': balancesCurrency,
        'averageInvoice': averageInvoice,
        'averageInvoiceCurrency': averageInvoiceCurrency,
        'invoicesSent': invoicesSent,
        'activeClients': activeClients
      };
}

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    new ProductEntity(json['id'] as int)
      ..productKey = json['product_key'] as String
      ..notes = json['notes'] as String
      ..cost = (json['cost'] as num)?.toDouble();

abstract class _$ProductEntitySerializerMixin {
  int get id;
  String get productKey;
  String get notes;
  double get cost;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'product_key': productKey,
        'notes': notes,
        'cost': cost
      };
}
