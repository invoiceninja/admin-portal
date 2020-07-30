import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_presenter.dart';
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
      entityType: EntityType.vendor,
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
        entityType: EntityType.vendor,
        entityIds: viewModel.vendorList,
        filter: state.vendorListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterVendors(value));
        },
      ),
      body: VendorListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.vendor,
        tableColumns: VendorPresenter.getAllTableFields(userCompany),
        defaultTableColumns: VendorPresenter.getDefaultTableFields(userCompany),
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
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.vendor)
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
