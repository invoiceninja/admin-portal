import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/search_text.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
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
          Expanded(
              child: _MatchDeposits(
            viewModel: viewModel,
          )),
        ],
      ),
    );
  }
}

class _MatchDeposits extends StatefulWidget {
  const _MatchDeposits({
    Key key,
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
  String _minLimit = '';
  String _maxLimit = '';
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
        if (_minLimit.isNotEmpty) {
          if (invoice.balanceOrAmount < parseDouble(_minLimit)) {
            return false;
          }
        }

        if (_maxLimit.isNotEmpty) {
          if (invoice.balanceOrAmount > parseDouble(_maxLimit)) {
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
                  placeholder: localization.search,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => _showFilter = !_showFilter);
              },
              color: _showFilter ? state.accentColor : null,
              icon: Icon(Icons.filter_alt),
              tooltip:
                  state.prefState.enableTooltips ? localization.filter : '',
            ),
            SizedBox(width: 8),
          ],
        ),
        ListDivider(),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _showFilter ? 138 : 0,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: DecoratedFormField(
                            label: localization.minLimit,
                            onChanged: (value) {
                              setState(() {
                                _minLimit = value;
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
                            label: localization.maxLimit,
                            onChanged: (value) {
                              setState(() {
                                _maxLimit = value;
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              '${_selectedInvoices.length} ${localization.selected} • ${formatNumber(totalSelected, context, currencyId: currencyId)}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ListDivider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 18,
            right: 20,
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
