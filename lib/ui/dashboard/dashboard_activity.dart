// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';

class DashboardActivity extends StatelessWidget {
  const DashboardActivity({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  Widget build(BuildContext context) {
    final company = viewModel.state.company;
    final activities = company.activities;

    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ScrollableListViewBuilder(
        itemCount: activities.length,
        separatorBuilder: (context, index) => ListDivider(),
        itemBuilder: (BuildContext context, index) {
          final activity = activities[index];
          return ActivityListTile(activity: activity);
        },
      ),
    );
  }
}
