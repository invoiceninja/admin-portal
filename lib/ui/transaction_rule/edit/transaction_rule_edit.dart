import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/expense_category_model.dart';
import 'package:invoiceninja_flutter/data/models/transaction_rule_model.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/edit/transaction_rule_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TransactionRuleEdit extends StatefulWidget {
  const TransactionRuleEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TransactionRuleEditVM viewModel;

  @override
  _TransactionRuleEditState createState() => _TransactionRuleEditState();
}

class _TransactionRuleEditState extends State<TransactionRuleEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_transactionRuleEdit');
  final _debouncer = Debouncer();

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final transactionRule = widget.viewModel.transactionRule;
    _nameController.text = transactionRule.name;

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
      final transactionRule = widget.viewModel.transactionRule
          .rebuild((b) => b..name = _nameController.text.trim());
      if (transactionRule != widget.viewModel.transactionRule) {
        widget.viewModel.onChanged(transactionRule);
      }
    });
  }

  void _onSubmitted() {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final transactionRule = viewModel.transactionRule;
    final state = viewModel.state;

    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final textStyle = TextStyle(color: textColor.withOpacity(.65));

    return EditScaffold(
      title: transactionRule.isNew
          ? localization!.newTransactionRule
          : localization!.editTransactionRule,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) => _onSubmitted(),
      body: Form(
        key: _formKey,
        child: Builder(
          builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      autofocus: true,
                      label: localization.name,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      onSavePressed: (context) => _onSubmitted(),
                      validator: (value) => value.trim().isEmpty
                          ? localization.pleaseEnterAName
                          : null,
                    ),
                    SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(localization.matchAllRules),
                      subtitle: Text(localization.matchAllRulesHelp),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: transactionRule.matchesOnAll,
                      onChanged: (value) {
                        viewModel.onChanged(transactionRule
                            .rebuild((b) => b..matchesOnAll = value));
                      },
                    ),
                    SwitchListTile(
                      title: Text(localization.autoConvert),
                      subtitle: Text(localization.autoConvertHelp),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: transactionRule.autoConvert,
                      onChanged: (value) {
                        viewModel.onChanged(transactionRule
                            .rebuild((b) => b..autoConvert = value));
                      },
                    ),
                  ],
                ),
                FormCard(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (transactionRule.rules.isNotEmpty) ...[
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            localization.field,
                            style: textStyle,
                          )),
                          Expanded(
                            child: Text(
                              localization.operator,
                              style: textStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              localization.value,
                              style: textStyle,
                            ),
                          ),
                          SizedBox(width: 100),
                        ],
                      ),
                      SizedBox(height: 4),
                      for (var rule in transactionRule.rules)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child:
                                    Text(localization.lookup(rule.searchKey)),
                              ),
                              Expanded(
                                child: Text(localization.lookup(rule.operator)),
                              ),
                              Expanded(
                                child: Text(rule.value),
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        final updatedRule = await showDialog<
                                                TransactionRuleCriteriaEntity>(
                                            context: context,
                                            builder: (context) =>
                                                _RuleCriteria(criteria: rule));
                                        if (updatedRule != null) {
                                          final index = transactionRule.rules
                                              .indexOf(rule);
                                          viewModel.onChanged(
                                              transactionRule.rebuild((b) => b
                                                ..rules.replaceRange(index,
                                                    index + 1, [updatedRule])));
                                        }
                                      },
                                      icon: Icon(MdiIcons.circleEditOutline),
                                    ),
                                    SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        viewModel.onChanged(
                                            transactionRule.rebuild(
                                                (b) => b..rules.remove(rule)));
                                      },
                                      icon: Icon(Icons.clear),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 12),
                    ],
                    OutlinedButton(
                      onPressed: () async {
                        final rule =
                            await showDialog<TransactionRuleCriteriaEntity>(
                                context: context,
                                builder: (context) => _RuleCriteria());

                        if (rule != null) {
                          viewModel.onChanged(transactionRule
                              .rebuild((b) => b..rules.add(rule)));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: IconText(
                          text: localization.addRule,
                          icon: Icons.add,
                        ),
                      ),
                    ),
                  ],
                ),
                FormCard(
                  children: [
                    EntityDropdown(
                      entityType: EntityType.vendor,
                      entityId: transactionRule.vendorId,
                      entityList: memoizedDropdownVendorList(
                          state.vendorState.map,
                          state.vendorState.list,
                          state.userState.map,
                          state.staticState),
                      labelText: localization.vendor,
                      onSelected: (vendor) {
                        viewModel.onChanged(transactionRule
                            .rebuild((b) => b..vendorId = vendor?.id ?? ''));
                      },
                      onCreateNew: (completer, name) {
                        store.dispatch(SaveVendorRequest(
                            vendor:
                                VendorEntity().rebuild((b) => b..name = name),
                            completer: completer));
                      },
                    ),
                    EntityDropdown(
                      entityType: EntityType.expenseCategory,
                      entityId: transactionRule.categoryId,
                      entityList: memoizedDropdownExpenseCategoryList(
                        state.expenseCategoryState.map,
                        state.expenseCategoryState.list,
                        state.staticState,
                        state.userState.map,
                        transactionRule.categoryId,
                      ),
                      labelText: localization.category,
                      onSelected: (category) {
                        viewModel.onChanged(transactionRule.rebuild(
                            (b) => b..categoryId = category?.id ?? ''));
                      },
                      onCreateNew: (completer, name) {
                        store.dispatch(SaveExpenseCategoryRequest(
                            expenseCategory: ExpenseCategoryEntity()
                                .rebuild((b) => b..name = name),
                            completer: completer));
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RuleCriteria extends StatefulWidget {
  const _RuleCriteria({
    Key? key,
    this.criteria,
  }) : super(key: key);

  final TransactionRuleCriteriaEntity? criteria;

  @override
  State<_RuleCriteria> createState() => __RuleCriteriaState();
}

class __RuleCriteriaState extends State<_RuleCriteria> {
  TransactionRuleCriteriaEntity? _criteria;
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_ruleCriteria');

  @override
  void initState() {
    super.initState();

    _criteria = widget.criteria ?? TransactionRuleCriteriaEntity();
  }

  void onDonePressed() {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (_criteria!.searchKey.isEmpty ||
        _criteria!.operator.isEmpty ||
        (_criteria!.value.isEmpty &&
            _criteria!.operator !=
                TransactionRuleCriteriaEntity.STRING_OPERATOR_IS_EMPTY)) {
      return;
    }

    Navigator.of(context).pop(_criteria);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppDropdownButton<String>(
              labelText: localization.field,
              value: _criteria!.searchKey,
              onChanged: (dynamic value) {
                setState(() {
                  _criteria = _criteria!.rebuild((b) => b
                    ..searchKey = value
                    ..operator = value ==
                            TransactionRuleCriteriaEntity.SEARCH_KEY_DESCRIPTION
                        ? TransactionRuleCriteriaEntity.STRING_OPERATOR_CONTAINS
                        : TransactionRuleCriteriaEntity.NUMBER_OPERATOR_EQUALS);
                });
              },
              items: [
                DropdownMenuItem<String>(
                  child: Text(localization.description),
                  value: TransactionRuleCriteriaEntity.SEARCH_KEY_DESCRIPTION,
                ),
                DropdownMenuItem<String>(
                  child: Text(localization.amount),
                  value: TransactionRuleCriteriaEntity.SEARCH_KEY_AMOUNT,
                ),
              ],
            ),
            AppDropdownButton<String>(
              labelText: localization.operator,
              value: _criteria!.operator,
              onChanged: (dynamic value) {
                setState(() {
                  _criteria = _criteria!.rebuild((b) => b..operator = value);
                });
              },
              items: _criteria!.searchKey ==
                      TransactionRuleCriteriaEntity.SEARCH_KEY_DESCRIPTION
                  ? [
                      DropdownMenuItem<String>(
                        child: Text(localization.contains),
                        value: TransactionRuleCriteriaEntity
                            .STRING_OPERATOR_CONTAINS,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(localization.startsWith),
                        value: TransactionRuleCriteriaEntity
                            .STRING_OPERATOR_STARTS_WITH,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(localization.isWord),
                        value: TransactionRuleCriteriaEntity.STRING_OPERATOR_IS,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(localization.isEmpty),
                        value: TransactionRuleCriteriaEntity
                            .STRING_OPERATOR_IS_EMPTY,
                      ),
                    ]
                  : [
                      DropdownMenuItem<String>(
                        child: Text(TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_LESS_THAN),
                        value: TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_LESS_THAN,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_LESS_THAN_OR_EQUALS),
                        value: TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_LESS_THAN_OR_EQUALS,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_EQUALS),
                        value: TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_EQUALS,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_GREATER_THAN),
                        value: TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_GREATER_THAN,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_GREATER_THAN_OR_EQUALS),
                        value: TransactionRuleCriteriaEntity
                            .NUMBER_OPERATOR_GREATER_THAN_OR_EQUALS,
                      ),
                    ],
            ),
            if (_criteria!.operator !=
                TransactionRuleCriteriaEntity.STRING_OPERATOR_IS_EMPTY)
              DecoratedFormField(
                autofocus: true,
                label: localization.value,
                initialValue: _criteria!.value,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _criteria = _criteria!.rebuild((b) => b..value = value);
                  });
                },
                onSavePressed: (context) => onDonePressed(),
                validator: (value) => value.trim().isEmpty
                    ? localization.pleaseEnterAValue
                    : null,
              )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(localization.cancel.toUpperCase()),
        ),
        TextButton(
          onPressed: onDonePressed,
          child: Text(localization.done.toUpperCase()),
        ),
      ],
    );
  }
}
