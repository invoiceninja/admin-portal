// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    new ProductResponse((json['data'] as List)
        ?.map((e) => e == null
            ? null
            : new ProductEntity.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$ProductResponseSerializerMixin {
  List<ProductEntity> get products;
  Map<String, dynamic> toJson() => <String, dynamic>{'data': products};
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
