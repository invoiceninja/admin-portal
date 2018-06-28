import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'frequency_model.g.dart';

abstract class FrequencyListResponse implements Built<FrequencyListResponse, FrequencyListResponseBuilder> {

  BuiltList<FrequencyEntity> get data;

  FrequencyListResponse._();
  factory FrequencyListResponse([updates(FrequencyListResponseBuilder b)]) = _$FrequencyListResponse;
  static Serializer<FrequencyListResponse> get serializer => _$frequencyListResponseSerializer;
}

abstract class FrequencyItemResponse implements Built<FrequencyItemResponse, FrequencyItemResponseBuilder> {

  FrequencyEntity get data;

  FrequencyItemResponse._();
  factory FrequencyItemResponse([updates(FrequencyItemResponseBuilder b)]) = _$FrequencyItemResponse;
  static Serializer<FrequencyItemResponse> get serializer => _$frequencyItemResponseSerializer;
}

class FrequencyFields {
  static const String name = 'name';
  static const String dateInterval = 'dateInterval';
  
}


abstract class FrequencyEntity implements Built<FrequencyEntity, FrequencyEntityBuilder> {

  factory FrequencyEntity() {
    return _$FrequencyEntity._(
      id: 0,
      name: '',
      dateInterval: '',
    );
  }

  int get id;
  String get name;
  @BuiltValueField(wireName: 'date_interval')
  String get dateInterval;

  FrequencyEntity._();
  static Serializer<FrequencyEntity> get serializer => _$frequencyEntitySerializer;
}

