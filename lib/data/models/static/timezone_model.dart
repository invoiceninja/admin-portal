import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'timezone_model.g.dart';

abstract class TimezoneListResponse implements Built<TimezoneListResponse, TimezoneListResponseBuilder> {

  BuiltList<Timezone> get data;

  TimezoneListResponse._();
  factory TimezoneListResponse([updates(TimezoneListResponseBuilder b)]) = _$TimezoneListResponse;
  static Serializer<TimezoneListResponse> get serializer => _$timezoneListResponseSerializer;
}

abstract class TimezoneItemResponse implements Built<TimezoneItemResponse, TimezoneItemResponseBuilder> {

  Timezone get data;

  TimezoneItemResponse._();
  factory TimezoneItemResponse([updates(TimezoneItemResponseBuilder b)]) = _$TimezoneItemResponse;
  static Serializer<TimezoneItemResponse> get serializer => _$timezoneItemResponseSerializer;
}

class TimezoneFields {
  static const String name = 'name';
  static const String location = 'location';
}

abstract class Timezone implements Built<Timezone, TimezoneBuilder> {
  
  @nullable
  String get name;

  @nullable
  String get location;
  
  Timezone._();
  factory Timezone([updates(TimezoneBuilder b)]) = _$Timezone;
  static Serializer<Timezone> get serializer => _$timezoneSerializer;
}