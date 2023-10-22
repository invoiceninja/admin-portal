// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen.dart';

class SettingsScreenBuilder extends StatelessWidget {
  const SettingsScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsScreenVM>(
      converter: SettingsScreenVM.fromStore,
      builder: (context, vm) {
        return SettingsScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class SettingsScreenVM {
  SettingsScreenVM({required this.state});

  final AppState state;

  static SettingsScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return SettingsScreenVM(
      state: state,
    );
  }
}
