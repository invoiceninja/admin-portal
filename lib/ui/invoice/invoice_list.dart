import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
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
    final listState = viewModel.listState;
    final isInMultiselect = listState.isInMultiselect();

    final documentMap = memoizedEntityDocumentMap(
        EntityType.invoice, state.documentState.map, state.expenseState.map);

    return Column(
      children: <Widget>[
        if (listState.filterEntityId != null)
          ListFilterMessage(
            filterEntityId: listState.filterEntityId,
            filterEntityType: listState.filterEntityType,
            onPressed: viewModel.onViewEntityFilterPressed,
            onClearPressed: viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
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
                                  listState.isSelected(invoice.id),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
