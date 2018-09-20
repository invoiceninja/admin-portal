import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'dashboard_state.g.dart';

abstract class DashboardState implements Built<DashboardState, DashboardStateBuilder> {

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
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded {
    return lastUpdated != null && lastUpdated > 0;
  }

  static Serializer<DashboardState> get serializer => _$dashboardStateSerializer;
}


abstract class DashboardUIState implements Built<DashboardUIState, DashboardUIStateBuilder> {

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

  static Serializer<DashboardUIState> get serializer => _$dashboardUIStateSerializer;

  String get startDate {
    final today = DateTime.now();
    switch (dateRange) {
      case DateRange.last7Days:
        final date = DateTime.now().subtract(Duration(days: 7));
        return convertDateTimeToSqlDate(date);
      case DateRange.last30Days:
        final date = DateTime.now().subtract(Duration(days: 30));
        return convertDateTimeToSqlDate(date);
      case DateRange.thisMonth:
        final date = DateTime.utc(today.year, today.month, 1);
        return convertDateTimeToSqlDate(date);
      case DateRange.lastMonth:
        int lastMonth;
        int lastYear;
        if (today.month == 1) {
          lastMonth = 12;
          lastYear = today.year - 1;
        } else {
          lastMonth = today.month - 1;
          lastYear = today.year;
        }
        final date = DateTime.utc(lastYear, lastMonth, 1);
        return convertDateTimeToSqlDate(date);
      case DateRange.thisYear:
        final date = DateTime.utc(today.year, 1, 1);
        return convertDateTimeToSqlDate(date);
      case DateRange.lastYear:
        final date = DateTime.utc(today.year - 1, 1, 1);
        return convertDateTimeToSqlDate(date);
      default:
        return customStartDate;
    }
  }

  String get endDate {
    switch (dateRange) {
      case DateRange.lastMonth:
        final today = DateTime.now();
        final date = DateTime.utc(today.year, today.month, 1);
        return convertDateTimeToSqlDate(date);
      case DateRange.lastYear:
        final today = DateTime.now();
        final date = DateTime.utc(today.year, 1, 1);
        return convertDateTimeToSqlDate(date);
      case DateRange.custom:
        return customEndDate;
      default:
        return convertDateTimeToSqlDate();
    }
  }
}

