import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:redux/redux.dart';

class AppBottomBar extends StatefulWidget {

  final List<String> sortFields;
  final Function(String) onSelectedSortField;
  final String selectedSortField;
  final bool selectedSortAscending;

  final BuiltList<int> selectedStatuses;
  final BuiltList<EntityState> selectedStates;
  final Function(List<int>) onSelectedStatus;
  final Function(EntityState, bool) onSelectedState;

  AppBottomBar(
      {this.sortFields,
        this.onSelectedSortField,
        this.selectedSortField,
        this.selectedSortAscending,
        this.selectedStates,
        this.selectedStatuses,
        this.onSelectedState,
        this.onSelectedStatus});

  @override
  _AppBottomBarState createState() => new _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  PersistentBottomSheetController _sortController;
  PersistentBottomSheetController _filterController;

  @override
  Widget build(BuildContext context) {
    final _showFilterSheet = () {
      if (_filterController != null) {
        _filterController.close();
        return;
      }

      _filterController = Scaffold.of(context).showBottomSheet((context) {
        return StoreConnector<AppState, BuiltList<EntityState>>(
          distinct: true,
          converter: (Store<AppState> store) => store.state.productListState().stateFilters,
          builder: (BuildContext context, stateFilters) {
            return Container(
              color: Colors.grey[200],
              child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Column(
                  children: EntityState.values.map<Widget>((state) {
                    return CheckboxListTile(
                      title: Text(AppLocalization.of(context).lookup(state.toString())),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: stateFilters.contains(state),
                      dense: true,
                      onChanged: (value) {
                        widget.onSelectedState(state, value);
                      },
                    );
                  }).toList(),
                ),
                /*
            Column(
                mainAxisSize: MainAxisSize.min,
                children: sortFields.map((sortField) {
                  return CheckboxListTile(
                    dense: true,
                    title:
                        Text(AppLocalization.of(context).lookup(sortField)),
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

          },
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

      _sortController  = Scaffold.of(context).showBottomSheet((context) {
        return StoreConnector<AppState, ListUIState>(
          distinct: true,
          converter: (Store<AppState> store) => store.state.productListState(),
          builder: (BuildContext context, listUIState) {
            return Container(
              color: Colors.grey[200],
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.sortFields.map((sortField) {
                    return RadioListTile(
                      dense: true,
                      title: Text(AppLocalization.of(context).lookup(sortField)),
                      subtitle: sortField == listUIState.sortField
                          ? Text(listUIState.sortAscending
                          ? AppLocalization.of(context).ascending
                          : AppLocalization.of(context).descending)
                          : null,
                      groupValue: listUIState.sortField,
                      onChanged: (value) {
                        widget.onSelectedSortField(value);
                      },
                      value: sortField,
                    );
                  }).toList()),
            );
          },
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
            tooltip: AppLocalization.of(context).sort,
            icon: Icon(Icons.sort_by_alpha),
            onPressed: _showSortSheet,
          ),
          IconButton(
            tooltip: AppLocalization.of(context).filter,
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
    );
  }
}