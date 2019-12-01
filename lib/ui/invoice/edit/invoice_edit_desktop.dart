import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';

class InvoiceEditDesktop extends StatefulWidget {
  const InvoiceEditDesktop({
    Key key,
    @required this.viewModel,
    this.isQuote = false,
  }) : super(key: key);

  final EntityEditDetailsVM viewModel;
  final bool isQuote;

  @override
  InvoiceEditDesktopState createState() => InvoiceEditDesktopState();
}

class InvoiceEditDesktopState extends State<InvoiceEditDesktop> {
  @override
  Widget build(BuildContext context) {
    return Text('test');
  }
}
