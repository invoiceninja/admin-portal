import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/transaction/edit/transaction_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

class TransactionEdit extends StatefulWidget {
  const TransactionEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TransactionEditVM viewModel;

  @override
  _TransactionEditState createState() => _TransactionEditState();
}

class _TransactionEditState extends State<TransactionEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_transactionEdit');
  final _debouncer = Debouncer();

  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
      _descriptionController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final transaction = widget.viewModel.transaction;
    _amountController.text = formatNumber(transaction.amount, context,
        formatNumberType: FormatNumberType.inputMoney);
    _descriptionController.text = transaction.description;

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
    _debouncer.run(() {
      final transaction = widget.viewModel.transaction.rebuild((b) => b
        ..amount = parseDouble(_amountController.text.trim())
        ..description = _descriptionController.text.trim());
      if (transaction != widget.viewModel.transaction) {
        widget.viewModel.onChanged(transaction);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final transaction = viewModel.transaction;

    return EditScaffold(
      title: transaction.isNew
          ? localization.newTransaction
          : localization.editTransaction,
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
                    DecoratedFormField(
                      label: localization.amount,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: _amountController,
                    ),
                    DatePicker(
                        labelText: localization.date,
                        onSelected: (date, _) {
                          viewModel.onChanged(
                              transaction.rebuild((b) => b..date = date));
                        },
                        selectedDate: transaction.date),
                    DecoratedFormField(
                      label: localization.description,
                      keyboardType: TextInputType.multiline,
                      controller: _descriptionController,
                      maxLines: 4,
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
