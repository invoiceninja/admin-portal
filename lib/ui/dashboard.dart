import 'package:flutter/material.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/ui/app/sidebar.dart';

class Dashboard extends StatelessWidget {
  Dashboard() : super(key: NinjaKeys.dashboard);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dashboard'),
      ),
      drawer: new Sidebar(),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              'DASHBOARD',
            ),
          ],
        ),
      ),
    );
  }
}