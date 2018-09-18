import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_model.g.dart';

class DateRange extends EnumClass {
  const DateRange._(String name) : super(name);

  static Serializer<DateRange> get serializer => _$dateRangeSerializer;

  static const DateRange last7Days = _$last7Days;
  static const DateRange lastWeek = _$lastWeek;
  static const DateRange last30Days = _$last30Days;
  static const DateRange thisMonth = _$thisMonth;
  static const DateRange lastMonth = _$lastMonth;
  static const DateRange thisYear = _$thisYear;
  static const DateRange lastYear = _$lastYear;
  static const DateRange custom = _$custom;

  static BuiltSet<DateRange> get values => _$values;

  static DateRange valueOf(String name) => _$valueOf(name);
}

class DateRangeComparison extends EnumClass {
  const DateRangeComparison._(String name) : super(name);

  static Serializer<DateRangeComparison> get serializer => _$dateRangeComparisonSerializer;

  static const DateRangeComparison previousPeriod = _$previousPeriod;
  static const DateRangeComparison previousYear = _$previousYear;
  static const DateRangeComparison customRange = _$customRange;

  static BuiltSet<DateRangeComparison> get values => _$comparisonValues;

  static DateRangeComparison valueOf(String name) => _$comparisonValueOf(name);
}
