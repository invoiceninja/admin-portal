import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/reports/client_report.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
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
    @required this.onReportColumnsChanged,
    @required this.reportResult,
  });

  final AppState state;
  final ReportResult reportResult;
  final Function(BuildContext, List<String>) onReportColumnsChanged;
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
      onReportColumnsChanged: (context, columns) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).savedSettings);
        final user = state.user.rebuild((b) => b
          ..userCompany
                  .settings
                  .reportColumns[state.uiState.reportsUIState.report] =
              BuiltList<String>(columns));
        if (state.authState.hasRecentlyEnteredPassword) {
          store.dispatch(
            SaveUserSettingsRequest(
              completer: completer,
              user: user,
            ),
          );
        } else {
          passwordCallback(
              context: context,
              callback: (password) {
                store.dispatch(
                  SaveUserSettingsRequest(
                    completer: completer,
                    user: user,
                    password: password,
                  ),
                );
              });
        }
      },
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
