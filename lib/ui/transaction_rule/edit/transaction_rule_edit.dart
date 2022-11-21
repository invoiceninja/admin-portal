import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
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
    final bool isValid = _formKey.currentState.validate();

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

    return EditScaffold(
      title: transactionRule.isNew
          ? localization.newTransactionRule
          : localization.editTransactionRule,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) => _onSubmitted(),
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      label: localization.name,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      onSavePressed: (context) => _onSubmitted(),
                    ),
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
                            .rebuild((b) => b..vendorId = vendor.id));
                      },
                      onCreateNew: (completer, name) {
                        store.dispatch(SaveVendorRequest(
                            vendor:
                                VendorEntity().rebuild((b) => b..name = name),
                            completer: completer));
                      },
                    )
                  ],
                ),
              ],
            );
          })),
    );
  }
}
