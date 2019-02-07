import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/utils/dates.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'dashboard_state.g.dart';

abstract class DashboardState
    implements Built<DashboardState, DashboardStateBuilder> {
  factory DashboardState() {
    return _$DashboardState._(
      data: null,
    );
  }

  DashboardState._();

  @nullable
  int get lastUpdated;

  @nullable
  DashboardEntity get data;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded {
    return lastUpdated != null && lastUpdated > 0;
  }

  static Serializer<DashboardState> get serializer =>
      _$dashboardStateSerializer;
}

abstract class DashboardUIState
    implements Built<DashboardUIState, DashboardUIStateBuilder> {
  factory DashboardUIState() {
    return _$DashboardUIState._(
      dateRange: DateRange.last30Days,
      customStartDate: '',
      customEndDate: convertDateTimeToSqlDate(),
      enableComparison: true,
      compareDateRange: DateRangeComparison.previousPeriod,
      compareCustomStartDate: '',
      compareCustomEndDate: convertDateTimeToSqlDate(),
      offset: 0,
      currencyId: 0,
    );
  }

  DashboardUIState._();

  DateRange get dateRange;

  String get customStartDate;

  String get customEndDate;

  bool get enableComparison;

  DateRangeComparison get compareDateRange;

  String get compareCustomStartDate;

  String get compareCustomEndDate;

  int get offset;

  int get currencyId;

  static Serializer<DashboardUIState> get serializer =>
      _$dashboardUIStateSerializer;

  String startDate(CompanyEntity company) {
    final today = DateTime.now();
    final firstDayOfMonth = DateTime.utc(today.year, today.month, 1);
    final firstDayOfYear = DateTime.utc(today.year, company.firstMonthOfYear, 1);
    switch (dateRange) {
      case DateRange.last7Days:
        final date = today.subtract(Duration(days: 7 * (1 + offset)));
        return convertDateTimeToSqlDate(date);
      case DateRange.last30Days:
        final date = today.subtract(Duration(days: 30 * (1 + offset)));
        return convertDateTimeToSqlDate(date);
      case DateRange.thisMonth:
        final date = addMonths(firstDayOfMonth, offset * -1);
        return convertDateTimeToSqlDate(date);
      case DateRange.lastMonth:
        final date = addMonths(firstDayOfMonth, (1 + offset) * -1);
        return convertDateTimeToSqlDate(date);
      case DateRange.thisYear:
        final date = addYears(firstDayOfYear, offset * -1);
        return convertDateTimeToSqlDate(date);
      case DateRange.lastYear:
        final date = addYears(firstDayOfYear, (1 + offset) * -1);
        return convertDateTimeToSqlDate(date);
      default:
        final startDate = DateTime.parse(customStartDate);
        final endDate = DateTime.parse(customEndDate);
        final days = endDate.difference(startDate).inDays;
        return convertDateTimeToSqlDate(
            startDate.subtract(Duration(days: days * offset)));
    }
  }

  String endDate(CompanyEntity company) {
    final today = DateTime.now();
    final firstDayOfMonth = DateTime.utc(today.year, today.month, 1);
    final firstDayOfYear = DateTime.utc(today.year, company.firstMonthOfYear, 1);
    switch (dateRange) {
      case DateRange.last7Days:
        final date = today.subtract(Duration(days: 7 * offset));
        return convertDateTimeToSqlDate(date);
      case DateRange.last30Days:
        final date = today.subtract(Duration(days: 30 * offset));
        return convertDateTimeToSqlDate(date);
      case DateRange.thisMonth:
        final date = addMonths(firstDayOfMonth, (offset - 1) * -1)
            .subtract(Duration(days: 1));
        return convertDateTimeToSqlDate(date);
      case DateRange.lastMonth:
        final date =
            addMonths(firstDayOfMonth, offset * -1).subtract(Duration(days: 1));
        return convertDateTimeToSqlDate(date);
      case DateRange.thisYear:
        final date = addYears(firstDayOfYear, (offset - 1) * -1)
            .subtract(Duration(days: 1));
        return convertDateTimeToSqlDate(date);
      case DateRange.lastYear:
        final date =
            addYears(firstDayOfYear, offset * -1).subtract(Duration(days: 1));
        return convertDateTimeToSqlDate(date);
      default:
        final startDate = DateTime.parse(customStartDate);
        final endDate = DateTime.parse(customEndDate);
        final days = endDate.difference(startDate).inDays;
        return convertDateTimeToSqlDate(
            endDate.subtract(Duration(days: days * offset)));
    }
  }
}
