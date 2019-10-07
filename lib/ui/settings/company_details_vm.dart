import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CompanyDetailsScreen extends StatelessWidget {
  const CompanyDetailsScreen({Key key}) : super(key: key);
  static const String route = '/settings/$kSettingsCompanyDetails';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyDetailsVM>(
      converter: CompanyDetailsVM.fromStore,
      builder: (context, viewModel) {
        return CompanyDetails(
            key: ValueKey(viewModel.state.settingsUIState.updatedAt),
            viewModel: viewModel);
      },
    );
  }
}

class CompanyDetailsVM {
  CompanyDetailsVM({
    @required this.state,
    @required this.settings,
    @required this.company,
    @required this.onCompanyChanged,
    @required this.onSettingsChanged,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.onUploadLogo,
  });

  static CompanyDetailsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CompanyDetailsVM(
      state: state,
      settings: state.uiState.settingsUIState.settings,
      company: state.uiState.settingsUIState.userCompany.company,
      onSettingsChanged: (settings) =>
          store.dispatch(UpdateSettings(settings: settings)),
      onCompanyChanged: (company) =>
          store.dispatch(UpdateCompany(company: company)),
      onCancelPressed: (context) => store.dispatch(ResetSettings()),
      onSavePressed: (context) {
        final completer = snackBarCompleter(
            context, AppLocalization.of(context).savedSettings);
        store.dispatch(SaveCompanyRequest(
            completer: completer,
            company: state.uiState.settingsUIState.userCompany.company));
      },
      onUploadLogo: (context, path) {
        final completer = snackBarCompleter(
            context, AppLocalization.of(context).uploadedLogo);
        store.dispatch(UploadLogoRequest(completer: completer, path: path));
      },
    );
  }

  final AppState state;
  final CompanyEntity company;
  final SettingsEntity settings;
  final Function(SettingsEntity) onSettingsChanged;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function(BuildContext, String) onUploadLogo;
}
