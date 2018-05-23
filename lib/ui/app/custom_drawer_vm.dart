import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/ui/app/custom_drawer.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/company/company_selectors.dart';
import 'package:invoiceninja/data/models/models.dart';

class CustomDrawerVM extends StatelessWidget {
  CustomDrawerVM({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return CustomDrawer(
          companyName: vm.companyName,
          hasMultipleCompanies: vm.hasMultipleCompanies,
          companies: vm.companies,
        );
      },
    );
  }
}

class _ViewModel {
  final String companyName;
  final bool hasMultipleCompanies;
  final List<CompanyEntity> companies;

  _ViewModel({
    @required this.companyName,
    @required this.hasMultipleCompanies,
    @required this.companies,
});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      companyName: store.state.selectedCompany().name,
      hasMultipleCompanies: store.state.companyState2.company.token != null,
      companies: companiesSelector(store.state),
    );
  }
}
