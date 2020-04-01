import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
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
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.companyGatewayList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () =>
          store.dispatch(StartCompanyGatewayMultiselect()),
      onCheckboxChanged: (value) {
        final companyGateways = viewModel.companyGatewayList
            .map<CompanyGatewayEntity>((companyGatewayId) =>
                viewModel.companyGatewayMap[companyGatewayId])
            .where((companyGateway) =>
                value != listUIState.isSelected(companyGateway.id))
            .toList();

        handleCompanyGatewayAction(
            context, companyGateways, EntityAction.toggleMultiselect);
      },
      isSettings: true,
      appBarTitle: Text(localization.companyGateways),
      appBarActions: [
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final companyGateways = listUIState.selectedIds
                        .map<CompanyGatewayEntity>((companyGatewayId) =>
                            viewModel.companyGatewayMap[companyGatewayId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: companyGateways,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>((_) =>
                            store.dispatch(ClearCompanyGatewayMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearCompanyGatewayMultiselect()),
          )
        else
          SaveCancelButtons(
            isSaving: state.isSaving,
            onSavePressed: viewModel.onSavePressed,
          ),
      ],
      body: CompanyGatewayListBuilder(),
      bottomNavigationBar: AppBottomBar(
        sortFields: [],
        onSelectedSortField: null,
        onlyList: true,
        entityType: EntityType.companyGateway,
        onSelectedCustom1: (value) =>
            store.dispatch(FilterCompanyGatewaysByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterCompanyGatewaysByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterCompanyGatewaysByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterCompanyGatewaysByCustom4(value)),
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterCompanyGatewaysByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.companyGatewayListState.isInMultiselect()) {
            store.dispatch(ClearCompanyGatewayMultiselect());
          } else {
            store.dispatch(StartCompanyGatewayMultiselect());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'company_gateway_fab',
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          if (state.settingsUIState.isFiltered) {
          } else {
            createEntityByType(
                context: context, entityType: EntityType.companyGateway);
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: localization.newCompanyGateway,
      ),
    );
  }
}
