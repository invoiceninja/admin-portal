import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class ExpenseEditNotes extends StatefulWidget {
  const ExpenseEditNotes({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseEditVM viewModel;

  @override
  ExpenseEditNotesState createState() => new ExpenseEditNotesState();
}

class ExpenseEditNotesState extends State<ExpenseEditNotes> {
  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();

  List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _publicNotesController,
      _privateNotesController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense;
    _publicNotesController.text = expense.publicNotes;
    _privateNotesController.text = expense.privateNotes;

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
    final expense = viewModel.expense.rebuild((b) => b
      ..publicNotes = _publicNotesController.text.trim()
      ..privateNotes = _privateNotesController.text.trim());
    if (expense != viewModel.expense) {
      _debouncer.run(() {
        viewModel.onChanged(expense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              maxLines: 8,
              controller: _publicNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.publicNotes,
            ),
            DecoratedFormField(
              maxLines: 8,
              controller: _privateNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.privateNotes,
            ),
          ],
        ),
      ],
    );
  }
}
