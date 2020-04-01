import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/settings/user_details.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsUserDetails';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserDetailsVM>(
      converter: UserDetailsVM.fromStore,
      builder: (context, viewModel) {
        return UserDetails(
            key: ValueKey(viewModel.state.settingsUIState.updatedAt),
            viewModel: viewModel);
      },
    );
  }
}

class UserDetailsVM {
  UserDetailsVM({
    @required this.user,
    @required this.state,
    @required this.onChanged,
    @required this.onSavePressed,
  });

  static UserDetailsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return UserDetailsVM(
      state: state,
      user: state.uiState.settingsUIState.user,
      onChanged: (user) => store.dispatch(UpdateUserSettings(user: user)),
      onSavePressed: (context) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).savedSettings);
        completer.future.then((_) {
          AppBuilder.of(context).rebuild();
        });
        if (state.authState.hasRecentlyEnteredPassword) {
          store.dispatch(
            SaveAuthUserRequest(
              completer: completer,
              user: state.uiState.settingsUIState.user,
            ),
          );
        } else {
          passwordCallback(
              context: context,
              callback: (password) {
                store.dispatch(
                  SaveAuthUserRequest(
                    completer: completer,
                    user: state.uiState.settingsUIState.user,
                    password: password,
                  ),
                );
              });
        }
      },
    );
  }

  final AppState state;
  final UserEntity user;
  final Function(UserEntity) onChanged;
  final Function(BuildContext) onSavePressed;
}
