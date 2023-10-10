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
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/task_settings.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskSettingsScreen extends StatelessWidget {
  const TaskSettingsScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsTasks';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskSettingsVM>(
      converter: TaskSettingsVM.fromStore,
      builder: (context, viewModel) {
        return TaskSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class TaskSettingsVM {
  TaskSettingsVM({
    required this.state,
    required this.company,
    required this.settings,
    required this.onCompanyChanged,
    required this.onSettingsChanged,
    required this.onSavePressed,
    required this.onConfigureStatusesPressed,
  });

  static TaskSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TaskSettingsVM(
      state: state,
      company: state.uiState.settingsUIState.company,
      settings: state.uiState.settingsUIState.settings,
      onCompanyChanged: (company) =>
          store.dispatch(UpdateCompany(company: company)),
      onSettingsChanged: (settings) {
        store.dispatch(UpdateSettings(settings: settings));
      },
      onSavePressed: (context) {
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
      },
      onConfigureStatusesPressed: (context) {
        store.dispatch(ViewSettings(section: kSettingsTaskStatuses));
      },
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final SettingsEntity settings;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(SettingsEntity) onSettingsChanged;
  final Function(BuildContext) onConfigureStatusesPressed;
}
