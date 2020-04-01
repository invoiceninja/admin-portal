import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

double round(double value, int precision) {
  final int fac = pow(10, precision);
  return (value * fac).round() / fac;
}

int parseInt(String value, {bool zeroIsNull = false}) {
  value = value.replaceAll(RegExp(r'[^0-9\.\-]'), '');

  final intValue = int.tryParse(value) ?? 0;

  return (intValue == 0 && zeroIsNull) ? null : intValue;
}

double parseDouble(String value, {bool zeroIsNull = false}) {
  // check for comma as decimal separator
  final RegExp regExp = RegExp(r',[\d]{1,2}$');
  if (regExp.hasMatch(value)) {
    value = value.replaceAll('.', '');
    value = value.replaceAll(',', '.');
  }

  value = value.replaceAll(RegExp(r'[^0-9\.\-]'), '');

  final doubleValue = double.tryParse(value) ?? 0.0;

  return (doubleValue == 0 && zeroIsNull) ? null : doubleValue;
}

enum FormatNumberType {
  money, // $1,000.00
  percent, // 1,000.00%
  int, // 1,000
  double, // 1,000.00
  input, // 1000.00
  duration,
}

String formatNumber(
  double value,
  BuildContext context, {
  String clientId,
  String currencyId,
  FormatNumberType formatNumberType = FormatNumberType.money,
  bool showCurrencyCode,
  bool zeroIsNull = false,
  bool roundToTwo = false,
}) {
  if ((zeroIsNull || formatNumberType == FormatNumberType.input) &&
      value == 0) {
    return null;
  } else if (value == null) {
    return '';
  }

  if (roundToTwo) {
    value = round(value, 2);
  }

  if (formatNumberType == FormatNumberType.duration) {
    return formatDuration(Duration(seconds: value.toInt()));
  }

  final state = StoreProvider.of<AppState>(context).state;
  final CompanyEntity company = state.company;
  final ClientEntity client = state.clientState.map[clientId];
  final GroupEntity group = state.groupState.map[client?.groupId];

  String countryId;

  if (client != null && client.hasNameSet) {
    countryId = client.countryId;
  } else {
    countryId = company.settings.countryId;
  }

  if (currencyId == kCurrencyAll) {
    currencyId = company.currencyId;
  } else if (currencyId != null && currencyId.isNotEmpty) {
    // do nothing
  } else if (client != null && client.hasCurrency) {
    currencyId = client.currencyId;
  } else if (group != null && group.hasCurrency) {
    currencyId = group.currencyId;
  } else {
    currencyId = company.currencyId;
  }

  final CurrencyEntity currency = state.staticState.currencyMap[currencyId];
  final CountryEntity country =
      state.staticState.countryMap[countryId] ?? CountryEntity();

  if (currency == null) {
    return '';
  }

  String thousandSeparator = currency.thousandSeparator;
  String decimalSeparator = currency.decimalSeparator;
  bool swapCurrencySymbol = currency.swapCurrencySymbol;

  if (currency.id == kCurrencyEuro) {
    swapCurrencySymbol = country.swapCurrencySymbol;
    if (country.thousandSeparator != null &&
        country.thousandSeparator.isNotEmpty) {
      thousandSeparator = country.thousandSeparator;
    }
    if (country.decimalSeparator != null &&
        country.decimalSeparator.isNotEmpty) {
      decimalSeparator = country.decimalSeparator;
    }
  }

  numberFormatSymbols['custom'] = NumberSymbols(
    NAME: 'custom',
    DECIMAL_SEP: decimalSeparator,
    GROUP_SEP: thousandSeparator,
    ZERO_DIGIT: '0',
    PLUS_SIGN: '+',
    MINUS_SIGN: '-',
  );

  NumberFormat formatter;
  String formatted;

  if (formatNumberType == FormatNumberType.int) {
    return NumberFormat('#,##0', 'custom').format(value);
  } else if (formatNumberType == FormatNumberType.double) {
    return NumberFormat('#,##0.####', 'custom').format(value);
  } else if (formatNumberType == FormatNumberType.input) {
    return NumberFormat('#.####', 'custom').format(value);
  } else {
    if (formatNumberType == FormatNumberType.percent) {
      formatter = NumberFormat('#,##0.####', 'custom');
    } else {
      formatter = NumberFormat('#,##0.00##', 'custom');
    }
    formatted = formatter.format(value);
  }

  if (formatNumberType == FormatNumberType.percent) {
    return '$formatted%';
  } else if ((showCurrencyCode ?? company.settings.showCurrencyCode) ||
      currency.symbol.isEmpty) {
    return '$formatted ${currency.code}';
  } else if (swapCurrencySymbol) {
    return '$formatted ${currency.symbol.trim()}';
  } else {
    return '${currency.symbol}$formatted';
  }
}

String cleanPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAll(RegExp(r'\D'), '');
}

String formatURL(String url) {
  if (url.startsWith('http')) {
    return url;
  }

  return 'http://' + url;
}

