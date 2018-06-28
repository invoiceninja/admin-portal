import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';
import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

enum NumberFormatTypes {
  money,
  percent,
}

String formatNumber(double value, AppState state, {
  int clientId,
  NumberFormatTypes formatType = NumberFormatTypes.money,
  bool zeroIsNull = false,
}) {
  if (zeroIsNull && value == 0) {
    return null;
  }

  CompanyEntity company = state.selectedCompany;
  ClientEntity client = state.selectedCompanyState.clientState.map[clientId];

  //var countryId = client?.countryId ?? company.countryId;
  var currencyId;
  var countryId = client?.countryId ?? 1;

  if (client != null && client.currencyId > 0) {
    currencyId = client.currencyId;
  } else if (company.currencyId > 0) {
    currencyId = company.currencyId;
  } else {
    currencyId = kCurrencyUSDollar;
  }

  CurrencyEntity currency = state.staticState.currencyMap[currencyId];
  CountryEntity country = state.staticState.countryMap[countryId];

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

  var formatter = NumberFormat('#,###.00##', 'custom');
  String formatted = formatter.format(value);

  if (formatType == NumberFormatTypes.percent) {
    return '${formatted}%';
  } else if (company.showCurrencyCode || currency.symbol.isEmpty) {
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