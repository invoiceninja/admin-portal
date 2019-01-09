import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:memoize/memoize.dart';

var memoizedHasMultipleCurrencies = memo2(
    (CompanyEntity company, BuiltMap<int, ClientEntity> clientMap) =>
        hasMultipleCurrencies(company, clientMap));

bool hasMultipleCurrencies(
        CompanyEntity company, BuiltMap<int, ClientEntity> clientMap) =>
    memoizedGetCurrencyIds(company, clientMap).length > 1;

var memoizedGetCurrencyIds = memo2(
    (CompanyEntity company, BuiltMap<int, ClientEntity> clientMap) =>
        getCurrencyIds(company, clientMap));

List<int> getCurrencyIds(
    CompanyEntity company, BuiltMap<int, ClientEntity> clientMap) {
  final currencyIds = <int>[];
  if (company.currencyId > 0) {
    currencyIds.add(company.currencyId);
  } else {
    currencyIds.add(kDefaultCurrencyId);
  }
  clientMap.forEach((clientId, client) {
    if (client.currencyId > 0 &&
        !client.isDeleted &&
        !currencyIds.contains(client.currencyId)) {
      currencyIds.add(client.currencyId);
    }
  });
  return currencyIds;
}

var memoizedFilteredSelector = memo2(
    (String filter, CompanyState state) => filteredSelector(filter, state));

List<BaseEntity> filteredSelector(String filter, CompanyState state) {
  final List<BaseEntity> list = []
    ..addAll(state.productState.list
        .map((productId) => state.productState.map[productId])
        .where((product) {
      return product.matchesFilter(filter);
    }).toList())
    ..addAll(state.clientState.list
        .map((clientId) => state.clientState.map[clientId])
        .where((client) {
      return client.matchesFilter(filter);
    }).toList())
    ..addAll(state.quoteState.list
        .map((quoteId) => state.quoteState.map[quoteId])
        .where((quote) {
      return quote.matchesFilter(filter);
    }).toList())
    ..addAll(state.paymentState.list
        .map((paymentId) => state.paymentState.map[paymentId])
        .where((payment) {
      return payment.matchesFilter(filter);
    }).toList())
    ..addAll(state.projectState.list
        .map((projectId) => state.projectState.map[projectId])
        .where((project) {
      return project.matchesFilter(filter);
    }).toList())
    ..addAll(state.taskState.list
        .map((taskId) => state.taskState.map[taskId])
        .where((task) {
      return task.matchesFilter(filter);
    }).toList())
    ..addAll(state.invoiceState.list
        .map((invoiceId) => state.invoiceState.map[invoiceId])
        .where((invoice) {
      return invoice.matchesFilter(filter);
    }).toList());

  list.sort((BaseEntity entityA, BaseEntity entityB) {
    return entityA.listDisplayName.compareTo(entityB.listDisplayName);
  });

  return list;
}

List<CompanyEntity> companiesSelector(AppState state) {
  final List<CompanyEntity> list = [];

  if (state.companyState1.company != null) {
    list.add(state.companyState1.company);
  }
  if (state.companyState2.company != null) {
    list.add(state.companyState2.company);
  }
  if (state.companyState3.company != null) {
    list.add(state.companyState3.company);
  }
  if (state.companyState4.company != null) {
    list.add(state.companyState4.company);
  }
  if (state.companyState5.company != null) {
    list.add(state.companyState5.company);
  }

  return list
      .where((CompanyEntity company) => company.name.isNotEmpty)
      .toList();
}

String localeSelector(AppState state) =>
    state.staticState?.languageMap[state.selectedCompany?.languageId]?.locale ??
    'en';
