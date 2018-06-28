import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'size_model.g.dart';

abstract class SizeListResponse implements Built<SizeListResponse, SizeListResponseBuilder> {

  BuiltList<SizeEntity> get data;

  SizeListResponse._();
  factory SizeListResponse([updates(SizeListResponseBuilder b)]) = _$SizeListResponse;
  static Serializer<SizeListResponse> get serializer => _$sizeListResponseSerializer;
}

abstract class SizeItemResponse implements Built<SizeItemResponse, SizeItemResponseBuilder> {

  SizeEntity get data;

  SizeItemResponse._();
  factory SizeItemResponse([updates(SizeItemResponseBuilder b)]) = _$SizeItemResponse;
  static Serializer<SizeItemResponse> get serializer => _$sizeItemResponseSerializer;
}

class SizeFields {
  static const String name = 'name';
}

abstract class SizeEntity implements Built<SizeEntity, SizeEntityBuilder> {

  factory SizeEntity() {
    return _$SizeEntity._(
      id: 0,
      name: '',
    );
  }

  int get id;

  String get name;
  
  SizeEntity._();
  static Serializer<SizeEntity> get serializer => _$sizeEntitySerializer;
}