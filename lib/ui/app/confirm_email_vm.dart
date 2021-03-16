import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/confirm_email.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ConfirmEmailBuilder extends StatelessWidget {
  const ConfirmEmailBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ConfirmEmailVM>(
      converter: ConfirmEmailVM.fromStore,
      builder: (context, viewModel) {
        return ConfirmEmail(viewModel: viewModel);
      },
    );
  }
}

class ConfirmEmailVM {
  ConfirmEmailVM({
    this.state,
    this.onRefreshPressed,
    this.onResendPressed,
    this.onUseLastPressed,
  });

  final AppState state;
  final Function onResendPressed;
  final Function onRefreshPressed;
  final Function(BuildContext) onUseLastPressed;

  static ConfirmEmailVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return ConfirmEmailVM(
      state: state,
      onRefreshPressed: () {
        store.dispatch(RefreshData());
      },
      onResendPressed: () {
        store.dispatch(ResendConfirmation());
      },
      onUseLastPressed: (context) {
        final user = state.user;
        passwordCallback(
            context: context,
            callback: (password, idToken) {
              store.dispatch(
                SaveAuthUserRequest(
                  user: user.rebuild((b) => b..email = user.lastEmailAddress),
                  password: password,
                  idToken: idToken,
                ),
              );
            });
      },
    );
  }
}
