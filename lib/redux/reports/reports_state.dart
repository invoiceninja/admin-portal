import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/utils/dates.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'reports_state.g.dart';

abstract class ReportsUIState
    implements Built<ReportsUIState, ReportsUIStateBuilder> {
  factory ReportsUIState() {
    return _$ReportsUIState._(
      report: kReportActivity,
      dateRange: DateRange.last30Days,
      customStartDate: '',
      customEndDate: convertDateTimeToSqlDate(),
      currencyId: kCurrencyAll,
      offset: 0,
    );
  }

  ReportsUIState._();

  String get report;

  DateRange get dateRange;

  String get customStartDate;

  String get customEndDate;

  int get offset;

  String get currencyId;

  static Serializer<ReportsUIState> get serializer =>
      _$reportsUIStateSerializer;

  bool matchesCurrency(String match) {
    if (currencyId == null ||
        currencyId.isEmpty ||
        currencyId == kCurrencyAll) {
      return true;
    }

    return currencyId == match;
  }


  String startDate(CompanyEntity company) {
    final today = DateTime.now();
    final firstDayOfMonth = DateTime.utc(today.year, today.month, 1);
    final firstDayOfYear = DateTime.utc(
        today.year, int.tryParse(company.firstMonthOfYear) ?? 0, 1);
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
        final startDate = customStartDate.isEmpty
            ? DateTime.now()
            : DateTime.parse(customStartDate);
        final endDate = customEndDate.isEmpty
            ? DateTime.now()
            : DateTime.parse(customEndDate);
        final days = endDate.difference(startDate).inDays;
        return convertDateTimeToSqlDate(
            startDate.subtract(Duration(days: days * offset)));
    }
  }

  String endDate(CompanyEntity company) {
    final today = DateTime.now();
    final firstDayOfMonth = DateTime.utc(today.year, today.month, 1);
    final firstDayOfYear = DateTime.utc(
        today.year, int.tryParse(company.firstMonthOfYear) ?? 0, 1);
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
        final startDate = customStartDate.isEmpty
            ? DateTime.now()
            : DateTime.parse(customStartDate);
        final endDate = customEndDate.isEmpty
            ? DateTime.now()
            : DateTime.parse(customEndDate);
        final days = endDate.difference(startDate).inDays;
        return convertDateTimeToSqlDate(
            endDate.subtract(Duration(days: days * offset)));
    }
  }

}
