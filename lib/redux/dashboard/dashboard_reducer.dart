import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';

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
    //return state.rebuild((b) => b..currencyId = action.company.jcurrencyId);
    // TODO re-enable
    return state;
  }

  return state;
}
