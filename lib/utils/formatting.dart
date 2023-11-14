// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

double round(double? value, int precision) {
  if (value == null || value.isNaN) {
    return 0;
  }

  final int fac = pow(10, precision) as int;
  double result = value * fac;

  // Workaround for floating point issues:
  // ie. 35 * 1.107 => 38.745
  // ie. .75 * 55.3 => 41.4749999999
  if ('$result'.contains('999999')) {
    result += 0.000001;
  }

  return result.round() / fac;
}

int? parseInt(String value, {bool zeroIsNull = false}) {
  value = value.replaceAll(RegExp(r'[^0-9\.\-]'), '');

  final intValue = int.tryParse(value) ?? 0;

  return (intValue == 0 && zeroIsNull) ? null : intValue;
}

double? parseDouble(String? value, {bool zeroIsNull = false}) {
  // check for comma as decimal separator
  final state = StoreProvider.of<AppState>(navigatorKey.currentContext!).state;

  if (state.company.useCommaAsDecimalPlace && value!.contains(',')) {
    value = value.replaceAll('.', '');
    value = value.replaceAll(',', '.');
  }

  value = value!.replaceAll(RegExp(r'[^0-9\.\-]'), '');

  final doubleValue = double.tryParse(value) ?? 0.0;

  return (doubleValue == 0 && zeroIsNull) ? null : doubleValue;
}

enum FormatNumberType {
  money, // $1,000.00
  percent, // 1,000.00%
  int, // 1,000
  double, // 1,000.00
  inputMoney, // 1000.00
  inputAmount, // 1000
  duration,
}

String formatSize(int size) {
  return size > 1000000
      ? '${round(size / 1000000, 1).toInt()} MB'
      : '${round(size / 1000, 0).toInt()} KB';
}

