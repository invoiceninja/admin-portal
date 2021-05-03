import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
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
        formatNumberType: FormatNumberType.inputAmount);

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
    final viewModel = widget.viewModel;
    final expense = viewModel.expense.rebuild((b) => b
      ..transactionReference = _transactionReferenceController.text.trim()
      ..exchangeRate = parseDouble(_exchangeRateController.text));
    if (expense != viewModel.expense) {
      _debouncer.run(() {
        viewModel.onChanged(expense);
      });
    }
  }

  void _setCurrency(CurrencyEntity currency) {
    final viewModel = widget.viewModel;
    final expense = viewModel.expense;

    final exchangeRate = currency == null
        ? 1
        : getExchangeRate(viewModel.state.staticState.currencyMap,
            fromCurrencyId: expense.currencyId, toCurrencyId: currency.id);

    viewModel.onChanged(expense.rebuild((b) => b
      ..invoiceCurrencyId = currency?.id ?? expense.invoiceCurrencyId
      ..exchangeRate = exchangeRate));
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _exchangeRateController.text = formatNumber(exchangeRate, context,
          formatNumberType: FormatNumberType.inputAmount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final staticState = viewModel.state.staticState;
    final company = viewModel.company;
    final expense = viewModel.expense;

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            expense.isInvoiced
                ? SizedBox()
                : SwitchListTile(
                    activeColor: Theme.of(context).accentColor,
                    title: Text(localization.shouldBeInvoiced),
                    subtitle: Text(localization.shouldBeInvoicedHelp),
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
              subtitle: Text(localization.markPaidHelp),
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
                        onSelected: (paymentType) => viewModel.onChanged(
                            expense.rebuild((b) =>
                                b..paymentTypeId = paymentType?.id ?? '')),
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
                        onSavePressed: viewModel.onSavePressed,
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : SizedBox(),
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(localization.convertCurrency),
              subtitle: Text(localization.convertCurrencyHelp),
              value: showConvertCurrencyFields,
              onChanged: (value) {
                setState(() => showConvertCurrencyFields = value);
                if (value) {
                  _setCurrency(
                      staticState.currencyMap[expense.invoiceCurrencyId]);
                } else {
                  viewModel
                      .onChanged(expense.rebuild((b) => b..exchangeRate = 1));
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
                subtitle: Text(localization.addDocumentsToInvoiceHelp),
                value: expense.invoiceDocuments,
                onChanged: (value) {
                  viewModel.onChanged(
                      expense.rebuild((b) => b..invoiceDocuments = value));
                })
          ],
        ),
        if (company.numberOfItemTaxRates > 0)
          FormCard(
            children: [
              BoolDropdownButton(
                label: localization.enterTaxes,
                enabledLabel: localization.byAmount,
                disabledLabel: localization.byRate,
                value: expense.calculateTaxByAmount ?? false,
                onChanged: (value) => viewModel.onChanged(
                    expense.rebuild((b) => b..calculateTaxByAmount = value)),
              ),
              SizedBox(height: 16),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.inclusiveTaxes),
                value: expense.usesInclusiveTaxes,
                subtitle: Text(
                    '\n${localization.exclusive}: 100 + 10% = 100 + 10\n${localization.inclusive}: 100 + 10% = 90.91 + 9.09'),
                onChanged: (value) => viewModel.onChanged(
                    expense.rebuild((b) => b..usesInclusiveTaxes = value)),
              ),
            ],
          ),
      ],
    );
  }
}
