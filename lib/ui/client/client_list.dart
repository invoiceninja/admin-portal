import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/client/client_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_item.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientList extends StatefulWidget {
  const ClientList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientListVM viewModel;

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.client,
        editingId: viewModel.state.clientUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.clientList,
        entityMap: viewModel.clientMap,
        entityPresenter: ClientPresenter(),
        onTap: (BaseEntity client) => viewModel.onClientTap(context, client));
  }

  @override
  void didUpdateWidget(ClientList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.clientUIState.editing.id;
    dataTableSource.entityList = viewModel.clientList;
    dataTableSource.entityMap = viewModel.clientMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final listUIState = state.uiState.clientUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final isList = state.prefState.moduleLayout == ModuleLayout.list;
    final clientList = viewModel.clientList;

    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    }

    if (state.shouldSelectEntity(
        entityType: EntityType.client, hasRecords: clientList.isNotEmpty)) {
      viewEntityById(
        context: context,
        entityType: EntityType.client,
        entityId: clientList.isEmpty ? null : clientList.first,
      );
    }

    final listOrTable = () {
      if (isList) {
        return viewModel.clientList.isEmpty
            ? HelpText(AppLocalization.of(context).noRecordsFound)
            : ListView.separated(
                separatorBuilder: (context, index) => ListDivider(),
                itemCount: viewModel.clientList.length,
                itemBuilder: (BuildContext context, index) {
                  final clientId = viewModel.clientList[index];
                  final client = viewModel.clientMap[clientId];

                  return ClientListItem(
                    user: viewModel.state.user,
                    filter: viewModel.filter,
                    client: client,
                    onEntityAction: (EntityAction action) {
                      if (action == EntityAction.more) {
                        showEntityActionsDialog(
                          entities: [client],
                          context: context,
                        );
                      } else {
                        handleClientAction(context, [client], action);
                      }
                    },
                    onTap: () => viewModel.onClientTap(context, client),
                    onLongPress: () async {
                      final longPressIsSelection =
                          state.prefState.longPressSelectionIsDefault ?? true;
                      if (longPressIsSelection && !isInMultiselect) {
                        handleClientAction(
                            context, [client], EntityAction.toggleMultiselect);
                      } else {
                        showEntityActionsDialog(
                          entities: [client],
                          context: context,
                        );
                      }
                    },
                    isChecked:
                        isInMultiselect && listUIState.isSelected(client.id),
                  );
                });
      } else {
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: PaginatedDataTable(
            onSelectAll: (value) {
              final clients = viewModel.clientList
                  .map<ClientEntity>(
                      (clientId) => viewModel.clientMap[clientId])
                  .where((client) => value != listUIState.isSelected(client.id))
                  .toList();
              handleClientAction(
                  context, clients, EntityAction.toggleMultiselect);
            },
            columns: [
              if (!listUIState.isInMultiselect()) DataColumn(label: SizedBox()),
              ...viewModel.tableColumns.map((field) => DataColumn(
                    label: Text(AppLocalization.of(context).lookup(field)),
                    numeric: EntityPresenter.isFieldNumeric(field),
                    onSort: (int columnIndex, bool ascending) =>
                        store.dispatch(SortClients(field)),
                  )),
            ],
            source: dataTableSource,
            header: DatatableHeader(
              entityType: EntityType.client,
              onClearPressed: viewModel.onClearEntityFilterPressed,
            ),
          ),
        ));
      }
    };

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: listOrTable(),
    );
  }
}
