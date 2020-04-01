import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/utils/money.dart';

class ExpenseEditSettings extends StatefulWidget {
  const ExpenseEditSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseEditVM viewModel;

  @override
  ExpenseEditSettingsState createState() => ExpenseEditSettingsState();
}

class ExpenseEditSettingsState extends State<ExpenseEditSettings> {
  bool showPaymentFields = false;
  bool showConvertCurrencyFields = false;

  final _transactionReferenceController = TextEditingController();
  final _exchangeRateController = TextEditingController();

  List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _transactionReferenceController,
      _exchangeRateController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense;
    _transactionReferenceController.text = expense.transactionReference;
    _exchangeRateController.text = formatNumber(expense.exchangeRate, context,
        formatNumberType: FormatNumberType.input);

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    showPaymentFields = expense.paymentDate.isNotEmpty;
    showConvertCurrencyFields =
        expense.exchangeRate != 0 && expense.exchangeRate != 1;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(() {
      final viewModel = widget.viewModel;
      final expense = viewModel.expense.rebuild((b) => b
        ..transactionReference = _transactionReferenceController.text.trim()
        ..exchangeRate = parseDouble(_exchangeRateController.text));
      if (expense != viewModel.expense) {
        viewModel.onChanged(expense);
      }
    });
  }

  void _setCurrency(CurrencyEntity currency) {
    final viewModel = widget.viewModel;
    final expense = viewModel.expense;
    final exchangeRate = currency == null
        ? 0.0
        : getExchangeRate(context,
            fromCurrencyId: expense.expenseCurrencyId,
            toCurrencyId: currency.id);

    viewModel.onChanged(expense.rebuild((b) => b
      ..invoiceCurrencyId = currency?.id ?? 0
      ..exchangeRate = exchangeRate));
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _exchangeRateController.text = formatNumber(exchangeRate, context,
          formatNumberType: FormatNumberType.input);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final staticState = viewModel.state.staticState;
    final company = viewModel.company;
    final expense = viewModel.expense;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            if (company.settings.enableFirstItemTaxRate)
              TaxRateDropdown(
                onSelected: (taxRate) =>
                    viewModel.onChanged(expense.rebuild((b) => b
                      ..taxRate1 = taxRate.rate
                      ..taxName1 = taxRate.name)),
                labelText: localization.tax,
                initialTaxName: expense.taxName1,
                initialTaxRate: expense.taxRate1,
              ),
            if (company.settings.enableSecondItemTaxRate)
              TaxRateDropdown(
                onSelected: (taxRate) =>
                    viewModel.onChanged(expense.rebuild((b) => b
                      ..taxRate2 = taxRate.rate
                      ..taxName2 = taxRate.name)),
                labelText: localization.tax,
                initialTaxName: expense.taxName2,
                initialTaxRate: expense.taxRate2,
              ),
            if (company.settings.enableThirdItemTaxRate)
              TaxRateDropdown(
                onSelected: (taxRate) =>
                    viewModel.onChanged(expense.rebuild((b) => b
                      ..taxRate3 = taxRate.rate
                      ..taxName3 = taxRate.name)),
                labelText: localization.tax,
                initialTaxName: expense.taxName3,
                initialTaxRate: expense.taxRate3,
              ),
            SizedBox(height: 16),
            expense.isInvoiced
                ? SizedBox()
                : SwitchListTile(
                    activeColor: Theme.of(context).accentColor,
                    title: Text(localization.markBillable),
                    value: expense.shouldBeInvoiced,
                    onChanged: (value) {
                      viewModel.onChanged(
                          expense.rebuild((b) => b..shouldBeInvoiced = value));
                    },
                  ),
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(localization.markPaid),
              value: showPaymentFields,
              onChanged: (value) {
                if (value) {
                  if (expense.paymentDate.isEmpty) {
                    viewModel.onChanged(expense.rebuild(
                        (b) => b..paymentDate = convertDateTimeToSqlDate()));
                  }
                } else {
                  viewModel
                      .onChanged(expense.rebuild((b) => b..paymentDate = ''));
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    _transactionReferenceController.text = '';
                  });
                }
                setState(() => showPaymentFields = value);
              },
            ),
            showPaymentFields
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 8),
                      EntityDropdown(
                        key: ValueKey(
                            '__payment_type_${expense.paymentTypeId}__'),
                        entityType: EntityType.paymentType,
                        entityList:
                            memoizedPaymentTypeList(staticState.paymentTypeMap),
                        labelText: localization.paymentType,
                        entityId: expense.paymentTypeId,
                        onSelected: (paymentType) => viewModel.onChanged(expense
                            .rebuild((b) => b..paymentTypeId = paymentType.id)),
                      ),
                      DatePicker(
                        labelText: localization.date,
                        selectedDate: expense.paymentDate,
                        onSelected: (date) {
                          viewModel.onChanged(
                              expense.rebuild((b) => b..paymentDate = date));
                        },
                      ),
                      DecoratedFormField(
                        controller: _transactionReferenceController,
                        keyboardType: TextInputType.text,
                        label: localization.transactionReference,
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : SizedBox(),
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(localization.convertCurrency),
              value: showConvertCurrencyFields,
              onChanged: (value) {
                setState(() => showConvertCurrencyFields = value);
                if (value) {
                  _setCurrency(
                      staticState.currencyMap[expense.invoiceCurrencyId]);
                } else {
                  viewModel
                      .onChanged(expense.rebuild((b) => b..exchangeRate = 0));
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    _exchangeRateController.text = '';
                  });
                }
              },
            ),
            showConvertCurrencyFields
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 8),
                      EntityDropdown(
                        key: ValueKey(
                            '__invoice_currency_${expense.invoiceCurrencyId}__'),
                        entityType: EntityType.currency,
                        entityList:
                            memoizedCurrencyList(staticState.currencyMap),
                        labelText: localization.currency,
                        entityId: expense.invoiceCurrencyId,
                        onSelected: (SelectableEntity currency) =>
                            _setCurrency(currency),
                      ),
                      DecoratedFormField(
                        key: ValueKey('__${expense.invoiceCurrencyId}__'),
                        controller: _exchangeRateController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        label: localization.exchangeRate,
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : SizedBox(),
            SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.addDocumentsToInvoice),
                value: expense.invoiceDocuments,
                onChanged: (value) {
                  viewModel.onChanged(
                      expense.rebuild((b) => b..invoiceDocuments = value));
                  viewModel.onAddDocumentsChanged(value);
                })
          ],
        ),
      ],
    );
  }
}
