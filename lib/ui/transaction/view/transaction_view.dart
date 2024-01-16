import 'dart:async';

import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_toggle_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/search_text.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_list_item.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_screen.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
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
    final transactions = viewModel.transactions;
    final transaction =
        transactions.isEmpty ? TransactionEntity() : transactions.first;
    final localization = AppLocalization.of(context);
    final state = viewModel.state;
    final hasUnconvertable = transactions
            .where((transaction) =>
                !transaction.isWithdrawal || transaction.isConverted)
            .isNotEmpty &&
        transactions.length > 1;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: transaction,
      title: transactions.length > 1
          ? '${transactions.length} ${localization!.selected}'
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: hasUnconvertable
            ? []
            : [
                if (transactions.length == 1) ...[
                  EntityHeader(
                    entity: transaction,
                    label: transaction.isDeposit
                        ? localization!.deposit
                        : localization!.withdrawal,
                    value: formatNumber(transaction.amount, context,
                        currencyId: transaction.currencyId),
                    secondLabel: localization.date,
                    secondValue: formatDate(transaction.date, context),
                  ),
                  ListDivider(),
                ],
                if (transaction.isConverted) ...[
                  if (transaction.formattedDescription.isNotEmpty) ...[
                    IconMessage(transaction.formattedDescription,
                        copyToClipboard: true),
                    ListDivider(),
                  ],
                  EntityListTile(
                    entity:
                        state.bankAccountState.get(transaction.bankAccountId),
                    isFilter: false,
                  ),
                  EntityListTile(
                    entity: state.transactionRuleState
                        .get(transaction.transactionRuleId),
                    isFilter: false,
                  ),
                  if (transaction.isDeposit) ...[
                    ...transaction.invoiceIds
                        .split(',')
                        .map((invoiceId) => state.invoiceState.get(invoiceId))
                        .map((invoice) =>
                            EntityListTile(entity: invoice, isFilter: false)),
                    EntityListTile(
                      entity: state.paymentState.get(transaction.paymentId),
                      isFilter: false,
                    ),
                  ] else ...[
                    EntityListTile(
                      entity: state.vendorState.get(transaction.vendorId),
                      isFilter: false,
                    ),
                    EntityListTile(
                      entity: state.expenseCategoryState
                          .get(transaction.categoryId),
                      isFilter: false,
                    ),
                    for (final expenseId in transaction.expenseId.split(','))
                      EntityListTile(
                        entity: state.expenseState.get(expenseId),
                        isFilter: false,
                      ),
                  ]
                ] else ...[
                  if (transaction.isDeposit)
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
    Key? key,
    // ignore: unused_element
    required this.viewModel,
  }) : super(key: key);

  final TransactionViewVM viewModel;

  @override
  State<_MatchDeposits> createState() => _MatchDepositsState();
}

class _MatchDepositsState extends State<_MatchDeposits> {
  final _invoiceScrollController = ScrollController();
  final _paymentScrollController = ScrollController();
  TextEditingController? _invoiceFilterController;
  TextEditingController? _paymentFilterController;
  FocusNode? _focusNode;
  late List<InvoiceEntity> _invoices;
  late List<InvoiceEntity> _selectedInvoices;
  late List<PaymentEntity> _payments;
  PaymentEntity? _selectedPayment;

  bool _matchExisting = false;
  bool _showFilter = false;
  String _minAmount = '';
  String _maxAmount = '';
  String _startDate = '';
  String _endDate = '';

