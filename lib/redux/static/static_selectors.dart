import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/static/country_model.dart';
import 'package:memoize/memoize.dart';


var memoizedCountryList = memo1((BuiltMap<int, CountryEntity> countryMap) =>
    countryList(countryMap));

List<int> countryList(BuiltMap<int, CountryEntity> countryMap) {
  final list = countryMap.keys.toList();

  list.sort((idA, idB) => countryMap[idA].listDisplayName
      .compareTo(countryMap[idB].listDisplayName));

  return list;
}