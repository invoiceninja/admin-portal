import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';

class DashboardActivity extends StatelessWidget {
  const DashboardActivity({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  Widget build(BuildContext context) {
    final company = viewModel.state.company;
    final activities = company.activities;

    return ScrollableListViewBuilder(
      itemCount: activities.length,
      itemBuilder: (BuildContext context, index) {
        final activity = activities[index];
        return ActivityListTile(activity: activity);
      },
    );
  }
}
