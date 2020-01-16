import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/invoice_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityListVM viewModel;

  @override
  _EntityListState createState() => _EntityListState();
}

class _EntityListState extends State<InvoiceList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.invoice,
        editingId: viewModel.state.invoiceUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.invoiceList,
        entityMap: viewModel.invoiceMap,
        entityPresenter: InvoicePresenter(),
        onTap: (BaseEntity invoice) =>
            viewModel.onInvoiceTap(context, invoice));
  }

  @override
  void didUpdateWidget(InvoiceList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.invoiceUIState.editing.id;
    dataTableSource.entityList = viewModel.invoiceList;
    dataTableSource.entityMap = viewModel.invoiceMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final listState = viewModel.listState;
    final listUIState = state.uiState.invoiceUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final isList = state.prefState.moduleLayout == ModuleLayout.list;
    final invoiceList = viewModel.invoiceList;

    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (invoiceList.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    if (isNotMobile(context) &&
        invoiceList.isNotEmpty &&
        !state.uiState.isEditing &&
        !invoiceList.contains(state.invoiceUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.invoice,
          entityId: invoiceList.first);
    }

    final listOrTable = () {
      if (isList) {
        final documentMap = memoizedEntityDocumentMap(EntityType.invoice,
            state.documentState.map, state.expenseState.map);

        return Column(children: <Widget>[
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
                                    client: client,
                                  );

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
                                    handleInvoiceAction(
                                        context, [invoice], action);
                                  }
                                },
                                onLongPress: () async {
                                  final longPressIsSelection = state.prefState
                                          .longPressSelectionIsDefault ??
                                      true;
                                  if (longPressIsSelection &&
                                      !isInMultiselect) {
                                    handleInvoiceAction(context, [invoice],
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
        ]);
      } else {
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: PaginatedDataTable(
              onSelectAll: (value) {
                final invoices = viewModel.invoiceList
                    .map<InvoiceEntity>(
                        (invoiceId) => viewModel.invoiceMap[invoiceId])
                    .where((invoice) =>
                        value != listUIState.isSelected(invoice.id))
                    .toList();
                handleInvoiceAction(
                    context, invoices, EntityAction.toggleMultiselect);
              },
              columns: [
                if (!listUIState.isInMultiselect())
                  DataColumn(label: SizedBox()),
                ...viewModel.tableColumns.map((field) => DataColumn(
                    label: Text(AppLocalization.of(context).lookup(field)),
                    numeric: EntityPresenter.isFieldNumeric(field),
                    onSort: (int columnIndex, bool ascending) =>
                        store.dispatch(SortInvoices(field)))),
              ],
              source: dataTableSource,
              header: DatatableHeader(
                entityType: EntityType.invoice,
              )),
        ));
      }
    };

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: listOrTable(),
    );
  }
}
