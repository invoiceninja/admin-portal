import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';
import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';

String formatMoney(double value, {
  CompanyEntity company,
  CurrencyEntity currency,
  CountryEntity country
}) {

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

  numberFormatSymbols['zz'] = new NumberSymbols(
    NAME: "zz",
    DECIMAL_SEP: decimalSeparator,
    GROUP_SEP: thousandSeparator,
    //GROUP_SEP: '\u00A0',
    PERCENT: '%',
    ZERO_DIGIT: '0',
    PLUS_SIGN: '+',
    MINUS_SIGN: '-',
    EXP_SYMBOL: 'e',
    PERMILL: '\u2030',
    INFINITY: '\u221E',
    NAN: 'NaN',
    DECIMAL_PATTERN: '#,##0.###',
    SCIENTIFIC_PATTERN: '#E0',
    PERCENT_PATTERN: '#,##0%',
    CURRENCY_PATTERN: '\u00A4#,##0.00',
    DEF_CURRENCY_CODE: 'AUD',
  );

  var formatter = NumberFormat('###.0#', 'zz');
  String formatted = formatter.format(value);

  if (company.showCurrencyCode || currency.symbol.isEmpty) {
    return '${formatted} ${currency.code}';
  } else if (swapCurrencySymbol) {
    return '${formatted} ${currency.symbol.trim()}';
  } else {
    return '${currency.symbol}${formatted}';
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

String formatAddress({dynamic object, bool isShipping = false, String delimiter = '\n'}) {
  var str = '';

  String address1 = (isShipping ? object.shippingAddress1 : object.address1) ?? '';
  String address2 = (isShipping ? object.shippingAddress2 : object.address2) ?? '';
  String city = (isShipping ? object.city : object.city) ?? '';
  String state = (isShipping ? object.state : object.state) ?? '';
  String postalCode = (isShipping ? object.postalCode : object.postalCode) ?? '';

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

String convertDateTimeToSqlDate(DateTime date) => date.toIso8601String().split('T').first;