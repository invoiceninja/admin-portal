import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';

class InvoicePdfView extends StatelessWidget {
  const InvoicePdfView({Key key, this.viewModel}) : super(key: key);

  final EntityPdfVM viewModel;

  @override
  Widget build(BuildContext context) {
    return PDFScaffold(invoice: viewModel.invoice);
  }
}
