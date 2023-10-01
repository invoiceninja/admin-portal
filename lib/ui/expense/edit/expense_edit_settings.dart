// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/money.dart';

class ExpenseEditSettings extends StatefulWidget {
  const ExpenseEditSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AbstractExpenseEditVM viewModel;

  @override
  ExpenseEditSettingsState createState() => ExpenseEditSettingsState();
}

class ExpenseEditSettingsState extends State<ExpenseEditSettings> {
  bool _showPaymentFields = false;
  bool _showConvertCurrencyFields = false;
  double? _convertedAmount = 0;

  final _transactionReferenceController = TextEditingController();
  final _exchangeRateController = TextEditingController();

  late List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _transactionReferenceController,
      _exchangeRateController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense!;
    _transactionReferenceController.text = expense.transactionReference;
    _exchangeRateController.text = formatNumber(expense.exchangeRate, context,
        formatNumberType: FormatNumberType.inputAmount)!;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    _showPaymentFields = expense.paymentDate.isNotEmpty;
    _showConvertCurrencyFields =
        expense.exchangeRate != 0 && expense.exchangeRate != 1;

    final state = widget.viewModel.state!;
    if (state.company.convertExpenseCurrency) {
      _showConvertCurrencyFields = true;
    }

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
    final expense = viewModel.expense!.rebuild((b) => b
      ..transactionReference = _transactionReferenceController.text.trim()
      ..exchangeRate = parseDouble(_exchangeRateController.text));
    if (expense != viewModel.expense) {
      _debouncer.run(() {
        viewModel.onChanged!(expense);
      });
    }
  }

  void _setCurrency(CurrencyEntity? currency) {
    final viewModel = widget.viewModel;
    final expense = viewModel.expense!;

    final exchangeRate = currency == null
        ? 1.0
        : getExchangeRate(viewModel.state!.staticState.currencyMap,
            fromCurrencyId: expense.currencyId, toCurrencyId: currency.id);

    viewModel.onChanged!(expense.rebuild((b) => b
      ..invoiceCurrencyId = currency?.id ?? ''
      ..exchangeRate = exchangeRate));

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _exchangeRateController.removeListener(_onChanged);
      _exchangeRateController.text = formatNumber(exchangeRate, context,
          formatNumberType: FormatNumberType.inputAmount)!;
      _exchangeRateController.addListener(_onChanged);
    });
  }

  void _calculateExchangeRate() {
    if (_convertedAmount == 0) {
      return;
    }

    final viewModel = widget.viewModel;
    final expense = viewModel.expense!;
    final amount = expense.grossAmount;
    final exchangeRate = _convertedAmount! / amount;

    _exchangeRateController.removeListener(_onChanged);
    _exchangeRateController.text = formatNumber(exchangeRate, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _exchangeRateController.addListener(_onChanged);

    viewModel
        .onChanged!(expense.rebuild((b) => b..exchangeRate = exchangeRate));
    _convertedAmount = 0;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final staticState = viewModel.state!.staticState;
    final company = viewModel.state!.company;
    final expense = viewModel.expense!;
    final state = widget.viewModel.state!;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.expense);

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          padding: isFullscreen
              ? const EdgeInsets.only(
                  left: kMobileDialogPadding / 2,
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding,
                )
              : null,
          children: <Widget>[
            expense.isInvoiced
                ? SizedBox()
                : SwitchListTile(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    title: Text(localization.shouldBeInvoiced),
                    subtitle: Text(localization.shouldBeInvoicedHelp),
                    value: expense.shouldBeInvoiced,
                    onChanged: (value) {
                      viewModel.onChanged!(
                          expense.rebuild((b) => b..shouldBeInvoiced = value));
                    },
                  ),
            SwitchListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              title: Text(localization.markPaid),
              value: _showPaymentFields,
              subtitle: Text(localization.markPaidHelp),
              onChanged: (value) {
                if (value) {
                  if (expense.paymentDate.isEmpty) {
                    viewModel.onChanged!(expense.rebuild(
                        (b) => b..paymentDate = convertDateTimeToSqlDate()));
                  }
                } else {
                  viewModel
                      .onChanged!(expense.rebuild((b) => b..paymentDate = ''));
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    _transactionReferenceController.text = '';
                  });
                }
                setState(() => _showPaymentFields = value);
              },
            ),
            _showPaymentFields
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 8),
                      EntityDropdown(
                        entityType: EntityType.paymentType,
                        entityList:
                            memoizedPaymentTypeList(staticState.paymentTypeMap),
                        labelText: localization.paymentType,
                        entityId: expense.paymentTypeId,
                        onSelected: (paymentType) => viewModel.onChanged!(
                            expense.rebuild((b) =>
                                b..paymentTypeId = paymentType?.id ?? '')),
                      ),
                      if (!expense.isRecurring)
                        DatePicker(
                          labelText: localization.date,
                          selectedDate: expense.paymentDate,
                          onSelected: (date, _) {
                            viewModel.onChanged!(
                                expense.rebuild((b) => b..paymentDate = date));
                          },
                        ),
                      DecoratedFormField(
                        controller: _transactionReferenceController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        label: localization.transactionReference,
                        onSavePressed: viewModel.onSavePressed,
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : SizedBox(),
            SwitchListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              title: Text(localization.convertCurrency),
              subtitle: Text(localization.convertCurrencyHelp),
              value: _showConvertCurrencyFields,
              onChanged: (value) {
                setState(() => _showConvertCurrencyFields = value);
                if (value) {
                  _setCurrency(
                      staticState.currencyMap[expense.invoiceCurrencyId]);
                } else {
                  viewModel
                      .onChanged!(expense.rebuild((b) => b..exchangeRate = 1));
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    _exchangeRateController.text = '';
                  });
                }
              },
            ),
            if (_showConvertCurrencyFields) ...[
              SizedBox(height: 8),
              EntityDropdown(
                entityType: EntityType.currency,
                entityList: memoizedCurrencyList(staticState.currencyMap),
                labelText: localization.currency,
                entityId: expense.invoiceCurrencyId,
                onSelected: (SelectableEntity? currency) =>
                    _setCurrency(currency as CurrencyEntity?),
              ),
              DecoratedFormField(
                key: ValueKey('__rate_${expense.invoiceCurrencyId}__'),
                controller: _exchangeRateController,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                label: localization.exchangeRate,
                isPercent: true,
              ),
              Focus(
                onFocusChange: (hasFocus) => _calculateExchangeRate(),
                child: DecoratedFormField(
                  key: ValueKey(
                      '__expense_amount_${expense.grossAmount}_${expense.exchangeRate}__'),
                  initialValue: expense.exchangeRate != 1 &&
                          expense.exchangeRate != 0
                      ? formatNumber(
                          expense.grossAmount * expense.exchangeRate, context,
                          formatNumberType: FormatNumberType.inputMoney)
                      : '',
                  label: localization.convertedAmount,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  isMoney: true,
                  onChanged: (value) {
                    _convertedAmount = parseDouble(value);
                  },
                  onSavePressed: (context) {
                    _calculateExchangeRate();
                    viewModel.onSavePressed!(context);
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
            SwitchListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: Text(localization.addDocumentsToInvoice),
                subtitle: Text(localization.addDocumentsToInvoiceHelp),
                value: expense.invoiceDocuments,
                onChanged: (value) {
                  viewModel.onChanged!(
                      expense.rebuild((b) => b..invoiceDocuments = value));
                })
          ],
        ),
        FormCard(
          padding: isFullscreen
              ? const EdgeInsets.only(
                  left: kMobileDialogPadding / 2,
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding,
                )
              : null,
          children: company.numberOfExpenseTaxRates == 0
              ? [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(localization.expenseTaxHelp)),
                      OutlinedButton(
                          onPressed: () {
                            final store = StoreProvider.of<AppState>(context);
                            store.dispatch(
                                ViewSettings(section: kSettingsTaxSettings));
                          },
                          child: Text(localization.settings))
                    ],
                  )
                ]
              : [
                  BoolDropdownButton(
                    label: localization.enterTaxes,
                    enabledLabel: localization.byAmount,
                    disabledLabel: localization.byRate,
                    value: expense.calculateTaxByAmount ?? false,
                    onChanged: (value) => viewModel.onChanged!(expense
                        .rebuild((b) => b..calculateTaxByAmount = value)),
                    minWidth: 80,
                  ),
                  SizedBox(height: 16),
                  SwitchListTile(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    title: Text(localization.inclusiveTaxes),
                    value: expense.usesInclusiveTaxes,
                    subtitle: Text(
                        '\n${localization.exclusive}: 100 + 10% = 100 + 10\n${localization.inclusive}: 100 + 10% = 90.91 + 9.09'),
                    onChanged: (value) => viewModel.onChanged!(
                        expense.rebuild((b) => b..usesInclusiveTaxes = value)),
                  ),
                ],
        ),
      ],
    );
  }
}
