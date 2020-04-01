import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/settings/online_payments.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class OnlinePaymentsScreen extends StatelessWidget {
  const OnlinePaymentsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsOnlinePayments';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnlinePaymentsVM>(
      converter: OnlinePaymentsVM.fromStore,
      builder: (context, viewModel) {
        return OnlinePayments(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class OnlinePaymentsVM {
  OnlinePaymentsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static OnlinePaymentsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return OnlinePaymentsVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
