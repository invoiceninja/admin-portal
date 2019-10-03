import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/notifications.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class NotificationsSettingsBuilder extends StatelessWidget {
  const NotificationsSettingsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NotificationSettingsVM>(
      converter: NotificationSettingsVM.fromStore,
      builder: (context, viewModel) {
        return NotificationSettings(viewModel: viewModel);
      },
    );
  }
}

class NotificationSettingsVM {
  NotificationSettingsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static NotificationSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return NotificationSettingsVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
