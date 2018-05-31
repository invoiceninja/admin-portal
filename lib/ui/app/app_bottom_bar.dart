import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

/*
enum BottomBarButtonType {
  filter,
  sort,
}
*/

/*
class _AppBottomBarChoice {
  const _AppBottomBarChoice (this.type, {this.label, this.icon});
  final String label;
  final IconData icon;
  final BottomBarButtonType type;
}
*/

class AppBottomBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  //final List<ActionMenuChoice> actions;

  final List<String> sortFields;
  final Function(String) onSelectedSort;
  final String selectedSort;

  AppBottomBar(
      {
      //this.actions,
      //this.onSelected,
      this.scaffoldKey,
      this.sortFields,
      this.onSelectedSort,
      this.selectedSort});

  @override
  Widget build(BuildContext context) {
    return new BottomAppBar(
      hasNotch: true,
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: AppLocalization.of((context)).sort,
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              scaffoldKey.currentState.showBottomSheet((context) {
                return Container(
                  color: Colors.grey[200],
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: sortFields.map((sortField) {
                        return RadioListTile(
                          dense: true,
                          title: Text(
                              AppLocalization.of((context)).lookup(sortField)),
                          groupValue: selectedSort,
                          onChanged: (value) {
                            this.onSelectedSort(value);
                          },
                          value: sortField,
                        );
                      }).toList()),
                );
              });
            },
          ),
          IconButton(
            tooltip: AppLocalization.of((context)).filter,
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
