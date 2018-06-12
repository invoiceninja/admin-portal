import 'package:invoiceninja/ui/app/app_search.dart';
import 'package:invoiceninja/ui/app/app_search_button.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/client_list_vm.dart';
import 'package:invoiceninja/ui/client/client_details_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/app/app_bottom_bar.dart';

class ClientScreen extends StatelessWidget {

  static final String route = '/clients';

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: AppSearch(
          entityType: EntityType.client,
          onSearchChanged: (value) {
            store.dispatch(SearchClients(value));
          },
        ),
        actions: [
          AppSearchButton(),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: ClientListBuilder(),
      bottomNavigationBar: AppBottomBar(
        selectedSortField: store.state.clientListState().sortField,
        selectedSortAscending: store.state.clientListState().sortAscending,
        onSelectedSortField: (value) {
          store.dispatch(SortClients(value));
        },
        sortFields: [
          ClientFields.name,
        ],
        selectedStates: store.state.clientListState().stateFilters,
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterClientsByState(state));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        //key: ArchSampleKeys.addClientFab,
        onPressed: () {
          store.dispatch(SelectClientAction(ClientEntity()));
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => ClientDetailsBuilder()));
        },
        child: Icon(Icons.add),
        tooltip: localization.newClient,
      ),
    );
  }
}
