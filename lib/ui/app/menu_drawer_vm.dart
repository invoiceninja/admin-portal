import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class MenuDrawerBuilder extends StatelessWidget {
  const MenuDrawerBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MenuDrawerVM>(
      converter: MenuDrawerVM.fromStore,
      builder: (context, viewModel) {
        return MenuDrawer(viewModel: viewModel);
      },
    );
  }
}

class MenuDrawerVM {
  MenuDrawerVM({
    @required this.companies,
    @required this.selectedCompany,
    @required this.user,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
    @required this.isLoading,
  });

  final List<CompanyEntity> companies;
  final CompanyEntity selectedCompany;
  final UserEntity user;
  final String selectedCompanyIndex;
  final Function(BuildContext context, String, CompanyEntity) onCompanyChanged;
  final bool isLoading;

  static MenuDrawerVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return MenuDrawerVM(
      isLoading: state.isLoading,
      companies: companiesSelector(state),
      user: state.user,
      selectedCompany: state.company,
      selectedCompanyIndex: state.uiState.selectedCompanyIndex.toString(),
      onCompanyChanged:
          (BuildContext context, String companyIndex, CompanyEntity company) {
        // TODO re-enable
        //store.dispatch(SelectCompany(int.parse(companyIndex), company));

        store.dispatch(LoadDashboard());
        AppBuilder.of(context).rebuild();
      },
    );
  }
}
