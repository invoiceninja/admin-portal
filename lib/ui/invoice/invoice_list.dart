import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/invoice/invoice_item.dart';
import 'package:invoiceninja/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class InvoiceList extends StatelessWidget {
  final InvoiceListVM viewModel;

  const InvoiceList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoaded) {
      return LoadingIndicator();
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    final localization = AppLocalization.of(context);
    final listState = viewModel.state.invoiceListState;
    final filteredClientId = listState.filterClientId;
    final filteredClient = filteredClientId != null
        ? viewModel.state.clientState.map[filteredClientId]
        : null;

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: Column(
        children: <Widget>[
          filteredClient != null
              ? Material(
                  color: Colors.orangeAccent,
                  elevation: 6.0,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Text(
                          localization.clientsInvoices.replaceFirst(
                              ':client', filteredClient.displayName),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => viewModel.onClearClientFilterPressed(),
                      )
                    ],
                  ),
                )
              : Container(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.invoiceList.length,
              itemBuilder: (BuildContext context, index) {
                final invoiceId = viewModel.invoiceList[index];
                final invoice = viewModel.invoiceMap[invoiceId];
                return Column(children: <Widget>[
                  InvoiceItem(
                    filter: viewModel.filter,
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
        ],
      ),
    );
  }
}
