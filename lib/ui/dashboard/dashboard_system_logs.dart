// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/system_log_viewer.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';

class DashboardSystemLogs extends StatelessWidget {
  const DashboardSystemLogs({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  Widget build(BuildContext context) {
    final company = viewModel.state.company;
    final systemLogs = company.systemLogs;

    return SystemLogViewer(
      systemLogs: systemLogs,
    );
  }
}
