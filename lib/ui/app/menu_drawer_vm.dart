import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
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
    @required this.state,
    @required this.companies,
    @required this.selectedCompany,
    @required this.user,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
    @required this.isLoading,
    @required this.onAddCompany,
  });

  final AppState state;
  final List<CompanyEntity> companies;
  final CompanyEntity selectedCompany;
  final UserEntity user;
  final String selectedCompanyIndex;
  final Function(BuildContext context, String, CompanyEntity) onCompanyChanged;
  final Function(BuildContext context) onAddCompany;

  final bool isLoading;

  static MenuDrawerVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return MenuDrawerVM(
      state: state,
      isLoading: state.isLoading,
      companies: companiesSelector(state),
      user: state.user,
      selectedCompany: state.company,
      selectedCompanyIndex: state.uiState.selectedCompanyIndex.toString(),
      onCompanyChanged:
          (BuildContext context, String companyIndex, CompanyEntity company) {
        store.dispatch(SelectCompany(int.parse(companyIndex)));
        store.dispatch(LoadClients());
        AppBuilder.of(context).rebuild();

        if (state.uiState.isInSettings) {
          store.dispatch(ViewSettings(
            navigator: Navigator.of(context),
            company: company,
            section: state.uiState.subRoute,
          ));
        }
      },
      onAddCompany: (BuildContext context) {
        store.dispatch(AddCompany(context));
      },
    );
  }
}
