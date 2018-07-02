import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';

class ActionMenuChoice {
  const ActionMenuChoice({
    @required this.action,
    @required this.label,
    @required this.icon});

  final String label;
  final IconData icon;
  final EntityAction action;
}

class ActionMenuButton extends StatelessWidget {
  final BaseEntity entity;
  final List<ActionMenuChoice> customActions;
  final Function(BuildContext, EntityAction) onSelected;
  final bool isLoading;

  ActionMenuButton({
    @required this.entity,
    @required this.onSelected,
    this.isLoading = false,
    this.customActions,
  });

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<EntityAction>> actions = [];

    if (isLoading) {
      return IconButton(
        onPressed: null,
        icon: SizedBox(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    customActions?.forEach((action) {
      if (action != null) {
        actions.add(PopupMenuItem<EntityAction>(
          value: action.action,
          child: Row(
            children: <Widget>[
              Icon(action.icon),
              SizedBox(width: 15.0),
              Text(action.label ?? ''),
            ],
          ),
        ));
      }
    });

    if (actions.length > 0) {
      actions.add(PopupMenuDivider());
    }
    
    if (entity.isArchived || entity.isDeleted) {
      actions.add(PopupMenuItem<EntityAction>(
        value: EntityAction.restore,
        child: Row(
          children: <Widget>[
            Icon(Icons.restore),
            SizedBox(width: 15.0),
            Text(AppLocalization.of(context).restore),
          ],
        ),
      ));
    }

    if (entity.isActive) {
      actions.add(PopupMenuItem<EntityAction>(
        value: EntityAction.archive,
        child: Row(
          children: <Widget>[
            Icon(Icons.archive),
            SizedBox(width: 15.0),
            Text(AppLocalization.of(context).archive),
          ],
        ),
      ));
    }

    if (entity.isActive || entity.isArchived) {
      actions.add(PopupMenuItem<EntityAction>(
        value: EntityAction.delete,
        child: Row(
          children: <Widget>[
            Icon(Icons.delete),
            SizedBox(width: 15.0),
            Text(AppLocalization.of(context).delete),
          ],
        ),
      ));
    }

    return PopupMenuButton<EntityAction>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => actions,
      onSelected: (EntityAction action) {
        this.onSelected(context, action);
      },
    );
  }
}