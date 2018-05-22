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
