import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';

class DashboardActivity extends StatelessWidget {
  const DashboardActivity({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  Widget build(BuildContext context) {
    if (!viewModel.dashboardState.isLoaded) {
      return LoadingIndicator();
    }

    final activities = viewModel.dashboardState.data.activities;

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (BuildContext context, index) {
        final activity = activities[index];
        return ActivityListTile(activity: activity);
      },
    );
  }
}

