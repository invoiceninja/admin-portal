import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';

ReportsUIState reportsUIReducer(ReportsUIState state, dynamic action) {
  if (action is UpdateReportSettings) {
    if (action.report != null &&
        action.report.isNotEmpty &&
        action.report != state.report) {
      return ReportsUIState().rebuild((b) => b..report = action.report);
    } else {
      return state.rebuild((b) => b
        ..report = action.report ?? state.report
        ..group = action.group ?? state.group
        ..subgroup = action.subgroup ?? state.subgroup
        ..chart = action.chart ?? state.chart
        ..customStartDate = action.customStartDate ?? state.customStartDate
        ..customEndDate = action.customEndDate ?? state.customEndDate
        ..filters.replace(action.filters ?? state.filters));
    }
  } else if (action is SelectCompany) {
    //return state.rebuild((b) => b..currencyId = action.company.currencyId);
    // TODO re-enable
    return state;
  }

  return state;
}
