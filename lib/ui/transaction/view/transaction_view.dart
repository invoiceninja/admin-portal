import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/search_text.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_list_item.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_item.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final TransactionViewVM viewModel;
  final bool isFilter;

  @override
  _TransactionViewState createState() => new _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final transaction = viewModel.transaction;
    final localization = AppLocalization.of(context);
    final state = viewModel.state;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: transaction,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          EntityHeader(
            entity: transaction,
            label: transaction.isDeposit
                ? localization.deposit
                : localization.withdrawal,
            value: formatNumber(transaction.amount, context,
                currencyId: transaction.currencyId),
            secondLabel: localization.date,
            secondValue: formatDate(transaction.date, context),
          ),
          ListDivider(),
          if (transaction.isConverted) ...[
            if (true)
              ...transaction.invoiceIds
                  .split(',')
                  .map((invoiceId) => state.invoiceState.get(invoiceId))
                  .map((invoice) =>
                      EntityListTile(entity: invoice, isFilter: false))
            else ...[
              EntitiesListTile(
                  entity: state.vendorState.get(transaction.vendorId),
                  isFilter: false),
              EntitiesListTile(
                  entity:
                      state.expenseCategoryState.get(transaction.categoryId),
                  isFilter: false),
              EntitiesListTile(
                  entity: state.expenseState.get(transaction.expenseId),
                  isFilter: false),
            ]
          ] else ...[
            if (false)
              Expanded(
                child: _MatchDeposits(
                  viewModel: viewModel,
                ),
              )
            else
              Expanded(
                child: _MatchWithdrawals(
                  viewModel: viewModel,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _MatchDeposits extends StatefulWidget {
  const _MatchDeposits({
    Key key,
    // ignore: unused_element
    @required this.viewModel,
  }) : super(key: key);

  final TransactionViewVM viewModel;

  @override
  State<_MatchDeposits> createState() => _MatchDepositsState();
}

class _MatchDepositsState extends State<_MatchDeposits> {
  TextEditingController _filterController;
  FocusNode _focusNode;
  List<InvoiceEntity> _invoices;
  List<InvoiceEntity> _selectedInvoices;

  bool _showFilter = false;
  String _minAmount = '';
  String _maxAmount = '';
  String _startDate = '';
  String _endDate = '';

  @override
  void initState() {
    super.initState();
    _filterController = TextEditingController();
    _focusNode = FocusNode();
    _selectedInvoices = [];

    updateInvoiceList();
  }

  void updateInvoiceList() {
    final state = widget.viewModel.state;
    final invoiceState = state.invoiceState;

    _invoices = invoiceState.map.values.where((invoice) {
      if (_selectedInvoices.isNotEmpty) {
        if (invoice.clientId != _selectedInvoices.first.clientId) {
          return false;
        }
      }

      if (invoice.isPaid || invoice.isDeleted) {
        return false;
      }

      final filter = _filterController.text;

      if (filter.isNotEmpty) {
        final client = state.clientState.get(invoice.clientId);
        if (!invoice.matchesFilter(filter) &&
            !client.matchesNameOrEmail(filter)) {
          return false;
        }
      }

      if (_showFilter) {
        if (_minAmount.isNotEmpty) {
          if (invoice.balanceOrAmount < parseDouble(_minAmount)) {
            return false;
          }
        }

        if (_maxAmount.isNotEmpty) {
          if (invoice.balanceOrAmount > parseDouble(_maxAmount)) {
            return false;
          }
        }

        if (_startDate.isNotEmpty) {
          if (invoice.date.compareTo(_startDate) == -1) {
            return false;
          }
        }

        if (_endDate.isNotEmpty) {
          if (invoice.date.compareTo(_endDate) == 1) {
            return false;
          }
        }
      }

      return true;
    }).toList();
    _invoices.sort((invoiceA, invoiceB) {
      /*
      if (_selectedInvoices.contains(invoiceA)) {
        return -1;
      } else if (_selectedInvoices.contains(invoiceB)) {
        return 1;
      }
      */

      return invoiceB.date.compareTo(invoiceA.date);
    });
  }

  bool get isFiltered {
    if (_minAmount.isNotEmpty || _maxAmount.isNotEmpty) {
      return true;
    }

    if (_startDate.isNotEmpty || _endDate.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    _filterController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final transaction = viewModel.transaction;
    final state = viewModel.state;

    String currencyId;
    if (_selectedInvoices.isNotEmpty) {
      currencyId =
          state.clientState.get(_selectedInvoices.first.clientId).currencyId;
    }

    double totalSelected = 0;
    _selectedInvoices
        .forEach((invoice) => totalSelected += invoice.balanceOrAmount);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18, top: 12, right: 10, bottom: 12),
                child: SearchText(
                  filterController: _filterController,
                  focusNode: _focusNode,
                  onChanged: (value) {
                    setState(() {
                      updateInvoiceList();
                    });
                  },
                  onCleared: () {
                    setState(() {
                      _filterController.text = '';
                      updateInvoiceList();
                    });
                  },
                  placeholder:
                      localization.searchInvoices.replaceFirst(':count ', ''),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => _showFilter = !_showFilter);
              },
              color: _showFilter || isFiltered ? state.accentColor : null,
              icon: Icon(Icons.filter_alt),
              tooltip:
                  state.prefState.enableTooltips ? localization.filter : '',
            ),
            SizedBox(width: 8),
          ],
        ),
        ListDivider(),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: _showFilter ? 138 : 0,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: DecoratedFormField(
                            label: localization.minAmount,
                            onChanged: (value) {
                              setState(() {
                                _minAmount = value;
                                updateInvoiceList();
                              });
                            },
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          )),
                          SizedBox(
                            width: kTableColumnGap,
                          ),
                          Expanded(
                              child: DecoratedFormField(
                            label: localization.maxAmount,
                            onChanged: (value) {
                              setState(() {
                                _maxAmount = value;
                                updateInvoiceList();
                              });
                            },
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          )),
                        ],
                      ),
                      Row(children: [
                        Expanded(
                          child: DatePicker(
                            labelText: localization.startDate,
                            onSelected: (date, _) {
                              setState(() {
                                _startDate = date;
                                updateInvoiceList();
                              });
                            },
                            selectedDate: _startDate,
                          ),
                        ),
                        SizedBox(width: kTableColumnGap),
                        Expanded(
                          child: DatePicker(
                            labelText: localization.endDate,
                            onSelected: (date, _) {
                              setState(() {
                                _endDate = date;
                                updateInvoiceList();
                              });
                            },
                            selectedDate: _endDate,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              ListDivider(),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: _invoices.length,
            itemBuilder: (BuildContext context, int index) {
              final invoice = _invoices[index];
              return InvoiceListItem(
                invoice: invoice,
                showCheck: true,
                isChecked: _selectedInvoices.contains(invoice),
                onTap: () => setState(() {
                  if (_selectedInvoices.contains(invoice)) {
                    _selectedInvoices.remove(invoice);
                  } else {
                    _selectedInvoices.add(invoice);
                  }
                  updateInvoiceList();
                }),
              );
            },
          ),
        ),
        if (_selectedInvoices.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '${_selectedInvoices.length} ${localization.selected} • ${formatNumber(totalSelected, context, currencyId: currencyId)}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ListDivider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            bottom: 18,
            right: 16,
          ),
          child: AppButton(
            label: localization.convertToPayment,
            onPressed: _selectedInvoices.isEmpty
                ? null
                : () {
                    final viewModel = widget.viewModel;
                    viewModel.onConvertToPayment(
                      context,
                      transaction.id,
                      _selectedInvoices.map((invoice) => invoice.id).toList(),
                    );
                  },
            iconData: getEntityActionIcon(EntityAction.convertToExpense),
          ),
        )
      ],
    );
  }
}

