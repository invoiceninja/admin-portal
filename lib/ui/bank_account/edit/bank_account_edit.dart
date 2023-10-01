// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/bank_account/edit/bank_account_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class BankAccountEdit extends StatefulWidget {
  const BankAccountEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final BankAccountEditVM viewModel;

  @override
  _BankAccountEditState createState() => _BankAccountEditState();
}

class _BankAccountEditState extends State<BankAccountEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_bankAccountEdit');
  final FocusScopeNode _focusNode = FocusScopeNode();

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final bankAccount = widget.viewModel.bankAccount;
    _nameController.text = bankAccount.name;

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
    _focusNode.dispose();

    super.dispose();
  }

  void _onChanged() {
    final bankAccount = widget.viewModel.bankAccount
        .rebuild((b) => b..name = _nameController.text.trim());
    if (bankAccount != widget.viewModel.bankAccount) {
      _debouncer.run(() {
        widget.viewModel.onChanged(bankAccount);
      });
    }
  }

  void _onSavePressed() {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final bankAccount = viewModel.bankAccount;

    return EditScaffold(
      entity: bankAccount,
      title: viewModel.bankAccount.isNew
          ? localization.newBankAccount
          : localization.editBankAccount,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (_) => _onSavePressed(),
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        child: ScrollableListView(
          key: ValueKey(
              '__bankAccount_${bankAccount.id}_${bankAccount.updatedAt}__'),
          children: <Widget>[
            FormCard(
              isLast: true,
              children: <Widget>[
                DecoratedFormField(
                  autofocus: true,
                  label: localization.name,
                  controller: _nameController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterAName
                      : null,
                  onSavePressed: (_) => _onSavePressed(),
                  keyboardType: TextInputType.text,
                ),
                if (bankAccount.isConnected) ...[
                  DatePicker(
                    labelText: localization.syncFrom,
                    onSelected: (date, _) => viewModel.onChanged(
                        bankAccount.rebuild((b) => b..fromDate = date)),
                    selectedDate: bankAccount.fromDate,
                    allowClearing: true,
                  ),
                  SizedBox(height: 16),
                  SwitchListTile(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    title: Text(localization.autoSync),
                    value: bankAccount.autoSync,
                    onChanged: (value) => viewModel.onChanged(
                        bankAccount.rebuild((b) => b..autoSync = value)),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
