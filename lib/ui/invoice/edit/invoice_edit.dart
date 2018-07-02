import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_item_selector.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/buttons/save_icon_button.dart';

class InvoiceEdit extends StatefulWidget {
  final InvoiceEditVM viewModel;

  InvoiceEdit({
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

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var viewModel = widget.viewModel;
    var invoice = viewModel.invoice;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(invoice.isNew()
              ? localization.newInvoice
              : '${localization.invoice} ${viewModel.origInvoice.invoiceNumber}'),
          actions: <Widget>[
            SaveIconButton(
              isVisible: !invoice.isDeleted,
              isLoading: widget.viewModel.isLoading,
              isDirty: invoice.isNew() || invoice != viewModel.origInvoice,
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
          hasNotch: true,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              '${localization.total}: ${formatNumber(invoice.calculateTotal(viewModel.state.selectedCompany.enableInclusiveTaxes), viewModel.state, clientId: viewModel.invoice.clientId)}',
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
                    state: viewModel.state,
                    onItemsSelected: viewModel.onItemsAdded,
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
