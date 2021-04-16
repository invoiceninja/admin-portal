import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/integrations.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class IntegrationSettingsScreen extends StatelessWidget {
  const IntegrationSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsIntegrations';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, IntegrationSettingsVM>(
      converter: IntegrationSettingsVM.fromStore,
      builder: (context, viewModel) {
        return IntegrationSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class IntegrationSettingsVM {
  IntegrationSettingsVM({
    @required this.state,
    @required this.onCompanyChanged,
    @required this.onSavePressed,
  });

  static IntegrationSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return IntegrationSettingsVM(
        state: state,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onSavePressed: (context) {
          Debouncer.runOnComplete(() {
            final settingsUIState = store.state.uiState.settingsUIState;
            final completer = snackBarCompleter<Null>(
                context, AppLocalization.of(context).savedSettings);
            store.dispatch(SaveCompanyRequest(
                completer: completer, company: settingsUIState.company));
          });
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(CompanyEntity) onCompanyChanged;
}
