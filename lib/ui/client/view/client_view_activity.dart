import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';

class ClientViewActivity extends StatelessWidget {
  const ClientViewActivity({this.client});

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {

    final activities = client.activities;

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
