// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DateRange _$last7Days = const DateRange._('last7Days');
const DateRange _$last30Days = const DateRange._('last30Days');
const DateRange _$last365Days = const DateRange._('last365Days');
const DateRange _$thisMonth = const DateRange._('thisMonth');
const DateRange _$lastMonth = const DateRange._('lastMonth');
const DateRange _$thisQuarter = const DateRange._('thisQuarter');
const DateRange _$lastQuarter = const DateRange._('lastQuarter');
const DateRange _$thisYear = const DateRange._('thisYear');
const DateRange _$lastYear = const DateRange._('lastYear');
const DateRange _$allTime = const DateRange._('allTime');
const DateRange _$custom = const DateRange._('custom');

DateRange _$valueOf(String name) {
  switch (name) {
    case 'last7Days':
      return _$last7Days;
    case 'last30Days':
      return _$last30Days;
    case 'last365Days':
      return _$last365Days;
    case 'thisMonth':
      return _$thisMonth;
    case 'lastMonth':
      return _$lastMonth;
    case 'thisQuarter':
      return _$thisQuarter;
    case 'lastQuarter':
      return _$lastQuarter;
    case 'thisYear':
      return _$thisYear;
    case 'lastYear':
      return _$lastYear;
    case 'allTime':
      return _$allTime;
    case 'custom':
      return _$custom;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DateRange> _$values = new BuiltSet<DateRange>(const <DateRange>[
  _$last7Days,
  _$last30Days,
  _$last365Days,
  _$thisMonth,
  _$lastMonth,
  _$thisQuarter,
  _$lastQuarter,
  _$thisYear,
  _$lastYear,
  _$allTime,
  _$custom,
]);

const DateRangeComparison _$previousPeriod =
    const DateRangeComparison._('previousPeriod');
const DateRangeComparison _$previousYear =
    const DateRangeComparison._('previousYear');
const DateRangeComparison _$customRange =
    const DateRangeComparison._('customRange');

DateRangeComparison _$comparisonValueOf(String name) {
  switch (name) {
    case 'previousPeriod':
      return _$previousPeriod;
    case 'previousYear':
      return _$previousYear;
    case 'customRange':
      return _$customRange;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DateRangeComparison> _$comparisonValues =
    new BuiltSet<DateRangeComparison>(const <DateRangeComparison>[
  _$previousPeriod,
  _$previousYear,
  _$customRange,
]);

Serializer<DateRange> _$dateRangeSerializer = new _$DateRangeSerializer();
Serializer<DateRangeComparison> _$dateRangeComparisonSerializer =
    new _$DateRangeComparisonSerializer();

class _$DateRangeSerializer implements PrimitiveSerializer<DateRange> {
  @override
  final Iterable<Type> types = const <Type>[DateRange];
  @override
  final String wireName = 'DateRange';

  @override
  Object serialize(Serializers serializers, DateRange object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  DateRange deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DateRange.valueOf(serialized as String);
}

class _$DateRangeComparisonSerializer
    implements PrimitiveSerializer<DateRangeComparison> {
  @override
  final Iterable<Type> types = const <Type>[DateRangeComparison];
  @override
  final String wireName = 'DateRangeComparison';

  @override
  Object serialize(Serializers serializers, DateRangeComparison object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  DateRangeComparison deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DateRangeComparison.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
