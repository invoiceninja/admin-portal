import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/settings/expense_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseSettings extends StatefulWidget {
  const ExpenseSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseSettingsVM viewModel;

  @override
  _ExpenseSettingsState createState() => _ExpenseSettingsState();
}

class _ExpenseSettingsState extends State<ExpenseSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_expenseSettings');
  FocusScopeNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    return EditScaffold(
      title: localization.expenseSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.shouldBeInvoiced),
                value: company.markExpensesInvoiceable ?? false,
                subtitle: Text(localization.shouldBeInvoicedHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..markExpensesInvoiceable = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.markPaid),
                value: company.markExpensesPaid ?? false,
                subtitle: Text(localization.markPaidHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..markExpensesPaid = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.addDocumentsToInvoice),
                value: company.invoiceExpenseDocuments ?? false,
                subtitle: Text(localization.addDocumentsToInvoiceHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..invoiceExpenseDocuments = value)),
              ),
            ],
          ),
          if (company.numberOfItemTaxRates > 0)
            FormCard(
              children: [
                BoolDropdownButton(
                  label: localization.enterTaxes,
                  enabledLabel: localization.byAmount,
                  disabledLabel: localization.byRate,
                  value: company.calculateExpenseTaxByAmount ?? false,
                  onChanged: (value) => viewModel.onCompanyChanged(company
                      .rebuild((b) => b..calculateExpenseTaxByAmount = value)),
                ),
                SizedBox(height: 16),
                SwitchListTile(
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.inclusiveTaxes),
                  value: company.expenseInclusiveTaxes ?? false,
                  subtitle: Text(
                      '\n${localization.exclusive}: 100 + 10% = 100 + 10\n${localization.inclusive}: 100 + 10% = 90.91 + 9.09'),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..expenseInclusiveTaxes = value)),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              iconData: Icons.settings,
              label: localization.configureCategories.toUpperCase(),
              onPressed: () => viewModel.onConfigureCategoriesPressed(context),
            ),
          ),
        ],
      ),
    );
  }
}
