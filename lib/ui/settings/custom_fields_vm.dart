import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/custom_fields.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CustomFieldsScreen extends StatelessWidget {
  const CustomFieldsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingCustomFields';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CustomFieldsVM>(
      converter: CustomFieldsVM.fromStore,
      builder: (context, viewModel) {
        return CustomFields(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class CustomFieldsVM {
  CustomFieldsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.company,
    @required this.onCompanyChanged,
  });

  static CustomFieldsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CustomFieldsVM(
        state: state,
        company: state.uiState.settingsUIState.userCompany.company,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onCancelPressed: (context) => store.dispatch(ResetSettings()),
        onSavePressed: (context) {
          final settingsUIState = state.uiState.settingsUIState;
          final completer = snackBarCompleter(
              context, AppLocalization.of(context).savedSettings);
          switch (settingsUIState.entityType) {
            case EntityType.company:
              store.dispatch(SaveCompanyRequest(
                  completer: completer,
                  company: settingsUIState.userCompany.company));
              break;
            case EntityType.group:
              store.dispatch(SaveGroupRequest(
                  completer: completer, group: settingsUIState.group));
              break;
            case EntityType.client:
              store.dispatch(SaveClientRequest(
                  completer: completer, client: settingsUIState.client));
              break;
          }
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
}
