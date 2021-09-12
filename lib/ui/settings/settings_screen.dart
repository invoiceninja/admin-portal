import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen_vm.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/settings';

  final SettingsScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return ListScaffold(
      entityType: EntityType.settings,
      appBarTitle: ListFilter(
        key:
            ValueKey('__cleared_at_${state.settingsUIState.filterClearedAt}__'),
        entityType: EntityType.settings,
        entityIds: [],
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
