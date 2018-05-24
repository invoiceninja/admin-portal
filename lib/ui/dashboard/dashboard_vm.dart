import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';

class DashboardVM extends StatelessWidget {
  DashboardVM({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return DashboardPanels(
          dashboardState: vm.dashboardState,
        );
      },
    );
  }
}

class _ViewModel {
  final DashboardState dashboardState;
  final bool isLoading;

  _ViewModel({
    @required this.dashboardState,
    @required this.isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      dashboardState: store.state.dashboardState(),
      isLoading: store.state.isLoading,
    );
  }
}
