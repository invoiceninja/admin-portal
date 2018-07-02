import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'date_format_model.g.dart';

abstract class DateFormatListResponse implements Built<DateFormatListResponse, DateFormatListResponseBuilder> {

  BuiltList<DateFormatEntity> get data;

  DateFormatListResponse._();
  factory DateFormatListResponse([void updates(DateFormatListResponseBuilder b)]) = _$DateFormatListResponse;
  static Serializer<DateFormatListResponse> get serializer => _$dateFormatListResponseSerializer;
}

abstract class DateFormatItemResponse implements Built<DateFormatItemResponse, DateFormatItemResponseBuilder> {

  DateFormatEntity get data;

  DateFormatItemResponse._();
  factory DateFormatItemResponse([void updates(DateFormatItemResponseBuilder b)]) = _$DateFormatItemResponse;
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
      pickerFormat: '',
      formatMoment: '',
    );
  }

  int get id;

  String get format;

  @BuiltValueField(wireName: 'picker_format')
  String get pickerFormat;

  @BuiltValueField(wireName: 'format_moment')
  String get formatMoment;
  
  DateFormatEntity._();
  static Serializer<DateFormatEntity> get serializer => _$dateFormatEntitySerializer;
}