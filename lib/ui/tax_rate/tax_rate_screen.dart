import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_list_vm.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class TaxRateSettingsScreen extends StatelessWidget {
  const TaxRateSettingsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsTaxRates';

  final TaxRateScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.taxRateUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      entityType: EntityType.taxRate,
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.taxRateList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartTaxRateMultiselect()),
      onCheckboxChanged: (value) {
        final taxRates = viewModel.taxRateList
            .map<TaxRateEntity>((taxRateId) => viewModel.taxRateMap[taxRateId])
            .where((taxRate) => value != listUIState.isSelected(taxRate.id))
            .toList();

        handleTaxRateAction(context, taxRates, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        entityType: EntityType.taxRate,
        entityIds: viewModel.taxRateList,
        filter: state.taxRateListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTaxRates(value));
        },
      ),
      appBarActions: [
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final taxRates = listUIState.selectedIds
                        .map<TaxRateEntity>(
                            (taxRateId) => viewModel.taxRateMap[taxRateId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: taxRates,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearTaxRateMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearTaxRateMultiselect()),
          ),
      ],
      body: TaxRateListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.taxRate,
        onSelectedSortField: (value) => store.dispatch(SortTaxRates(value)),
        sortFields: [
          TaxRateFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTaxRatesByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.taxRateListState.isInMultiselect()) {
            store.dispatch(ClearTaxRateMultiselect());
          } else {
            store.dispatch(StartTaxRateMultiselect());
          }
        },
      ),
      floatingActionButton: state.prefState.isMobile &&
              state.userCompany.canCreate(EntityType.taxRate)
          ? FloatingActionButton(
              heroTag: 'tax_rate_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.taxRate);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newTaxRate,
            )
          : null,
    );
  }
}
