import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseOverview extends StatelessWidget {
  const ExpenseOverview({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final expense = viewModel.expense;
    final company = viewModel.company;
    final state = viewModel.state;
    final vendor = state.vendorState.map[expense.vendorId];
    final client = state.clientState.map[expense.clientId];
    final invoice = state.invoiceState.map[expense.invoiceId];
    final category = company.expenseCategoryMap[expense.categoryId];

    final fields = <String, String>{
      localization.category: category?.name,
    };

    if (expense.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.expense1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.expense1,
          value: expense.customValue1);
    }

    if (expense.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.expense2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.expense2,
          value: expense.customValue2);
    }

    List<Widget> _buildDetailsList() {
      String tax = '';
      if (expense.taxName1.isNotEmpty) {
        tax += formatNumber(expense.taxRate1, context,
                formatNumberType: FormatNumberType.percent) +
            ' ' +
            expense.taxName1;
      }
      if (expense.taxName2.isNotEmpty) {
        tax += ' ' +
            formatNumber(expense.taxRate2, context,
                formatNumberType: FormatNumberType.percent) +
            ' ' +
            expense.taxName2;
      }

      final fields = <String, String>{
        localization.tax: tax,
        localization.paymentType:
            state.staticState.paymentTypeMap[expense.paymentTypeId]?.name,
        localization.paymentDate: formatDate(expense.paymentDate, context),
        localization.transactionReference: expense.transactionReference,
        localization.exchangeRate: expense.isConverted
            ? formatNumber(expense.exchangeRate, context,
                formatNumberType: FormatNumberType.double)
            : null,
        localization.currency: expense.isConverted
            ? state.staticState.currencyMap[expense.invoiceCurrencyId]?.name
            : null,
      };

      final listTiles = <Widget>[
        FieldGrid(fields),
      ];

      return listTiles;
    }

    return ListView(
      children: <Widget>[
        expense.isConverted
            ? EntityHeader(
                entity: expense,
                statusColor: ExpenseStatusColors.colors[expense.statusId],
                statusLabel:
                    localization.lookup('expense_status_${expense.statusId}'),
                label: localization.amount,
                value: formatNumber(expense.amountWithTax, context,
                    currencyId: expense.expenseCurrencyId),
                secondLabel: localization.converted,
                secondValue: formatNumber(
                    expense.convertedAmountWithTax, context,
                    currencyId: expense.invoiceCurrencyId),
              )
            : EntityHeader(
                entity: expense,
                statusColor: ExpenseStatusColors.colors[expense.statusId],
                statusLabel:
                    localization.lookup('expense_status_${expense.statusId}'),
                label: localization.amount,
                value: formatNumber(expense.amountWithTax, context,
                    currencyId: expense.expenseCurrencyId),
              ),
        ListDivider(),
        if ((expense.privateNotes ?? '').isNotEmpty) ...[
          IconMessage(expense.privateNotes, iconData: Icons.lock),
        ],
        FieldGrid(fields),
        ListDivider(),
        vendor == null
            ? SizedBox()
            : Material(
                color: Theme.of(context).canvasColor,
                child: ListTile(
                  title: EntityStateTitle(entity: vendor),
                  leading: Icon(getEntityIcon(EntityType.vendor), size: 18),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () =>
                      viewModel.onEntityPressed(context, EntityType.vendor),
                  onLongPress: () => viewModel.onEntityPressed(
                      context, EntityType.vendor, true),
                ),
              ),
        vendor == null
            ? SizedBox()
            : Container(
                color: Theme.of(context).backgroundColor,
                height: 12.0,
              ),
        client == null
            ? SizedBox()
            : Material(
                color: Theme.of(context).canvasColor,
                child: ListTile(
                  title: EntityStateTitle(entity: client),
                  leading: Icon(getEntityIcon(EntityType.client), size: 18),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () =>
                      viewModel.onEntityPressed(context, EntityType.client),
                  onLongPress: () => viewModel.onEntityPressed(
                      context, EntityType.client, true),
                ),
              ),
        client == null
            ? SizedBox()
            : Container(
                color: Theme.of(context).backgroundColor,
                height: 12.0,
              ),
        invoice == null
            ? SizedBox()
            : Material(
                color: Theme.of(context).canvasColor,
                child: ListTile(
                  title: EntityStateTitle(
                    entity: invoice,
                  ),
                  leading: Icon(getEntityIcon(EntityType.invoice), size: 18),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () =>
                      viewModel.onEntityPressed(context, EntityType.invoice),
                  onLongPress: () => viewModel.onEntityPressed(
                      context, EntityType.invoice, true),
                ),
              ),
        ..._buildDetailsList(),
        if ((expense.publicNotes ?? '').isNotEmpty) ...[
          IconMessage(expense.publicNotes),
          ListDivider()
        ],
      ],
    );
  }
}
