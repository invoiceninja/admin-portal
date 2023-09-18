// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'date_format_model.g.dart';

abstract class DateFormatListResponse
    implements Built<DateFormatListResponse, DateFormatListResponseBuilder> {
  factory DateFormatListResponse(
          [void updates(DateFormatListResponseBuilder b)]) =
      _$DateFormatListResponse;

  DateFormatListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<DateFormatEntity> get data;

  static Serializer<DateFormatListResponse> get serializer =>
      _$dateFormatListResponseSerializer;
}

abstract class DateFormatItemResponse
    implements Built<DateFormatItemResponse, DateFormatItemResponseBuilder> {
  factory DateFormatItemResponse(
          [void updates(DateFormatItemResponseBuilder b)]) =
      _$DateFormatItemResponse;

  DateFormatItemResponse._();

  @override
  @memoized
  int get hashCode;

  DateFormatEntity get data;

  static Serializer<DateFormatItemResponse> get serializer =>
      _$dateFormatItemResponseSerializer;
}

class DateFormatFields {
  static const String format = 'format';
}

abstract class DateFormatEntity extends Object
    with SelectableEntity
    implements Built<DateFormatEntity, DateFormatEntityBuilder> {
  factory DateFormatEntity() {
    return _$DateFormatEntity._(
      id: '',
      format: '',
    );
  }

  DateFormatEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'format_dart')
  String get format;

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (filter.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String? matchesFilterValue(String? filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    /*
    if (location.toLowerCase().contains(filter)) {
      return location;
    }
    */

    return null;
  }

  String get preview {
    final formatter = DateFormat(format, 'en');
    return formatter.format(DateTime.parse('2000-01-31'));
  }

  @override
  String get listDisplayName => preview;

  @override
  double? get listDisplayAmount => null;

  static Serializer<DateFormatEntity> get serializer =>
      _$dateFormatEntitySerializer;
}
