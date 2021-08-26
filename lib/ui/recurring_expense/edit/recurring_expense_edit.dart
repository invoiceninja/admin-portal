import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/edit/recurring_expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

class RecurringExpenseEdit extends StatefulWidget {
  const RecurringExpenseEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final RecurringExpenseEditVM viewModel;

  @override
  _RecurringExpenseEditState createState() => _RecurringExpenseEditState();
}

class _RecurringExpenseEditState extends State<RecurringExpenseEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_recurringExpenseEdit');
  final _debouncer = Debouncer();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

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
    _debouncer.run(() {});
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final recurringExpense = viewModel.recurringExpense;

    return EditScaffold(
      title: recurringExpense.isNew
          ? localization.newRecurringExpense
          : localization.editRecurringExpense,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
          setState(() {
            _autoValidate = !isValid;
          });
            */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    // STARTER: widgets - do not remove comment
                    TextFormField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Recurring_expenses',
                      ),
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
