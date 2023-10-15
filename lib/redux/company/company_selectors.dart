// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';

var memoizedDropdownExpenseCategoriesList = memo2(
    (BuiltMap<String, ExpenseCategoryEntity> categoryMap,
            BuiltList<String> categoryList) =>
        dropdownExpenseCategoriesSelector(categoryMap, categoryList));

List<String> dropdownExpenseCategoriesSelector(
    BuiltMap<String, ExpenseCategoryEntity> categoryMap,
    BuiltList<String> categoryList) {
  final list = categoryList
      .where((categoryId) => categoryMap[categoryId]!.isActive)
      .toList();

  list.sort((categoryAId, categoryBId) {
    final categoryA = categoryMap[categoryAId]!;
    final categoryB = categoryMap[categoryBId];
    return categoryA.compareTo(
        expenseCategory: categoryB,
        sortAscending: true,
        sortField: ExpenseCategoryFields.name);
  });

  return list;
}

var memoizedHasMultipleCurrencies = memo3((CompanyEntity? company,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, GroupEntity> groupMap) =>
    hasMultipleCurrencies(company, clientMap, groupMap));

bool hasMultipleCurrencies(
        CompanyEntity? company,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, GroupEntity> groupMap) =>
    memoizedGetCurrencyIds(company, clientMap, groupMap).length > 1;

var memoizedGetCurrencyIds = memo3((CompanyEntity? company,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, GroupEntity> groupMap) =>
    getCurrencyIds(company!, clientMap, groupMap));

List<String> getCurrencyIds(
    CompanyEntity company,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, GroupEntity> groupMap) {
  final currencyIds = <String>[company.currencyId];
  clientMap.forEach((clientId, client) {
    final group = groupMap[client.groupId];
    if (!client.isDeleted!) {
      String? currencyId;
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

  if (currencyIds.isEmpty) {
    return [kCurrencyUSDollar];
  } else if (currencyIds.length > 1) {
    return [kCurrencyAll, ...currencyIds];
  } else {
    return currencyIds;
  }
}

var memoizedFilteredSelector = memo2((String? filter, UserCompanyState state) =>
    filteredSelector(filter, state));

List<BaseEntity> filteredSelector(String? filter, UserCompanyState state) {
  final List<BaseEntity> list = []
    ..addAll(state.productState.list
        .map((productId) => state.productState.map[productId]!)
        .where((product) {
      return product.matchesFilter(filter);
    }).toList())
    ..addAll(state.clientState.list
        .map((clientId) => state.clientState.map[clientId]!)
        .where((client) {
      return client.matchesFilter(filter);
    }).toList())
    ..addAll(state.quoteState.list
        .map((quoteId) => state.quoteState.map[quoteId]!)
        .where((quote) {
      return quote.matchesFilter(filter);
    }).toList())
    ..addAll(state.paymentState.list
        .map((paymentId) => state.paymentState.map[paymentId]!)
        .where((payment) {
      return payment.matchesFilter(filter);
    }).toList())
    ..addAll(state.projectState.list
        .map((projectId) => state.projectState.map[projectId]!)
        .where((project) {
      return project.matchesFilter(filter);
    }).toList())
    ..addAll(state.taskState.list
        .map((taskId) => state.taskState.map[taskId]!)
        .where((task) {
      return task.matchesFilter(filter);
    }).toList())
    ..addAll(state.invoiceState.list
        .map((invoiceId) => state.invoiceState.map[invoiceId]!)
        .where((invoice) {
      return invoice.matchesFilter(filter);
    }).toList());

  list.sort((BaseEntity? entityA, BaseEntity? entityB) {
    return entityA!.listDisplayName.compareTo(entityB!.listDisplayName);
  });

  return list;
}

String localeSelector(AppState state, {bool twoLetter = false}) {
  var languageId = state.company.languageId;
  if (state.user.languageId.isNotEmpty) {
    languageId = state.user.languageId;
  }

  final languageMap = state.staticState.languageMap;
  final locale = languageMap[languageId]?.locale ?? 'en';

  // https://github.com/flutter/flutter/issues/32090
  if (locale == 'mk_MK' || locale == 'sq') {
    return 'en';
  } else if (twoLetter) {
    return locale.split('_').first;
  } else {
    return locale;
  }
}

String clientPortalUrlSelector(AppState state, {String route = 'login'}) {
  String url;

  final account = state.account;
  final company = state.company;

  if (company.portalMode == kClientPortalModeDomain) {
    url = company.portalDomain;
  } else {
    url = account.defaultUrl;

    if (state.isHosted) {
      url = url.replaceFirst('//', '//${company.subdomain}.');
    }
  }

  url += '/client/$route';

  if (state.isSelfHosted &&
      state.companies.length > 1 &&
      company.id != account.defaultCompanyId) {
    url += '/' + company.companyKey;
  }

  return url;
}
