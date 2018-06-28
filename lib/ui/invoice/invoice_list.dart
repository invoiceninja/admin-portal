import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/invoice/invoice_item.dart';
import 'package:invoiceninja/ui/invoice/invoice_list_vm.dart';

class InvoiceList extends StatelessWidget {
  final InvoiceListVM viewModel;

  InvoiceList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (! viewModel.isLoaded) {
      return LoadingIndicator();
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.invoiceList.length,
          itemBuilder: (BuildContext context, index) {
            var invoiceId = viewModel.invoiceList[index];
            var invoice = viewModel.invoiceMap[invoiceId];
            return Column(children: <Widget>[
              InvoiceItem(
                invoice: invoice,
                client: viewModel.clientMap[invoice.clientId],
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, invoice, direction),
                onTap: () => viewModel.onInvoiceTap(context, invoice),
                state: viewModel.state,
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
