import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';

class EntityListTile extends StatelessWidget {
  const EntityListTile({
    @required this.entity,
    this.onTap,
    this.onLongPress,
    this.subtitle,
  });

  final Function onTap;
  final Function onLongPress;
  final String subtitle;
  final BaseEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: EntityStateTitle(entity: entity),
              subtitle: subtitle != null && subtitle.isNotEmpty
                  ? Text(subtitle)
                  : null,
              leading: Icon(getEntityIcon(entity.entityType), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: onTap,
              onLongPress: onLongPress,
            ),
          ),
        ),
        ListDivider(),
      ],
    );
  }
}

class EntitiesListTile extends StatelessWidget {
  const EntitiesListTile({
    this.icon,
    this.onTap,
    this.onLongPress,
    this.title,
    this.subtitle,
  });

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: Text(title),
              subtitle: subtitle != null && subtitle.isNotEmpty
                  ? Text(subtitle)
                  : null,
              leading: Icon(icon, size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: onTap,
              onLongPress: onLongPress,
            ),
          ),
        ),
        ListDivider(),
      ],
    );
  }
}
