import 'package:invoiceninja_flutter/colors.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseOverview extends StatelessWidget {
  const ExpenseOverview({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final ExpenseViewVM viewModel;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final expense = viewModel.expense;
    final company = viewModel.company;
    final state = viewModel.state;
    final vendor = state.vendorState.get(expense.vendorId);
    final client = state.clientState.get(expense.clientId);
    final invoice = state.invoiceState.get(expense.invoiceId);
    final project = state.projectState.get(expense.projectId);
    final category = state.expenseCategoryState.get(expense.categoryId);
    final user = state.userState.get(expense.assignedUserId);

    final fields = <String, String>{};
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
      if (expense.calculateTaxByAmount) {
        if (expense.taxName1.isNotEmpty) {
          tax += formatNumber(expense.taxAmount1, context) +
              ' ' +
              expense.taxName1;
        }
        if (expense.taxName2.isNotEmpty) {
          tax += ' ' +
              formatNumber(expense.taxAmount2, context) +
              ' ' +
              expense.taxName2;
        }
        if (expense.taxName3.isNotEmpty) {
          tax += ' ' +
              formatNumber(expense.taxAmount3, context) +
              ' ' +
              expense.taxName3;
        }
      } else {
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
        if (expense.taxName3.isNotEmpty) {
          tax += ' ' +
              formatNumber(expense.taxRate3, context,
                  formatNumberType: FormatNumberType.percent) +
              ' ' +
              expense.taxName3;
        }
      }

      final fields = <String, String>{
        localization.date: formatDate(expense.date, context),
        localization.transactionReference: expense.transactionReference,
        localization.tax: tax,
        localization.paymentDate: formatDate(expense.paymentDate, context),
        localization.paymentType:
            state.staticState.paymentTypeMap[expense.paymentTypeId]?.name,
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

    return ScrollableListView(
      children: <Widget>[
        expense.isConverted
            ? EntityHeader(
                entity: expense,
                statusColor:
                    ExpenseStatusColors(state.prefState.colorThemeModel)
                        .colors[expense.statusId],
                statusLabel:
                    localization.lookup('expense_status_${expense.statusId}'),
                label: localization.amount,
                value: formatNumber(expense.grossAmount, context,
                    currencyId: expense.currencyId),
                secondLabel: localization.converted,
                secondValue: formatNumber(
                    expense.convertedAmountWithTax, context,
                    currencyId: expense.invoiceCurrencyId),
              )
            : EntityHeader(
                entity: expense,
                statusColor:
                    ExpenseStatusColors(state.prefState.colorThemeModel)
                        .colors[expense.statusId],
                statusLabel:
                    localization.lookup('expense_status_${expense.statusId}'),
                label: localization.amount,
                value: formatNumber(expense.grossAmount, context,
                    currencyId: expense.currencyId),
              ),
        ListDivider(),
        if ((expense.privateNotes ?? '').isNotEmpty) ...[
          IconMessage(expense.privateNotes, iconData: Icons.lock),
          ListDivider(),
        ],
        FieldGrid(fields),
        EntityListTile(entity: vendor, isFilter: isFilter),
        EntityListTile(entity: client, isFilter: isFilter),
        EntityListTile(entity: project, isFilter: isFilter),
        EntityListTile(entity: category, isFilter: isFilter),
        EntityListTile(entity: user, isFilter: isFilter),
        EntityListTile(entity: invoice, isFilter: isFilter),
        ..._buildDetailsList(),
        if ((expense.publicNotes ?? '').isNotEmpty) ...[
          IconMessage(expense.publicNotes),
          ListDivider()
        ],
      ],
    );
  }
}
