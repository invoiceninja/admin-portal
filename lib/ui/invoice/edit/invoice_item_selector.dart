// Flutter imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_item.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceItemSelector extends StatefulWidget {
  const InvoiceItemSelector({
    required this.invoice,
    required this.clientId,
    required this.showTasksAndExpenses,
    this.onItemsSelected,
    this.excluded,
  });

  final InvoiceEntity invoice;
  final Function(List<InvoiceItemEntity>, [String?, String?])? onItemsSelected;
  final String clientId;
  final List<BaseEntity>? excluded;
  final bool showTasksAndExpenses;

  @override
  _InvoiceItemSelectorState createState() => new _InvoiceItemSelectorState();
}

class _InvoiceItemSelectorState extends State<InvoiceItemSelector>
    with SingleTickerProviderStateMixin {
  String? _filter;
  String? _filterClientId;
  late TabController _tabController;
  final List<BaseEntity> _selected = [];

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filterClientId = widget.clientId;
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _textController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _addBlankItem(CompanyEntity company) {
    widget.onItemsSelected!([
      InvoiceItemEntity(
        quantity:
            company.defaultQuantity || !company.enableProductQuantity ? 1 : 0,
        typeId: _tabController.index == 1 ? InvoiceItemEntity.TYPE_TASK : null,
      )
    ]);
    Navigator.pop(context);
  }

  void _onItemsSelected(BuildContext context) {
    final List<InvoiceItemEntity> items = [];
    final state = StoreProvider.of<AppState>(context).state;
    final company = state.company;
    String projectId = '';

    _selected.forEach((entity) {
      if (entity.entityType == EntityType.product) {
        items.add(
          convertProductToInvoiceItem(
            company: company,
            product: entity as ProductEntity?,
            invoice: widget.invoice,
            currencyMap: state.staticState.currencyMap,
            client: state.clientState.get(widget.clientId),
          ),
        );
      } else if (entity.entityType == EntityType.task) {
        final task = entity as TaskEntity;
        projectId = task.projectId;
        items.add(convertTaskToInvoiceItem(task: task, context: context));
      } else if (entity.entityType == EntityType.expense) {
        final expense = entity as ExpenseEntity;
        items.add(convertExpenseToInvoiceItem(
          expense: expense,
          context: context,
        ));
      }
    });

    _updateClientId();

    widget.onItemsSelected!(items, _filterClientId, projectId);
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

      _updateClientId();
    });
  }

  void _updateClientId() {
    final selected = _selected.firstWhereOrNull((entity) =>
        entity is BelongsToClient &&
        (((entity as BelongsToClient).clientId ?? '').isNotEmpty));

    if (selected != null) {
      _filterClientId = (selected as BelongsToClient).clientId;
    } else if (widget.clientId.isEmpty) {
      _filterClientId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final state = StoreProvider.of<AppState>(context).state;
    final company = state.company;
    final showTabBar = widget.showTasksAndExpenses &&
        (company.isModuleEnabled(EntityType.task) ||
            company.isModuleEnabled(EntityType.expense));

    final products =
        memoizedProductList(state.productState.map).where((entityId) {
      final entity = state.productState.map[entityId]!;
      return entity.isActive && entity.matchesFilter(_filter);
    }).toList();

    final tasks = memoizedTaskList(
      state.taskState.map,
      _filterClientId,
      state.userState.map,
      state.clientState.map,
      state.projectState.map,
    ).where((entityId) {
      final task = state.taskState.get(entityId!);
      final client = state.clientState.get(task.clientId);
      if (widget.excluded != null && widget.excluded!.contains(task)) {
        return false;
      }
      return task.matchesFilter(_filter) || client.matchesNameOrEmail(_filter);
    }).toList();

    final expenses = memoizedClientExpenseList(
      state.expenseState.map,
      _filterClientId,
    ).where((entityId) {
      final expense = state.expenseState.get(entityId!);
      final client = state.clientState.get(expense.clientId!);
      if (widget.excluded != null && widget.excluded!.contains(expense)) {
        return false;
      }
      return expense.matchesFilter(_filter) ||
          client.matchesNameOrEmail(_filter);
    }).toList();

    Widget _productList() {
      return ScrollableListViewBuilder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final String? entityId = products[index];
          final product = state.productState.map[entityId]!;
          return ProductListItem(
            isDismissible: false,
            showCost: widget.invoice.isPurchaseOrder &&
                company.enableProductCost &&
                product.cost != 0,
            onCheckboxChanged: (checked) => _toggleEntity(product),
            product: product,
            filter: _filter,
            isChecked: _selected.contains(product),
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
      return ScrollableListViewBuilder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final String? entityId = tasks[index];
          final task = state.taskState.map[entityId]!;
          return TaskListItem(
            isDismissible: false,
            onCheckboxChanged: (checked) => _toggleEntity(task),
            task: task,
            filter: _filter,
            isChecked: _selected.contains(task),
            onTap: () {
              if (_selected.isNotEmpty) {
                _toggleEntity(task);
              } else {
                _selected.add(task);
                _onItemsSelected(context);
              }
            },
          );
        },
      );
    }

    Widget _expenseList() {
      return ScrollableListViewBuilder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          final String? entityId = expenses[index];
          final expense = state.expenseState.map[entityId] ?? ExpenseEntity();
          return ExpenseListItem(
            isDismissible: false,
            showSelected: false,
            showCheckbox: true,
            onCheckboxChanged: (checked) => _toggleEntity(expense),
            isChecked: _selected.contains(expense),
            expense: expense,
            filter: _filter,
            onTap: () {
              if (_selected.isNotEmpty) {
                _toggleEntity(expense);
              } else {
                _selected.add(expense);
                _onItemsSelected(context);
              }
            },
          );
        },
      );
    }

    final List<Widget> tabs = [
      Tab(
        text: localization.products +
            (products.isNotEmpty ? ' (${products.length})' : ''),
      ),
    ];
    final List<Widget> tabViews = [
      _productList(),
    ];

    if (company.isModuleEnabled(EntityType.task)) {
      tabs.add(Tab(
        text:
            localization.tasks + (tasks.isNotEmpty ? ' (${tasks.length})' : ''),
      ));
      tabViews.add(_taskList());
    }

    if (company.isModuleEnabled(EntityType.expense)) {
      tabs.add(Tab(
        text: localization.expenses +
            (expenses.isNotEmpty ? ' (${expenses.length})' : ''),
      ));
      tabViews.add(_expenseList());
    }

    return ResponsivePadding(
      child: Material(
        elevation: 4.0,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(
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
                      : !state.prefState.isEditorFullScreen(EntityType.invoice)
                          ? IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              tooltip: localization.createNew,
                              onPressed: () => _addBlankItem(company),
                            )
                          : SizedBox(),
                ],
              )
            ],
          ),
          showTabBar
              ? AppTabBar(
                  controller: _tabController,
                  tabs: tabs,
                )
              : SizedBox(),
          Expanded(
            child: showTabBar
                ? TabBarView(
                    controller: _tabController,
                    children: tabViews,
                  )
                : tabViews.first,
          ),
        ]),
      ),
    );
  }
}
