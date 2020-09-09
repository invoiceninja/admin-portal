import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/view/recurring_invoice_view_vm.dart';

class RecurringInvoiceView extends StatefulWidget {
  const RecurringInvoiceView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final RecurringInvoiceViewVM viewModel;
  final bool isFilter;

  @override
  _RecurringInvoiceViewState createState() => new _RecurringInvoiceViewState();
}

class _RecurringInvoiceViewState extends State<RecurringInvoiceView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final recurringInvoice = viewModel.recurringInvoice;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: recurringInvoice,
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
