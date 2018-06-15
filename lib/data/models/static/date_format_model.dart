import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'date_format_model.g.dart';

abstract class DateFormatListResponse implements Built<DateFormatListResponse, DateFormatListResponseBuilder> {

  BuiltList<DateFormatEntity> get data;

  DateFormatListResponse._();
  factory DateFormatListResponse([updates(DateFormatListResponseBuilder b)]) = _$DateFormatListResponse;
  static Serializer<DateFormatListResponse> get serializer => _$dateFormatListResponseSerializer;
}

abstract class DateFormatItemResponse implements Built<DateFormatItemResponse, DateFormatItemResponseBuilder> {

  DateFormatEntity get data;

  DateFormatItemResponse._();
  factory DateFormatItemResponse([updates(DateFormatItemResponseBuilder b)]) = _$DateFormatItemResponse;
  static Serializer<DateFormatItemResponse> get serializer => _$dateFormatItemResponseSerializer;
}

class DateFormatFields {
  static const String format = 'format';
  static const String pickerFormat = 'pickerFormat';
  static const String formatMoment = 'formatMoment';
}

abstract class DateFormatEntity implements Built<DateFormatEntity, DateFormatEntityBuilder> {
  
  @nullable
  String get format;

  @nullable
  @BuiltValueField(wireName: 'picker_format')
  String get pickerFormat;

  @nullable
  @BuiltValueField(wireName: 'format_moment')
  String get formatMoment;
  
  DateFormatEntity._();
  factory DateFormatEntity([updates(DateFormatEntityBuilder b)]) = _$DateFormatEntity;
  static Serializer<DateFormatEntity> get serializer => _$dateFormatEntitySerializer;
}