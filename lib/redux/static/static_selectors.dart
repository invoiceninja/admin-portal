import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:memoize/memoize.dart';

var memoizedCountryList = memo1((BuiltMap<int, CountryEntity> countryMap) =>
    countryList(countryMap));

List<int> countryList(BuiltMap<int, CountryEntity> countryMap) {
  final list = countryMap.keys.toList();

  list.sort((idA, idB) => countryMap[idA].listDisplayName
      .compareTo(countryMap[idB].listDisplayName));

  return list;
}

var memoizedLanguageList = memo1((BuiltMap<int, LanguageEntity> languageMap) =>
    languageList(languageMap));

List<int> languageList(BuiltMap<int, LanguageEntity> languageMap) {
  final list = languageMap.keys.toList();

  list.sort((idA, idB) => languageMap[idA].listDisplayName
      .compareTo(languageMap[idB].listDisplayName));

  return list;
}

var memoizedCurrencyList = memo1((BuiltMap<int, CurrencyEntity> currencyMap) =>
    currencyList(currencyMap));

List<int> currencyList(BuiltMap<int, CurrencyEntity> currencyMap) {
  final list = currencyMap.keys.toList();

  list.sort((idA, idB) => currencyMap[idA].listDisplayName
      .compareTo(currencyMap[idB].listDisplayName));

  return list;
}

var memoizedIndustryList = memo1((BuiltMap<int, IndustryEntity> industryMap) =>
    industryList(industryMap));

List<int> industryList(BuiltMap<int, IndustryEntity> industryMap) {
  final list = industryMap.keys.toList();

  list.sort((idA, idB) => industryMap[idA].listDisplayName
      .compareTo(industryMap[idB].listDisplayName));

  return list;
}

var memoizedSizeList = memo1((BuiltMap<int, SizeEntity> sizeMap) =>
    sizeList(sizeMap));

List<int> sizeList(BuiltMap<int, SizeEntity> sizeMap) {
  final list = sizeMap.keys.toList();

  list.sort((idA, idB) => sizeMap[idA].id
      .compareTo(sizeMap[idB].id));

  return list;
}

var memoizedPaymentTypeList = memo1((BuiltMap<int, PaymentTypeEntity> paymentTypeMap) =>
    paymentTypeList(paymentTypeMap));

List<int> paymentTypeList(BuiltMap<int, PaymentTypeEntity> paymentTypeMap) {
  final list = paymentTypeMap.keys.toList();

  list.sort((idA, idB) => paymentTypeMap[idA].id
      .compareTo(paymentTypeMap[idB].id));

  return list;
}


