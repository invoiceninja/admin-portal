import 'dart:math';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';

class EntityDropdown extends StatefulWidget {
  EntityDropdown({
    @required this.labelText,
    @required this.entityList,
    @required this.entityMap,
    this.initialValue,
  });

  final List<int> entityList;
  final BuiltMap<int, BaseEntity> entityMap;
  final String labelText;
  final int initialValue;

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
    var entityList = widget.entityList;
    var entityMap = widget.entityMap;

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
                  onChanged: (value) {
                    print('value: $value');
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localization.filter,
                  ),
                ),
              ),
              /*
                        FlatButton(
                          child: Text(localization.cancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                        RaisedButton(
                          child: Text(localization.create),
                        ),
                        */
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
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _headerRow(),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                children: entityList
                                    .getRange(0, min(6, entityList.length))
                                    .map((entityId) => ListTile(
                                          dense: true,
                                          title: Text(entityMap[entityId]
                                              .listDisplayName),
                                          onTap: () {
                                            //
                                          },
                                        ))
                                    .toList()),
                          ]),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
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
