import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
    @required this.selectedCompany,
    @required this.user,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
    @required this.isLoading,
    @required this.onAddCompany,
  });

  final AppState state;
  final CompanyEntity selectedCompany;
  final UserEntity user;
  final String selectedCompanyIndex;
  final Function(BuildContext context, int, CompanyEntity) onCompanyChanged;
  final Function(BuildContext context) onAddCompany;

  final bool isLoading;

  static MenuDrawerVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return MenuDrawerVM(
      state: state,
      isLoading: state.isLoading,
      user: state.user,
      selectedCompany: state.company,
      selectedCompanyIndex: state.uiState.selectedCompanyIndex.toString(),
      onCompanyChanged:
          (BuildContext context, int index, CompanyEntity company) {
        if (index == state.uiState.selectedCompanyIndex) {
          return;
        }

        checkForChanges(
            store: store, context: context, callback: () {
          store.dispatch(ClearEntityFilter());
          store.dispatch(SelectCompany(companyIndex: index));
          if (store.state.isStale) {
            if (!store.state.isLoaded && store.state.company.isLarge) {
              store.dispatch(LoadClients());
            } else {
              store.dispatch(RefreshData());
            }
          }
          AppBuilder.of(context).rebuild();

          if (state.uiState.isInSettings) {
            String section = state.uiState.subRoute;
            if ([kSettingsUserDetails].contains(section)) {
              section = kSettingsCompanyDetails;
            }
            store.dispatch(ViewSettings(
              navigator: Navigator.of(context),
              company: company,
              section: section,
              force: true,
            ));
          }
        });
      },
      onAddCompany: (BuildContext context) {
        confirmCallback(
            context: context,
            message: AppLocalization.of(context).addCompany,
            callback: () {
              store.dispatch(AddCompany(context));
            });
      },
    );
  }
}
