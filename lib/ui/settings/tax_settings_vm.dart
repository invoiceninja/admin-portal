import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_settings.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaxSettingsScreen extends StatelessWidget {
  const TaxSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsTaxSettings';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxSettingsVM>(
      converter: TaxSettingsVM.fromStore,
      builder: (context, viewModel) {
        return TaxSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class TaxSettingsVM {
  TaxSettingsVM({
    @required this.state,
    @required this.company,
    @required this.settings,
    @required this.onSettingsChanged,
    @required this.onCompanyChanged,
    @required this.onSavePressed,
    @required this.onConfigureRatesPressed,
  });

  static TaxSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TaxSettingsVM(
        state: state,
        settings: state.uiState.settingsUIState.settings,
        company: state.uiState.settingsUIState.company,
        onSettingsChanged: (settings) {
          store.dispatch(UpdateSettings(settings: settings));
        },
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onSavePressed: (context) {
          final settingsUIState = state.uiState.settingsUIState;
          final completer = snackBarCompleter<Null>(
              context, AppLocalization.of(context).savedSettings);
          store.dispatch(SaveCompanyRequest(
              completer: completer, company: settingsUIState.company));
        },
        onConfigureRatesPressed: (context) {
          if (state.taxRateState.list.isEmpty) {
            store.dispatch(ViewSettings(
                navigator: Navigator.of(context),
                section: kSettingsTaxRatesEdit));
          } else {
            store.dispatch(ViewSettings(
                navigator: Navigator.of(context), section: kSettingsTaxRates));
          }
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final SettingsEntity settings;
  final Function(SettingsEntity) onSettingsChanged;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(BuildContext) onConfigureRatesPressed;
}
