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
  FocusNode _clientFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    _clientFocus.addListener(() {
      if (_clientFocus.hasFocus) {
        _clientFocus.unfocus();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: TextField(
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
                    ),
                    ListView.builder(
                        itemCount: widget.entityList.length,
                        itemBuilder: (BuildContext context, index) {
                          var entityId = widget.entityList[index];
                          var entity = widget.entityMap[entityId];
                          return Column(children: <Widget>[
                            ListTile(
                              title: Text(entity.id.toString()),
                            ),
                            Divider(
                              height: 1.0,
                            ),
                          ]);
                        }),
                  ]),
                ),
              );
            });
      }
    });

    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: Icon(Icons.search),
      ),
      focusNode: _clientFocus,
    );
  }
}
