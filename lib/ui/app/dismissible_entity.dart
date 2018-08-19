import 'dart:math';

import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class DismissibleEntity extends StatelessWidget {
  const DismissibleEntity({
    @required this.user,
    @required this.entity,
    @required this.child,
    @required this.onDismissed,
  });

  final UserEntity user;
  final BaseEntity entity;
  final Widget child;
  final Function onDismissed;

  @override
  Widget build(BuildContext context) {
    if (!user.canEditEntity(entity)) {
      return child;
    }

    return Dismissible(
      // TODO fix this properly https://github.com/flutter/flutter/issues/11825
      //key: Key(entity.entityKey),
      key: Key(entity.entityKey + Random().nextInt(100000).toString()),
      onDismissed: onDismissed,
      child: child,
      background: entity.isDeleted
          ? Container(
              color: Colors.blue,
              child: const ListTile(
                  leading: const Icon(Icons.restore,
                      color: Colors.white, size: 36.0)),
            )
          : Container(
              color: Colors.red,
              child: const ListTile(
                  leading: const Icon(Icons.delete,
                      color: Colors.white, size: 36.0))),
      secondaryBackground: entity.isArchived || entity.isDeleted
          ? Container(
              color: Colors.blue,
              child: const ListTile(
                  trailing: const Icon(Icons.restore,
                      color: Colors.white, size: 36.0)),
            )
          : Container(
              color: Colors.orange,
              child: const ListTile(
                  trailing: const Icon(Icons.archive,
                      color: Colors.white, size: 36.0))),
    );
  }
}
