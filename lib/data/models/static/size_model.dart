import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'size_model.g.dart';

abstract class SizeListResponse implements Built<SizeListResponse, SizeListResponseBuilder> {

  BuiltList<Size> get data;

  SizeListResponse._();
  factory SizeListResponse([updates(SizeListResponseBuilder b)]) = _$SizeListResponse;
  static Serializer<SizeListResponse> get serializer => _$sizeListResponseSerializer;
}

abstract class SizeItemResponse implements Built<SizeItemResponse, SizeItemResponseBuilder> {

  Size get data;

  SizeItemResponse._();
  factory SizeItemResponse([updates(SizeItemResponseBuilder b)]) = _$SizeItemResponse;
  static Serializer<SizeItemResponse> get serializer => _$sizeItemResponseSerializer;
}

class SizeFields {
  static const String name = 'name';
}

abstract class Size implements Built<Size, SizeBuilder> {
  
  @nullable
  String get name;
  
  Size._();
  factory Size([updates(SizeBuilder b)]) = _$Size;
  static Serializer<Size> get serializer => _$sizeSerializer;
}