import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';

double getExchangeRate(BuiltMap<String, CurrencyEntity> currencyMap,
    {String fromCurrencyId, String toCurrencyId}) {
  if (fromCurrencyId == null || toCurrencyId == null) {
    return 1;
  }
  final fromCurrency = currencyMap[fromCurrencyId];
  final toCurrency = currencyMap[toCurrencyId];
  // TODO replace with data from server
  final baseCurrency = currencyMap[kCurrencyUSDollar];

  if (fromCurrency == baseCurrency) {
    return toCurrency.exchangeRate;
  }

  if (toCurrency == baseCurrency) {
    return 1 / (fromCurrency?.exchangeRate ?? 1);
  }

  return toCurrency.exchangeRate * (1 / fromCurrency.exchangeRate);
}
