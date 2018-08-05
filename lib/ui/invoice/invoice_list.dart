import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceList extends StatelessWidget {
  final InvoiceListVM viewModel;

  const InvoiceList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterClientId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;

    return Column(
      children: <Widget>[
        filteredClient != null
            ? Material(
                color: Colors.orangeAccent,
                elevation: 6.0,
                child: InkWell(
                  onTap: () => viewModel.onViewClientFilterPressed(context),
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
                ),
              )
            : Container(),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.invoiceList.isEmpty
                      ? Opacity(
                          opacity: 0.5,
                          child: Center(
                            child: Text(
                              AppLocalization.of(context).noRecordsFound,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.invoiceList.length,
                          itemBuilder: (BuildContext context, index) {
                            final invoiceId = viewModel.invoiceList[index];
                            final invoice = viewModel.invoiceMap[invoiceId];
                            return Column(
                              children: <Widget>[
                                InvoiceListItem(
                                  filter: viewModel.filter,
                                  invoice: invoice,
                                  client: viewModel.clientMap[invoice.clientId],
                                  onDismissed: (DismissDirection direction) =>
                                      viewModel.onDismissed(
                                          context, invoice, direction),
                                  onTap: () =>
                                      viewModel.onInvoiceTap(context, invoice),
                                ),
                                Divider(
                                  height: 1.0,
                                ),
                              ],
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
