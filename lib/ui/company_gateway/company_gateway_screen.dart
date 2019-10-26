import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'company_gateway_screen_vm.dart';

class CompanyGatewayScreen extends StatelessWidget {
  const CompanyGatewayScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsOnlinePayments';

  final CompanyGatewayScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return AppScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.companyGatewayList.length,
      showCheckbox: isInMultiselect,
      onCheckboxChanged: (value) {
        final companyGateways = viewModel.companyGatewayList
            .map<CompanyGatewayEntity>((companyGatewayId) =>
                viewModel.companyGatewayMap[companyGatewayId])
            .where((companyGateway) =>
                value != listUIState.isSelected(companyGateway.id))
            .toList();

        viewModel.onEntityAction(
            context, companyGateways, EntityAction.toggleMultiselect);
      },
      hideHamburgerButton: true,
      appBarTitle: ListFilter(
        key: ValueKey(state.companyGatewayListState.filterClearedAt),
        entityType: EntityType.companyGateway,
        onFilterChanged: (value) {
          store.dispatch(FilterCompanyGateways(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            entityType: EntityType.product,
            onFilterPressed: (String value) {
              store.dispatch(FilterCompanyGateways(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearCompanyGatewayMultiselect(context: context));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.productListState.selectedIds.isEmpty
                ? null
                : () async {
                    final companyGateways = viewModel.companyGatewayList
                        .map<CompanyGatewayEntity>((companyGatewayId) =>
                            viewModel.companyGatewayMap[companyGatewayId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: companyGateways,
                        userCompany: userCompany,
                        context: context,
                        onEntityAction: viewModel.onEntityAction,
                        multiselect: true);
                    store.dispatch(
                        ClearCompanyGatewayMultiselect(context: context));
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
          CompanyGatewayFields.priority,
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
