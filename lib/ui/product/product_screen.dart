import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

class ProductScreen extends StatelessWidget {
  static const String route = '/product';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            entityType: EntityType.product,
            onFilterChanged: (value) {
              store.dispatch(FilterProducts(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.product,
              onFilterPressed: (String value) {
                store.dispatch(FilterProducts(value));
              },
            ),
          ],
        ),
        drawer: AppDrawerBuilder(),
        body: ProductListBuilder(),
        bottomNavigationBar: AppBottomBar(
          entityType: EntityType.product,
          onSelectedSortField: (value) => store.dispatch(SortProducts(value)),
          customValues1: company.getCustomFieldValues(CustomFieldType.product1,
              excludeBlank: true),
          customValues2: company.getCustomFieldValues(CustomFieldType.product2,
              excludeBlank: true),
          onSelectedCustom1: (value) =>
              store.dispatch(FilterProductsByCustom1(value)),
          onSelectedCustom2: (value) =>
              store.dispatch(FilterProductsByCustom2(value)),
          sortFields: [
            ProductFields.productKey,
            ProductFields.cost,
            ProductFields.updatedAt,
          ],
          onSelectedState: (EntityState state, value) {
            store.dispatch(FilterProductsByState(state));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.product)
            ? FloatingActionButton(
                key: Key(ProductKeys.fab),
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  store.dispatch(
                      EditProduct(product: ProductEntity(), context: context));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: localization.newProduct,
              )
            : null,
      ),
    );
  }
}
