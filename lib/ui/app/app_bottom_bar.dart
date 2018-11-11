import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:redux/redux.dart';

class AppBottomBar extends StatefulWidget {

  const AppBottomBar({
    this.sortFields,
    this.onSelectedSortField,
    this.entityType,
    this.onSelectedState,
    this.onSelectedStatus,
    this.onSelectedCustom1,
    this.onSelectedCustom2,
    this.statuses = const [],
    this.customValues1 = const [],
    this.customValues2 = const [],
  });

  final EntityType entityType;
  final List<String> sortFields;
  final List<EntityStatus> statuses;
  final Function(String) onSelectedSortField;
  final Function(EntityState, bool) onSelectedState;
  final Function(EntityStatus, bool) onSelectedStatus;
  final Function(String) onSelectedCustom1;
  final Function(String) onSelectedCustom2;
  final List<String> customValues1;
  final List<String> customValues2;

  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  PersistentBottomSheetController _sortController;
  PersistentBottomSheetController _filterStateController;
  PersistentBottomSheetController _filterStatusController;
  PersistentBottomSheetController _filterCustom1Controller;
  PersistentBottomSheetController _filterCustom2Controller;

  @override
  Widget build(BuildContext context) {

    final _showFilterStateSheet = () {
      if (_filterStateController != null) {
        _filterStateController.close();
        return;
      }

      _filterStateController =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
        return StoreConnector<AppState, BuiltList<EntityState>>(
          converter: (Store<AppState> store) =>
              store.state.getListState(widget.entityType).stateFilters,
          builder: (BuildContext context, stateFilters) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Column(
                  children: EntityState.values.map<Widget>((state) {
                    return CheckboxListTile(
                      key: Key(state.toString()),
                      title: Text(
                          AppLocalization.of(context).lookup(state.toString())),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: stateFilters.contains(state),
                      activeColor: Theme.of(context).accentColor,
                      dense: true,
                      onChanged: (value) {
                        widget.onSelectedState(state, value);
                      },
                    );
                  }).toList(),
                ),
              ]),
            );
          },
        );
      });

      _filterStateController.closed.whenComplete(() {
        _filterStateController = null;
      });
    };

    final _showFilterStatusSheet = () {
      if (_filterStatusController != null) {
        _filterStatusController.close();
        return;
      }

      _filterStatusController =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
        return StoreConnector<AppState, BuiltList<EntityStatus>>(
          converter: (Store<AppState> store) =>
              store.state.getListState(widget.entityType).statusFilters,
          builder: (BuildContext context, statusFilters) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Column(
                  children: widget.statuses.map((status) {
                    return CheckboxListTile(
                      key: Key(status.toString()),
                      title:
                          Text(AppLocalization.of(context).lookup(status.name)),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: statusFilters.contains(status),
                      activeColor: Theme.of(context).accentColor,
                      dense: true,
                      onChanged: (value) {
                        widget.onSelectedStatus(status, value);
                      },
                    );
                  }).toList(),
                ),
              ]),
            );
          },
        );
      });

      _filterStatusController.closed.whenComplete(() {
        _filterStatusController = null;
      });
    };

    final _showSortSheet = () {
      if (_sortController != null) {
        _sortController.close();
        return;
      }

      _sortController =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
        return StoreConnector<AppState, ListUIState>(
          //distinct: true,
          converter: (Store<AppState> store) =>
              store.state.getListState(widget.entityType),
          builder: (BuildContext context, listUIState) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.sortFields.map((sortField) {
                    return RadioListTile(
                      dense: true,
                      title:
                          Text(AppLocalization.of(context).lookup(sortField)),
                      subtitle: sortField == listUIState.sortField
                          ? Text(listUIState.sortAscending
                              ? AppLocalization.of(context).ascending
                              : AppLocalization.of(context).descending)
                          : null,
                      groupValue: listUIState.sortField,
                      activeColor: Theme.of(context).accentColor,
                      onChanged: (String value) {
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

    final _showFilterCustom1Sheet = () {
      if (_filterCustom1Controller != null) {
        _filterCustom1Controller.close();
        return;
      }

      _filterCustom1Controller =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
            return StoreConnector<AppState, BuiltList<String>>(
              converter: (Store<AppState> store) =>
              store.state.getListState(widget.entityType).custom1Filters,
              builder: (BuildContext context, customFilters) {
                return Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Column(
                      children: widget.customValues1.map<Widget>((customField) {
                        return CheckboxListTile(
                          key: Key(customField.toString()),
                          title: Text(customField),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: customFilters.contains(customField),
                          activeColor: Theme.of(context).accentColor,
                          dense: true,
                          onChanged: (value) {
                            widget.onSelectedCustom1(customField);
                          },
                        );
                      }).toList(),
                    ),
                  ]),
                );
              },
            );
          });

      _filterCustom1Controller.closed.whenComplete(() {
        _filterCustom1Controller = null;
      });
    };

    final _showFilterCustom2Sheet = () {
      if (_filterCustom2Controller != null) {
        _filterCustom2Controller.close();
        return;
      }

      _filterCustom2Controller =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
            return StoreConnector<AppState, BuiltList<String>>(
              converter: (Store<AppState> store) =>
              store.state.getListState(widget.entityType).custom2Filters,
              builder: (BuildContext context, customFilters) {
                return Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Column(
                      children: widget.customValues2.map<Widget>((customField) {
                        return CheckboxListTile(
                          key: Key(customField.toString()),
                          title: Text(customField),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: customFilters.contains(customField),
                          activeColor: Theme.of(context).accentColor,
                          dense: true,
                          onChanged: (value) {
                            widget.onSelectedCustom2(customField);
                          },
                        );
                      }).toList(),
                    ),
                  ]),
                );
              },
            );
          });

      _filterCustom2Controller.closed.whenComplete(() {
        _filterCustom2Controller = null;
      });
    };

    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      return BottomAppBar(
        shape: CircularNotchedRectangle(),
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
              onPressed: _showFilterStateSheet,
              color: store.state
                      .getListState(widget.entityType)
                      .hasStateFilters
                  ? Theme.of(context).accentColor
                  : null,
            ),
            widget.statuses.isNotEmpty ? IconButton(
              tooltip: AppLocalization.of(context).filter,
              icon: Icon(Icons.filter),
              onPressed: _showFilterStatusSheet,
              color: store.state
                  .getListState(widget.entityType)
                  .hasStatusFilters
                  ? Theme.of(context).accentColor
                  : null,
            ) : SizedBox(width: 0.0),
            widget.customValues1.isNotEmpty ? IconButton(
              tooltip: AppLocalization.of(context).filter,
              icon: Icon(Icons.looks_one),
              onPressed: _showFilterCustom1Sheet,
              color: store.state
                  .getListState(widget.entityType)
                  .hasCustom1Filters
                  ? Theme.of(context).accentColor
                  : null,
            ) : SizedBox(width: 0.0),
            widget.customValues2.isNotEmpty ? IconButton(
              tooltip: AppLocalization.of(context).filter,
              icon: Icon(Icons.looks_two),
              onPressed: _showFilterCustom2Sheet,
              color: store.state
                  .getListState(widget.entityType)
                  .hasCustom2Filters
                  ? Theme.of(context).accentColor
                  : null,
            ) : SizedBox(width: 0.0),
          ],
        ),
      );
    });
  }
}
