import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class ClientScreen extends StatelessWidget {
  static const String route = '/client';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            entityType: EntityType.client,
            onFilterChanged: (value) {
              store.dispatch(FilterClients(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.client,
              onFilterPressed: (String value) {
                store.dispatch(FilterClients(value));
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.client)
            ? FloatingActionButton(
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
      ),
    );
  }
}
