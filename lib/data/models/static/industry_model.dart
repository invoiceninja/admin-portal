import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'industry_model.g.dart';

abstract class IndustryListResponse implements Built<IndustryListResponse, IndustryListResponseBuilder> {

  BuiltList<IndustryEntity> get data;

  IndustryListResponse._();
  factory IndustryListResponse([void updates(IndustryListResponseBuilder b)]) = _$IndustryListResponse;
  static Serializer<IndustryListResponse> get serializer => _$industryListResponseSerializer;
}

abstract class IndustryItemResponse implements Built<IndustryItemResponse, IndustryItemResponseBuilder> {

  IndustryEntity get data;

  IndustryItemResponse._();
  factory IndustryItemResponse([void updates(IndustryItemResponseBuilder b)]) = _$IndustryItemResponse;
  static Serializer<IndustryItemResponse> get serializer => _$industryItemResponseSerializer;
}

class IndustryFields {
  static const String name = 'name';
}

abstract class IndustryEntity implements Built<IndustryEntity, IndustryEntityBuilder> {
  
  factory IndustryEntity() {
    return _$IndustryEntity._(
      id: 0,
      name: '',
    );
  }

  int get id;
  String get name;
  
  IndustryEntity._();
  static Serializer<IndustryEntity> get serializer => _$industryEntitySerializer;
}