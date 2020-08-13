import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

class InvoiceViewHistory extends StatefulWidget {
  const InvoiceViewHistory({@required this.viewModel});

  final EntityViewVM viewModel;

  @override
  _InvoiceViewHistoryState createState() => _InvoiceViewHistoryState();
}

class _InvoiceViewHistoryState extends State<InvoiceViewHistory> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel.invoice.isStale) {
      widget.viewModel.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
