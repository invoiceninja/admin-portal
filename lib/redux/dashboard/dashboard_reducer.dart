import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja/data/models/models.dart';

final dashboardReducer = combineReducers<DashboardState>([
  TypedReducer<DashboardState, DashboardLoadedAction>(_setLoadedDashboards),
  TypedReducer<DashboardState, DashboardNotLoadedAction>(_setNoDashboards),
]);

DashboardState _setLoadedDashboards(DashboardState dashboardState, DashboardLoadedAction action) {
  return DashboardState().copyWith(
      lastUpdated: DateTime.now().millisecondsSinceEpoch,
      data: action.data
  );
}

DashboardState _setNoDashboards(DashboardState dashboardState, DashboardNotLoadedAction action) {
  return DashboardState().copyWith(
      data: null,
  );
}
