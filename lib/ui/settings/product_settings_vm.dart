// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/product_settings.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductSettingsScreen extends StatelessWidget {
  const ProductSettingsScreen({Key? key}) : super(key: key);
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
    required this.state,
    required this.company,
    required this.onCompanyChanged,
    required this.onSavePressed,
  });

  static ProductSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ProductSettingsVM(
        state: state,
        company: state.uiState.settingsUIState.company,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onSavePressed: (context) {
          Debouncer.runOnComplete(() {
            final settingsUIState = store.state.uiState.settingsUIState;
            final completer = snackBarCompleter<Null>(
                AppLocalization.of(context)!.savedSettings);
            store.dispatch(SaveCompanyRequest(
                completer: completer, company: settingsUIState.company));
          });
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
}
