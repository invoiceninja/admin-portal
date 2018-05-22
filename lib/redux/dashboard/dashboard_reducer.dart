import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/data/models/models.dart';

final dashboardReducer = combineReducers<DashboardEntity>([
  TypedReducer<DashboardEntity, DashboardLoadedAction>(_setLoadedDashboards),
  TypedReducer<DashboardEntity, DashboardNotLoadedAction>(_setNoDashboards),
]);

DashboardEntity _setLoadedDashboards(DashboardEntity data, DashboardLoadedAction action) {
  return action.data;
}

DashboardEntity _setNoDashboards(DashboardEntity data, DashboardNotLoadedAction action) {
  return null;
}
