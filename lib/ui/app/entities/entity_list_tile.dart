import 'package:flutter/material.dart';

class EntityListTile extends StatelessWidget {
  const EntityListTile(
      {this.icon, this.onTap, this.onLongPress, this.title, this.subtitle});

  final Function onTap;
  final Function onLongPress;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text(title),
            subtitle:
                subtitle != null && subtitle.isNotEmpty ? Text(subtitle) : null,
            leading: Icon(icon, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        ),
        Divider(height: 1),
      ],
    );
  }
}
