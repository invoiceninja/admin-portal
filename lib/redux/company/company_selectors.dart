import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:memoize/memoize.dart';

var memoizedDropdownExpenseCategoriesList = memo2(
    (BuiltMap<String, ExpenseCategoryEntity> categoryMap,
            BuiltList<String> categoryList) =>
        dropdownExpenseCategoriesSelector(categoryMap, categoryList));

List<String> dropdownExpenseCategoriesSelector(
    BuiltMap<String, ExpenseCategoryEntity> categoryMap,
    BuiltList<String> categoryList) {
  final list = categoryList
      .where((categoryId) => categoryMap[categoryId].isActive)
      .toList();

  list.sort((categoryAId, categoryBId) {
    final categoryA = categoryMap[categoryAId];
    final categoryB = categoryMap[categoryBId];
    return categoryA.compareTo(
        expenseCategory: categoryB,
        sortAscending: true,
        sortField: ExpenseCategoryFields.name);
  });

  return list;
}

var memoizedHasMultipleCurrencies = memo3((CompanyEntity company,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, GroupEntity> groupMap) =>
    hasMultipleCurrencies(company, clientMap, groupMap));

bool hasMultipleCurrencies(
        CompanyEntity company,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, GroupEntity> groupMap) =>
    memoizedGetCurrencyIds(company, clientMap, groupMap).length > 1;

var memoizedGetCurrencyIds = memo3((CompanyEntity company,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, GroupEntity> groupMap) =>
    getCurrencyIds(company, clientMap, groupMap));

List<String> getCurrencyIds(
    CompanyEntity company,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, GroupEntity> groupMap) {
  final currencyIds = <String>[company.currencyId];
  clientMap.forEach((clientId, client) {
    final group = groupMap[client.groupId];
    if (!client.isDeleted) {
      String currencyId;
      if (client.hasCurrency) {
        currencyId = client.currencyId;
      } else if (group != null && group.hasCurrency) {
        currencyId = group.currencyId;
      }
      if (currencyId != null && !currencyIds.contains(currencyId)) {
        currencyIds.add(currencyId);
      }
    }
  });

  return currencyIds.length > 1 ? [kCurrencyAll, ...currencyIds] : currencyIds;
}

var memoizedFilteredSelector = memo2(
    (String filter, UserCompanyState state) => filteredSelector(filter, state));

List<BaseEntity> filteredSelector(String filter, UserCompanyState state) {
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

String localeSelector(AppState state) {
  final locale = state.staticState
          ?.languageMap[state.company?.settings?.languageId]?.locale ??
      'en';

  // https://github.com/flutter/flutter/issues/32090
  if (locale == 'mk_MK' || locale == 'sq') {
    return 'en';
  } else {
    return locale;
  }
}

String portalRegistrationUrlSelector(AppState state) {
  String url = state.account.defaultUrl;

  url += '/client/register';

  if (state.companies.length > 1 &&
      state.company.id != state.account.defaultCompanyId) {
    url += '/' + state.company.companyKey;
  }

  return url;
}
