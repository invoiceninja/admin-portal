// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_list_vm.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaxRateSettingsScreen extends StatelessWidget {
  const TaxRateSettingsScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsTaxRates';

  final TaxRateScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.taxRate,
      onHamburgerLongPress: () => store.dispatch(StartTaxRateMultiselect()),
      onCancelSettingsSection: kSettingsTaxSettings,
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.taxRateListState.filterClearedAt}__'),
        entityType: EntityType.taxRate,
        entityIds: viewModel.taxRateList,
        filter: state.taxRateListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTaxRates(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTaxRatesByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.taxRateListState.isInMultiselect()) {
          store.dispatch(ClearTaxRateMultiselect());
        } else {
          store.dispatch(StartTaxRateMultiselect());
        }
      },
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
              tooltip: localization!.newTaxRate,
            )
          : null,
    );
  }
}
