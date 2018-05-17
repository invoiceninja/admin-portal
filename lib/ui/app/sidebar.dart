import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            child: new DrawerHeader(
              child: new Center(
                child: new Text('Logo'),
              ),
            ),
            color: Colors.white10,
          ),
          new ListTile(
            leading: new Icon(Icons.dashboard),
            title: new Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/');
            },
          ),
          /*
          new ListTile(
            leading: new Icon(Icons.people),
            title: new Text('Clients'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/clientList');
            },
          ),
          */
          new ListTile(
            leading: new Icon(Icons.language),
            title: new Text('Products'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/productList');
            },
          ),
          /*
          new ListTile(
            leading: new Icon(Icons.email),
            title: new Text('Invoices'),
            onTap: () {},
          ),
          */
        ],
      ),
    );
  }
}
