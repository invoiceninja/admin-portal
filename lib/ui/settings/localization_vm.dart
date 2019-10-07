import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/localization_settings.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class LocalizationScreen extends StatelessWidget {
  const LocalizationScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsLocalization';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LocalizationSettingsVM>(
      converter: LocalizationSettingsVM.fromStore,
      builder: (context, viewModel) {
        return LocalizationSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class LocalizationSettingsVM {
  LocalizationSettingsVM({
    @required this.state,
    @required this.settings,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static LocalizationSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return LocalizationSettingsVM(
        state: state,
        settings: state.uiState.settingsUIState.settings,
        onChanged: (settings) {
          store.dispatch(UpdateSettings(settings: settings));
        },
        onCancelPressed: (context) => store.dispatch(ResetSettings()),
        onSavePressed: (context) {
          final completer = snackBarCompleter(
              context, AppLocalization.of(context).savedSettings);
          store.dispatch(SaveCompanyRequest(
              completer: completer,
              company: state.uiState.settingsUIState.userCompany.company));
        });
  }

  final AppState state;
  final SettingsEntity settings;
  final Function(SettingsEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
