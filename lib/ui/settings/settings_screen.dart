import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = '/settings';

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return AppScaffold(
      appBarTitle: ListFilter(
        title: localization.settings,
        key: ValueKey(state.settingsUIState.updatedAt),
        filter: state.settingsUIState.filter,
        onFilterChanged: (value) {

        },
      ),
      appBarActions: <Widget>[
        ListFilterButton(
          //entityType: EntityType.client,
          onFilterPressed: (String value) {
            //store.dispatch(FilterClients(value));
          },
        ),
      ],
      body: SettingsListBuilder(),
    );
  }
}