String? formatNumber(
  double? value,
  BuildContext? context, {
  String? clientId,
  String? vendorId,
  String? currencyId,
  FormatNumberType? formatNumberType = FormatNumberType.money,
  bool? showCurrencyCode,
  bool zeroIsNull = false,
  bool roundToPrecision = true,
}) {
  if (zeroIsNull && value == 0) {
    return null;
  } else if (value == null ||
      (value == 0 &&
          ([
            FormatNumberType.inputMoney,
            FormatNumberType.inputAmount,
          ].contains(formatNumberType)))) {
    return '';
  }

  if (formatNumberType == FormatNumberType.duration) {
    return formatDuration(Duration(seconds: value.toInt()));
  }

  final state = StoreProvider.of<AppState>(context!).state;
  final CompanyEntity company = state.company;
  final ClientEntity? client = state.clientState.map[clientId];
  final VendorEntity? vendor = state.vendorState.map[vendorId];
  final GroupEntity? group = state.groupState.map[client?.groupId];

  String? countryId;

  if ((client?.countryId ?? '').isNotEmpty && client!.hasNameSet) {
    countryId = client.countryId;
  } else if ((vendor?.countryId ?? '').isNotEmpty && vendor!.hasNameSet) {
    countryId = vendor.countryId;
  } else {
    countryId = company.settings.countryId;
  }

  if (currencyId == kCurrencyAll) {
    currencyId = company.currencyId;
  } else if (currencyId != null && currencyId.isNotEmpty) {
    // do nothing
  } else if (client != null && client.hasCurrency) {
    currencyId = client.currencyId;
  } else if (vendor != null && vendor.hasCurrency) {
    currencyId = vendor.currencyId;
  } else if (group != null && group.hasCurrency) {
    currencyId = group.currencyId;
  } else {
    currencyId = company.currencyId;
  }

  final CurrencyEntity? currency = state.staticState.currencyMap[currencyId];
  final CurrencyEntity? companyCurrency =
      state.staticState.currencyMap[company.currencyId];

  final CountryEntity country =
      state.staticState.countryMap[countryId] ?? CountryEntity();
  /*
  final CountryEntity companyCountry =
      state.staticState.countryMap[company.settings.countryId] ??
          CountryEntity();
  */

  if (currency == null) {
    return '';
  }

  if (formatNumberType == FormatNumberType.money && roundToPrecision) {
    value = round(value, currency.precision);
  }

  String thousandSeparator = currency.thousandSeparator;
  String decimalSeparator = currency.decimalSeparator;
  bool swapCurrencySymbol = companyCurrency!.swapCurrencySymbol;

  if (currency.id == kCurrencyEuro) {
    //swapCurrencySymbol = companyCountry.swapCurrencySymbol;
    swapCurrencySymbol = country.swapCurrencySymbol;
    if (country.thousandSeparator.isNotEmpty) {
      thousandSeparator = country.thousandSeparator;
    }
    if (country.decimalSeparator.isNotEmpty) {
      decimalSeparator = country.decimalSeparator;
    }
  }

  if ([
    FormatNumberType.inputMoney,
    FormatNumberType.inputAmount,
  ].contains(formatNumberType)) {
    thousandSeparator = '';
    if (state.company.useCommaAsDecimalPlace) {
      decimalSeparator = ',';
    } else {
      decimalSeparator = '.';
    }
  }

  numberFormatSymbols['custom'] = NumberSymbols(
    NAME: 'custom',
    DECIMAL_SEP: decimalSeparator,
    GROUP_SEP: thousandSeparator,
    ZERO_DIGIT: '0',
    PLUS_SIGN: '+',
    MINUS_SIGN: '-',
    CURRENCY_PATTERN: '',
    DECIMAL_PATTERN: '',
    DEF_CURRENCY_CODE: '',
    EXP_SYMBOL: '',
    INFINITY: '',
    NAN: '',
    PERCENT: '',
    PERCENT_PATTERN: '',
    PERMILL: '',
    SCIENTIFIC_PATTERN: '',
  );

  late NumberFormat formatter;
  String? formatted;

  if (formatNumberType == FormatNumberType.int) {
    return NumberFormat('#,##0', 'custom').format(value);
  } else if (formatNumberType == FormatNumberType.double) {
    return NumberFormat('#,##0.#####', 'custom').format(value);
  } else if (formatNumberType == FormatNumberType.inputAmount) {
    return NumberFormat('#.#####', 'custom').format(value);
  } else if (formatNumberType == FormatNumberType.inputMoney) {
    if (currency.precision == 0) {
      return NumberFormat('#.#####', 'custom').format(value);
    } else if (currency.precision == 1) {
      return NumberFormat('#.0####', 'custom').format(value);
    } else if (currency.precision == 2) {
      return NumberFormat('#.00###', 'custom').format(value);
    } else if (currency.precision == 3) {
      return NumberFormat('#.000##', 'custom').format(value);
    }
  } else {
    if (formatNumberType == FormatNumberType.percent) {
      formatter = NumberFormat('#,##0.#####', 'custom');
    } else if (currency.precision == 0) {
      formatter = NumberFormat('#,##0.#####', 'custom');
    } else if (currency.precision == 1) {
      formatter = NumberFormat('#,##0.0####', 'custom');
    } else if (currency.precision == 2) {
      formatter = NumberFormat('#,##0.00###', 'custom');
    } else {
      formatter = NumberFormat('#,##0.000##', 'custom');
    }

    formatted = formatter.format(value < 0 ? value * -1 : value);

    // Ugly workaround to prevent showing negative zero values
    if (formatted == '-0.00') {
      formatted = '0.00';
    } else if (formatted == '-0,00') {
      formatted = '0,00';
    }
  }

  final prefix = value < 0 ? '-' : '';

  if (formatNumberType == FormatNumberType.percent) {
    return '$prefix$formatted%';
  } else if ((showCurrencyCode ?? company.settings.showCurrencyCode ?? false) ||
      currency.symbol.isEmpty) {
    return '$prefix$formatted ${currency.code}';
  } else {
    if (swapCurrencySymbol) {
      return '$prefix$formatted ${currency.symbol.trim()}';
    } else {
      return '$prefix${currency.symbol}$formatted';
    }
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

String formatAddress(AppState appState,
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
  final String countryId =
      (isShipping ? object.shippingCountryId : object.countryId) ?? '';

  if (address1.isNotEmpty) {
    str += address1 + delimiter;
  }
  if (address2.isNotEmpty) {
    str += address2 + delimiter;
  }

  if (city.isNotEmpty) {
    str += city + ', ';
  }

  if (state.isNotEmpty) {
    str += state + ' ';
  }

  if (postalCode.isNotEmpty) {
    str += postalCode;
  }

  if (countryId.isNotEmpty &&
      countryId != appState.company.settings.countryId) {
    if (str.isNotEmpty) {
      str += delimiter;
    }

    str += appState.staticState.countryMap[countryId]?.name ?? '';
  }

  return str;
}

String convertDateTimeToSqlDate([DateTime? date]) {
  date = date ?? DateTime.now();
  return date.toIso8601String().split('T').first;
}

DateTime convertSqlDateToDateTime([String? date]) {
  date = date ?? convertDateTimeToSqlDate();
  final parts = date.split('-');
  return DateTime.utc(
    parseInt(parts[0])!,
    parseInt(parts[1])!,
    parseInt(parts[2])!,
  );
}

DateTime convertTimestampToDate(int? timestamp) =>
    DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0) * 1000, isUtc: true);

String convertTimestampToDateString(int? timestamp) => (timestamp ?? 0) == 0
    ? ''
    : convertTimestampToDate(timestamp).toIso8601String();

String formatDuration(Duration? duration, {bool showSeconds = true}) {
  final time = duration.toString().split('.')[0];

  if (showSeconds) {
    return time;
  } else {
    final parts = time.split(':');
    return '${parts[0]}:${parts[1]}';
  }
}

DateTime convertTimeOfDayToDateTime(TimeOfDay? timeOfDay,
    [DateTime? dateTime]) {
  dateTime ??= DateTime.now();
  return DateTime(dateTime.year, dateTime.month, dateTime.day,
          timeOfDay?.hour ?? 0, timeOfDay?.minute ?? 0)
      .toUtc();
}

