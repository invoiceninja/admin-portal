import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'timezone_model.g.dart';

abstract class TimezoneListResponse implements Built<TimezoneListResponse, TimezoneListResponseBuilder> {

  BuiltList<TimezoneEntity> get data;

  TimezoneListResponse._();
  factory TimezoneListResponse([void updates(TimezoneListResponseBuilder b)]) = _$TimezoneListResponse;
  static Serializer<TimezoneListResponse> get serializer => _$timezoneListResponseSerializer;
}

abstract class TimezoneItemResponse implements Built<TimezoneItemResponse, TimezoneItemResponseBuilder> {

  TimezoneEntity get data;

  TimezoneItemResponse._();
  factory TimezoneItemResponse([void updates(TimezoneItemResponseBuilder b)]) = _$TimezoneItemResponse;
  static Serializer<TimezoneItemResponse> get serializer => _$timezoneItemResponseSerializer;
}

class TimezoneFields {
  static const String name = 'name';
  static const String location = 'location';
}

abstract class TimezoneEntity implements Built<TimezoneEntity, TimezoneEntityBuilder> {
  
  factory TimezoneEntity() {
    return _$TimezoneEntity._(
      id: 0,
      name: '',
      location: '',
    );
  }

  int get id;

  String get name;

  String get location;
  
  TimezoneEntity._();
  static Serializer<TimezoneEntity> get serializer => _$timezoneEntitySerializer;
}