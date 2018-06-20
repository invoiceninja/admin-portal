import 'dart:math';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';

class EntityDropdown extends StatefulWidget {
  EntityDropdown({
    @required this.labelText,
    @required this.entityList,
    @required this.entityMap,
    @required this.onFilterChanged,
    this.initialValue,
  });

  final List<int> entityList;
  final BuiltMap<int, BaseEntity> entityMap;
  final String labelText;
  final int initialValue;
  final Function(String) onFilterChanged;

  @override
  _EntityDropdownState createState() => _EntityDropdownState();
}

class _EntityDropdownState extends State<EntityDropdown> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();

        _headerRow() {
          return Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) => widget.onFilterChanged(value),
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localization.filter,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: StoreBuilder(
                    builder: (BuildContext context, Store<AppState> store) {
                  return Column(
                    children: <Widget>[
                      Material(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                          _headerRow(),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              children: widget.entityList
                                  .getRange(0, min(6, widget.entityList.length))
                                  .map((entityId) {
                                var entity = widget.entityMap[entityId];
                                var filter =
                                    store.state.uiState.entityDropdownFilter;
                                var subtitle = null;
                                var matchField =
                                    entity.matchesSearchField(filter);
                                if (matchField != null) {
                                  var field = localization.lookup(matchField);
                                  var value = entity.matchesSearchValue(filter);
                                  subtitle = '$field: $value';
                                }
                                return ListTile(
                                  dense: true,
                                  title: Text(entity.listDisplayName),
                                  subtitle:
                                      subtitle != null ? Text(subtitle) : null,
                                  onTap: () {
                                    //
                                  },
                                );
                              }).toList()),
                        ]),
                      ),
                      Expanded(child: Container()),
                    ],
                  );
                }),
              );
            });
      }
    });

    return TextFormField(
      focusNode: _focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
