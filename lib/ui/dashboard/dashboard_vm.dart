import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';

class DashboardBuilder extends StatelessWidget {
  const DashboardBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashboardVM>(
      converter: DashboardVM.fromStore,
      builder: (context, vm) {
        return DashboardPanels(
          viewModel: vm
        );
      },
    );
  }
}

class DashboardVM {
  final DashboardState dashboardState;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;

  DashboardVM({
    @required this.dashboardState,
    @required this.isLoading,
    @required this.onRefreshed,
  });

  static DashboardVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final Completer<Null> completer = new Completer<Null>();
      store.dispatch(LoadDashboard(completer, true));
      return completer.future.then((_) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: SnackBarRow(
              message: AppLocalization.of(context).refreshComplete,
            )));
      });
    }

    return DashboardVM(
      dashboardState: store.state.dashboardState,
      isLoading: store.state.isLoading,
      onRefreshed: (context) => _handleRefresh(context),
    );
  }
}
