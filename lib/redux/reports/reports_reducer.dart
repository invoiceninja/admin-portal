// Project imports:
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';

ReportsUIState reportsUIReducer(ReportsUIState state, dynamic action) {
  if (action is SaveAuthUserSuccess) {
    return state.rebuild((b) => b
      ..group = ''
      ..subgroup = ''
      ..selectedGroup = ''
      ..chart = '');
  } else if (action is UpdateReportSettings) {
    if (action.report.isNotEmpty && action.report != state.report) {
      return ReportsUIState().rebuild((b) => b..report = action.report);
    } else {
      return state.rebuild((b) => b
        ..report = action.report
        ..group = action.group ?? state.group
        ..selectedGroup = action.selectedGroup ?? state.selectedGroup
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
