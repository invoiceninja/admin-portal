import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class InvoiceView extends StatefulWidget {
  final InvoiceViewVM viewModel;

  InvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

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
    var store = StoreProvider.of<AppState>(context);
    var invoice = widget.viewModel.invoice;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewModel.invoice.invoiceNumber ?? ''), // Text(localizations.invoiceDetails),
        actions: widget.viewModel.invoice.isNew()
            ? []
            : [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              widget.viewModel.onEditPressed(context);
            },
          ),
          ActionMenuButton(
            entity: widget.viewModel.invoice,
            onSelected: widget.viewModel.onActionSelected,
          )
        ],
      ),
      body: Text('test'),
    );
  }
}
