// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/confirm_email.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ConfirmEmailBuilder extends StatelessWidget {
  const ConfirmEmailBuilder({Key? key}) : super(key: key);

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
    this.onLogoutPressed,
    this.onUseLastPressed,
    this.onChangeEmail,
  });

  final AppState? state;
  final Function? onResendPressed;
  final Function? onRefreshPressed;
  final Function? onLogoutPressed;
  final Function(BuildContext, String, String?, String?)? onChangeEmail;
  final Function(BuildContext)? onUseLastPressed;

  static ConfirmEmailVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return ConfirmEmailVM(
      state: state,
      onRefreshPressed: () {
        store.dispatch(RefreshData());
      },
      onLogoutPressed: () {
        store.dispatch(UserLogout());
      },
      onResendPressed: () {
        store.dispatch(ResendConfirmation());
      },
      onChangeEmail: (context, email, password, idToken) {
        final user = store.state.user.rebuild((b) => b..email = email);
        final completer =
            snackBarCompleter<Null>(AppLocalization.of(context)!.savedSettings);
        store.dispatch(SaveAuthUserRequest(
          user: user,
          password: password,
          idToken: idToken,
          completer: completer,
        ));
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
