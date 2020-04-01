import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({
    @required this.sortFields,
    @required this.onSelectedSortField,
    @required this.entityType,
    @required this.onSelectedState,
    @required this.onCheckboxPressed,
    this.onSelectedStatus,
    this.onSelectedCustom1,
    this.onSelectedCustom2,
    this.onSelectedCustom3,
    this.onSelectedCustom4,
    this.statuses = const [],
    this.customValues1 = const [],
    this.customValues2 = const [],
    this.customValues3 = const [],
    this.customValues4 = const [],
    this.onlyList = false,
  });

  final EntityType entityType;
  final List<String> sortFields;
  final List<EntityStatus> statuses;
  final Function onCheckboxPressed;
  final Function(String) onSelectedSortField;
  final Function(EntityState, bool) onSelectedState;
  final Function(EntityStatus, bool) onSelectedStatus;
  final Function(String) onSelectedCustom1;
  final Function(String) onSelectedCustom2;
  final Function(String) onSelectedCustom3;
  final Function(String) onSelectedCustom4;
  final List<String> customValues1;
  final List<String> customValues2;
  final List<String> customValues3;
  final List<String> customValues4;
  final bool onlyList;

  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  PersistentBottomSheetController _sortController;
  PersistentBottomSheetController _filterStateController;
  PersistentBottomSheetController _filterStatusController;
  PersistentBottomSheetController _filterCustom1Controller;
  PersistentBottomSheetController _filterCustom2Controller;
  PersistentBottomSheetController _filterCustom3Controller;
  PersistentBottomSheetController _filterCustom4Controller;

  int kSortPanel = 0;
  int kFilterStatePanel = 1;
  int kFilterStatusPanel = 2;
  int kCustom1Panel = 3;
  int kCustom2Panel = 4;
  int kCustom3Panel = 5;
  int kCustom4Panel = 6;

  int closeBottomSheet() {
    if (_filterStateController != null) {
      _filterStateController.close();
      return kFilterStatePanel;
    }

    if (_filterStatusController != null) {
      _filterStatusController.close();
      return kFilterStatusPanel;
    }

    if (_sortController != null) {
      _sortController.close();
      return kSortPanel;
    }

    if (_filterCustom1Controller != null) {
      _filterCustom1Controller.close();
      return kCustom1Panel;
    }

    if (_filterCustom2Controller != null) {
      _filterCustom2Controller.close();
      return kCustom2Panel;
    }

    if (_filterCustom3Controller != null) {
      _filterCustom3Controller.close();
      return kCustom3Panel;
    }

    if (_filterCustom4Controller != null) {
      _filterCustom4Controller.close();
      return kCustom4Panel;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;

    final _showFilterStateSheet = () {
      if (closeBottomSheet() == kFilterStatePanel) {
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
      if (closeBottomSheet() == kFilterStatusPanel) {
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
      if (closeBottomSheet() == kSortPanel) {
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
                    return GestureDetector(
                      onTap: () => widget.onSelectedSortField(sortField),
                      child: RadioListTile(
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
                        onChanged: (String value) =>
                            widget.onSelectedSortField(value),
                        value: sortField,
                      ),
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
      if (closeBottomSheet() == kCustom1Panel) {
        return;
      }

      _filterCustom1Controller =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
        return CustomFieldSelector(
          customNumber: 1,
          entityType: widget.entityType,
          customFilters: state.getListState(widget.entityType).custom1Filters,
          onSelected: (field) => widget.onSelectedCustom1(field),
          customValues: widget.customValues1,
        );
      });

      _filterCustom1Controller.closed.whenComplete(() {
        _filterCustom1Controller = null;
      });
    };

    final _showFilterCustom2Sheet = () {
      if (closeBottomSheet() == kCustom2Panel) {
        return;
      }
      _filterCustom2Controller =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
        return CustomFieldSelector(
          customNumber: 2,
          entityType: widget.entityType,
          customFilters: state.getListState(widget.entityType).custom2Filters,
          onSelected: (field) => widget.onSelectedCustom2(field),
          customValues: widget.customValues2,
        );
      });

      _filterCustom2Controller.closed.whenComplete(() {
        _filterCustom2Controller = null;
      });
    };

    final _showFilterCustom3Sheet = () {
      if (closeBottomSheet() == kCustom3Panel) {
        return;
      }

      _filterCustom3Controller =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
        return CustomFieldSelector(
          customNumber: 3,
          entityType: widget.entityType,
          customFilters: state.getListState(widget.entityType).custom3Filters,
          onSelected: (field) => widget.onSelectedCustom3(field),
          customValues: widget.customValues3,
        );
      });

      _filterCustom3Controller.closed.whenComplete(() {
        _filterCustom3Controller = null;
      });
    };

    final _showFilterCustom4Sheet = () {
      if (closeBottomSheet() == kCustom4Panel) {
        return;
      }

      _filterCustom4Controller =
          Scaffold.of(context).showBottomSheet<StoreConnector>((context) {
        return CustomFieldSelector(
          customNumber: 4,
          entityType: widget.entityType,
          customFilters: state.getListState(widget.entityType).custom4Filters,
          onSelected: (field) => widget.onSelectedCustom4(field),
          customValues: widget.customValues4,
        );
      });

      _filterCustom4Controller.closed.whenComplete(() {
        _filterCustom4Controller = null;
      });
    };

    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      final localization = AppLocalization.of(context);
      final prefState = store.state.prefState;
      final isList =
          prefState.moduleLayout == ModuleLayout.list || widget.onlyList;

      return BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: localization.multiselect,
              icon: Icon(Icons.check_box),
              onPressed: () => widget.onCheckboxPressed(),
            ),
            if (!widget.onlyList)
              IconButton(
                tooltip: localization.switchListTable,
                icon: Icon(isList ? Icons.table_chart : Icons.view_list),
                onPressed: () {
                  store.dispatch(SwitchListTableLayout());
                },
              ),
            if (isList && widget.sortFields.isNotEmpty)
              IconButton(
                tooltip: localization.sort,
                icon: Icon(Icons.sort_by_alpha),
                onPressed: _showSortSheet,
              ),
            if (!isList && isNotMobile(context))
              IconButton(
                tooltip: localization.preview,
                icon: Icon(Icons.chrome_reader_mode),
                onPressed: () {
                  store.dispatch(UserSettingsChanged(
                      isPreviewVisible: !state.prefState.isPreviewVisible));
                },
              ),
            IconButton(
              tooltip: localization.filter,
              icon: Icon(Icons.filter_list),
              onPressed: _showFilterStateSheet,
              color: store.state.getListState(widget.entityType).hasStateFilters
                  ? Theme.of(context).accentColor
                  : null,
            ),
            if (widget.statuses.isNotEmpty)
              IconButton(
                tooltip: localization.filter,
                icon: Icon(Icons.filter),
                onPressed: _showFilterStatusSheet,
                color:
                    store.state.getListState(widget.entityType).hasStatusFilters
                        ? Theme.of(context).accentColor
                        : null,
              ),
            if (widget.customValues1.isNotEmpty)
              IconButton(
                tooltip: localization.filter,
                icon: Icon(Icons.looks_one),
                onPressed: _showFilterCustom1Sheet,
                color: store.state
                        .getListState(widget.entityType)
                        .hasCustom1Filters
                    ? Theme.of(context).accentColor
                    : null,
              ),
            if (widget.customValues2.isNotEmpty)
              IconButton(
                tooltip: localization.filter,
                icon: Icon(Icons.looks_two),
                onPressed: _showFilterCustom2Sheet,
                color: store.state
                        .getListState(widget.entityType)
                        .hasCustom2Filters
                    ? Theme.of(context).accentColor
                    : null,
              ),
            if (widget.customValues3.isNotEmpty)
              IconButton(
                tooltip: localization.filter,
                icon: Icon(Icons.looks_two),
                onPressed: _showFilterCustom3Sheet,
                color: store.state
                        .getListState(widget.entityType)
                        .hasCustom3Filters
                    ? Theme.of(context).accentColor
                    : null,
              ),
            if (widget.customValues4.isNotEmpty)
              IconButton(
                tooltip: localization.filter,
                icon: Icon(Icons.looks_two),
                onPressed: _showFilterCustom4Sheet,
                color: store.state
                        .getListState(widget.entityType)
                        .hasCustom4Filters
                    ? Theme.of(context).accentColor
                    : null,
              ),
          ],
        ),
      );
    });
  }
}

class CustomFieldSelector extends StatelessWidget {
  const CustomFieldSelector({
    Key key,
    @required this.customNumber,
    @required this.entityType,
    @required this.customValues,
    @required this.onSelected,
    @required this.customFilters,
  }) : super(key: key);

  final int customNumber;
  final EntityType entityType;
  final List<String> customValues;
  final Function(String) onSelected;
  final BuiltList<String> customFilters;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuiltList<String>>(
      converter: (Store<AppState> store) =>
          store.state.getListState(entityType).getCustomFilters(customNumber),
      builder: (BuildContext context, customFilters) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Column(
              children: customValues.map<Widget>((customField) {
                return CheckboxListTile(
                  key: Key(customField.toString()),
                  title: Text(customField),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: customFilters.contains(customField),
                  activeColor: Theme.of(context).accentColor,
                  dense: true,
                  onChanged: (value) => onSelected(customField),
                );
              }).toList(),
            ),
          ]),
        );
      },
    );
  }
}
