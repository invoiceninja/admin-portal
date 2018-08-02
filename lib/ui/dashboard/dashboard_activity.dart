import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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

class ActivityListTile extends StatelessWidget {

  const ActivityListTile({
    Key key,
    @required this.activity,
  }) : super(key: key);

  final ActivityEntity activity;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    String title = localization.lookup('activity_${activity.activityTypeId}');

    return ListTile(
      title: Text(title),
    );
  }
}
