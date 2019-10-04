import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/client_portal.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ClientPortalScreen extends StatelessWidget {
  const ClientPortalScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsClientPortal';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientPortalVM>(
      converter: ClientPortalVM.fromStore,
      builder: (context, viewModel) {
        return ClientPortal(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class ClientPortalVM {
  ClientPortalVM({
    @required this.state,
    @required this.company,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static ClientPortalVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ClientPortalVM(
        state: state,
        company: state.selectedCompany,
        onChanged: (company) {
          store.dispatch(UpdateCompanySettings(company: state.selectedCompany));
        },
        onCancelPressed: (context) {},
        onSavePressed: (context) {
          final completer = snackBarCompleter(
              context, AppLocalization.of(context).savedSettings);
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
