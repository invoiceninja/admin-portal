import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_item_selector.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';

class InvoiceEdit extends StatefulWidget {
  const InvoiceEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditVM viewModel;

  @override
  _InvoiceEditState createState() => _InvoiceEditState();
}

class _InvoiceEditState extends State<InvoiceEdit>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const kDetailsScreen = 0;
  static const kItemScreen = 1;
  static const kNotesScreen = 2;

  @override
  void initState() {
    super.initState();

    final invoice = widget.viewModel.invoice;
    final invoiceItem = widget.viewModel.invoiceItem;

    final index = invoice.invoiceItems.contains(invoiceItem)
        ? kItemScreen
        : kDetailsScreen;
    _controller = TabController(vsync: this, length: 3, initialIndex: index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(invoice.isNew
              ? invoice.isQuote
                  ? localization.newQuote
                  : localization.newInvoice
              : invoice.isQuote
                  ? localization.editQuote
                  : localization.editInvoice),
          actions: <Widget>[
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: !invoice.isDeleted,
              isSaving: widget.viewModel.isSaving,
              isDirty: invoice.isNew || invoice != viewModel.origInvoice,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                widget.viewModel.onSavePressed(context);
              },
            )
          ],
          bottom: TabBar(
            controller: _controller,
            //isScrollable: true,
            tabs: [
              Tab(
                text: localization.details,
              ),
              Tab(
                text: localization.items,
              ),
              Tab(
                text: localization.notes,
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: _controller,
            children: invoice.isQuote
                ? <Widget>[
                    QuoteEditDetailsScreen(),
                    QuoteEditItemsScreen(),
                    QuoteEditNotesScreen(),
                  ]
                : <Widget>[
                    InvoiceEditDetailsScreen(),
                    InvoiceEditItemsScreen(),
                    InvoiceEditNotesScreen(),
                  ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              '${localization.total}: ${formatNumber(invoice.calculateTotal(viewModel.company.enableInclusiveTaxes), context, clientId: viewModel.invoice.clientId)}',
              style: TextStyle(
                //color: Theme.of(context).selectedRowColor,
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () {
            showDialog<InvoiceItemSelector>(
                context: context,
                builder: (BuildContext context) {
                  return InvoiceItemSelector(
                    excluded: invoice.invoiceItems
                        .where((item) => item.isTask || item.isExpense)
                        //.map((item) => item.isTask ? viewModel.state.taskState.map[item.taskId] : viewModel.expenseState)
                        .map((item) =>
                            viewModel.state.taskState.map[item.taskId])
                        .toList(),
                    clientId: invoice.clientId,
                    onItemsSelected: (items, [clientId]) {
                      viewModel.onItemsAdded(items, clientId);
                      _controller.animateTo(kItemScreen);
                    },
                  );
                });
          },
          child: const Icon(Icons.add, color: Colors.white),
          tooltip: localization.addItem,
        ),
      ),
    );
  }
}
