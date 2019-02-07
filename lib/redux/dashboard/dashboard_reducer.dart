import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
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
    if (settings != null) {
      return state.rebuild((b) => b
        ..dateRange = settings.dateRange
        ..customStartDate = settings.startDate
        ..customEndDate = settings.endDate
        ..enableComparison = settings.enableComparison
        ..compareDateRange = settings.compareDateRange
        ..compareCustomStartDate = settings.compareStartDate
        ..compareCustomStartDate = settings.compareEndDate
        ..offset = 0);
    } else if (action.offset != null) {
      return state.rebuild((b) => b..offset += action.offset);
    } else if (action.currencyId != null) {
      return state.rebuild((b) => b..currencyId = action.currencyId);
    }
  } else if (action is SelectCompany) {
    return state.rebuild((b) => b..currencyId = action.company.currencyId);
  }

  return state;
}
