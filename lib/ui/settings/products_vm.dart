import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/products.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ProductSettingsScreen extends StatelessWidget {
  const ProductSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsProducts';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductSettingsVM>(
      converter: ProductSettingsVM.fromStore,
      builder: (context, viewModel) {
        return ProductSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class ProductSettingsVM {
  ProductSettingsVM({
    @required this.state,
    @required this.settings,
    @required this.onSettingsChanged,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static ProductSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ProductSettingsVM(
        state: state,
        settings: state.uiState.settingsUIState.settings,
        onSettingsChanged: (settings) {
          store.dispatch(UpdateSettings(settings: settings));
        },
        onCancelPressed: (context) => store.dispatch(ResetSettings()),
        onSavePressed: (context) {
          final settingsUIState = state.uiState.settingsUIState;
          final completer = snackBarCompleter(
              context, AppLocalization.of(context).savedSettings);
          store.dispatch(SaveCompanyRequest(
              completer: completer,
              company: settingsUIState.userCompany.company));
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final SettingsEntity settings;
  final Function(SettingsEntity) onSettingsChanged;
}
