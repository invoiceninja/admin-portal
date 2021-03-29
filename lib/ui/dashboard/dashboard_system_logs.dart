import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/system_log_viewer.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';

class DashboardSystemLogs extends StatelessWidget {
  const DashboardSystemLogs({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  Widget build(BuildContext context) {
    final company = viewModel.state.company;
    //final systemLogs = company.systemLogs;
    final clientId = viewModel.state.clientState.list.first;
    final systemLogs = viewModel.state.clientState.map[clientId].systemLogs;
    print('## systemLogs: $systemLogs');

    return SystemLogViewer(
      systemLogs: systemLogs,
    );

    return ScrollableListViewBuilder(
      itemCount: systemLogs.length,
      itemBuilder: (BuildContext context, index) {
        return SystemLogViewer(
          systemLogs: systemLogs,
        );
      },
    );
  }
}
