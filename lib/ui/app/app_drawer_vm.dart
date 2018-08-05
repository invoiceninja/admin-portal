import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class AppDrawerBuilder extends StatelessWidget {
  const AppDrawerBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppDrawerVM>(
      converter: AppDrawerVM.fromStore,
      builder: (context, viewModel) {
        return AppDrawer(viewModel: viewModel);
      },
    );
  }
}

class AppDrawerVM {
  final List<CompanyEntity> companies;
  final CompanyEntity selectedCompany;
  final String selectedCompanyIndex;
  final Function(BuildContext context, String) onCompanyChanged;
  final bool isLoading;

  AppDrawerVM({
    @required this.companies,
    @required this.selectedCompany,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
    @required this.isLoading,
});

  static AppDrawerVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return AppDrawerVM(
      isLoading: state.isLoading,
      companies: companiesSelector(state),
      selectedCompany: state.selectedCompany,
      selectedCompanyIndex: state.uiState.selectedCompanyIndex.toString(),
      onCompanyChanged: (BuildContext context, String companyIndex) {
        store.dispatch(SelectCompany(int.parse(companyIndex)));
      },
    );
  }
}
