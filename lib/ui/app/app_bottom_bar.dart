import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

class AppBottomBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  final List<String> sortFields;
  final Function(String) onSelectedSortField;
  final String selectedSortField;
  final bool selectedSortAscending;

  AppBottomBar({
      this.scaffoldKey,
      this.sortFields,
      this.onSelectedSortField,
      this.selectedSortField,
      this.selectedSortAscending});

  @override
  Widget build(BuildContext context) {
    final _showSortSheet = () {
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
                  subtitle: sortField == this.selectedSortField
                      ? Text(selectedSortAscending
                      ? AppLocalization.of((context)).ascending
                      : AppLocalization.of((context)).descending)
                      : null,
                  groupValue: selectedSortField,
                  onChanged: (value) {
                    this.onSelectedSortField(value);
                  },
                  value: sortField,
                );
              }).toList()),
        );
      });
    };

    return new BottomAppBar(
      hasNotch: true,
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: AppLocalization.of((context)).sort,
            icon: Icon(Icons.sort_by_alpha),
            onPressed: _showSortSheet,
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
