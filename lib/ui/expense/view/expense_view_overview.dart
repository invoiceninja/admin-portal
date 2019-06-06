import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/one_value_header.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
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
    final fields = <String, String>{};

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
        /*
        EntityListTile(
          icon: getEntityIcon(EntityType.invoice),
          title: localization.invoices,
          onTap: () => viewModel.onEntityPressed(context, EntityType.invoice),
          onLongPress: () =>
              viewModel.onEntityPressed(context, EntityType.invoice, true),
          subtitle: memoizedInvoiceStatsForExpense(
              expense.id,
              state.invoiceState.map,
              localization.active,
              localization.archived),
        ),
        */
      ],
    );
  }
}

class EntityListTile extends StatelessWidget {
  const EntityListTile(
      {this.icon, this.onTap, this.onLongPress, this.title, this.subtitle});

  final Function onTap;
  final Function onLongPress;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Theme.of(context).canvasColor,
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: Icon(icon, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        ),
        Divider(),
      ],
    );
  }
}
