import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_item.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceItemSelector extends StatefulWidget {
  const InvoiceItemSelector({
    @required this.clientId,
    this.onItemsSelected,
    this.excluded,
  });

  final Function(List<InvoiceItemEntity>, [int]) onItemsSelected;
  final int clientId;
  final List<int> excluded;

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

  void _onItemsSelected(BuildContext context, [int clientId]) {
    final List<InvoiceItemEntity> items = [];
    final state = StoreProvider.of<AppState>(context).state;

    _selected.forEach((entity) {
      if (state.selectedCompany.fillProducts == false) {
        final product = entity as ProductEntity;
        items.add(InvoiceItemEntity().rebuild((b) => b
          ..productKey = product.productKey
          ..qty = 1));
      } else {
        var item = (entity as ConvertToInvoiceItem).asInvoiceItem;
        if (entity.entityType == EntityType.task) {
          final task = entity as TaskEntity;
          final project = state.projectState.map[task.projectId];
          var notes = item.notes + '\n';
          task.taskTimes.forEach((time) {
            final start = formatDate(time.startDate.toIso8601String(), context,
                showTime: true);
            final end = formatDate(time.endDate.toIso8601String(), context,
                showTime: true, showDate: false, showSeconds: false);
            notes += '\n### $start - $end';
          });
          item = item.rebuild((b) => b
            ..notes = notes
            ..cost = taskRateSelector(
                company: state.selectedCompany, project: project));
        }
        items.add(item);
      }
    });

    widget.onItemsSelected(items, clientId);
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

      return ListView.builder(
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final int entityId = matches[index];
          final product = state.productState.map[entityId];
          return ProductListItem(
            onCheckboxChanged: (checked) => _toggleEntity(product),
            isChecked: _selected.contains(product),
            product: product,
            user: state.user,
            filter: _filter,
            onTap: () {
              if (_selected.isNotEmpty) {
                _toggleEntity(product);
              } else {
                _selected.add(product);
                _onItemsSelected(context);
              }
            },
          );
        },
      );
    }

    Widget _taskList() {
      final state = StoreProvider.of<AppState>(context).state;
      final matches = memoizedTaskList(state.taskState.map, widget.clientId)
          .where((entityId) {
        final task = state.taskState.map[entityId];
        return task.matchesFilter(_filter) &&
            widget.excluded != null &&
            !widget.excluded.contains(task.id);
      }).toList();

      return ListView.builder(
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final int entityId = matches[index];
          final task = state.taskState.map[entityId];
          final project = state.projectState.map[task.projectId];
          final client = state.clientState.map[task.clientId];
          return TaskListItem(
            onCheckboxChanged: (checked) => _toggleEntity(task),
            isChecked: _selected.contains(task),
            project: project,
            task: task,
            client: client,
            onTap: () {
              if (_selected.isNotEmpty) {
                _toggleEntity(task);
              } else {
                _selected.add(task);
                _onItemsSelected(context, client?.id);
              }
            },
            filter: _filter,
            user: state.selectedCompany.user,
          );
        },
      );
    }

    final state = StoreProvider.of<AppState>(context).state;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 4.0,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _headerRow(),
          TabBar(
            labelColor:
                state.uiState.enableDarkMode ? Colors.white : Colors.black,
            indicatorColor: Theme.of(context).accentColor,
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
