import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class EmailSettingsBuilder extends StatelessWidget {
  const EmailSettingsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailSettingsVM>(
      converter: EmailSettingsVM.fromStore,
      builder: (context, viewModel) {
        return EmailSettings(viewModel: viewModel);
      },
    );
  }
}

class EmailSettingsVM {
  EmailSettingsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static EmailSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return EmailSettingsVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
