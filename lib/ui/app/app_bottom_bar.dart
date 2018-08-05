import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:redux/redux.dart';

class AppBottomBar extends StatefulWidget {
  final EntityType entityType;
  final List<String> sortFields;
  final List<EntityStatus> statuses;
  final Function(String) onSelectedSortField;
  final Function(EntityState, bool) onSelectedState;
  final Function(EntityStatus, bool) onSelectedStatus;

  const AppBottomBar({
    this.sortFields,
    this.onSelectedSortField,
    this.entityType,
    this.onSelectedState,
    this.statuses,
    this.onSelectedStatus,
  });

  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  PersistentBottomSheetController _sortController;
  PersistentBottomSheetController _filterStateController;
  PersistentBottomSheetController _filterStatusController;

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
          //distinct: true,
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
                      .hasCustomStateFilters
                  ? Theme.of(context).accentColor
                  : null,
            ),
            Opacity(
              opacity: widget.statuses == null ? 0.0 : 1.0,
              child: IconButton(
                tooltip: AppLocalization.of(context).filter,
                icon: Icon(Icons.filter),
                onPressed: _showFilterStatusSheet,
                color: store.state
                    .getListState(widget.entityType)
                    .hasCustomStatusFilters
                    ? Theme.of(context).accentColor
                    : null,
              ),
            ),
          ],
        ),
      );
    });
  }
}
