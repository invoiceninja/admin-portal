import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_vm.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class CompanyGatewayScreen extends StatelessWidget {
  static const String route = '/company_gateway';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(state.companyGatewayListState.filterClearedAt),
        entityType: EntityType.companyGateway,
        onFilterChanged: (value) {
          store.dispatch(FilterCompanyGateways(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.companyGateway,
          onFilterPressed: (String value) {
            store.dispatch(FilterCompanyGateways(value));
          },
        ),
      ],
      body: CompanyGatewayListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.companyGateway,
        onSelectedSortField: (value) =>
            store.dispatch(SortCompanyGateways(value)),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterCompanyGatewaysByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterCompanyGatewaysByCustom2(value)),
        sortFields: [
          CompanyGatewayFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterCompanyGatewaysByState(state));
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.companyGateway)
          ? FloatingActionButton(
              heroTag: 'company_gateway_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(EditCompanyGateway(
                    companyGateway: CompanyGatewayEntity(), context: context));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newCompanyGateway,
            )
          : null,
    );
  }
}
