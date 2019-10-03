import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CompanyDetailsBuilder extends StatelessWidget {
  const CompanyDetailsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyDetailsVM>(
      converter: CompanyDetailsVM.fromStore,
      builder: (context, viewModel) {
        return CompanyDetails(viewModel: viewModel);
      },
    );
  }
}

class CompanyDetailsVM {
  CompanyDetailsVM({
    @required this.state,
    @required this.company,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static CompanyDetailsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CompanyDetailsVM(
        state: state,
        company: state.selectedCompany,
        onChanged: (company) {
          store.dispatch(UpdateCompanySettings(company: state.selectedCompany));
        },
        onCancelPressed: (context) {},
        onSavePressed: (context) {
          final completer = snackBarCompleter(
              context, AppLocalization.of(context).refreshData);
          store.dispatch(SaveCompanyRequest(
              completer: completer,
              company: state.uiState.settingsUIState.editing.company));
        });
  }

  final AppState state;
  final CompanyEntity company;
  final Function(CompanyEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
