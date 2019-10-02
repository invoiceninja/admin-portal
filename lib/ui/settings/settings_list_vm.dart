import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

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
  });

  static SettingsListVM fromStore(Store<AppState> store) {
    return SettingsListVM(
        state: store.state,
        loadSection: (context, section) {
          store.dispatch(ViewSettings(context: context));
        });
  }

  final AppState state;
  final Function(BuildContext, String) loadSection;
}
