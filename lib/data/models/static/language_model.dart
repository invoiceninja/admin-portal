import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'language_model.g.dart';

abstract class LanguageListResponse implements Built<LanguageListResponse, LanguageListResponseBuilder> {

  BuiltList<LanguageEntity> get data;

  LanguageListResponse._();
  factory LanguageListResponse([updates(LanguageListResponseBuilder b)]) = _$LanguageListResponse;
  static Serializer<LanguageListResponse> get serializer => _$languageListResponseSerializer;
}

abstract class LanguageItemResponse implements Built<LanguageItemResponse, LanguageItemResponseBuilder> {

  LanguageEntity get data;

  LanguageItemResponse._();
  factory LanguageItemResponse([updates(LanguageItemResponseBuilder b)]) = _$LanguageItemResponse;
  static Serializer<LanguageItemResponse> get serializer => _$languageItemResponseSerializer;
}

class LanguageFields {
  static const String name = 'name';
  static const String locale = 'locale';
  
}


abstract class LanguageEntity implements Built<LanguageEntity, LanguageEntityBuilder> {

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'locale')
  String get locale;

 


  LanguageEntity._();
  factory LanguageEntity([updates(LanguageEntityBuilder b)]) = _$LanguageEntity;
  static Serializer<LanguageEntity> get serializer => _$languageEntitySerializer;
}

