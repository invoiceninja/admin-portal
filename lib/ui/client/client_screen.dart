import 'package:invoiceninja/ui/app/app_search.dart';
import 'package:invoiceninja/ui/app/app_search_button.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/client_list_vm.dart';
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
          AppSearchButton(
            entityType: EntityType.client,
            onSearchPressed: (value) {
              store.dispatch(SearchClients(value));
            },
          ),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: ClientListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.client,
        onSelectedSortField: (value) {
          store.dispatch(SortClients(value));
        },
        sortFields: [
          ClientFields.name,
          ClientFields.balance,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterClientsByState(state));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          var client = ClientEntity()
              .rebuild((b) => b..contacts.replace([ContactEntity()]));
          store.dispatch(SelectClient(client));
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => ClientEditScreen()));
        },
        child: Icon(Icons.add, color: Colors.white,),
        tooltip: localization.newClient,
      ),
    );
  }
}
