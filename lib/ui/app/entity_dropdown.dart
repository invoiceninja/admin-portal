import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';

class EntityDropdown extends StatefulWidget {
  const EntityDropdown({
    @required this.entityType,
    @required this.labelText,
    @required this.entityMap,
    @required this.entityList,
    @required this.onSelected,
    this.validator,
    this.initialValue,
  });

  final EntityType entityType;
  final BuiltMap<int, SelectableEntity> entityMap;
  final List<int> entityList;
  final String labelText;
  final String initialValue;
  final Function(int) onSelected;
  final Function validator;

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
            onSelected: (entityId) {
              _textController.text = widget.entityMap[entityId].listDisplayName;
              widget.onSelected(entityId);
              Navigator.pop(context);
            },
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
  });

  final BuiltMap<int, SelectableEntity> entityMap;
  final List<int> entityList;
  final Function(int) onSelected;

  @override
  _EntityDropdownDialogState createState() => new _EntityDropdownDialogState();
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
          )
        ],
      );
    }

    Widget _createList() {
      final matches = widget.entityList
          .where(
              (entityId) => widget.entityMap[entityId].matchesSearch(_filter))
          .toList();

      return ListView.builder(
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final int entityId = matches[index];
          final entity = widget.entityMap[entityId];
          final String subtitle = entity.matchesSearchValue(_filter);
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
            onTap: () => widget.onSelected(entityId),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Material(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            _headerRow(),
            _createList(),
          ]),
        ),
      ),
    );
  }
}
