import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityDropdown extends StatefulWidget {
  const EntityDropdown({
    @required Key key,
    @required this.entityType,
    @required this.labelText,
    @required this.onSelected,
    this.entityMap,
    this.entityList,
    this.allowClearing = false,
    this.autoValidate = false,
    this.validator,
    this.entityId,
    this.onAddPressed,
    this.onFieldSubmitted,
  }) : super(key: key);

  final EntityType entityType;
  final List<String> entityList;
  final String labelText;
  final String entityId;
  final BuiltMap<String, SelectableEntity> entityMap;
  final Function(SelectableEntity) onSelected;
  final Function validator;
  final bool autoValidate;
  final bool allowClearing;
  final Function(String) onFieldSubmitted;
  final Function(Completer<SelectableEntity> completer) onAddPressed;

  @override
  _EntityDropdownState createState() => _EntityDropdownState();
}

class _EntityDropdownState extends State<EntityDropdown> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  BuiltMap<String, SelectableEntity> _entityMap;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOptions();
      }
    });
  }

  @override
  void didChangeDependencies() {
    final state = StoreProvider.of<AppState>(context).state;
    _entityMap = widget.entityMap ?? state.getEntityMap(widget.entityType);

    if (_entityMap == null) {
      print('ERROR: ENTITY MAP IS NULL: ${widget.entityType}');
    } else {
      _textController.text = _entityMap[widget.entityId]?.listDisplayName ?? '';
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _showOptions() {
    showDialog<EntityDropdownDialog>(
        context: context,
        builder: (BuildContext context) {
          return EntityDropdownDialog(
            entityMap: _entityMap,
            entityList: widget.entityList ?? _entityMap.keys.toList(),
            onSelected: (entity, [update = true]) {
              widget.onSelected(entity);

              if (update) {
                _textController.text = entity.listDisplayName;
              }

              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted(entity.listDisplayName);
              }
            },
            onAddPressed: widget.onAddPressed != null
                ? (context, completer) => widget.onAddPressed(completer)
                : null,
          );
        });
  }

  bool get showClear =>
      widget.allowClearing &&
      widget.entityId != null &&
      widget.entityId.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        InkWell(
          key: ValueKey(widget.labelText),
          onTap: () => _showOptions(),
          child: IgnorePointer(
            child: TextFormField(
              focusNode: _focusNode,
              readOnly: true,
              validator: widget.validator,
              autovalidate: widget.autoValidate,
              controller: _textController,
              decoration: InputDecoration(
                labelText: widget.labelText,
                suffixIcon: showClear ? null : const Icon(Icons.search),
              ),
            ),
          ),
        ),
        if (showClear)
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _textController.text = '';
              widget.onSelected(null);
            },
          ),
      ],
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

  final BuiltMap<String, SelectableEntity> entityMap;
  final List<String> entityList;
  final Function(SelectableEntity, [bool]) onSelected

  ;
  final Function(BuildContext context, Completer completer) onAddPressed;

  @override
  _EntityDropdownDialogState createState() => _EntityDropdownDialogState();
}

class _EntityDropdownDialogState extends State<EntityDropdownDialog> {
  String _filter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    void _selectEntity(SelectableEntity entity) {
      widget.onSelected(entity);
      Navigator.pop(context);
    }

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
              /*
              onSubmitted: (value) {
                final entityId = widget.entityList.firstWhere((entityId) =>
                    widget.entityMap[entityId].matchesFilter(_filter));
                final entity = widget.entityMap[entityId];
                _selectEntity(entity);
              },
               */
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
                  tooltip: localization.createNew,
                  onPressed: () {
                    Navigator.pop(context);
                    final Completer<SelectableEntity> completer =
                        Completer<SelectableEntity>();
                    widget.onAddPressed(context, completer);
                    completer.future.then((entity) {
                      widget.onSelected(entity, false);
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
          final entityId = matches[index];
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
            onTap: () => _selectEntity(entity),
          );
        },
      );
    }

    return ResponsivePadding(
      child: Material(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _headerRow(),
            Expanded(child: _createList()),
          ],
        ),
      ),
    );
  }
}
