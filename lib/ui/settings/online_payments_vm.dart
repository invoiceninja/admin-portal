import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/online_payments.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class OnlinePaymentsBuilder extends StatelessWidget {
  const OnlinePaymentsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnlinePaymentsVM>(
      converter: OnlinePaymentsVM.fromStore,
      builder: (context, viewModel) {
        return OnlinePayments(viewModel: viewModel);
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
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
