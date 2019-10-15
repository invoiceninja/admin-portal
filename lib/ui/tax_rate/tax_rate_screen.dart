import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_list_vm.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class TaxRateScreen extends StatelessWidget {
  static const String route = '/tax_rate';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.selectedCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(state.taxRateListState.filterClearedAt),
        entityType: EntityType.taxRate,
        onFilterChanged: (value) {
          store.dispatch(FilterTaxRates(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.taxRate,
          onFilterPressed: (String value) {
            store.dispatch(FilterTaxRates(value));
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
