import 'dart:math';

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