  @override
  void initState() {
    super.initState();
    _invoiceFilterController = TextEditingController();
    _paymentFilterController = TextEditingController();
    _focusNode = FocusNode();
    _selectedInvoices = [];

    final transactions = widget.viewModel.transactions;
    final state = widget.viewModel.state;
    if (transactions.isNotEmpty) {
      _selectedInvoices = transactions.first.invoiceIds
          .split(',')
          .map((invoiceId) => state.invoiceState.map[invoiceId])
          .whereNotNull()
          .toList();
    }

    updateInvoiceList();
    updatePaymentList();
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

      if (invoice.isPaid || invoice.isDeleted!) {
        return false;
      }

      final filter = _invoiceFilterController!.text;

      if (filter.isNotEmpty) {
        final client = state.clientState.get(invoice.clientId);
        if (!invoice.matchesFilter(filter) &&
            !client.matchesNameOrEmail(filter)) {
          return false;
        }
      }

      if (_showFilter) {
        if (_minAmount.isNotEmpty) {
          if (invoice.balanceOrAmount < parseDouble(_minAmount)!) {
            return false;
          }
        }

        if (_maxAmount.isNotEmpty) {
          if (invoice.balanceOrAmount > parseDouble(_maxAmount)!) {
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
      return invoiceB.date.compareTo(invoiceA.date);
    });
  }

  void updatePaymentList() {
    final state = widget.viewModel.state;
    final paymentState = state.paymentState;

    _payments = paymentState.map.values.where((payment) {
      if (_selectedPayment != null) {
        if (payment.id != _selectedPayment!.id) {
          return false;
        }
      }

      if (payment.transactionId.isNotEmpty || payment.isDeleted!) {
        return false;
      }

      final filter = _paymentFilterController!.text;

      if (filter.isNotEmpty) {
        final client = state.clientState.get(payment.clientId);
        if (!payment.matchesFilter(filter) &&
            !client.matchesNameOrEmail(filter)) {
          return false;
        }
      }

      if (_showFilter) {
        if (_minAmount.isNotEmpty) {
          if (payment.amount < parseDouble(_minAmount)!) {
            return false;
          }
        }

        if (_maxAmount.isNotEmpty) {
          if (payment.amount > parseDouble(_maxAmount)!) {
            return false;
          }
        }

        if (_startDate.isNotEmpty) {
          if (payment.date.compareTo(_startDate) == -1) {
            return false;
          }
        }

        if (_endDate.isNotEmpty) {
          if (payment.date.compareTo(_endDate) == 1) {
            return false;
          }
        }
      }

      return true;
    }).toList();
    _payments.sort((paymentA, paymentB) {
      return paymentB.date.compareTo(paymentA.date);
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
    _invoiceScrollController.dispose();
    _paymentScrollController.dispose();
    _invoiceFilterController!.dispose();
    _paymentFilterController!.dispose();
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    final totalSelected = <String, double>{};
    _selectedInvoices.forEach((invoice) {
      final client = state.clientState.get(invoice.clientId);
      final currencyId = client.currencyId ?? kCurrencyUSDollar;
      if (!totalSelected.containsKey(currencyId)) {
        totalSelected[currencyId] = 0;
      }
      totalSelected[currencyId] =
          totalSelected[currencyId]! + invoice.balanceOrAmount;
    });
    final totalSelectedString = totalSelected.keys.map((currencyId) {
      return formatNumber(totalSelected[currencyId], context,
          currencyId: currencyId);
    }).join(' | ');

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (viewModel.transactions.length == 1) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: AppToggleButtons(
                padding: 0,
                onTabChanged: (value) =>
                    setState(() => _matchExisting = value == 1),
                selectedIndex: _matchExisting ? 1 : 0,
                tabLabels: [
                  localization.createPayment,
                  localization.linkPayment,
                ],
              ),
            ),
          ),
          ListDivider(),
        ],
        if (_matchExisting)
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 22, top: 12, right: 10, bottom: 12),
                  child: SearchText(
                    filterController: _paymentFilterController,
                    focusNode: _focusNode,
                    onChanged: (value) {
                      setState(() {
                        updatePaymentList();
                      });
                    },
                    onCleared: () {
                      setState(() {
                        _paymentFilterController!.text = '';
                        updatePaymentList();
                      });
                    },
                    placeholder:
                        localization.searchPayments.replaceFirst(':count ', ''),
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
          )
        else
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 22, top: 12, right: 10, bottom: 12),
                  child: SearchText(
                    filterController: _invoiceFilterController,
                    focusNode: _focusNode,
                    onChanged: (value) {
                      setState(() {
                        updateInvoiceList();
                      });
                    },
                    onCleared: () {
                      setState(() {
                        _invoiceFilterController!.text = '';
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
        if (_matchExisting) ...[
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              controller: _paymentScrollController,
              child: ListView.separated(
                controller: _paymentScrollController,
                separatorBuilder: (context, index) => ListDivider(),
                itemCount: _payments.length,
                itemBuilder: (BuildContext context, int index) {
                  final payment = _payments[index];
                  return PaymentListItem(
                    payment: payment,
                    showCheckbox: true,
                    showSelected: false,
                    isChecked: (_selectedPayment?.id ?? '') == payment.id,
                    onTap: () => setState(() {
                      if ((_selectedPayment?.id ?? '') == payment.id) {
                        _selectedPayment = null;
                      } else {
                        _selectedPayment = payment;
                      }
                      updatePaymentList();
                    }),
                  );
                },
              ),
            ),
          ),
        ] else ...[
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              controller: _invoiceScrollController,
              child: ListView.separated(
                controller: _invoiceScrollController,
                separatorBuilder: (context, index) => ListDivider(),
                itemCount: _invoices.length,
                itemBuilder: (BuildContext context, int index) {
                  final invoice = _invoices[index];
                  return InvoiceListItem(
                    invoice: invoice,
                    showCheckbox: true,
                    showSelected: false,
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
          ),
          if (_selectedInvoices.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                '${_selectedInvoices.length} ${localization.selected} • $totalSelectedString',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
        ListDivider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 18,
            right: 20,
          ),
          child: _matchExisting
              ? AppButton(
                  label: localization.linkPayment,
                  onPressed:
                      _selectedPayment == null || viewModel.state.isSaving
                          ? null
                          : () {
                              final viewModel = widget.viewModel;
                              viewModel.onLinkToPayment(
                                context,
                                _selectedPayment!.id,
                              );
                            },
                  iconData: Icons.link,
                )
              : AppButton(
                  label: localization.createPayment,
                  onPressed:
                      _selectedInvoices.isEmpty || viewModel.state.isSaving
                          ? null
                          : () {
                              final viewModel = widget.viewModel;
                              viewModel.onConvertToPayment(
                                context,
                                _selectedInvoices
                                    .map((invoice) => invoice.id)
                                    .toList(),
                              );
                            },
                  iconData: Icons.add,
                ),
        )
      ],
    );
  }
}

