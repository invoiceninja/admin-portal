// Dart imports:
import 'dart:math';

// Project imports:
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

const _daysInMonth = const [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

bool isLeapYear(int value) =>
    value % 400 == 0 || (value % 4 == 0 && value % 100 != 0);

int daysInMonth(int year, int month) {
  var result = _daysInMonth[month];
  if (month == 2 && isLeapYear(year)) {
    result++;
  }
  return result;
}

DateTime addYears(DateTime dateTime, int offset) {
  return DateTime.utc(dateTime.year + offset, dateTime.month, dateTime.day);
}

DateTime addDays(DateTime dateTime, int offset) {
  return dateTime.add(Duration(days: offset));
}

DateTime addMonths(DateTime dateTime, int offset) {
  final r = offset % 12;
  final q = (offset - r) ~/ 12;
  var newYear = dateTime.year + q;
  var newMonth = dateTime.month + r;
  if (newMonth > 12) {
    newYear++;
    newMonth -= 12;
  }
  final newDay = min(dateTime.day, daysInMonth(newYear, newMonth));
  if (dateTime.isUtc) {
    return new DateTime.utc(
        newYear,
        newMonth,
        newDay,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
        dateTime.millisecond,
        dateTime.microsecond);
  } else {
    return new DateTime(
        newYear,
        newMonth,
        newDay,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
        dateTime.millisecond,
        dateTime.microsecond);
  }
}

String? calculateStartDate({
  required CompanyEntity company,
  DateRange? dateRange,
  int offset = 0,
  String? customStartDate,
  String? customEndDate,
}) {
  final today = DateTime.now();
  final firstDayOfMonth = DateTime.utc(today.year, today.month, 1);
  final firstMonthOfYear = int.tryParse(company.firstMonthOfYear) ?? 1;
  final year = today.year - (firstMonthOfYear > today.month ? 1 : 0);
  final firstDayOfYear = DateTime.utc(year, firstMonthOfYear, 1);
  switch (dateRange) {
    case DateRange.last7Days:
      final date = today.subtract(Duration(days: 7 * (1 + offset)));
      return convertDateTimeToSqlDate(date);
    case DateRange.last30Days:
      final date = today.subtract(Duration(days: 30 * (1 + offset)));
      return convertDateTimeToSqlDate(date);
    case DateRange.last365Days:
      final date = today.subtract(Duration(days: 365 * (1 + offset)));
      return convertDateTimeToSqlDate(date);
    case DateRange.thisMonth:
      final date = addMonths(firstDayOfMonth, offset * -1);
      return convertDateTimeToSqlDate(date);
    case DateRange.lastMonth:
      final date = addMonths(firstDayOfMonth, (1 + offset) * -1);
      return convertDateTimeToSqlDate(date);
    case DateRange.thisQuarter:
      final monthOffset = (today.month - 1) % 3 * -1;
      final date = addMonths(firstDayOfMonth, (offset * -3) + monthOffset);
      return convertDateTimeToSqlDate(date);
    case DateRange.lastQuarter:
      final monthOffset = (today.month - 1) % 3 * -1;
      final date =
          addMonths(firstDayOfMonth, ((offset + 1) * -3) + monthOffset);
      return convertDateTimeToSqlDate(date);
    case DateRange.thisYear:
      final date = addYears(firstDayOfYear, offset * -1);
      return convertDateTimeToSqlDate(date);
    case DateRange.lastYear:
      final date = addYears(firstDayOfYear, (1 + offset) * -1);
      return convertDateTimeToSqlDate(date);
    case DateRange.allTime:
      return null;
    default:
      final startDate = (customStartDate == null || customStartDate.isEmpty)
          ? DateTime.now()
          : (DateTime.tryParse(customStartDate) ?? DateTime.now());
      final endDate = (customEndDate == null || customEndDate.isEmpty)
          ? DateTime.now()
          : (DateTime.tryParse(customEndDate) ?? DateTime.now());
      final days = endDate.difference(startDate).inDays;
      return convertDateTimeToSqlDate(
          startDate.subtract(Duration(days: days * offset)));
  }
}

String? calculateEndDate({
  required CompanyEntity company,
  DateRange? dateRange,
  int offset = 0,
  String? customStartDate,
  String? customEndDate,
}) {
  final today = DateTime.now();
  final firstDayOfMonth = DateTime.utc(today.year, today.month, 1);
  final firstMonthOfYear = int.tryParse(company.firstMonthOfYear) ?? 1;
  final year = today.year - (firstMonthOfYear > today.month ? 1 : 0);
  final firstDayOfYear = DateTime.utc(year, firstMonthOfYear, 1);
  switch (dateRange) {
    case DateRange.last7Days:
      final date = today.subtract(Duration(days: 7 * offset));
      return convertDateTimeToSqlDate(date);
    case DateRange.last30Days:
      final date = today.subtract(Duration(days: 30 * offset));
      return convertDateTimeToSqlDate(date);
    case DateRange.last365Days:
      final date = today.subtract(Duration(days: 365 * offset));
      return convertDateTimeToSqlDate(date);
    case DateRange.thisMonth:
      final date = addMonths(firstDayOfMonth, (offset - 1) * -1)
          .subtract(Duration(days: 1));
      return convertDateTimeToSqlDate(date);
    case DateRange.lastMonth:
      final date =
          addMonths(firstDayOfMonth, offset * -1).subtract(Duration(days: 1));
      return convertDateTimeToSqlDate(date);
    case DateRange.thisQuarter:
      final monthOffset = (today.month - 1) % 3 * -1;
      final date = addMonths(firstDayOfMonth, (offset * -3) + monthOffset + 3)
          .subtract(Duration(days: 1));
      return convertDateTimeToSqlDate(date);
    case DateRange.lastQuarter:
      final monthOffset = (today.month - 1) % 3 * -1;
      final date =
          addMonths(firstDayOfMonth, ((offset + 1) * -3) + monthOffset + 3)
              .subtract(Duration(days: 1));
      return convertDateTimeToSqlDate(date);
    case DateRange.thisYear:
      final date = addYears(firstDayOfYear, (offset - 1) * -1)
          .subtract(Duration(days: 1));
      return convertDateTimeToSqlDate(date);
    case DateRange.lastYear:
      final date =
          addYears(firstDayOfYear, offset * -1).subtract(Duration(days: 1));
      return convertDateTimeToSqlDate(date);
    case DateRange.allTime:
      return null;
    default:
      final startDate = (customStartDate == null || customStartDate.isEmpty)
          ? DateTime.now()
          : (DateTime.tryParse(customStartDate) ?? DateTime.now());
      final endDate = (customEndDate == null || customEndDate.isEmpty)
          ? DateTime.now()
          : (DateTime.tryParse(customEndDate) ?? DateTime.now());
      final days = endDate.difference(startDate).inDays;
      return convertDateTimeToSqlDate(
          endDate.subtract(Duration(days: days * offset)));
  }
}
