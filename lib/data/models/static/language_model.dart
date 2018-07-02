import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'language_model.g.dart';

abstract class LanguageListResponse implements Built<LanguageListResponse, LanguageListResponseBuilder> {

  factory LanguageListResponse([void updates(LanguageListResponseBuilder b)]) = _$LanguageListResponse;
  LanguageListResponse._();

  BuiltList<LanguageEntity> get data;

  static Serializer<LanguageListResponse> get serializer => _$languageListResponseSerializer;
}

abstract class LanguageItemResponse implements Built<LanguageItemResponse, LanguageItemResponseBuilder> {

  factory LanguageItemResponse([void updates(LanguageItemResponseBuilder b)]) = _$LanguageItemResponse;
  LanguageItemResponse._();

  LanguageEntity get data;

  static Serializer<LanguageItemResponse> get serializer => _$languageItemResponseSerializer;
}

class LanguageFields {
  static const String name = 'name';
  static const String locale = 'locale';
  
}

abstract class LanguageEntity implements Built<LanguageEntity, LanguageEntityBuilder> {

  factory LanguageEntity() {
    return _$LanguageEntity._(
      id: 0,
      name: '',
      locale: '',
    );
  }
  LanguageEntity._();

  int get id;
  String get name;
  String get locale;

  static Serializer<LanguageEntity> get serializer => _$languageEntitySerializer;
}

