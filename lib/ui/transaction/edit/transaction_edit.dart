import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_selectors.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/transaction/edit/transaction_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

class TransactionEdit extends StatefulWidget {
  const TransactionEdit({
    Key? key,
    required this.viewModel,
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
        formatNumberType: FormatNumberType.inputMoney)!;
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

  void _onSavePressed() {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final transaction = viewModel.transaction;
    final state = viewModel.state;
    final store = StoreProvider.of<AppState>(context);

    return EditScaffold(
      title: transaction.isNew
          ? localization!.newTransaction
          : localization!.editTransaction,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) => _onSavePressed(),
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    AppDropdownButton<String>(
                        labelText: localization.type,
                        value: transaction.baseType,
                        onChanged: (dynamic value) {
                          viewModel.onChanged(
                              transaction.rebuild((b) => b..baseType = value));
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(localization.withdrawal),
                            value: TransactionEntity.TYPE_WITHDRAWL,
                          ),
                          DropdownMenuItem(
                            child: Text(localization.deposit),
                            value: TransactionEntity.TYPE_DEPOSIT,
                          ),
                        ]),
                    DatePicker(
                        labelText: localization.date,
                        onSelected: (date, _) {
                          viewModel.onChanged(
                              transaction.rebuild((b) => b..date = date));
                        },
                        selectedDate: transaction.date),
                    DecoratedFormField(
                      autofocus: transaction.isNew,
                      label: localization.amount,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: _amountController,
                      onSavePressed: (_) => _onSavePressed(),
                      validator: (value) =>
                          value.isEmpty ? localization.pleaseEnterAValue : null,
                    ),
                    EntityDropdown(
                      entityType: EntityType.currency,
                      entityList:
                          memoizedCurrencyList(state.staticState.currencyMap),
                      labelText: localization.currency,
                      entityId: transaction.currencyId,
                      onSelected: (SelectableEntity? currency) =>
                          viewModel.onChanged(viewModel.transaction.rebuild(
                              (b) => b..currencyId = currency?.id ?? '')),
                    ),
                    EntityDropdown(
                      entityType: EntityType.bankAccount,
                      entityId: transaction.bankAccountId,
                      labelText: localization.bankAccount,
                      entityList: memoizedDropdownBankAccountList(
                        state.bankAccountState.map,
                        state.bankAccountState.list,
                        state.staticState,
                        state.userState.map,
                        transaction.bankAccountId,
                      ),
                      onSelected: (bankAccount) => viewModel.onChanged(
                        transaction.rebuild(
                            (b) => b.bankAccountId = bankAccount?.id ?? ''),
                      ),
                      onAddPressed: (completer) =>
                          viewModel.onAddBankAccountPressed(context, completer),
                      onCreateNew: (completer, name) {
                        store.dispatch(SaveBankAccountRequest(
                            bankAccount: BankAccountEntity()
                                .rebuild((b) => b..name = name),
                            completer: completer));
                      },
                      validator: (dynamic value) =>
                          transaction.bankAccountId.isEmpty
                              ? localization.pleaseEnterAValue
                              : null,
                      overrideSuggestedAmount: (entity) => '',
                    ),
                    DecoratedFormField(
                      label: localization.description,
                      keyboardType: TextInputType.multiline,
                      controller: _descriptionController,
                      maxLines: 6,
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
