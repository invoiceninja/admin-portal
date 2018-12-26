import 'dart:math';

import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DismissibleEntity extends StatelessWidget {
  const DismissibleEntity({
    @required this.user,
    @required this.entity,
    @required this.child,
    @required this.onEntityAction,
  });

  final UserEntity user;
  final BaseEntity entity;
  final Widget child;
  final Function(EntityAction entityAction) onEntityAction;

  @override
  Widget build(BuildContext context) {
    if (!user.canEditEntity(entity)) {
      return child;
    }

    if (onEntityAction == null) {
      return child;
    }

    final localization = AppLocalization.of(context);

    return Slidable(
      child: child,
      delegate: SlidableDrawerDelegate(),
      key: Key(entity.entityKey + Random().nextInt(100000).toString()),
      actions: <Widget>[
        entity.isActive
            ? IconSlideAction(
                caption: localization.archive,
                color: Colors.orange,
                foregroundColor: Colors.white,
                icon: Icons.archive,
                onTap: () => onEntityAction(EntityAction.archive),
              )
            : IconSlideAction(
                caption: localization.restore,
                color: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.restore,
                onTap: () => onEntityAction(EntityAction.restore),
              ),
        IconSlideAction(
          caption: localization.more,
          color: Colors.black45,
          foregroundColor: Colors.white,
          icon: Icons.more_horiz,
          onTap: () => onEntityAction(EntityAction.more),
        ),
      ],
      secondaryActions: <Widget>[
        entity.isDeleted
            ? IconSlideAction(
                caption: localization.restore,
                color: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.restore,
                onTap: () => onEntityAction(EntityAction.restore),
              )
            : IconSlideAction(
                caption: localization.delete,
                color: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                onTap: () => onEntityAction(EntityAction.delete),
              ),
      ],
    );
  }
}
