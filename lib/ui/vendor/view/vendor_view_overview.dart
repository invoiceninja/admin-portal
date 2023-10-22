// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorOverview extends StatelessWidget {
  const VendorOverview({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final VendorViewVM viewModel;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final vendor = viewModel.vendor;
    final company = viewModel.company!;
    final state = StoreProvider.of<AppState>(context).state;
    final statics = state.staticState;
    final fields = <String, String?>{};
    final user =
        vendor.hasUser ? state.userState.get(vendor.assignedUserId!) : null;

    if (vendor.hasCurrency && vendor.currencyId != company.currencyId) {
      fields[VendorFields.currencyId] =
          statics.currencyMap[vendor.currencyId]!.name;
    }

    if (vendor.hasLanguage && vendor.languageId != company.languageId) {
      fields[VendorFields.languageId] =
          statics.languageMap[vendor.currencyId]!.name;
    }

    if (company.hasCustomField(CustomFieldType.vendor1) &&
        vendor.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.vendor1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.vendor1,
          value: vendor.customValue1);
    }

    if (company.hasCustomField(CustomFieldType.vendor2) &&
        vendor.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.vendor2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.vendor2,
          value: vendor.customValue2);
    }

    if (company.hasCustomField(CustomFieldType.vendor3) &&
        vendor.customValue3.isNotEmpty) {
      final label3 = company.getCustomFieldLabel(CustomFieldType.vendor3);
      fields[label3] = formatCustomValue(
          context: context,
          field: CustomFieldType.vendor3,
          value: vendor.customValue3);
    }

    if (company.hasCustomField(CustomFieldType.vendor4) &&
        vendor.customValue4.isNotEmpty) {
      final label4 = company.getCustomFieldLabel(CustomFieldType.vendor4);
      fields[label4] = formatCustomValue(
          context: context,
          field: CustomFieldType.vendor4,
          value: vendor.customValue4);
    }

    return ScrollableListView(
      children: <Widget>[
        EntityHeader(
          entity: vendor,
          label: localization.total,
          value: formatNumber(
              memoizedCalculateVendorBalance(vendor.id, vendor.currencyId,
                  state.expenseState.map, state.expenseState.list),
              context,
              currencyId: vendor.currencyId),
        ),
        ListDivider(),
        if (vendor.privateNotes.isNotEmpty) ...[
          IconMessage(vendor.privateNotes,
              iconData: Icons.lock, copyToClipboard: true),
          ListDivider()
        ],
        if (vendor.hasUser && user != null)
          EntityListTile(
            entity: user,
            isFilter: isFilter,
          ),
        FieldGrid(fields),
        if (company.isModuleEnabled(EntityType.purchaseOrder))
          EntitiesListTile(
            entity: vendor,
            title: localization.purchaseOrders,
            entityType: EntityType.purchaseOrder,
            isFilter: isFilter,
            subtitle: memoizedPurchaseOrderStatsForVendor(
                    vendor.id, state.purchaseOrderState.map)
                .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.expense))
          EntitiesListTile(
            entity: vendor,
            title: localization.expenses,
            entityType: EntityType.expense,
            isFilter: isFilter,
            subtitle:
                memoizedExpenseStatsForVendor(vendor.id, state.expenseState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.recurringExpense))
          EntitiesListTile(
            entity: vendor,
            title: localization.recurringExpenses,
            entityType: EntityType.recurringExpense,
            isFilter: isFilter,
            subtitle: memoizedRecurringExpenseStatsForVendor(
                    vendor.id, state.recurringExpenseState.map)
                .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.transaction))
          EntitiesListTile(
            entity: vendor,
            title: localization.transactions,
            entityType: EntityType.transaction,
            isFilter: isFilter,
            subtitle: memoizedTransactionStatsForVendor(
                    vendor.id, state.transactionState.map)
                .present(localization.active, localization.archived),
          ),
        if (vendor.publicNotes.isNotEmpty) ...[
          IconMessage(vendor.publicNotes, copyToClipboard: true),
          ListDivider()
        ],
      ],
    );
  }
}
