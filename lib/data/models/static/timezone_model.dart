// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'timezone_model.g.dart';

abstract class TimezoneListResponse
    implements Built<TimezoneListResponse, TimezoneListResponseBuilder> {
  factory TimezoneListResponse([void updates(TimezoneListResponseBuilder b)]) =
      _$TimezoneListResponse;

  TimezoneListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TimezoneEntity> get data;

  static Serializer<TimezoneListResponse> get serializer =>
      _$timezoneListResponseSerializer;
}

abstract class TimezoneItemResponse
    implements Built<TimezoneItemResponse, TimezoneItemResponseBuilder> {
  factory TimezoneItemResponse([void updates(TimezoneItemResponseBuilder b)]) =
      _$TimezoneItemResponse;

  TimezoneItemResponse._();

  @override
  @memoized
  int get hashCode;

  TimezoneEntity get data;

  static Serializer<TimezoneItemResponse> get serializer =>
      _$timezoneItemResponseSerializer;
}

class TimezoneFields {
  static const String name = 'name';
  static const String location = 'location';
}

abstract class TimezoneEntity extends Object
    with SelectableEntity
    implements Built<TimezoneEntity, TimezoneEntityBuilder> {
  factory TimezoneEntity() {
    return _$TimezoneEntity._(
      id: '',
      name: '',
      location: '',
    );
  }

  TimezoneEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  String get location;

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    } else if (location.toLowerCase().contains(filter)) {
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

    if (location.toLowerCase().contains(filter)) {
      return location;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double? get listDisplayAmount => null;

  static Serializer<TimezoneEntity> get serializer =>
      _$timezoneEntitySerializer;
}
