import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class LocalizationBuilder extends StatelessWidget {
  const LocalizationBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LocalizationSettingsVM>(
      converter: LocalizationSettingsVM.fromStore,
      builder: (context, viewModel) {
        return LocalizationSettings(viewModel: viewModel);
      },
    );
  }
}

class LocalizationSettingsVM {
  LocalizationSettingsVM({
    @required this.state,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static LocalizationSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return LocalizationSettingsVM(
        state: state,
        onChanged: (company) {
          store.dispatch(UpdateCompanySettings(company: company));
        },
        onSavePressed: (context) {
          final completer = snackBarCompleter(
              context, AppLocalization.of(context).refreshData);
          store.dispatch(SaveCompanyRequest(
              completer: completer,
              company: state.uiState.settingsUIState.editing.company));
        });
  }

  final AppState state;
  final Function(CompanyEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
