import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders.dart';
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
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static TemplatesAndRemindersVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TemplatesAndRemindersVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
