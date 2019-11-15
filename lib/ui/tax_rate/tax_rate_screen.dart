import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
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
      isSettings: true,
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.taxRateList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () =>
          store.dispatch(StartTaxRateMultiselect(context: context)),
      onCheckboxChanged: (value) {
        final taxRates = viewModel.taxRateList
            .map<TaxRateEntity>((taxRateId) => viewModel.taxRateMap[taxRateId])
            .where((taxRate) => value != listUIState.isSelected(taxRate.id))
            .toList();

        handleTaxRateAction(context, taxRates, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.taxRates,
        key: ValueKey(state.taxRateListState.filterClearedAt),
        filter: state.taxRateListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTaxRates(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.taxRateListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterTaxRates(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearTaxRateMultiselect(context: context));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.taxRateListState.selectedIds.isEmpty
                ? null
                : () async {
                    final taxRates = viewModel.taxRateList
                        .map<TaxRateEntity>(
                            (taxRateId) => viewModel.taxRateMap[taxRateId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: taxRates,
                        context: context,
                        multiselect: true);
                    store.dispatch(ClearTaxRateMultiselect(context: context));
                  },
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
      ),
      floatingActionButton: state.userCompany.canCreate(EntityType.taxRate)
          ? FloatingActionButton(
              heroTag: 'tax_rate_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(
                    EditTaxRate(taxRate: TaxRateEntity(), context: context));
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
