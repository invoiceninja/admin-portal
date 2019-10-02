import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/buy_now_buttons.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class BuyNowButtonsBuilder extends StatelessWidget {
  const BuyNowButtonsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyNowButtonsVM>(
      converter: BuyNowButtonsVM.fromStore,
      builder: (context, viewModel) {
        return BuyNowButtons(viewModel: viewModel);
      },
    );
  }
}

class BuyNowButtonsVM {
  BuyNowButtonsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static BuyNowButtonsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return BuyNowButtonsVM(
      state: state,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
