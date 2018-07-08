import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

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