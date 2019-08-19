import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_vm.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class VendorScreen extends StatelessWidget {
  static const String route = '/vendor';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(store.state.vendorListState.filterClearedAt),
        entityType: EntityType.vendor,
        onFilterChanged: (value) {
          store.dispatch(FilterVendors(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.vendor,
          onFilterPressed: (String value) {
            store.dispatch(FilterVendors(value));
          },
        ),
      ],
      body: VendorListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.vendor,
        onSelectedSortField: (value) => store.dispatch(SortVendors(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.vendor1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.vendor2,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterVendorsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterVendorsByCustom2(value)),
        sortFields: [
          VendorFields.name,
          VendorFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterVendorsByState(state));
        },
      ),
      floatingActionButton: user.canCreate(EntityType.vendor)
          ? FloatingActionButton(
              //key: Key(VendorKeys.vendorScreenFABKeyString),
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(
                    EditVendor(vendor: VendorEntity(), context: context));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newVendor,
            )
          : null,
    );
  }
}
