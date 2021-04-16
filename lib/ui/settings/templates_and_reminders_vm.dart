import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TemplatesAndRemindersScreen extends StatelessWidget {
  const TemplatesAndRemindersScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsTemplatesAndReminders';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TemplatesAndRemindersVM>(
      converter: TemplatesAndRemindersVM.fromStore,
      builder: (context, viewModel) {
        return TemplatesAndReminders(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class TemplatesAndRemindersVM {
  TemplatesAndRemindersVM({
    @required this.state,
    @required this.settings,
    @required this.onSettingsChanged,
    @required this.onSavePressed,
  });

  static TemplatesAndRemindersVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TemplatesAndRemindersVM(
      state: state,
      settings: state.uiState.settingsUIState.settings,
      onSettingsChanged: (settings) {
        store.dispatch(UpdateSettings(settings: settings));
      },
      onSavePressed: (context) {
        Debouncer.runOnComplete(() {
          final settingsUIState = store.state.uiState.settingsUIState;
          switch (settingsUIState.entityType) {
            case EntityType.company:
              final completer = snackBarCompleter<Null>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveCompanyRequest(
                  completer: completer, company: settingsUIState.company));
              break;
            case EntityType.group:
              final completer = snackBarCompleter<GroupEntity>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveGroupRequest(
                  completer: completer, group: settingsUIState.group));
              break;
            case EntityType.client:
              final completer = snackBarCompleter<ClientEntity>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveClientRequest(
                  completer: completer, client: settingsUIState.client));
              break;
          }
        });
      },
    );
  }

  final AppState state;
  final SettingsEntity settings;
  final Function(SettingsEntity) onSettingsChanged;
  final Function(BuildContext) onSavePressed;
}
