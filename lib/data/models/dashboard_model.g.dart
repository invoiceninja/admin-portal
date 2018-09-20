// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

const DateRange _$last7Days = const DateRange._('last7Days');
const DateRange _$last30Days = const DateRange._('last30Days');
const DateRange _$thisMonth = const DateRange._('thisMonth');
const DateRange _$lastMonth = const DateRange._('lastMonth');
const DateRange _$thisYear = const DateRange._('thisYear');
const DateRange _$lastYear = const DateRange._('lastYear');
const DateRange _$custom = const DateRange._('custom');

DateRange _$valueOf(String name) {
  switch (name) {
    case 'last7Days':
      return _$last7Days;
    case 'last30Days':
      return _$last30Days;
    case 'thisMonth':
      return _$thisMonth;
    case 'lastMonth':
      return _$lastMonth;
    case 'thisYear':
      return _$thisYear;
    case 'lastYear':
      return _$lastYear;
    case 'custom':
      return _$custom;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DateRange> _$values = new BuiltSet<DateRange>(const <DateRange>[
  _$last7Days,
  _$last30Days,
  _$thisMonth,
  _$lastMonth,
  _$thisYear,
  _$lastYear,
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
