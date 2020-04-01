import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';

class ClientViewActivity extends StatefulWidget {
  const ClientViewActivity({Key key, this.viewModel}) : super(key: key);

  final ClientViewVM viewModel;

  @override
  _ClientViewActivityState createState() => _ClientViewActivityState();
}

class _ClientViewActivityState extends State<ClientViewActivity> {
  @override
  void didChangeDependencies() {
    widget.viewModel.onRefreshed(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final activities = widget.viewModel.client.activities;

    if (activities.isEmpty) {
      return LoadingIndicator();
    }

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (BuildContext context, index) {
        final activity = activities[index];
        return ActivityListTile(activity: activity);
      },
    );
  }
}
