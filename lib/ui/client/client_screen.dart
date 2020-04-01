import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'client_screen_vm.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/client';

  final ClientScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.clientUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.clientList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartClientMultiselect()),
      onCheckboxChanged: (value) {
        final clients = viewModel.clientList
            .map<ClientEntity>((clientId) => viewModel.clientMap[clientId])
            .where((client) => value != listUIState.isSelected(client.id))
            .toList();

        handleClientAction(context, clients, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.clients,
        key: ValueKey(state.clientListState.filterClearedAt),
        filter: state.clientListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterClients(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.clientListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterClients(value));
            },
          ),
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final clients = listUIState.selectedIds
                        .map<ClientEntity>(
                            (clientId) => viewModel.clientMap[clientId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: clients,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearClientMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearClientMultiselect()),
          ),
      ],
      body: ClientListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.client,
        onSelectedSortField: (value) {
          store.dispatch(SortClients(value));
        },
        sortFields: [
          ClientFields.name,
          ClientFields.balance,
          ClientFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterClientsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.clientListState.isInMultiselect()) {
            store.dispatch(ClearClientMultiselect());
          } else {
            store.dispatch(StartClientMultiselect());
          }
        },
        customValues1: company.getCustomFieldValues(CustomFieldType.client1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.client2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.client3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.client4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterClientsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterClientsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterClientsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterClientsByCustom4(value)),
      ),
      floatingActionButton: userCompany.canCreate(EntityType.client)
          ? FloatingActionButton(
              heroTag: 'client_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.client);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newClient,
            )
          : null,
    );
  }
}
