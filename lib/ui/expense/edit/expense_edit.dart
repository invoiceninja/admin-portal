import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_details.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_documents.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_settings.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';

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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(expense.isNew
              ? localization.newExpense
              : localization.editExpense),
          actions: <Widget>[
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: !expense.isDeleted,
              isDirty: expense.isNew || expense != viewModel.origExpense,
              isSaving: viewModel.isSaving,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            )
          ],
          bottom: TabBar(
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
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
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
      ),
    );
  }
}
