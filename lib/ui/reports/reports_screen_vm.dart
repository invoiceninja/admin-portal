import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_selectors.dart';
import 'package:invoiceninja_flutter/ui/reports/client_report.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:redux/redux.dart';

import 'reports_screen.dart';

class ReportsScreenBuilder extends StatelessWidget {
  const ReportsScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ReportsScreenVM>(
      converter: ReportsScreenVM.fromStore,
      builder: (context, vm) {
        return ReportsScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ReportsScreenVM {
  ReportsScreenVM({
    @required this.state,
    @required this.onSettingsChanged,
    @required this.reportResult,
  });

  final AppState state;
  final ReportResult reportResult;
  final Function({
    String report,
    DateRange dateRange,
    String customStartDate,
    String customEndDate,
  }) onSettingsChanged;

  static ReportsScreenVM fromStore(Store<AppState> store) {
    final state = store.state;
    ReportResult reportResult;

    switch (state.uiState.reportsUIState.report) {
      default:
        reportResult = clientReport(
          userCompany: state.userCompany,
          clientMap: state.clientState.map,
          reportsUIState: state.uiState.reportsUIState,
        );
        break;
    }

    return ReportsScreenVM(
      state: state,
      reportResult: reportResult,
      onSettingsChanged: ({
        String report,
        DateRange dateRange,
        String customStartDate,
        String customEndDate,
      }) {
        store.dispatch(UpdateReportSettings(
          report: report,
          dateRange: dateRange,
          customStartDate: customStartDate,
          customEndDate: customEndDate,
        ));
      },
    );
  }
}
