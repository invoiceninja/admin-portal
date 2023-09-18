// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list.dart';

class SettingsListBuilder extends StatelessWidget {
  const SettingsListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsListVM>(
      converter: SettingsListVM.fromStore,
      builder: (context, viewModel) {
        return SettingsList(viewModel: viewModel);
      },
    );
  }
}

class SettingsListVM {
  SettingsListVM({
    required this.state,
    required this.loadSection,
    required this.onViewClientPressed,
    required this.onViewGroupPressed,
    required this.onClearSettingsFilterPressed,
  });

  static SettingsListVM fromStore(Store<AppState> store) {
    final state = store.state;
    final settingsUIState = state.uiState.settingsUIState;

    return SettingsListVM(
        state: state,
        loadSection: (context, section, tabIndex) {
          store.dispatch(ViewSettings(
            section: section,
            company: state.company,
            user: state.user,
            tabIndex: tabIndex,
          ));
        },
        onClearSettingsFilterPressed: () =>
            store.dispatch(ClearSettingsFilter()),
        onViewClientPressed: (context) {
          viewEntity(entity: settingsUIState.client);
        },
        onViewGroupPressed: (context) {
          viewEntity(entity: settingsUIState.group);
        });
  }

  final AppState state;
  final Function(BuildContext, String, int?) loadSection;
  final Function(BuildContext) onViewGroupPressed;
  final Function(BuildContext) onViewClientPressed;
  final Function() onClearSettingsFilterPressed;
}
