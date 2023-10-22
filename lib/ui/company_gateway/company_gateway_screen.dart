// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'company_gateway_screen_vm.dart';

class CompanyGatewayScreen extends StatelessWidget {
  const CompanyGatewayScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsCompanyGateways';

  final CompanyGatewayScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final settingsUIState = state.uiState.settingsUIState;

    return ListScaffold(
      entityType: EntityType.companyGateway,
      onHamburgerLongPress: () =>
          store.dispatch(StartCompanyGatewayMultiselect()),
      onCancelSettingsSection: kSettingsPaymentSettings,
      appBarTitle: Text(localization.companyGateways),
      onCheckboxPressed: () {
        if (store.state.companyGatewayListState.isInMultiselect()) {
          store.dispatch(ClearCompanyGatewayMultiselect());
        } else {
          store.dispatch(StartCompanyGatewayMultiselect());
        }
      },
      appBarActions: [
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            isHeader: true,
            saveLabel: localization.actions,
            onSavePressed: listUIState.selectedIds!.isEmpty
                ? null
                : (context) async {
                    final companyGateways = listUIState.selectedIds!
                        .map<CompanyGatewayEntity>((companyGatewayId) =>
                            viewModel.companyGatewayMap[companyGatewayId]!)
                        .whereType<CompanyGatewayEntity>()
                        .toList();

                    await showEntityActionsDialog(
                      entities: companyGateways,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<Null>((_) =>
                            store.dispatch(ClearCompanyGatewayMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearCompanyGatewayMultiselect()),
          )
        else ...[
          if (settingsUIState.isFiltered && !state.isSaving)
            TextButton(
              child: Text(localization.reset,
                  style: TextStyle(color: store.state.headerTextColor)),
              onPressed: () {
                final settings = settingsUIState.settings
                    .rebuild((b) => b..companyGatewayIds = '');
                store.dispatch(UpdateSettings(settings: settings));
              },
            ),
          SaveCancelButtons(
            isEnabled: settingsUIState.isChanged,
            isCancelEnabled: true,
            isHeader: true,
            onSavePressed: viewModel.onSavePressed,
            onCancelPressed: isMobile(context) || !settingsUIState.isChanged
                ? null
                : (_) {
                    if (settingsUIState.isChanged) {
                      store.dispatch(ResetSettings());
                    } else {
                      store.dispatch(
                          ViewSettings(section: kSettingsPaymentSettings));
                    }
                  },
          )
        ],
      ],
      body: CompanyGatewayListBuilder(),
      bottomNavigationBar: AppBottomBar(
        sortFields: [],
        onSelectedSortField: null,
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
      floatingActionButton:
          state.prefState.isMobile && state.userCompany.isAdmin
              ? FloatingActionButton(
                  heroTag: 'company_gateway_fab',
                  backgroundColor: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    if (settingsUIState.isFiltered) {
                    } else {
                      createEntityByType(
                          context: context,
                          entityType: EntityType.companyGateway);
                    }
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
