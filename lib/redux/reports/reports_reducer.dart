import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';

ReportsUIState reportsUIReducer(ReportsUIState state, dynamic action) {
  if (action is UpdateReportSettings) {
    return state.rebuild((b) => b
      ..report = action.report ?? state.report
      ..dateRange = action.dateRange ?? state.dateRange
      ..customStartDate = action.customStartDate ?? state.customStartDate
      ..customEndDate = action.customEndDate ?? state.customEndDate
      ..currencyId = action.currencyId ?? state.currencyId);
  } else if (action is SelectCompany) {
    //return state.rebuild((b) => b..currencyId = action.company.jcurrencyId);
    // TODO re-enable
    return state;
  }

  return state;
}
