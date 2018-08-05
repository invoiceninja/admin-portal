import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';

class DashboardOverview extends StatelessWidget {

  const DashboardOverview({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  Widget build(BuildContext context) {
    if (!viewModel.dashboardState.isLoaded) {
      return LoadingIndicator();
    }

    return new Container();
  }
}
