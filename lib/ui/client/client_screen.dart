import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/multiple_entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/app/list_multiselect_button.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/src/store.dart';

import 'client_screen_vm.dart';

final GlobalKey<ScaffoldState> _clientListScaffoldKey =
    GlobalKey<ScaffoldState>(debugLabel: 'clientListScaffold');

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
    final company = state.selectedCompany;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      scaffoldKey: _clientListScaffoldKey,
      appBarTitle: ListFilter(
        key: ValueKey(state.clientListState.filterClearedAt),
        entityType: EntityType.client,
        onFilterChanged: (value) {
          store.dispatch(FilterClients(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            entityType: EntityType.client,
            onFilterPressed: (String value) {
              store.dispatch(FilterClients(value));
            },
          ),
        if (viewModel.isInMultiselect)
          ListMultiselectButton(
              mode: ListMultiselectButtonMode.DONE,
              onPressed: () => _finishMultiselect(
                  context, ListMultiselectButtonMode.DONE, store)),
        if (viewModel.isInMultiselect)
          ListMultiselectButton(
              mode: ListMultiselectButtonMode.CANCEL,
              onPressed: () => _finishMultiselect(
                  context, ListMultiselectButtonMode.CANCEL, store)),
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
        customValues1: company.getCustomFieldValues(CustomFieldType.client1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.client2,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterClientsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterClientsByCustom2(value)),
      ),
      floatingActionButton: userCompany.canCreate(EntityType.client)
          ? FloatingActionButton(
              heroTag: 'client_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () => store.dispatch(
                  EditClient(client: ClientEntity(), context: context)),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newClient,
            )
          : null,
    );
  }

  void _finishMultiselect(BuildContext context, ListMultiselectButtonMode mode,
      Store<AppState> store) async {
    if (mode == ListMultiselectButtonMode.DONE) {
      await showMultipleEntitiesActionsDialog(
          entities: store.state.clientListState.selectedEntities,
          user: viewModel.user,
          onEntityAction: viewModel.onEntityAction,
          scaffoldKey: _clientListScaffoldKey);
    }
    store.dispatch(ClearMultiselect(context: context));
  }
}