class _MatchWithdrawals extends StatefulWidget {
  const _MatchWithdrawals({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TransactionViewVM viewModel;

  @override
  State<_MatchWithdrawals> createState() => _MatchWithdrawalsState();
}

class _MatchWithdrawalsState extends State<_MatchWithdrawals> {
  final _vendorScrollController = ScrollController();
  final _categoryScrollController = ScrollController();
  final _expenseScrollController = ScrollController();

  bool _matchExisting = false;
  bool _showFilter = false;
  String _minAmount = '';
  String _maxAmount = '';
  String _startDate = '';
  String _endDate = '';

  TextEditingController? _vendorFilterController;
  TextEditingController? _categoryFilterController;
  TextEditingController? _expenseFilterController;
  FocusNode? _vendorFocusNode;
  FocusNode? _categoryFocusNode;
  FocusNode? _expenseFocusNode;
  late List<VendorEntity?> _vendors;
  late List<ExpenseCategoryEntity?> _categories;
  late List<ExpenseEntity?> _expenses;
  VendorEntity? _selectedVendor;
  ExpenseCategoryEntity? _selectedCategory;
  late List<ExpenseEntity> _selectedExpenses;

  @override
  void initState() {
    super.initState();

    _vendorFilterController = TextEditingController();
    _categoryFilterController = TextEditingController();
    _expenseFilterController = TextEditingController();
    _selectedExpenses = [];

    _vendorFocusNode = FocusNode();
    _categoryFocusNode = FocusNode();
    _expenseFocusNode = FocusNode();

    final transactions = widget.viewModel.transactions;
    final state = widget.viewModel.state;
    if (transactions.isNotEmpty) {
      final transaction = transactions.first;
      if ((transaction.pendingCategoryId ?? '').isNotEmpty) {
        _selectedCategory =
            state.expenseCategoryState.get(transaction.pendingCategoryId!);
      } else if (transaction.categoryId.isNotEmpty) {
        _selectedCategory =
            state.expenseCategoryState.get(transaction.categoryId);
      }

      if ((transaction.pendingVendorId ?? '').isNotEmpty) {
        _selectedVendor = state.vendorState.get(transaction.pendingVendorId!);
      } else if (transaction.vendorId.isNotEmpty) {
        _selectedVendor = state.vendorState.get(transaction.vendorId);
      }
    }

    updateVendorList();
    updateCategoryList();
    updateExpenseList();
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

      if (category.isDeleted!) {
        return false;
      }

      final filter = _categoryFilterController!.text;

      if (filter.isNotEmpty) {
        if (!category.matchesFilter(filter)) {
          return false;
        }
      }

      return true;
    }).toList();
    _categories.sort((categoryA, categoryB) {
      return categoryA!.name
          .toLowerCase()
          .compareTo(categoryB!.name.toLowerCase());
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

      if (vendor.isDeleted!) {
        return false;
      }

      final filter = _vendorFilterController!.text;

      if (filter.isNotEmpty) {
        if (!vendor.matchesFilter(filter)) {
          return false;
        }
      }

      return true;
    }).toList();
    _vendors.sort((vendorA, vendorB) {
      return vendorA!.name.toLowerCase().compareTo(vendorB!.name.toLowerCase());
    });
  }

