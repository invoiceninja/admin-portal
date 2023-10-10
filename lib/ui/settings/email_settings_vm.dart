// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EmailSettingsScreen extends StatelessWidget {
  const EmailSettingsScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsEmailSettings';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailSettingsVM>(
      converter: EmailSettingsVM.fromStore,
      builder: (context, viewModel) {
        return EmailSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class EmailSettingsVM {
  EmailSettingsVM({
    required this.state,
    required this.company,
    required this.onCompanyChanged,
    required this.settings,
    required this.onSettingsChanged,
    required this.onSavePressed,
    required this.onEInvoiceCertificateSelected,
  });

  static EmailSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return EmailSettingsVM(
        state: state,
        company: state.uiState.settingsUIState.company,
        settings: state.uiState.settingsUIState.settings,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onSettingsChanged: (settings) {
          store.dispatch(UpdateSettings(settings: settings));
        },
        onSavePressed: (
          context,
        ) {
          if (!state.isProPlan && !state.isTrial) {
            return;
          }

          Debouncer.runOnComplete(() {
            final settingsUIState = store.state.uiState.settingsUIState;
            final settings = settingsUIState.settings;
            if (settings.emailStyle == kEmailDesignCustom &&
                !settings.emailStyleCustom!.contains('\$body')) {
              showErrorDialog(
                  message: AppLocalization.of(context)!
                      .bodyVariableMissing
                      .replaceFirst(':body', '\$body'));
              return;
            }

            switch (settingsUIState.entityType) {
              case EntityType.company:
                final completer = snackBarCompleter<Null>(
                    AppLocalization.of(context)!.savedSettings);
                store.dispatch(SaveCompanyRequest(
                  completer: completer,
                  company: settingsUIState.company,
                ));
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
        },
        onEInvoiceCertificateSelected: (eInvoiceCertificate) {
          final completer = snackBarCompleter<Null>(
              AppLocalization.of(navigatorKey.currentContext!)!
                  .uploadedCertificate);
          store.dispatch(
            SaveEInvoiceCertificateRequest(
                completer: completer,
                company: state.company,
                eInvoiceCertificate: eInvoiceCertificate),
          );
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final SettingsEntity settings;
  final Function(SettingsEntity) onSettingsChanged;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(MultipartFile) onEInvoiceCertificateSelected;
}
