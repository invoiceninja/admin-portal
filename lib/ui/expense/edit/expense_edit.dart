import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_details.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_settings.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseEdit extends StatefulWidget {
  const ExpenseEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseEditVM viewModel;

  @override
  _ExpenseEditState createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<ExpenseEdit>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_expenseEdit');

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final expense = viewModel.expense;

    return EditScaffold(
      entity: expense,
      title: expense.isNew ? localization.newExpense : localization.editExpense,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
        setState(() {
          autoValidate = !isValid ?? false;
        })
         */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      appBarBottom: TabBar(
        controller: _controller,
        //isScrollable: true,
        tabs: [
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.notes,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          key: ValueKey(viewModel.expense.id),
          controller: _controller,
          children: <Widget>[
            ExpenseEditDetails(
              viewModel: widget.viewModel,
            ),
            ExpenseEditSettings(
              viewModel: widget.viewModel,
            ),
            ExpenseEditNotes(
              viewModel: widget.viewModel,
            ),
          ],
        ),
      ),
    );
  }
}
