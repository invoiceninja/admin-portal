import 'package:flutter/material.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/ui/app/custom_drawer.dart';

class ClientList extends StatelessWidget {
  ClientList() : super(key: NinjaKeys.clientList);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Clients'),
      ),
      drawer: new CustomDrawer(),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              'THE CLIENTS',
            ),
          ],
        ),
      ),
    );
  }
}
