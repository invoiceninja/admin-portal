import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/expense_category/view/expense_category_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';

class ExpenseCategoryView extends StatefulWidget {
  const ExpenseCategoryView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final ExpenseCategoryViewVM viewModel;
  final bool isFilter;

  @override
  _ExpenseCategoryViewState createState() => new _ExpenseCategoryViewState();
}

class _ExpenseCategoryViewState extends State<ExpenseCategoryView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final expenseCategory = viewModel.expenseCategory;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: expenseCategory,
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
