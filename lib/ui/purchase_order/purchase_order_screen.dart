import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/purchase_order_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_list_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'purchase_order_screen_vm.dart';

class PurchaseOrderScreen extends StatelessWidget {
  const PurchaseOrderScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/purchase_order';

  final PurchaseOrderScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    final statuses = [
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kPurchaseOrderStatusDraft
          ..name = localization!.draft,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kPurchaseOrderStatusSent
          ..name = localization!.sent,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kPurchaseOrderStatusAccepted
          ..name = localization!.accepted,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kPurchaseOrderStatusCancelled
          ..name = localization!.cancelled,
      ),
    ];

    return ListScaffold(
      entityType: EntityType.purchaseOrder,
      onHamburgerLongPress: () =>
          store.dispatch(StartPurchaseOrderMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.purchaseOrderListState.filterClearedAt}__'),
        entityType: EntityType.purchaseOrder,
        entityIds: viewModel.purchaseOrderList,
        filter: state.purchaseOrderListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterPurchaseOrders(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterPurchaseOrdersByState(state));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterPurchaseOrdersByStatus(status));
        },
        statuses: statuses,
      ),
      onCheckboxPressed: () {
        if (store.state.purchaseOrderListState.isInMultiselect()) {
          store.dispatch(ClearPurchaseOrderMultiselect());
        } else {
          store.dispatch(StartPurchaseOrderMultiselect());
        }
      },
      body: PurchaseOrderListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.purchaseOrder,
        tableColumns: PurchaseOrderPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            PurchaseOrderPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortPurchaseOrders(value));
        },
        sortFields: [
          PurchaseOrderFields.number,
          PurchaseOrderFields.date,
          PurchaseOrderFields.dueDate,
          EntityFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterPurchaseOrdersByState(state));
        },
        statuses: statuses,
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterPurchaseOrdersByStatus(status));
        },
        onCheckboxPressed: () {
          if (store.state.purchaseOrderListState.isInMultiselect()) {
            store.dispatch(ClearPurchaseOrderMultiselect());
          } else {
            store.dispatch(StartPurchaseOrderMultiselect());
          }
        },
        customValues1: company.getCustomFieldValues(CustomFieldType.invoice1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.invoice2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.invoice3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.invoice4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterPurchaseOrdersByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterPurchaseOrdersByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterPurchaseOrdersByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterPurchaseOrdersByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.purchaseOrder)
          ? FloatingActionButton(
              heroTag: 'purchase_order_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.purchaseOrder);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newPurchaseOrder,
            )
          : null,
    );
  }
}
