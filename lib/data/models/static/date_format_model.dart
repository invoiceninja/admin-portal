import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'date_format_model.g.dart';

abstract class DateFormatListResponse implements Built<DateFormatListResponse, DateFormatListResponseBuilder> {

  factory DateFormatListResponse([void updates(DateFormatListResponseBuilder b)]) = _$DateFormatListResponse;
  DateFormatListResponse._();

  BuiltList<DateFormatEntity> get data;

  static Serializer<DateFormatListResponse> get serializer => _$dateFormatListResponseSerializer;
}

abstract class DateFormatItemResponse implements Built<DateFormatItemResponse, DateFormatItemResponseBuilder> {

  factory DateFormatItemResponse([void updates(DateFormatItemResponseBuilder b)]) = _$DateFormatItemResponse;
  DateFormatItemResponse._();

  DateFormatEntity get data;

  static Serializer<DateFormatItemResponse> get serializer => _$dateFormatItemResponseSerializer;
}

class DateFormatFields {
  static const String format = 'format';
  static const String pickerFormat = 'pickerFormat';
  static const String formatMoment = 'formatMoment';
}

abstract class DateFormatEntity implements Built<DateFormatEntity, DateFormatEntityBuilder> {
  
  factory DateFormatEntity() {
    return _$DateFormatEntity._(
      id: 0,
      format: '',
    );
  }
  DateFormatEntity._();

  int get id;

  @BuiltValueField(wireName: 'format_dart')
  String get format;

  static Serializer<DateFormatEntity> get serializer => _$dateFormatEntitySerializer;
}