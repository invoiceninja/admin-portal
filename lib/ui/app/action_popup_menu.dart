import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

enum ActionMenuButtonType {
  filter,
  sort,
}

class ActionMenuChoice {
  const ActionMenuChoice(this.action, {this.label, this.icon});
  final String label;
  final IconData icon;
  final ActionMenuButtonType action;
}

class ActionMenuButton extends StatelessWidget {
  final List<ActionMenuChoice> actions;
  final Function onSelected;

  ActionMenuButton({this.actions, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ActionMenuChoice>(
      // overflow menu
      onSelected: (ActionMenuChoice choice) => this.onSelected(choice),
      itemBuilder: (BuildContext context) {
        return actions.map((ActionMenuChoice choice) {
          var icon, label;
          switch (choice.action) {
            case ActionMenuButtonType.filter:
              icon = choice.icon ?? Icons.filter_list;
              label = choice.label ?? AppLocalization.of(context).filter;
              break;
            case ActionMenuButtonType.sort:
              icon = choice.icon ?? Icons.sort;
              label = choice.label ?? AppLocalization.of(context).sort;
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
      },
    );
  }
}
