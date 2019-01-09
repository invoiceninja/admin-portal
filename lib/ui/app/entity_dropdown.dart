import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityDropdown extends StatefulWidget {
  const EntityDropdown({
    Key key,
    @required this.entityType,
    @required this.labelText,
    @required this.entityMap,
    @required this.entityList,
    @required this.onSelected,
    this.validator,
    this.autoValidate = false,
    this.initialValue,
    this.onAddPressed,
  })  : super(key: key);

  final EntityType entityType;
  final BuiltMap<int, SelectableEntity> entityMap;
  final List<int> entityList;
  final String labelText;
  final String initialValue;
  final Function(SelectableEntity) onSelected;
  final Function validator;
  final bool autoValidate;
  final Function(Completer<SelectableEntity> completer) onAddPressed;

  @override
  _EntityDropdownState createState() => _EntityDropdownState();
}

class _EntityDropdownState extends State<EntityDropdown> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.initialValue;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showOptions() {
    showDialog<EntityDropdownDialog>(
        context: context,
        builder: (BuildContext context) {
          return EntityDropdownDialog(
            entityMap: widget.entityMap,
            entityList: widget.entityList,
            onSelected: (entity) {
              _textController.text = entity.listDisplayName;
              widget.onSelected(entity);
              Navigator.pop(context);
            },
            onAddPressed: widget.onAddPressed != null
                ? (context, completer) => widget.onAddPressed(completer)
                : null,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showOptions(),
      child: IgnorePointer(
        child: TextFormField(
          validator: widget.validator,
          autovalidate: widget.autoValidate,
          controller: _textController,
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

class EntityDropdownDialog extends StatefulWidget {
  const EntityDropdownDialog({
    @required this.entityMap,
    @required this.entityList,
    @required this.onSelected,
    this.onAddPressed,
  });

  final BuiltMap<int, SelectableEntity> entityMap;
  final List<int> entityList;
  final Function(SelectableEntity) onSelected;
  final Function(BuildContext context, Completer completer) onAddPressed;

  @override
  _EntityDropdownDialogState createState() => _EntityDropdownDialogState();
}

class _EntityDropdownDialogState extends State<EntityDropdownDialog> {
  String _filter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    Widget _headerRow() {
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
                setState(() {
                  _filter = value;
                });
              },
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: localization.filter,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          widget.onAddPressed != null
              ? IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    final Completer<SelectableEntity> completer =
                        Completer<SelectableEntity>();
                    widget.onAddPressed(context, completer);
                    completer.future.then((entity) {
                      widget.onSelected(entity);
                    });
                  },
                )
              : Container()
        ],
      );
    }

    Widget _createList() {
      final matches = widget.entityList
          .where(
              (entityId) => widget.entityMap[entityId].matchesFilter(_filter))
          .toList();

      return ListView.builder(
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final int entityId = matches[index];
          final entity = widget.entityMap[entityId];
          final String subtitle = entity.matchesFilterValue(_filter);
          return ListTile(
            dense: true,
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(entity.listDisplayName),
                ),
                entity.listDisplayAmount != null
                    ? Text(formatNumber(entity.listDisplayAmount, context,
                        formatNumberType: entity.listDisplayAmountType))
                    : Container(),
              ],
            ),
            subtitle: subtitle != null ? Text(subtitle, maxLines: 2) : null,
            onTap: () => widget.onSelected(entity),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 4.0,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          _headerRow(),
          Expanded(child: _createList()),
        ]),
      ),
    );
  }
}
