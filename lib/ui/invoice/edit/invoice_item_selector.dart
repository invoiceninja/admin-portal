import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceItemSelector extends StatefulWidget {
  const InvoiceItemSelector({
    @required this.clientId,
    this.onItemsSelected,
  });

  final Function(List<InvoiceItemEntity>) onItemsSelected;
  final int clientId;

  @override
  _InvoiceItemSelectorState createState() => new _InvoiceItemSelectorState();
}

class _InvoiceItemSelectorState extends State<InvoiceItemSelector>
    with SingleTickerProviderStateMixin {
  String _filter;
  TabController _tabController;
  final List<BaseEntity> _selected = [];

  final _textController = TextEditingController();

  //EntityType _selectedEntityType = EntityType.product;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _textController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _addBlankItem() {
    widget.onItemsSelected([InvoiceItemEntity()]);
    Navigator.pop(context);
  }

  void _onItemsSelected(BuildContext context) {
    final List<InvoiceItemEntity> items = [];
    final state = StoreProvider.of<AppState>(context).state;

    _selected.forEach((entity) {
      final product = entity as ProductEntity;
      if (state.selectedCompany.fillProducts == false) {
        items.add(InvoiceItemEntity().rebuild((b) => b
          ..productKey = product.productKey
          ..qty = 1));
      } else {
        items.add(product.asInvoiceItem);
      }
    });

    widget.onItemsSelected(items);
    Navigator.pop(context);
  }

  void _toggleEntity(BaseEntity entity) {
    setState(() {
      _filter = '';
      _textController.text = '';
      if (_selected.contains(entity)) {
        _selected.remove(entity);
      } else {
        _selected.add(entity);
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
                hintText: _selected.isEmpty
                    ? localization.filter
                    : localization.countSelected
                        .replaceFirst(':count', '${_selected.length}'),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    setState(() {
                      _filter = _textController.text = '';
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              _selected.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () => _onItemsSelected(context),
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

    Widget _productList() {
      final state = StoreProvider.of<AppState>(context).state;
      final matches =
      memoizedProductList(state.productState.map).where((entityId) {
        final entity = state.productState.map[entityId];
        return entity.isActive && entity.matchesFilter(_filter);
      }).toList();

      matches.sort((idA, idB) =>
          state.productState.map[idA].compareTo(state.productState.map[idB]));

      return ListView.builder(
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final int entityId = matches[index];
          final entity = state.productState.map[entityId];
          final String subtitle = entity.matchesFilterValue(_filter);
          return ListTile(
            dense: true,
            leading: Checkbox(
              activeColor: Theme.of(context).accentColor,
              value: _selected.contains(entityId),
              onChanged: (bool value) => _toggleEntity(entity),
            ),
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
            onTap: () {
              if (_selected.isNotEmpty) {
                _toggleEntity(entity);
              } else {
                _selected.add(entity);
                _onItemsSelected(context);
              }
            },
          );
        },
      );
    }

    Widget _taskList() {
      final state = StoreProvider.of<AppState>(context).state;
      final matches =
      memoizedTaskList(state.taskState.map, widget.clientId).where((entityId) {
        final entity = state.taskState.map[entityId];
        return entity.isActive && entity.matchesFilter(_filter);
      }).toList();

      //matches.sort((idA, idB) =>
          //state.productState.map[idA].compareTo(state.productState.map[idB]));

      return ListView.builder(
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final int entityId = matches[index];
          final entity = state.taskState.map[entityId];
          final String subtitle = entity.matchesFilterValue(_filter);
          return ListTile(
            dense: true,
            leading: Checkbox(
              activeColor: Theme.of(context).accentColor,
              value: _selected.contains(entityId),
              onChanged: (bool value) => _toggleEntity(entity),
            ),
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
            onTap: () {
              if (_selected.isNotEmpty) {
                _toggleEntity(entity);
              } else {
                _selected.add(entity);
                _onItemsSelected(context);
              }
            },
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 4.0,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _headerRow(),
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: localization.products,
              ),
              Tab(
                text: localization.tasks,
              ),
              /*
              Tab(
                text: localization.expenses,
              ),
              */
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _productList(),
                _taskList(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
