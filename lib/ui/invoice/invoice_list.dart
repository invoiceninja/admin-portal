import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceList extends StatelessWidget {
  const InvoiceList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterEntityId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;
    final isInMultiselect = listState.isInMultiselect();

    final documentMap = memoizedEntityDocumentMap(
        EntityType.invoice, state.documentState.map, state.expenseState.map);

    return Column(
      children: <Widget>[
        filteredClient != null
            ? Material(
                color: Colors.orangeAccent,
                elevation: 6.0,
                child: InkWell(
                  onTap: () => viewModel.onViewEntityFilterPressed(context),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Text(
                          '${localization.filteredByClient}: ${filteredClient.listDisplayName}',
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
                        onPressed: () => viewModel.onClearEntityFilterPressed(),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: !viewModel.isLoaded
              ? (viewModel.isLoading ? LoadingIndicator() : SizedBox())
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.invoiceList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.invoiceList.length,
                          itemBuilder: (BuildContext context, index) {
                            final invoiceId = viewModel.invoiceList[index];
                            final invoice = viewModel.invoiceMap[invoiceId];
                            final client =
                                viewModel.clientMap[invoice.clientId] ??
                                    ClientEntity();

                            void showDialog() => showEntityActionsDialog(
                                entities: [invoice],
                                context: context,
                                userCompany: state.userCompany,
                                client: client,
                                onEntityAction: viewModel.onEntityAction);

                            return InvoiceListItem(
                              user: viewModel.user,
                              filter: viewModel.filter,
                              hasDocuments: documentMap[invoice.id] == true,
                              invoice: invoice,
                              client: viewModel.clientMap[invoice.clientId] ??
                                  ClientEntity(),
                              onTap: () =>
                                  viewModel.onInvoiceTap(context, invoice),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, [invoice], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection =
                                    state.uiState.longPressSelectionIsDefault ??
                                        true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  viewModel.onEntityAction(context, [invoice],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listState.isSelected(invoice),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
