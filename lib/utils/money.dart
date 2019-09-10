import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

double getExchangeRate(BuildContext context,
    {int fromCurrencyId, int toCurrencyId}) {
  final currencyMap = getCurrencyMap(context);
  return getExchangeRateWithMap(currencyMap,
      fromCurrencyId: fromCurrencyId, toCurrencyId: toCurrencyId);
}

BuiltMap<int, CurrencyEntity> getCurrencyMap(BuildContext context) {
  final state = StoreProvider.of<AppState>(context).state;
  return state.staticState.currencyMap;
}

double getExchangeRateWithMap(BuiltMap<int, CurrencyEntity> currencyMap,
    {int fromCurrencyId, int toCurrencyId}) {
  final fromCurrency = currencyMap[fromCurrencyId];
  final toCurrency = currencyMap[toCurrencyId];
  // TODO replace with data from server
  final baseCurrency = currencyMap[kCurrencyUSDollar];

  if (fromCurrency == baseCurrency) {
    return toCurrency.exchangeRate;
  }

  if (toCurrency == baseCurrency) {
    return 1 / fromCurrency.exchangeRate;
  }

  return toCurrency.exchangeRate * (1 / fromCurrency.exchangeRate);
}
