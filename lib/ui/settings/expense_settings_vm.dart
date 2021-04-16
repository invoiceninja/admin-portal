import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/expense_settings.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ExpenseSettingsScreen extends StatelessWidget {
  const ExpenseSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsExpenses';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseSettingsVM>(
      converter: ExpenseSettingsVM.fromStore,
      builder: (context, viewModel) {
        return ExpenseSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class ExpenseSettingsVM {
  ExpenseSettingsVM({
    @required this.state,
    @required this.company,
    @required this.onCompanyChanged,
    @required this.onSavePressed,
    @required this.onConfigureCategoriesPressed,
  });

  static ExpenseSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ExpenseSettingsVM(
      state: state,
      company: state.uiState.settingsUIState.company,
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
      },
      onConfigureCategoriesPressed: (context) {
        store.dispatch(ViewSettings(section: kSettingsExpenseCategories));
      },
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(BuildContext) onConfigureCategoriesPressed;
}
