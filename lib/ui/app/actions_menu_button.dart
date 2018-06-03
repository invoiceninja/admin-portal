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
  final ProductEntity entity;
  //final List<ActionMenuChoice> actions;
  final Function onSelected;

  ActionMenuButton({
    //this.actions,
    this.entity,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ActionMenuChoice>(
      itemBuilder: (BuildContext context) {
        return [
          entity.isActive() ? PopupMenuItem<ActionMenuChoice>(
            //value: choice,
            child: Row(
              children: <Widget>[
                Icon(Icons.archive),
                SizedBox(width: 15.0),
                //Text(label),
              ],
            ),
          ) : Container(),
          entity.isActive() || entity.isArchived() ? PopupMenuItem<ActionMenuChoice>(
            //value: choice,
            child: Row(
              children: <Widget>[
                Icon(Icons.delete),
                SizedBox(width: 15.0),
                //Text(label),
              ],
            ),
          ) : Container(),
          entity.isArchived() || entity.isDeleted ? PopupMenuItem<ActionMenuChoice>(
            //value: choice,
            child: Row(
              children: <Widget>[
                Icon(Icons.restore),
                SizedBox(width: 15.0),
                //Text(label),
              ],
            ),
          ) : Container(),
        ];
        /*
        return actions.map((ActionMenuChoice choice) {
          var icon, label;
          switch (choice.action) {
            case EntityAction.archive:
              icon = choice.icon ?? Icons.archive;
              label = choice.label ?? AppLocalization.of(context).archive;
              break;
            case EntityAction.delete:
              icon = choice.icon ?? Icons.delete;
              label = choice.label ?? AppLocalization.of(context).delete;
              break;
          }
          return new PopupMenuItem<ActionMenuChoice>(
            value: choice,
            child: Row(
              children: <Widget>[
                Icon(icon),
                SizedBox(width: 15.0),
                Text(label),
              ],
            ),
          );
        }).toList();
        */
      },
      onSelected: (ActionMenuChoice choice) {
        this.onSelected(choice);
      },
    );
  }
}