TimeOfDay convertDateTimeToTimeOfDay(DateTime? dateTime) =>
    TimeOfDay(hour: dateTime?.hour ?? 0, minute: dateTime?.minute ?? 0);

String formatDateRange(String startDate, String endDate, BuildContext context) {
  final today = DateTime.now();

  final startDateTime = DateTime.tryParse(startDate)!.toLocal();
  final startFormatter =
      DateFormat(today.year == startDateTime.year ? 'MMM d' : 'MMM d, yyy');
  final startDateTimeString = startFormatter.format(startDateTime);

  final endDateTime = DateTime.tryParse(endDate)!.toLocal();
  final endFormatter =
      DateFormat(today.year == endDateTime.year ? 'MMM d' : 'MMM d, yyy');
  final endDateTimeString = endFormatter.format(endDateTime);

  return '$startDateTimeString - $endDateTimeString';
}

String parseDate(String value, BuildContext context) {
  if (value.isEmpty) {
    return '';
  }

  final state = StoreProvider.of<AppState>(context).state;
  final CompanyEntity company = state.company;

  final dateFormats = state.staticState.dateFormatMap;
  final dateFormatId = (company.settings.dateFormatId ?? '').isNotEmpty
      ? company.settings.dateFormatId
      : kDefaultDateFormat;

  final format = dateFormats[dateFormatId]!.format;
  final formatter = DateFormat(format, localeSelector(state));

  return convertDateTimeToSqlDate(formatter.parse(value));
}

DateTime? parseTime(String value, BuildContext context) {
  if (value.isEmpty) {
    return null;
  }

  final state = StoreProvider.of<AppState>(context).state;
  final CompanyEntity company = state.company;

  final showSeconds = ':'.allMatches(value).length >= 2;
  final enableMilitaryTime = company.settings.enableMilitaryTime;
  String format;

  format = showSeconds
      ? enableMilitaryTime!
          ? 'H:mm:ss'
          : 'h:mm:ss a'
      : enableMilitaryTime!
          ? 'H:mm'
          : 'h:mm a';

  final formatter = DateFormat('y-M-D ' + format, localeSelector(state));
  return formatter.parse('2000-01-01 ' + value);
}

String formatDate(String? value, BuildContext? context,
    {bool showDate = true, bool showTime = false, bool showSeconds = true}) {
  if (value == null || value.isEmpty) {
    return '';
  }

  final state = StoreProvider.of<AppState>(context!).state;
  final CompanyEntity? company = state.company;
  var formattedValue = '';

  if (showTime) {
    String format;
    if (!showDate) {
      format = showSeconds
          ? company!.settings.enableMilitaryTime!
              ? 'H:mm:ss'
              : 'h:mm:ss a'
          : company!.settings.enableMilitaryTime!
              ? 'H:mm'
              : 'h:mm a';
    } else {
      final dateFormats = state.staticState.dateFormatMap;
      final dateFormatId = (company!.settings.dateFormatId ?? '').isNotEmpty
          ? company.settings.dateFormatId
          : kDefaultDateFormat;
      format = dateFormats[dateFormatId]!.format;
      format += ' ' +
          (showSeconds
              ? company.settings.enableMilitaryTime!
                  ? 'H:mm:ss'
                  : 'h:mm:ss a'
              : company.settings.enableMilitaryTime!
                  ? 'H:mm'
                  : 'h:mm a');
    }
    final formatter = DateFormat(format, localeSelector(state));
    final parsed = DateTime.tryParse(value.endsWith('Z') ? value : value + 'Z');
    formattedValue = parsed == null ? '' : formatter.format(parsed.toLocal());
  } else {
    final dateFormats = state.staticState.dateFormatMap;
    final formatter = DateFormat(
        dateFormats[company!.settings.dateFormatId]!.format,
        localeSelector(state));
    final parsed = DateTime.tryParse(value);
    formattedValue = parsed == null ? '' : formatter.format(parsed);
  }

  // Fix double periods in dates in foreign languages #527
  return formattedValue.replaceFirst('..', '.');
}

String formatApiUrl(String? url) {
  url = cleanApiUrl(url);

  if (url.isEmpty) {
    return '';
  }

  return url + '/api/v1';
}

String cleanApiUrl(String? url) => (url ?? '')
    .trim()
    .replaceFirst(RegExp(r'/api/v1'), '')
    .replaceFirst(RegExp(r'/$'), '');

String? formatCustomValue(
    {String? value, String? field, required BuildContext context}) {
  final localization = AppLocalization.of(context);
  final state = StoreProvider.of<AppState>(context).state;
  final CompanyEntity company = state.company;

  switch (company.getCustomFieldType(field)) {
    case kFieldTypeSwitch:
      return value == 'yes' ? localization!.yes : localization!.no;
    case kFieldTypeDate:
      return formatDate(value, context);
    default:
      return value;
  }
}
