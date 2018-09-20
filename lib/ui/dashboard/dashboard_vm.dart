import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';

class DashboardBuilder extends StatelessWidget {
  const DashboardBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashboardVM>(
      distinct: true,
      converter: DashboardVM.fromStore,
      builder: (context, viewModel) {
        return DashboardView(viewModel: viewModel);
      },
    );
  }
}

class DashboardVM {
  final AppState state;
  final DashboardState dashboardState;
  final DashboardUIState dashboardUIState;
  final String filter;
  final List<BaseEntity> filteredList;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(DashboardSettings) onSettingsChanged;

  DashboardVM({
    @required this.state,
    @required this.dashboardUIState,
    @required this.dashboardState,
    @required this.isLoading,
    @required this.filter,
    @required this.filteredList,
    @required this.onRefreshed,
    @required this.onSettingsChanged,
  });

  static DashboardVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadDashboard(completer, true));
      return completer.future;
    }

    final state = store.state;
    final filter = state.uiState.filter;

    return DashboardVM(
      state: state,
      dashboardUIState: state.dashboardUIState,
      dashboardState: state.dashboardState,
      isLoading: state.isLoading,
      onRefreshed: (context) => _handleRefresh(context),
      onSettingsChanged: (DashboardSettings settings) =>
          store.dispatch(UpdateDashboardSettings(settings)),
      filter: filter,
      filteredList:
          memoizedFilteredSelector(filter, state.selectedCompanyState),
    );
  }

  @override
  bool operator ==(dynamic other) =>
      dashboardState == other.dashboardState &&
      dashboardUIState == other.dashboardUIState &&
      isLoading == other.isLoading &&
      filter == other.filter &&
      filteredList == other.filteredList;

  @override
  int get hashCode =>
      dashboardState.hashCode ^
      dashboardUIState.hashCode ^
      isLoading.hashCode ^
      filter.hashCode ^
      filteredList.hashCode;
}
