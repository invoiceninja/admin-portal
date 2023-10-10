// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/custom_fields.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CustomFieldsScreen extends StatelessWidget {
  const CustomFieldsScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsCustomFields';

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
    required this.state,
    required this.onSavePressed,
    required this.company,
    required this.onCompanyChanged,
  });

  static CustomFieldsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CustomFieldsVM(
        state: state,
        company: state.uiState.settingsUIState.company,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onSavePressed: (context) {
          if (!state.isProPlan && !state.isTrial) {
            return;
          }

          Debouncer.runOnComplete(() {
            final settingsUIState = store.state.uiState.settingsUIState;
            switch (settingsUIState.entityType) {
              case EntityType.company:
                final completer = snackBarCompleter<Null>(
                    AppLocalization.of(context)!.savedSettings);
                store.dispatch(SaveCompanyRequest(
                    completer: completer, company: settingsUIState.company));
                break;
              case EntityType.group:
                final completer = snackBarCompleter<GroupEntity>(
                    AppLocalization.of(context)!.savedSettings);
                store.dispatch(SaveGroupRequest(
                    completer: completer, group: settingsUIState.group));
                break;
              case EntityType.client:
                final completer = snackBarCompleter<ClientEntity>(
                    AppLocalization.of(context)!.savedSettings);
                store.dispatch(SaveClientRequest(
                    completer: completer, client: settingsUIState.client));
                break;
            }
          });
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
}
