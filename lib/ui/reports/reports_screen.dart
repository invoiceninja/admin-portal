import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/reports';

  final ReportsScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = viewModel.state;

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        drawer: isMobile(context) || state.prefState.isMenuFloated
            ? MenuDrawerBuilder()
            : null,
        endDrawer: isMobile(context) || state.prefState.isHistoryFloated
            ? HistoryDrawerBuilder()
            : null,
        appBar: AppBar(
          leading: isMobile(context) || state.prefState.isMenuFloated
              ? null
              : IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => store
                      .dispatch(UserSettingsChanged(sidebar: AppSidebar.menu)),
                ),
          title: Text(localization.reports),
        ),
        body: Column(
          children: <Widget>[
            FormCard(
              children: <Widget>[
                AppDropdownButton<String>(
                  labelText: localization.report,
                  value: state.uiState.reportsUIState.report,
                  onChanged: (dynamic value) =>
                      viewModel.onSettingsChanged(value),
                  items: [
                    kReportActivity,
                    kReportAging,
                    kReportClient,
                    kReportCredit,
                    kReportDocument,
                    kReportExpense,
                    kReportInvoice,
                    kReportPayment,
                    kReportProduct,
                    kReportProfitAndLoss,
                    kReportTask,
                    kReportTaxRate,
                    kReportQuote,
                  ]
                      .map((report) => DropdownMenuItem(
                            value: report,
                            child: Text(localization.lookup(report)),
                          ))
                      .toList(),
                ),
                AppDropdownButton<DateRange>(
                  labelText: localization.dateRange,
                  value: state.uiState.reportsUIState.dateRange,
                  onChanged: (dynamic value) => null,
                  items: DateRange.values
                      .map((dateRange) => DropdownMenuItem<DateRange>(
                            child:
                                Text(localization.lookup(dateRange.toString())),
                            value: dateRange,
                          ))
                      .toList(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
