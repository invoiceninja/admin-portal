import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense_category/edit/expense_category_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ExpenseCategoryEdit extends StatefulWidget {
  const ExpenseCategoryEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseCategoryEditVM viewModel;

  @override
  _ExpenseCategoryEditState createState() => _ExpenseCategoryEditState();
}

class _ExpenseCategoryEditState extends State<ExpenseCategoryEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_expenseCategoryEdit');
  final _debouncer = Debouncer();
  bool _autoValidate = false;

  // STARTER: controllers - do not remove comment
  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
      _nameController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final expenseCategory = widget.viewModel.expenseCategory;
    _nameController.text = expenseCategory.name;

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
    final expenseCategory = widget.viewModel.expenseCategory
        .rebuild((b) => b..name = _nameController.text.trim());
    if (expenseCategory != widget.viewModel.expenseCategory) {
      _debouncer.run(() {
        widget.viewModel.onChanged(expenseCategory);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final expenseCategory = viewModel.expenseCategory;

    return EditScaffold(
      title: expenseCategory.isNew
          ? localization.newExpenseCategory
          : localization.editExpenseCategory,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        setState(() {
          _autoValidate = !isValid;
        });

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
                    DecoratedFormField(
                      autofocus: true,
                      controller: _nameController,
                      autovalidate: _autoValidate,
                      label: localization.name,
                    ),
                    FormColorPicker(
                      initialValue: expenseCategory.color,
                      onSelected: (value) => viewModel.onChanged(
                          expenseCategory.rebuild((b) => b..color = value)),
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
