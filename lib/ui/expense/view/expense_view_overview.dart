import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
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

    return ListView(
      children: <Widget>[
        expense.isConverted
            ? EntityHeader(
                backgroundColor: ExpenseStatusColors.colors[expense.statusId],
                label: localization.amount,
                value: formatNumber(expense.amountWithTax, context,
                    currencyId: expense.expenseCurrencyId),
                secondLabel: localization.converted,
                secondValue: formatNumber(
                    expense.convertedAmountWithTax, context,
                    currencyId: expense.invoiceCurrencyId),
              )
            : EntityHeader(
                backgroundColor: ExpenseStatusColors.colors[expense.statusId],
                label: localization.amount,
                value: formatNumber(expense.amountWithTax, context,
                    currencyId: expense.expenseCurrencyId),
              ),
        expense.privateNotes != null && expense.privateNotes.isNotEmpty
            ? IconMessage(expense.privateNotes)
            : Container(),
        FieldGrid(fields),
        Divider(
          height: 1.0,
        ),
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
                      title:
                          '${localization.invoice} ${invoice.number}'),
                  leading: Icon(getEntityIcon(EntityType.invoice), size: 18),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () =>
                      viewModel.onEntityPressed(context, EntityType.invoice),
                  onLongPress: () => viewModel.onEntityPressed(
                      context, EntityType.invoice, true),
                ),
              ),
        invoice == null
            ? SizedBox()
            : Container(
                color: Theme.of(context).backgroundColor,
                height: 12.0,
              ),
      ],
    );
  }
}
