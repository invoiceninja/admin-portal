import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list.dart';
import 'package:redux/redux.dart';

class SettingsListBuilder extends StatelessWidget {
  const SettingsListBuilder({Key key}) : super(key: key);

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
    @required this.state,
    @required this.loadSection,
    @required this.onViewClientPressed,
    @required this.onViewGroupPressed,
    @required this.onClearSettingsFilterPressed,
  });

  static SettingsListVM fromStore(Store<AppState> store) {
    final state = store.state;
    final settingsUIState = state.uiState.settingsUIState;

    return SettingsListVM(
        state: state,
        loadSection: (context, section) {
          store.dispatch(ViewSettings(
              context: context,
              section: section,
              userCompany: state.userCompany));
        },
        onClearSettingsFilterPressed: () =>
            store.dispatch(ClearSettingsFilter()),
        onViewClientPressed: (context) => store.dispatch(
            ViewClient(context: context, clientId: settingsUIState.client.id)),
        onViewGroupPressed: (context) => store.dispatch(
            ViewGroup(context: context, groupId: settingsUIState.group.id)));
  }

  final AppState state;
  final Function(BuildContext, String) loadSection;
  final Function(BuildContext) onViewGroupPressed;
  final Function(BuildContext) onViewClientPressed;
  final Function() onClearSettingsFilterPressed;
}
