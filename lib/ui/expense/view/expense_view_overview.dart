import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/one_value_header.dart';
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
      fields[label1] = expense.customValue1;
    }

    if (expense.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.expense2);
      fields[label2] = expense.customValue2;
    }

    return ListView(
      children: <Widget>[
        OneValueHeader(
          label: localization.balanceDue,
          value: formatNumber(expense.amount, context,
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
            : EntityListTile(
                icon: getEntityIcon(EntityType.vendor),
                title: vendor.name,
                onTap: () =>
                    viewModel.onEntityPressed(context, EntityType.vendor),
                onLongPress: () =>
                    viewModel.onEntityPressed(context, EntityType.vendor, true),
              ),
        client == null
            ? SizedBox()
            : EntityListTile(
                icon: getEntityIcon(EntityType.client),
                title: client.listDisplayName,
                onTap: () =>
                    viewModel.onEntityPressed(context, EntityType.client),
                onLongPress: () =>
                    viewModel.onEntityPressed(context, EntityType.client, true),
              ),
        invoice == null
            ? SizedBox()
            : EntityListTile(
                icon: getEntityIcon(EntityType.invoice),
                title: '${localization.invoice} ${invoice.invoiceNumber}',
                onTap: () =>
                    viewModel.onEntityPressed(context, EntityType.invoice),
                onLongPress: () => viewModel.onEntityPressed(
                    context, EntityType.invoice, true),
              ),
      ],
    );
  }
}
