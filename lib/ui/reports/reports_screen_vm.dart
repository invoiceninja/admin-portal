import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
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
    @required this.onReportSorted,
    @required this.reportResult,
  });

  final AppState state;
  final ReportResult reportResult;
  final Function(BuildContext, List<String>) onReportColumnsChanged;
  final Function(int, bool) onReportSorted;
  final Function({String report}) onSettingsChanged;

  static ReportsScreenVM fromStore(Store<AppState> store) {
    final state = store.state;
    ReportResult reportResult;

    switch (state.uiState.reportsUIState.report) {
      default:
        reportResult = memoizedClientReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.clientState.map,
        );
        break;
    }

    return ReportsScreenVM(
      state: state,
      reportResult: reportResult,
      onReportSorted: (index, ascending) {
        store.dispatch(UpdateReportSettings(
          report: state.uiState.reportsUIState.report,
          sortIndex: index,
          sortAscending: ascending,
        ));
      },
      onReportColumnsChanged: (context, columns) {
        final report = state.uiState.reportsUIState.report;
        final allReportSettings = state.userCompany.settings.reportSettings;
        final reportSettings =
            (allReportSettings != null && allReportSettings.containsKey(report)
                    ? allReportSettings[report]
                    : ReportSettingsEntity())
                .rebuild((b) => b..columns.replace(BuiltList<String>(columns)));
        final user = state.user.rebuild((b) => b
          ..userCompany
                  .settings
                  .reportSettings[state.uiState.reportsUIState.report] =
              reportSettings);
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).savedSettings);
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
      }) {
        store.dispatch(UpdateReportSettings(
          report: report,
        ));
      },
    );
  }
}
