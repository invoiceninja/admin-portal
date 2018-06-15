import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';

class ActionMenuChoice {
  const ActionMenuChoice(this.action, {this.label, this.icon});
  final String label;
  final IconData icon;
  final EntityAction action;
}

class ActionMenuButton extends StatelessWidget {
  final BaseEntity entity;
  //final List<ActionMenuChoice> actions;
  final Function(BuildContext, EntityAction) onSelected;

  ActionMenuButton({
    //this.actions,
    this.entity,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<EntityAction>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return [
          entity.isArchived() || entity.isDeleted ? PopupMenuItem<EntityAction>(
            value: EntityAction.restore,
            child: Row(
              children: <Widget>[
                Icon(Icons.restore, color:  Colors.grey[600]),
                SizedBox(width: 15.0),
                Text(AppLocalization.of(context).restore),
              ],
            ),
          ) : null,
          entity.isActive() ? PopupMenuItem<EntityAction>(
            value: EntityAction.archive,
            child: Row(
              children: <Widget>[
                Icon(Icons.archive, color: Colors.grey[600]),
                SizedBox(width: 15.0),
                Text(AppLocalization.of(context).archive),
              ],
            ),
          ) : null,
          entity.isActive() || entity.isArchived() ? PopupMenuItem<EntityAction>(
            value: EntityAction.delete,
            child: Row(
              children: <Widget>[
                Icon(Icons.delete, color: Colors.grey[600]),
                SizedBox(width: 15.0),
                Text(AppLocalization.of(context).delete),
              ],
            ),
          ) : null,
        ];
      },
      onSelected: (EntityAction action) {
        this.onSelected(context, action);
      },
    );
  }
}