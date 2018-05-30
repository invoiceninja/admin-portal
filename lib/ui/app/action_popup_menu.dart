import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

enum ActionMenuButtonType {
  filter,
  sort,
}

class SortField {
  final String field;
  final String label;
  SortField(this.field, this.label);
}

class ActionMenuChoice {
  const ActionMenuChoice(this.action, {this.label, this.icon});
  final String label;
  final IconData icon;
  final ActionMenuButtonType action;
}

class ActionMenuButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<ActionMenuChoice> actions;
  final List<SortField> sortFields;
  final Function onSelected;

  ActionMenuButton(
      {this.actions, this.onSelected, this.scaffoldKey, this.sortFields});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ActionMenuChoice>(
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
      onSelected: (ActionMenuChoice choice) {
        switch (choice.action) {
          case ActionMenuButtonType.sort:
            scaffoldKey.currentState.showBottomSheet((context) {
              return Container(
                color: Colors.grey[200],
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: sortFields.map((sortField) {
                      return RadioListTile(
                        title: Text(sortField.label),
                        groupValue: 'sort',
                        onChanged: (String) {},
                        value: sortField.field,
                      );
                    }).toList()),
              );
            });
            break;
          case ActionMenuButtonType.filter:
            break;
        }
      },
    );
  }
}
