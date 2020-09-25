import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

class InvoiceViewSchedule extends StatelessWidget {
  const InvoiceViewSchedule({Key key, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final invoice = viewModel.invoice;

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
    );
  }
}