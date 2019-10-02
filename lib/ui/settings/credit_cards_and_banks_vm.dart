import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/credit_cards_and_banks.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditCardsAndBanksBuilder extends StatelessWidget {
  const CreditCardsAndBanksBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditCardsAndBanksVM>(
      converter: CreditCardsAndBanksVM.fromStore,
      builder: (context, viewModel) {
        return CreditCardsAndBanks(viewModel: viewModel);
      },
    );
  }
}

class CreditCardsAndBanksVM {
  CreditCardsAndBanksVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static CreditCardsAndBanksVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CreditCardsAndBanksVM(
      state: state,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
