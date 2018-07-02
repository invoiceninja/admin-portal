import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';
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

