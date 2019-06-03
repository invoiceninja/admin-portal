import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseViewVM viewModel;

  @override
  _ExpenseViewState createState() => new _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final expense = viewModel.expense;

    return Scaffold(
      appBar: AppBar(
        title: Text(expense.expenseDate),
        actions: expense.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  user: viewModel.company.user,
                  isSaving: viewModel.isSaving,
                  entity: expense,
                  onSelected: viewModel.onActionSelected,
                ),
              ],
      ),
      body: FormCard(children: [
        // STARTER: widgets - do not remove comment
      ]),
    );
  }
}
