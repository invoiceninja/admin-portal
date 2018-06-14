import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'industry_model.g.dart';

abstract class IndustryListResponse implements Built<IndustryListResponse, IndustryListResponseBuilder> {

  BuiltList<Industry> get data;

  IndustryListResponse._();
  factory IndustryListResponse([updates(IndustryListResponseBuilder b)]) = _$IndustryListResponse;
  static Serializer<IndustryListResponse> get serializer => _$industryListResponseSerializer;
}

abstract class IndustryItemResponse implements Built<IndustryItemResponse, IndustryItemResponseBuilder> {

  Industry get data;

  IndustryItemResponse._();
  factory IndustryItemResponse([updates(IndustryItemResponseBuilder b)]) = _$IndustryItemResponse;
  static Serializer<IndustryItemResponse> get serializer => _$industryItemResponseSerializer;
}

class IndustryFields {
  static const String name = 'name';
}

abstract class Industry implements Built<Industry, IndustryBuilder> {
  
  @nullable
  String get name;
  
  Industry._();
  factory Industry([updates(IndustryBuilder b)]) = _$Industry;
  static Serializer<Industry> get serializer => _$industrySerializer;
}