String formatAddress(
    {dynamic object, bool isShipping = false, String delimiter = '\n'}) {
  var str = '';

  final String address1 =
      (isShipping ? object.shippingAddress1 : object.address1) ?? '';
  final String address2 =
      (isShipping ? object.shippingAddress2 : object.address2) ?? '';
  final String city = (isShipping ? object.shippingCity : object.city) ?? '';
  final String state = (isShipping ? object.shippingState : object.state) ?? '';
  final String postalCode =
      (isShipping ? object.shippingPostalCode : object.postalCode) ?? '';

  if (address1.isNotEmpty) {
    str += address1 + delimiter;
  }
  if (address2.isNotEmpty) {
    str += address2 + delimiter;
  }

  if (city.isNotEmpty || state.isNotEmpty || postalCode.isNotEmpty) {
    str += city + ',' + state + ' ' + postalCode;
  }

  return str;
}

String convertDateTimeToSqlDate([DateTime date]) {
  date = date ?? DateTime.now();
  return date.toIso8601String().split('T').first;
}

DateTime convertTimestampToDate(int timestamp) =>
    DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0) * 1000);

String convertTimestampToDateString(int timestamp) =>
    convertTimestampToDate(timestamp).toIso8601String();

String formatDuration(Duration duration, {bool showSeconds = true}) {
  final time = duration.toString().split('.')[0];

  if (showSeconds) {
    return time;
  } else {
    final parts = time.split(':');
    return '${parts[0]}:${parts[1]}';
  }
}

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, DateTime dateTime) {
  dateTime ??= DateTime.now();
  return DateTime(dateTime.year, dateTime.month, dateTime.day,
          timeOfDay?.hour ?? 0, timeOfDay?.minute ?? 0)
      .toUtc();
}

TimeOfDay convertDateTimeToTimeOfDay(DateTime dateTime) =>
    TimeOfDay(hour: dateTime?.hour ?? 0, minute: dateTime?.minute ?? 0);

String formatDateRange(String startDate, String endDate, BuildContext context) {
  final today = DateTime.now();

  final startDateTime = DateTime.tryParse(startDate).toLocal();
  final startFormatter =
      DateFormat(today.year == startDateTime.year ? 'MMM d' : 'MMM d, yyy');
  final startDateTimeString = startFormatter.format(startDateTime);

  final endDateTime = DateTime.tryParse(endDate).toLocal();
  final endFormatter =
      DateFormat(today.year == endDateTime.year ? 'MMM d' : 'MMM d, yyy');
  final endDateTimeString = endFormatter.format(endDateTime);

  return '$startDateTimeString - $endDateTimeString';
}

String formatDate(String value, BuildContext context,
    {bool showDate = true, bool showTime = false, bool showSeconds = true}) {
  if (value == null || value.isEmpty) {
    return '';
  }

  final state = StoreProvider.of<AppState>(context).state;
  final CompanyEntity company = state.company;

  if (state.staticState.dateFormatMap.isEmpty) {
    return '';
  }

  if (showTime) {
    String format;
    if (!showDate) {
      format = showSeconds
          ? company.settings.enableMilitaryTime ? 'H:mm:ss' : 'h:mm:ss a'
          : company.settings.enableMilitaryTime ? 'H:mm' : 'h:mm a';
    } else {
      final dateFormats = state.staticState.dateFormatMap;
      final dateFormatId = (company.settings.dateFormatId ?? '').isNotEmpty
          ? company.settings.dateFormatId
          : kDefaultDateFormat;
      format = dateFormats[dateFormatId].format;
      format += ' ' +
          (showSeconds
              ? company.settings.enableMilitaryTime ? 'H:mm:ss' : 'h:mm:ss a'
              : company.settings.enableMilitaryTime ? 'H:mm' : 'h:mm a');
    }
    final formatter = DateFormat(format, localeSelector(state));
    final parsed = DateTime.tryParse(value);
    return parsed == null ? '' : formatter.format(parsed.toLocal());
  } else {
    final dateFormats = state.staticState.dateFormatMap;
    final formatter = DateFormat(
        dateFormats[company.settings.dateFormatId].format,
        localeSelector(state));
    final parsed = DateTime.tryParse(value);
    return parsed == null ? '' : formatter.format(parsed);
  }
}

String formatApiUrl(String url) => cleanApiUrl(url) + '/api/v1';

String cleanApiUrl(String url) => (url ?? '')
    .trim()
    .replaceFirst(RegExp(r'/api/v1'), '')
    .replaceFirst(RegExp(r'/$'), '');

String formatCustomValue({String value, String field, BuildContext context}) {
  final localization = AppLocalization.of(context);
  final state = StoreProvider.of<AppState>(context).state;
  final CompanyEntity company = state.company;

  switch (company.getCustomFieldType(field)) {
    case kFieldTypeSwitch:
      return value == 'yes' ? localization.yes : localization.no;
      break;
    case kFieldTypeDate:
      return formatDate(value, context);
      break;
    default:
      return value;
  }
}
