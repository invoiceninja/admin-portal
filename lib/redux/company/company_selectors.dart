import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

List<CompanyEntity> companiesSelector(AppState state) {
  List<CompanyEntity> list = [];

  if (! state.companyState1.company.isBlank()) {
    list.add(state.companyState1.company);
  }
  if (! state.companyState2.company.isBlank()) {
    list.add(state.companyState2.company);
  }
  if (! state.companyState3.company.isBlank()) {
    list.add(state.companyState3.company);
  }
  if (! state.companyState4.company.isBlank()) {
    list.add(state.companyState4.company);
  }
  if (! state.companyState5.company.isBlank()) {
    list.add(state.companyState5.company);
  }

  return list;
}