import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
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

class _ExpenseEditState extends State<ExpenseEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense;
    // STARTER: read value - do not remove comment

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final expense = widget.viewModel.expense.rebuild((b) => b
        // STARTER: set value - do not remove comment
        );
    if (expense != widget.viewModel.expense) {
      widget.viewModel.onChanged(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final expense = viewModel.expense;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.expense.isNew
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
            ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Builder(builder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      // STARTER: widgets - do not remove comment
                    ],
                  ),
                ],
              );
            })),
      ),
    );
  }
}
