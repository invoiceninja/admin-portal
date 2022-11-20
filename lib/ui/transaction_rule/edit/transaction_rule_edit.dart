import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/edit/transaction_rule_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

class TransactionRuleEdit extends StatefulWidget {
  const TransactionRuleEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TransactionRuleEditVM viewModel;

  @override
  _TransactionRuleEditState createState() => _TransactionRuleEditState();
}

class _TransactionRuleEditState extends State<TransactionRuleEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_transactionRuleEdit');
  final _debouncer = Debouncer();

  // STARTER: controllers - do not remove comment
  final _transaction_rulesController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
      _transaction_rulesController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final transactionRule = widget.viewModel.transactionRule;
    // STARTER: read value - do not remove comment
    _transaction_rulesController.text = transaction_rule.transaction_rules;

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
      final transactionRule = widget.viewModel.transactionRule.rebuild((b) => b
        // STARTER: set value - do not remove comment
        ..transaction_rules = _transaction_rulesController.text.trim());
      if (transactionRule != widget.viewModel.transactionRule) {
        widget.viewModel.onChanged(transactionRule);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final transactionRule = viewModel.transactionRule;

    return EditScaffold(
      title: transactionRule.isNew
          ? localization.newTransactionRule
          : localization.editTransactionRule,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

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
                      controller: _transaction_rulesController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Transaction_rules',
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
