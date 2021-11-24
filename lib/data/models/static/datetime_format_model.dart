// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'datetime_format_model.g.dart';

abstract class DatetimeFormatListResponse
    implements
        Built<DatetimeFormatListResponse, DatetimeFormatListResponseBuilder> {
  factory DatetimeFormatListResponse(
          [void updates(DatetimeFormatListResponseBuilder b)]) =
      _$DatetimeFormatListResponse;
  DatetimeFormatListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<DatetimeFormatEntity> get data;

  static Serializer<DatetimeFormatListResponse> get serializer =>
      _$datetimeFormatListResponseSerializer;
}

abstract class DatetimeFormatItemResponse
    implements
        Built<DatetimeFormatItemResponse, DatetimeFormatItemResponseBuilder> {
  factory DatetimeFormatItemResponse(
          [void updates(DatetimeFormatItemResponseBuilder b)]) =
      _$DatetimeFormatItemResponse;
  DatetimeFormatItemResponse._();

  @override
  @memoized
  int get hashCode;

  DatetimeFormatEntity get data;

  static Serializer<DatetimeFormatItemResponse> get serializer =>
      _$datetimeFormatItemResponseSerializer;
}

class DatetimeFormatFields {
  static const String format = 'format';
  static const String formatMoment = 'format_moment';
}

abstract class DatetimeFormatEntity
    implements Built<DatetimeFormatEntity, DatetimeFormatEntityBuilder> {
  factory DatetimeFormatEntity() {
    return _$DatetimeFormatEntity._(
      id: '',
      format: '',
    );
  }
  DatetimeFormatEntity._();

  @override
  @memoized
  int get hashCode;

  String get id;

  @BuiltValueField(wireName: 'format_dart')
  String get format;

  static Serializer<DatetimeFormatEntity> get serializer =>
      _$datetimeFormatEntitySerializer;
}
