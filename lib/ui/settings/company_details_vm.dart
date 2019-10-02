import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CompanyDetailsBuilder extends StatelessWidget {
  const CompanyDetailsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyDetailsVM>(
      converter: CompanyDetailsVM.fromStore,
      builder: (context, viewModel) {
        return CompanyDetails(viewModel: viewModel);
      },
    );
  }
}

class CompanyDetailsVM {
  CompanyDetailsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.onBackPressed,
  });

  static CompanyDetailsVM fromStore(Store<AppState> store) {
    //final state = store.state;

    return CompanyDetailsVM(
      state: store.state,
      onBackPressed: () {
        /*
        if (state.uiState.currentRoute.contains(ProductScreen.route)) {
          store.dispatch(UpdateCurrentRoute(ProductScreen.route));
        }
        */
      },
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function onBackPressed;
}
