import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';

@JsonSerializable()
class BaseListResponse extends Object with _$BaseListResponseSerializerMixin {
  //final String message;

  @JsonKey(name: "data")
  final List<dynamic> data;

  BaseListResponse(
      this.data,
      );

  factory BaseListResponse.fromJson(Map<String, dynamic> json) => _$BaseListResponseFromJson(json);
}

@JsonSerializable()
class BaseItemResponse extends Object with _$BaseItemResponseSerializerMixin {
  //final String message;

  @JsonKey(name: "data")
  final dynamic data;

  BaseItemResponse(
      this.data,
      );

  factory BaseItemResponse.fromJson(Map<String, dynamic> json) => _$BaseItemResponseFromJson(json);
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