import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

double getExchangeRate(BuildContext context,
    {String fromCurrencyId, String toCurrencyId}) {
  final state = StoreProvider.of<AppState>(context).state;
  final currencyMap = state.staticState.currencyMap;
  return getExchangeRateWithMap(currencyMap,
      fromCurrencyId: fromCurrencyId, toCurrencyId: toCurrencyId);
}

double getExchangeRateWithMap(BuiltMap<String, CurrencyEntity> currencyMap,
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
