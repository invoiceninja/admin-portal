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
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<ActionMenuChoice> actions;
  final Function onSelected;

  final List<String> sortFields;
  final Function(String, Function) onSelectedSort;
  final String selectedSort;

  ActionMenuButton({
    this.actions,
    this.onSelected,
    this.scaffoldKey,
    this.sortFields,
    this.onSelectedSort,
    this.selectedSort});

  @override
  Widget build(BuildContext context) {
    print('=== BUILD ===');

    showSortScreen() {
      scaffoldKey.currentState.showBottomSheet((context) {
        return Container(
          color: Colors.grey[200],
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: sortFields.map((sortField) {
                return RadioListTile(
                  dense: true,
                  title: Text(AppLocalization.of((context)).lookup(sortField)),
                  groupValue: selectedSort,
                  onChanged: (value) {
                    this.onSelectedSort(value, showSortScreen);
                  },
                  value: sortField,
                );
              }).toList()),
        );
      });
    }

    showFIlterScree() {
      scaffoldKey.currentState.showBottomSheet((context) {
        bool _active = false;

        return Container(
          color: Colors.grey[200],
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  value: true,
                  title: Text('Active'),
                  selected: _active,
                  onChanged: (checked) {
                    _active = ! checked;
                  },
                ),
              ]
          ),
        );
      });
    }

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
            showSortScreen();
            break;
          case ActionMenuButtonType.filter:
            showFIlterScree();
            break;
        }
      },
    );
  }
}
