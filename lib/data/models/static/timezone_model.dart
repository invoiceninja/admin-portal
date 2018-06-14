import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'timezone_model.g.dart';

abstract class TimezoneListResponse implements Built<TimezoneListResponse, TimezoneListResponseBuilder> {

  BuiltList<TimezoneEntity> get data;

  TimezoneListResponse._();
  factory TimezoneListResponse([updates(TimezoneListResponseBuilder b)]) = _$TimezoneListResponse;
  static Serializer<TimezoneListResponse> get serializer => _$timezoneListResponseSerializer;
}

abstract class TimezoneItemResponse implements Built<TimezoneItemResponse, TimezoneItemResponseBuilder> {

  TimezoneEntity get data;

  TimezoneItemResponse._();
  factory TimezoneItemResponse([updates(TimezoneItemResponseBuilder b)]) = _$TimezoneItemResponse;
  static Serializer<TimezoneItemResponse> get serializer => _$timezoneItemResponseSerializer;
}

class TimezoneFields {
  static const String name = 'name';
  static const String location = 'location';
}

abstract class TimezoneEntity implements Built<TimezoneEntity, TimezoneEntityBuilder> {
  
  @nullable
  String get name;

  @nullable
  String get location;
  
  TimezoneEntity._();
  factory TimezoneEntity([updates(TimezoneEntityBuilder b)]) = _$TimezoneEntity;
  static Serializer<TimezoneEntity> get serializer => _$timezoneEntitySerializer;
}