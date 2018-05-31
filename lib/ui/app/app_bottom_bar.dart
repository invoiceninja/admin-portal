import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

enum EntityState {
  active,
  archived,
  deleted,
}

class AppBottomBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  final List<String> sortFields;
  final Function(String) onSelectedSortField;
  final String selectedSortField;
  final bool selectedSortAscending;

  final List<int> selectStatusIds;
  final List<int> selectStateIds;
  final Function(List<int>) onSelectedStatusIds;
  final Function(List<int>) onSelectedStateIds;

  PersistentBottomSheetController _sortController;
  PersistentBottomSheetController _filterController;

  AppBottomBar(
      {this.scaffoldKey,
      this.sortFields,
      this.onSelectedSortField,
      this.selectedSortField,
      this.selectedSortAscending,
      this.selectStateIds,
      this.selectStatusIds,
      this.onSelectedStateIds,
      this.onSelectedStatusIds});

  @override
  Widget build(BuildContext context) {
    final _showFilterSheet = () {
      if (_filterController != null) {
        _filterController.close();
        return;
      }

      _filterController = scaffoldKey.currentState.showBottomSheet((context) {
        return Container(
          color: Colors.grey[200],
          child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Column(
              children: <Widget>[
                CheckboxListTile(
                  value: true,
                  dense: true,
                  title: Text(AppLocalization.of((context)).active),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {

                  },
                ),
                CheckboxListTile(
                  value: true,
                  dense: true,
                  title: Text(AppLocalization.of((context)).archived),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {

                  },
                ),
                CheckboxListTile(
                  value: true,
                  dense: true,
                  title: Text(AppLocalization.of((context)).deleted),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {

                  },
                ),
              ],
            ),
            /*
            Column(
                mainAxisSize: MainAxisSize.min,
                children: sortFields.map((sortField) {
                  return CheckboxListTile(
                    dense: true,
                    title:
                        Text(AppLocalization.of((context)).lookup(sortField)),
                    groupValue: selectedSortField,
                    onChanged: (value) {
                      this.onSelectedSortField(value);
                    },
                    value: sortField,
                  );
                }).toList()),
                */
          ]),
        );
      });

      _filterController.closed.whenComplete(() {
        _filterController = null;
      });
    };

    final _showSortSheet = () {
      if (_sortController != null) {
        _sortController.close();
        return;
      }

      _sortController = scaffoldKey.currentState.showBottomSheet((context) {
        return Container(
          color: Colors.grey[200],
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: sortFields.map((sortField) {
                return RadioListTile(
                  dense: true,
                  title: Text(AppLocalization.of((context)).lookup(sortField)),
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

      _sortController.closed.whenComplete(() {
        _sortController = null;
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
            onPressed: _showFilterSheet,
          ),
        ],
      ),
    );
  }
}
