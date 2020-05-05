import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/settings';

  final SettingsScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return ListScaffold(
      appBarTitle: ListFilter(
        placeholder: localization.searchSettings,
        key: ValueKey(state.settingsUIState.filterClearedAt),
        filter: state.settingsUIState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterSettings(value));
        },
      ),
      appBarActions: <Widget>[],
      body: SettingsListBuilder(),
    );
  }
}
