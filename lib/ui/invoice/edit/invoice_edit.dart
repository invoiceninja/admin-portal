import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/save_icon_button.dart';

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
  static final GlobalKey<InvoiceEditDetailsState> _detailsKey =
      GlobalKey<InvoiceEditDetailsState>();
  static final GlobalKey<InvoiceEditItemsState> _itemsKey =
      GlobalKey<InvoiceEditItemsState>();

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

    List<Widget> editors = [
      InvoiceEditDetails(
        invoice: invoice,
        key: _detailsKey,
        clientList: viewModel.clientList,
        clientMap: viewModel.clientMap,
      ),
      InvoiceEditItems(
        invoice: invoice,
        key: _itemsKey,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackClicked();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(invoice.isNew()
              ? localization.newInvoice
              : invoice.invoiceNumber),
          actions: <Widget>[
            SaveIconButton(
              isLoading: widget.viewModel.isLoading,
              onPressed: () {
                if (! _formKey.currentState.validate()) {
                  return;
                }

                _formKey.currentState.save();

                //var detailsState = _detailsKey.currentState;
                //var itemsState = _itemsKey.currentState;

                /*
                InvoiceEntity invoice = widget.viewModel.invoice.rebuild((b) => b
                  ..items.replace(
                      itemState?.getItems() ?? widget.viewModel.invoice.items));
                */

                widget.viewModel.onSaveClicked(context, invoice);
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
            children: editors,
          ),
        ),
      ),
    );
  }
}
