import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/view/recurring_expense_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';

class RecurringExpenseView extends StatefulWidget {
  const RecurringExpenseView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final RecurringExpenseViewVM viewModel;
  final bool isFilter;

  @override
  _RecurringExpenseViewState createState() => new _RecurringExpenseViewState();
}

class _RecurringExpenseViewState extends State<RecurringExpenseView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final recurringExpense = viewModel.recurringExpense;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: recurringExpense,
      body: ScrollableListView(
        children: <Widget>[],
      ),
    );
  }
}
