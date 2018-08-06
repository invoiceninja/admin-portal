import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';

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

  return list;
}
