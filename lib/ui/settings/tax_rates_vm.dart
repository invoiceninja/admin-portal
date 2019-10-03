import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_rates.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaxRatesBuilder extends StatelessWidget {
  const TaxRatesBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxRatesVM>(
      converter: TaxRatesVM.fromStore,
      builder: (context, viewModel) {
        return TaxRates(viewModel: viewModel);
      },
    );
  }
}

class TaxRatesVM {
  TaxRatesVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static TaxRatesVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TaxRatesVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
