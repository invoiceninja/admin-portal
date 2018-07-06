import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_item_selector.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/buttons/save_icon_button.dart';

class InvoiceEdit extends StatefulWidget {
  final InvoiceEditVM viewModel;

  const InvoiceEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _InvoiceEditState createState() => _InvoiceEditState();
}

class _InvoiceEditState extends State<InvoiceEdit>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const kDetailsScreen = 0;
  static const kItemScreen = 1;

  @override
  void initState() {
    super.initState();

    final invoice = widget.viewModel.invoice;
    final invoiceItem = widget.viewModel.invoiceItem;

    final index =
        invoice.invoiceItems.contains(invoiceItem) ? kItemScreen : kDetailsScreen;
    _controller =
        TabController(vsync: this, length: 2, initialIndex: index);
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
              ? localization.newInvoice
              : '${localization.invoice} ${viewModel.origInvoice.invoiceNumber}'),
          actions: <Widget>[
            SaveIconButton(
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
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              InvoiceEditDetailsScreen(),
              InvoiceEditItemsScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              '${localization.total}: ${formatNumber(invoice.calculateTotal(viewModel.company.enableInclusiveTaxes), context, clientId: viewModel.invoice.clientId)}',
              style: TextStyle(
                fontSize: 18.0,
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
                    productMap: viewModel.productMap,
                    onItemsSelected: (items) {
                      viewModel.onItemsAdded(items);
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