class _MatchWithdrawals extends StatefulWidget {
  const _MatchWithdrawals({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TransactionViewVM viewModel;

  @override
  State<_MatchWithdrawals> createState() => _MatchWithdrawalsState();
}

class _MatchWithdrawalsState extends State<_MatchWithdrawals> {
  TextEditingController _vendorFilterController;
  TextEditingController _categoryFilterController;
  FocusNode _vendorFocusNode;
  FocusNode _categoryFocusNode;
  List<VendorEntity> _vendors;
  List<ExpenseCategoryEntity> _categories;
  VendorEntity _selectedVendor;
  ExpenseCategoryEntity _selectedCategory;

  @override
  void initState() {
    super.initState();

    _vendorFilterController = TextEditingController();
    _categoryFilterController = TextEditingController();

    _vendorFocusNode = FocusNode();
    _categoryFocusNode = FocusNode();

    updateVendorList();
    updateCategoryList();
  }

  void updateCategoryList() {
    final state = widget.viewModel.state;
    final categoryState = state.expenseCategoryState;

    _categories = categoryState.map.values.where((category) {
      if (_selectedCategory != null) {
        if (category.id != _selectedCategory?.id) {
          return false;
        }
      }

      if (category.isDeleted) {
        return false;
      }

      final filter = _categoryFilterController.text;

      if (filter.isNotEmpty) {
        if (!category.matchesFilter(filter)) {
          return false;
        }
      }

      return true;
    }).toList();
    _categories.sort((categoryA, categoryB) {
      return categoryA.name
          .toLowerCase()
          .compareTo(categoryB.name.toLowerCase());
    });
  }

  void updateVendorList() {
    final state = widget.viewModel.state;
    final vendorState = state.vendorState;

    _vendors = vendorState.map.values.where((vendor) {
      if (_selectedVendor != null) {
        if (vendor.id != _selectedVendor?.id) {
          return false;
        }
      }

      if (vendor.isDeleted) {
        return false;
      }

      final filter = _vendorFilterController.text;

      if (filter.isNotEmpty) {
        if (!vendor.matchesFilter(filter)) {
          return false;
        }
      }

      return true;
    }).toList();
    _vendors.sort((vendorA, vendorB) {
      return vendorA.name.toLowerCase().compareTo(vendorB.name.toLowerCase());
    });
  }

  @override
  void dispose() {
    _vendorFilterController.dispose();
    _categoryFilterController.dispose();
    _vendorFocusNode.dispose();
    _categoryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final transaction = viewModel.transaction;

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18, top: 12, right: 10, bottom: 12),
                child: SearchText(
                    filterController: _vendorFilterController,
                    focusNode: _vendorFocusNode,
                    onChanged: (value) {
                      setState(() {
                        updateVendorList();
                      });
                    },
                    onCleared: () {
                      setState(() {
                        _vendorFilterController.text = '';
                        updateVendorList();
                      });
                    },
                    placeholder:
                        localization.searchVendors.replaceFirst(':count ', '')),
              ),
            ),
          ],
        ),
        ListDivider(),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: _vendors.length,
            itemBuilder: (BuildContext context, int index) {
              final vendor = _vendors[index];
              return VendorListItem(
                vendor: vendor,
                showCheck: true,
                isChecked: _selectedVendor?.id == vendor.id,
                onTap: () => setState(() {
                  if (_selectedVendor?.id == vendor.id) {
                    _selectedVendor = null;
                  } else {
                    _selectedVendor = vendor;
                  }
                  updateVendorList();
                }),
              );
            },
          ),
        ),
        ListDivider(),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18, top: 12, right: 10, bottom: 12),
                child: SearchText(
                    filterController: _categoryFilterController,
                    focusNode: _categoryFocusNode,
                    onChanged: (value) {
                      setState(() {
                        updateCategoryList();
                      });
                    },
                    onCleared: () {
                      setState(() {
                        _categoryFilterController.text = '';
                        updateCategoryList();
                      });
                    },
                    placeholder: localization.searchCategories
                        .replaceFirst(':count ', '')),
              ),
            ),
          ],
        ),
        ListDivider(),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: _categories.length,
            itemBuilder: (BuildContext context, int index) {
              final category = _categories[index];
              return ExpenseCategoryListItem(
                expenseCategory: category,
                showCheck: true,
                isChecked: _selectedCategory?.id == category.id,
                onTap: () => setState(() {
                  if (_selectedCategory?.id == category.id) {
                    _selectedCategory = null;
                  } else {
                    _selectedCategory = category;
                  }
                  updateCategoryList();
                }),
              );
            },
          ),
        ),
        ListDivider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            bottom: 16,
            right: 16,
          ),
          child: AppButton(
            label: localization.convertToExpense,
            onPressed: _selectedVendor == null
                ? null
                : () {
                    final viewModel = widget.viewModel;
                    viewModel.onConvertToExpense(
                      context,
                      transaction.id,
                      _selectedVendor.id,
                      _selectedCategory?.id ?? '',
                    );
                  },
            iconData: getEntityActionIcon(EntityAction.convertToExpense),
          ),
        )
      ],
    );
  }
}
