import 'package:invoiceninja/data/models/invoice_model.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

class InvoiceItemSelector extends StatefulWidget {
  InvoiceItemSelector({this.state, this.onItemsSelected});

  final AppState state;
  final Function(List<InvoiceItemEntity>) onItemsSelected;

  @override
  _InvoiceItemSelectorState createState() => new _InvoiceItemSelectorState();
}

class _InvoiceItemSelectorState extends State<InvoiceItemSelector> {
  String _filter;
  List<int> _selectedIds = [];

  final _textController = TextEditingController();
  //EntityType _selectedEntityType = EntityType.product;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addBlankItem() {
    widget.onItemsSelected([
      InvoiceItemEntity()
    ]);
    Navigator.pop(context);
  }

  void _onItemsSelected() {
    final List<InvoiceItemEntity> items = [];

    _selectedIds.forEach((entityId) {
      final product = widget.state.productState.map[entityId];
      items.add(product.asInvoiceItem);
    });

    widget.onItemsSelected(items);
    Navigator.pop(context);
  }

  void _toggleEntity(int entityId) {
    setState(() {
      _filter = '';
      _textController.text = '';
      if (_selectedIds.contains(entityId)) {
        _selectedIds.remove(entityId);
      } else {
        _selectedIds.add(entityId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    Widget _headerRow() {
      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Icon(Icons.search),
            /*
                  child: DropdownButton(
                    value: 'Products',
                    onChanged: (value) {
                      //
                    },
                    items: <String>['Products', 'Tasks', 'Expenses']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                  */
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              onChanged: (value) {
                setState(() {
                  _filter = value;
                });
              },
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _selectedIds.length == 0
                    ? localization.filter
                    : localization.countSelected
                        .replaceFirst(':count', '${_selectedIds.length}'),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  if (_textController.text.length > 0) {
                    setState(() {
                      _filter = _textController.text = '';
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              _selectedIds.length > 0
                  ? IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () => _onItemsSelected(),
                    )
                  : IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () => _addBlankItem(),
              ),
            ],
          )
        ],
      );
    }

    Widget _entityList() {
      final state = widget.state.selectedCompanyState.productState;
      final matches = state.list
          .where((entityId) => state.map[entityId].matchesSearch(_filter))
          .toList();

      matches.sort((idA, idB) => state.map[idA].compareTo(state.map[idB]));

      return ListView.builder(
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final int entityId = matches[index];
          final entity = state.map[entityId];
          final String subtitle = entity.matchesSearchValue(_filter);
          return ListTile(
            dense: true,
            leading: Checkbox(
              value: _selectedIds.contains(entityId),
              onChanged: (bool value) => _toggleEntity(entityId),
            ),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(entity.listDisplayName),
                ),
                Text(entity.listDisplayCost(widget.state)),
              ],
            ),
            subtitle: subtitle != null ? Text(subtitle, maxLines: 2) : null,
            onTap: () {
              if (_selectedIds.isNotEmpty) {
                _toggleEntity(entityId);
              } else {
                _selectedIds.add(entityId);
                _onItemsSelected();
              }
            },
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
            _entityList(),
          ]),
        ),
      ),
    );
  }
}
