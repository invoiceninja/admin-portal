import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_vm.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/vendor';

  final VendorScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.vendorUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.vendorList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartVendorMultiselect()),
      onCheckboxChanged: (value) {
        final vendors = viewModel.vendorList
            .map<VendorEntity>((vendorId) => viewModel.vendorMap[vendorId])
            .where((vendor) => value != listUIState.isSelected(vendor.id))
            .toList();

        handleVendorAction(context, vendors, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.vendors,
        key: ValueKey(store.state.vendorListState.filterClearedAt),
        filter: state.vendorListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterVendors(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.vendorListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterVendors(value));
            },
          ),
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final vendors = listUIState.selectedIds
                        .map<VendorEntity>(
                            (vendorId) => viewModel.vendorMap[vendorId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: vendors,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearVendorMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearVendorMultiselect()),
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
        customValues3: company.getCustomFieldValues(CustomFieldType.vendor3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.vendor4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterVendorsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterVendorsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterVendorsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterVendorsByCustom4(value)),
        sortFields: [
          VendorFields.name,
          VendorFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterVendorsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.vendorListState.isInMultiselect()) {
            store.dispatch(ClearVendorMultiselect());
          } else {
            store.dispatch(StartVendorMultiselect());
          }
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.vendor)
          ? FloatingActionButton(
              heroTag: 'vendor_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.vendor);
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
