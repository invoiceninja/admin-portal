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
    @required this.onReportFiltersChanged,
    @required this.onReportSorted,
    @required this.reportResult,
  });

  final AppState state;
  final ReportResult reportResult;
  final Function(BuildContext, List<String>) onReportColumnsChanged;
  final Function(BuildContext, BuiltMap<String, String>) onReportFiltersChanged;
  final Function(int, bool) onReportSorted;
  final Function({
    String report,
    String customStartDate,
    String customEndDate,
    String group,
    String subgroup,
    String chart,
  }) onSettingsChanged;

  static ReportsScreenVM fromStore(Store<AppState> store) {
    final state = store.state;
    final report = state.uiState.reportsUIState.report;
    ReportResult reportResult;

    switch (state.uiState.reportsUIState.report) {
      default:
        reportResult = memoizedClientReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.clientState.map,
          state.userState.map,
          state.staticState,
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
        ));
      },
      onReportFiltersChanged: (context, filterMap) {
        store.dispatch(UpdateReportSettings(
          report: report,
          filters: filterMap,
        ));
      },
      onReportColumnsChanged: (context, columns) {
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
        String group,
        String subgroup,
        String chart,
        String customStartDate,
        String customEndDate,
      }) {
        final reportState = state.uiState.reportsUIState;
        if (group != null && reportState.group != group) {
          store.dispatch(UpdateReportSettings(
            report: report ?? reportState.report,
            group: group,
            chart: chart,
            subgroup: subgroup,
            customStartDate: '',
            customEndDate: '',
            filters: BuiltMap<String, String>(),
          ));
        } else {
          store.dispatch(UpdateReportSettings(
            report: report ?? reportState.report,
            group: group,
            subgroup: subgroup,
            chart: chart,
            customStartDate: customStartDate,
            customEndDate: customEndDate,
          ));
        }
      },
    );
  }
}
