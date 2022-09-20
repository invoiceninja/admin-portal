import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
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
              child: _MatchInvoices(
            viewModel: viewModel,
          )),
        ],
      ),
    );
  }
}

class _MatchInvoices extends StatefulWidget {
  const _MatchInvoices({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TransactionViewVM viewModel;

  @override
  State<_MatchInvoices> createState() => __MatchInvoicesState();
}

class __MatchInvoicesState extends State<_MatchInvoices> {
  TextEditingController _filterController;
  FocusNode _focusNode;
  List<InvoiceEntity> _invoices;
  List<InvoiceEntity> _selectedInvoices;

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

      return true;
    }).toList();
    _invoices.sort((invoiceA, invoiceB) {
      if (_selectedInvoices.contains(invoiceA)) {
        return -1;
      } else if (_selectedInvoices.contains(invoiceB)) {
        return 1;
      }

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
            )
          ],
        ),
        ListDivider(),
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
        ListDivider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 16,
            right: 20,
          ),
          child: AppButton(
            label: localization.convertToPayment,
            onPressed: _selectedInvoices.length == 0
                ? null
                : () {
//
                  },
            iconData: getEntityActionIcon(EntityAction.convertToExpense),
          ),
        )
      ],
    );
  }
}
