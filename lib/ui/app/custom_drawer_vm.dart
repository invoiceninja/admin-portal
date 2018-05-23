import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/custom_drawer.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';

class CustomDrawerVM extends StatelessWidget {
  CustomDrawerVM({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return CustomDrawer(
          companyName: vm.companyName,
        );
      },
    );
  }
}

class _ViewModel {
  final String companyName;

  _ViewModel({
    @required this.companyName,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      companyName: store.state.selectedCompany().name,
    );
  }
}
