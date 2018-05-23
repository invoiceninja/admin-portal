import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/ui/app/custom_drawer.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/company/company_selectors.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';
import 'package:invoiceninja/data/models/models.dart';

class CustomDrawerVM extends StatelessWidget {
  CustomDrawerVM({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return CustomDrawer(
          companies: vm.companies,
          selectedCompany: vm.selectedCompany,
          selectedCompanyIndex: vm.selectedCompanyIndex,
          onCompanyChanged: vm.onCompanyChanged,
        );
      },
    );
  }
}

class _ViewModel {
  final List<CompanyEntity> companies;
  final CompanyEntity selectedCompany;
  final String selectedCompanyIndex;
  final Function(String) onCompanyChanged;

  _ViewModel({
    @required this.companies,
    @required this.selectedCompany,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      companies: companiesSelector(store.state),
      selectedCompany: store.state.selectedCompany(),
      selectedCompanyIndex: store.state.selectedCompanyIndex.toString(),
      onCompanyChanged: (String companyId) {
        store.dispatch(SelectCompany(int.parse(companyId)));
      },
    );
  }
}
