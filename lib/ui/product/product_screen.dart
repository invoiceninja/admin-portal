// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:invoiceninja_flutter/ui/product/product_presenter.dart';
import 'package:invoiceninja_flutter/ui/product/product_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/product';

  final ProductScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.product,
      onHamburgerLongPress: () => store.dispatch(StartProductMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.productListState.filterClearedAt}__'),
        entityType: EntityType.product,
        entityIds: viewModel.productList,
        filter: state.productListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterProducts(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProductsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.productListState.isInMultiselect()) {
          store.dispatch(ClearProductMultiselect());
        } else {
          store.dispatch(StartProductMultiselect());
        }
      },
      body: ProductListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.product,
        iconButtons: [
          IconButton(
              icon: Icon(getEntityIcon(EntityType.settings)),
              onPressed: () {
                store.dispatch(ViewSettings(
                  section: kSettingsProducts,
                  company: state.company,
                ));
              })
        ],
        tableColumns: ProductPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            ProductPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) => store.dispatch(SortProducts(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.product1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.product2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.product3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.product4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterProductsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterProductsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterProductsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterProductsByCustom4(value)),
        sortFields: [
          ProductFields.productKey,
          ProductFields.cost,
          ProductFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProductsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.productListState.isInMultiselect()) {
            store.dispatch(ClearProductMultiselect());
          } else {
            store.dispatch(StartProductMultiselect());
          }
        },
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.product)
          ? FloatingActionButton(
              heroTag: 'product_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.product);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newProduct,
            )
          : null,
    );
  }
}
