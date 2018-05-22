import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

class DashboardVM extends StatelessWidget {
  DashboardVM({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return DashboardPanels(
          dashboard: vm.dashboard,
        );
      },
    );
  }
}

class _ViewModel {
  final DashboardEntity dashboard;
  final bool loading;

  _ViewModel({
    @required this.dashboard,
    @required this.loading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      dashboard: store.state.dashboard,
      loading: store.state.isLoading,
    );
  }
}
