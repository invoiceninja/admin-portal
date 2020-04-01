import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
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
    @required this.company,
    @required this.settings,
    @required this.onSettingsChanged,
    @required this.onCompanyChanged,
    @required this.onSavePressed,
  });

  static LocalizationSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return LocalizationSettingsVM(
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
          switch (settingsUIState.entityType) {
            case EntityType.company:
              final completer = snackBarCompleter<Null>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveCompanyRequest(
                  completer: completer, company: settingsUIState.company));
              break;
            case EntityType.group:
              final completer = snackBarCompleter<GroupEntity>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveGroupRequest(
                  completer: completer, group: settingsUIState.group));
              break;
            case EntityType.client:
              final completer = snackBarCompleter<ClientEntity>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveClientRequest(
                  completer: completer, client: settingsUIState.client));
              break;
          }
        });
  }

  final AppState state;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
  final SettingsEntity settings;
  final Function(SettingsEntity) onSettingsChanged;
  final Function(BuildContext) onSavePressed;
}
