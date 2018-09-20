import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';

final dashboardReducer = combineReducers<DashboardState>([
  TypedReducer<DashboardState, LoadDashboardSuccess>(_setLoadedDashboards),
]);

DashboardState _setLoadedDashboards(
    DashboardState dashboardState, LoadDashboardSuccess action) {
  return dashboardState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..data.replace(action.data));
}

DashboardUIState dashboardUIReducer(DashboardUIState state, dynamic action) {
  if (action is UpdateDashboardSettings) {
    final settings = action.settings;
    final offset = action.offset;

    if (settings != null) {
      return state.rebuild((b) => b
        ..dateRange = settings.dateRange
        ..customStartDate = settings.startDate
        ..customEndDate = settings.endDate
        ..enableComparison = settings.enableComparison
        ..compareDateRange = settings.compareDateRange
        ..compareCustomStartDate = settings.compareStartDate
        ..compareCustomStartDate = settings.compareEndDate);
    } else if (offset != null) {
      return state.rebuild((b) => b..offset += offset);
    }
  }

  return state;
}
