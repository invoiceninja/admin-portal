import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientList extends StatelessWidget {

  static final String route = '/clients';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalization.of(context).clients),
      ),
      drawer: new AppDrawerBuilder(),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ],
        ),
      ),
    );
  }
}
