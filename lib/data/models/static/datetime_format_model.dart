import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'datetime_format_model.g.dart';

abstract class DatetimeFormatListResponse implements Built<DatetimeFormatListResponse, DatetimeFormatListResponseBuilder> {

  factory DatetimeFormatListResponse([void updates(DatetimeFormatListResponseBuilder b)]) = _$DatetimeFormatListResponse;
  DatetimeFormatListResponse._();

  BuiltList<DatetimeFormatEntity> get data;

  static Serializer<DatetimeFormatListResponse> get serializer => _$datetimeFormatListResponseSerializer;
}

abstract class DatetimeFormatItemResponse implements Built<DatetimeFormatItemResponse, DatetimeFormatItemResponseBuilder> {

  factory DatetimeFormatItemResponse([void updates(DatetimeFormatItemResponseBuilder b)]) = _$DatetimeFormatItemResponse;
  DatetimeFormatItemResponse._();

  DatetimeFormatEntity get data;

  static Serializer<DatetimeFormatItemResponse> get serializer => _$datetimeFormatItemResponseSerializer;
}

class DatetimeFormatFields {
  static const String format = 'format';
  static const String formatMoment = 'formatMoment';
}

abstract class DatetimeFormatEntity implements Built<DatetimeFormatEntity, DatetimeFormatEntityBuilder> {

  factory DatetimeFormatEntity() {
    return _$DatetimeFormatEntity._(
      id: 0,
      format: '',
    );
  }
  DatetimeFormatEntity._();

  int get id;

  @BuiltValueField(wireName: 'format_dart')
  String get format;

  static Serializer<DatetimeFormatEntity> get serializer => _$datetimeFormatEntitySerializer;
}