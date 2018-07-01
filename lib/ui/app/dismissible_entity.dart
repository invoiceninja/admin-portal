

import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';

class DismissibleEntity extends StatelessWidget {

  DismissibleEntity({
    this.entity,
    this.child,
    this.onDismissed,
    this.onTap,
  });

  final BaseEntity entity;
  final Widget child;
  final Function onDismissed;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(entity.entityKey),
      onDismissed: onDismissed,
      child: child,
      background: entity.isDeleted ? Container(
        color: Colors.blue,
        child: const ListTile(
            leading:
            const Icon(Icons.restore, color: Colors.white, size: 36.0)),
      ) : Container(
          color: Colors.red,
          child: const ListTile(
              leading:
              const Icon(Icons.delete, color: Colors.white, size: 36.0))),
      secondaryBackground: entity.isArchived() || entity.isDeleted ? Container(
        color: Colors.blue,
        child: const ListTile(
            trailing:
            const Icon(Icons.restore, color: Colors.white, size: 36.0)),
      ) : Container(
          color: Colors.orange,
          child: const ListTile(
              trailing:
              const Icon(Icons.archive, color: Colors.white, size: 36.0))),
    );
  }
}