  void updateExpenseList() {
    final state = widget.viewModel.state;
    final expenseState = state.expenseState;

    _expenses = expenseState.map.values.where((expense) {
      if (expense.transactionId.isNotEmpty || expense.isDeleted!) {
        return false;
      }

      final filter = _expenseFilterController!.text;

      if (filter.isNotEmpty) {
        final client = state.clientState.get(expense.clientId!);
        final vendor = state.vendorState.get(expense.vendorId!);
        if (!expense.matchesFilter(filter) &&
            !client.matchesNameOrEmail(filter) &&
            !vendor.matchesNameOrEmail(filter)) {
          return false;
        }
      }

      if (_showFilter) {
        if (_minAmount.isNotEmpty) {
          if (expense.amount < parseDouble(_minAmount)!) {
            return false;
          }
        }

        if (_maxAmount.isNotEmpty) {
          if (expense.amount > parseDouble(_maxAmount)!) {
            return false;
          }
        }

        if (_startDate.isNotEmpty) {
          if (expense.date!.compareTo(_startDate) == -1) {
            return false;
          }
        }

        if (_endDate.isNotEmpty) {
          if (expense.date!.compareTo(_endDate) == 1) {
            return false;
          }
        }
      }

      return true;
    }).toList();
    _expenses.sort((expenseA, expenseB) {
      return expenseB!.date!.compareTo(expenseA!.date!);
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
    _vendorFilterController!.dispose();
    _categoryFilterController!.dispose();
    _expenseFilterController!.dispose();

    _vendorFocusNode!.dispose();
    _categoryFocusNode!.dispose();
    _expenseFocusNode!.dispose();

    _vendorScrollController.dispose();
    _categoryScrollController.dispose();
    _expenseScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final transactions = viewModel.transactions;
    final transaction =
        transactions.isNotEmpty ? transactions.first : TransactionEntity();

    final totalSelected = <String, double>{};
    _selectedExpenses.forEach((expense) {
      if (!totalSelected.containsKey(expense.currencyId)) {
        totalSelected[expense.currencyId] = 0;
      }
      totalSelected[expense.currencyId] =
          totalSelected[expense.currencyId]! + expense.grossAmount;
    });
    final totalSelectedString = totalSelected.keys.map((currencyId) {
      return formatNumber(totalSelected[currencyId], context,
          currencyId: currencyId);
    }).join(' | ');

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (viewModel.transactions.length == 1) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: AppToggleButtons(
                padding: 0,
                onTabChanged: (value) =>
                    setState(() => _matchExisting = value == 1),
                selectedIndex: _matchExisting ? 1 : 0,
                tabLabels: [
                  localization!.createExpense,
                  localization.linkExpense,
                ],
              ),
            ),
          ),
        ],
        ListDivider(),
        if (_matchExisting) ...[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 22, top: 12, right: 10, bottom: 12),
                  child: SearchText(
                    filterController: _expenseFilterController,
                    focusNode: _expenseFocusNode,
                    onChanged: (value) {
                      setState(() {
                        updateExpenseList();
                      });
                    },
                    onCleared: () {
                      setState(() {
                        _expenseFilterController!.text = '';
                        updateExpenseList();
                      });
                    },
                    placeholder: localization!.searchExpenses
                        .replaceFirst(':count ', ''),
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
                                  updateExpenseList();
                                });
                              },
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
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
                                  updateExpenseList();
                                });
                              },
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
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
                                  updateExpenseList();
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
                                  updateExpenseList();
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
            child: Scrollbar(
              thumbVisibility: true,
              controller: _expenseScrollController,
              child: ListView.separated(
                controller: _expenseScrollController,
                separatorBuilder: (context, index) => ListDivider(),
                itemCount: _expenses.length,
                itemBuilder: (BuildContext context, int index) {
                  final expense = _expenses[index]!;
                  return ExpenseListItem(
                    expense: expense,
                    showCheckbox: true,
                    showSelected: false,
                    isChecked: _selectedExpenses.contains(expense),
                    onTap: () => setState(() {
                      if (_selectedExpenses.contains(expense)) {
                        _selectedExpenses.remove(expense);
                      } else {
                        _selectedExpenses.add(expense);
                      }
                      updateExpenseList();
                      store.dispatch(SaveTransactionSuccess(transaction.rebuild(
                          (b) => b
                            ..pendingExpenseId = _selectedExpenses
                                .map((expense) => expense.id)
                                .join(','))));
                    }),
                  );
                },
              ),
            ),
          ),
        ] else
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 22, top: 12, right: 10, bottom: 12),
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
                                _vendorFilterController!.text = '';
                                updateVendorList();
                              });
                            },
                            placeholder: localization!.searchVendors
                                .replaceFirst(':count ', '')),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final completer = snackBarCompleter<VendorEntity>(
                            localization.createdVendor);
                        createEntity(
                            entity: VendorEntity(state: viewModel.state),
                            force: true,
                            completer: completer,
                            cancelCompleter: Completer<Null>()
                              ..future.then<Null>((_) {
                                store.dispatch(UpdateCurrentRoute(
                                    TransactionScreen.route));
                              }));
                        completer.future.then((SelectableEntity vendor) {
                          store.dispatch(SaveTransactionSuccess(transaction
                              .rebuild((b) => b..pendingVendorId = vendor.id)));
                          store.dispatch(
                              UpdateCurrentRoute(TransactionScreen.route));
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                ListDivider(),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _vendorScrollController,
                    child: ListView.separated(
                      controller: _vendorScrollController,
                      separatorBuilder: (context, index) => ListDivider(),
                      itemCount: _vendors.length,
                      itemBuilder: (BuildContext context, int index) {
                        final vendor = _vendors[index]!;
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
                            store.dispatch(SaveTransactionSuccess(
                                transaction.rebuild((b) =>
                                    b..pendingVendorId = _selectedVendor?.id)));
                          }),
                        );
                      },
                    ),
                  ),
                ),
                ListDivider(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 22, top: 12, right: 10, bottom: 12),
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
                                _categoryFilterController!.text = '';
                                updateCategoryList();
                              });
                            },
                            placeholder: localization.searchCategories
                                .replaceFirst(':count ', '')),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final completer =
                            snackBarCompleter<ExpenseCategoryEntity>(
                                localization.createdExpenseCategory);
                        createEntity(
                            entity:
                                ExpenseCategoryEntity(state: viewModel.state),
                            force: true,
                            completer: completer,
                            cancelCompleter: Completer<Null>()
                              ..future.then<Null>((_) {
                                store.dispatch(UpdateCurrentRoute(
                                    TransactionScreen.route));
                              }));
                        completer.future.then((SelectableEntity category) {
                          store.dispatch(SaveTransactionSuccess(
                              transaction.rebuild(
                                  (b) => b..pendingCategoryId = category.id)));
                          store.dispatch(
                              UpdateCurrentRoute(TransactionScreen.route));
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                ListDivider(),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _categoryScrollController,
                    child: ListView.separated(
                      controller: _categoryScrollController,
                      separatorBuilder: (context, index) => ListDivider(),
                      itemCount: _categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        final category = _categories[index]!;
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
                            store.dispatch(SaveTransactionSuccess(
                                transaction.rebuild((b) => b
                                  ..pendingCategoryId =
                                      _selectedCategory?.id)));
                          }),
                        );
                      },
                    ),
                  ),
                ),
                if (transaction.category.isNotEmpty &&
                    _selectedCategory == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      '${localization.defaultCategory}: ${transaction.category}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
        if (_selectedExpenses.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '${_selectedExpenses.length} ${localization.selected} • $totalSelectedString',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ListDivider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 16,
            right: 20,
          ),
          child: _matchExisting
              ? AppButton(
                  label: _selectedExpenses.length > 1
                      ? localization.linkExpenses
                      : localization.linkExpense,
                  onPressed:
                      _selectedExpenses.isEmpty || viewModel.state.isSaving
                          ? null
                          : () {
                              final viewModel = widget.viewModel;
                              viewModel.onLinkToExpense(
                                context,
                                _selectedExpenses
                                    .map((expense) => expense.id)
                                    .join(','),
                              );
                            },
                  iconData: Icons.link,
                )
              : AppButton(
                  label: localization.createExpense,
                  onPressed: viewModel.state.isSaving ||
                          (_selectedVendor == null && _selectedCategory == null)
                      ? null
                      : () {
                          final viewModel = widget.viewModel;
                          viewModel.onConvertToExpense(
                            context,
                            _selectedVendor?.id ?? '',
                            _selectedCategory?.id ?? '',
                          );
                        },
                  iconData: Icons.add,
                ),
        )
      ],
    );
  }
}
