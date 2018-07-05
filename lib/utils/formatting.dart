import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';
import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

double round(double value, int precision) {
  final int fac = pow(10, precision);
  return (value * fac).round() / fac;
}

enum FormatNumberType {
  money, // $1,000.00
  percent, // 1,000.00%
  int, // 1,000
  double, // 1,000.00
  input, // 1000.00
}

String formatNumber(
  double value,
  BuildContext context, {
  int clientId,
  FormatNumberType formatNumberType = FormatNumberType.money,
  bool zeroIsNull = false,
}) {
  if ((zeroIsNull || formatNumberType == FormatNumberType.input) &&
      value == 0) {
    return null;
  }

  final state = StoreProvider.of<AppState>(context).state;
  final CompanyEntity company = state.selectedCompany;
  final ClientEntity client =
      state.selectedCompanyState.clientState.map[clientId];

  final countryId = client?.countryId ?? company.countryId;
  int currencyId;

  if (client != null && client.currencyId > 0) {
    currencyId = client.currencyId;
  } else if (company.currencyId > 0) {
    currencyId = company.currencyId;
  } else {
    currencyId = kCurrencyUSDollar;
  }

  final CurrencyEntity currency = state.staticState.currencyMap[currencyId];
  final CountryEntity country = state.staticState.countryMap[countryId];

  String thousandSeparator = currency.thousandSeparator;
  String decimalSeparator = currency.decimalSeparator;
  bool swapCurrencySymbol = currency.swapCurrencySymbol;

  if (currency.id == kCurrencyEuro) {
    swapCurrencySymbol = country.swapCurrencySymbol;
    if (country.thousandSeparator.isNotEmpty) {
      thousandSeparator = country.thousandSeparator;
    }
    if (country.decimalSeparator.isNotEmpty) {
      decimalSeparator = country.decimalSeparator;
    }
  }

  numberFormatSymbols['custom'] = new NumberSymbols(
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
  } else if (company.showCurrencyCode || currency.symbol.isEmpty) {
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

String formatApiUrlMachine(String url) => formatApiUrlReadable(url) + '/api/v1';

String formatApiUrlReadable(String url) => url
    .trim()
    .replaceFirst(RegExp(r'/api/v1'), '')
    .replaceFirst(RegExp(r'/$'), '');
