import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/search_text.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
  String _filter;

  @override
  void initState() {
    super.initState();
    _filterController = TextEditingController();
    _focusNode = FocusNode();
    _selectedInvoices = [];

    updateInvoiceList();
  }

  void updateInvoiceList() {
    final invoiceState = widget.viewModel.state.invoiceState;
    _invoices = invoiceState.map.values.where((invoice) {
      if (_selectedInvoices.isNotEmpty) {
        if (invoice.clientId != _selectedInvoices.first.clientId) {
          return false;
        }
      }

      return true;
    }).toList();
    _invoices
        .sort((invoiceA, invoiceB) => invoiceB.date.compareTo(invoiceA.date));
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
                  onChanged: (value) {},
                  onCleared: () => null,
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
        )),
      ],
    );
  }
}
