import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class ExpenseEditDocuments extends StatefulWidget {
  const ExpenseEditDocuments({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseEditVM viewModel;

  @override
  ExpenseEditDocumentsState createState() => ExpenseEditDocumentsState();
}

class ExpenseEditDocumentsState extends State<ExpenseEditDocuments> {
  final List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final expense = viewModel.expense.rebuild((b) => b);
    if (expense != viewModel.expense) {
      viewModel.onChanged(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
          ],
        ),
      ],
    );
  }
}
