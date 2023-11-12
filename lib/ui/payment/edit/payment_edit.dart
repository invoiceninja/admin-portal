// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_footer.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/money.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class PaymentEdit extends StatefulWidget {
  const PaymentEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PaymentEditVM viewModel;

  @override
  _PaymentEditState createState() => _PaymentEditState();
}

class _PaymentEditState extends State<PaymentEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_paymentEdit');

  final _amountController = TextEditingController();
  final _numberController = TextEditingController();
  final _transactionReferenceController = TextEditingController();
  final _privateNotesController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();
  final _exchangeRateController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  bool _showConvertCurrency = false;
  double? _convertedAmount = 0;

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
      _numberController,
      _transactionReferenceController,
      _privateNotesController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
      _exchangeRateController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final payment = widget.viewModel.payment;

    _showConvertCurrency =
        payment.exchangeRate != 1 && payment.exchangeRate != 0;
    final state = widget.viewModel.state;
    if (state.company.convertPaymentCurrency) {
      _showConvertCurrency = true;
    }

    _amountController.text = formatNumber(payment.amount, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _numberController.text = payment.number;
    _transactionReferenceController.text = payment.transactionReference;
    _privateNotesController.text = payment.privateNotes;
    _custom1Controller.text = payment.customValue1;
    _custom2Controller.text = payment.customValue2;
    _custom3Controller.text = payment.customValue3;
    _custom4Controller.text = payment.customValue4;
    _exchangeRateController.text = formatNumber(payment.exchangeRate, context,
        formatNumberType: FormatNumberType.inputMoney)!;

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
    final payment = widget.viewModel.payment.rebuild((b) => b
      ..amount = parseDouble(_amountController.text)
      ..number = _numberController.text.trim()
      ..transactionReference = _transactionReferenceController.text.trim()
      ..privateNotes = _privateNotesController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim()
      ..exchangeRate = parseDouble(_exchangeRateController.text));
    if (payment != widget.viewModel.payment) {
      _debouncer.run(() {
        widget.viewModel.onChanged(payment);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  void convertCurrency(SelectableEntity? currency) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final state = viewModel.state;
    double exchangeRate = 1;
    if (currency != null) {
      final client = state.clientState.get(payment.clientId);
      exchangeRate = getExchangeRate(state.staticState.currencyMap,
          fromCurrencyId: client.currencyId, toCurrencyId: currency.id);
    }

    _exchangeRateController.removeListener(_onChanged);
    _exchangeRateController.text = formatNumber(exchangeRate, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _exchangeRateController.addListener(_onChanged);

    viewModel.onChanged(payment.rebuild((b) => b
      ..exchangeCurrencyId = currency?.id ?? ''
      ..exchangeRate = exchangeRate));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final state = viewModel.state;
    final localization = AppLocalization.of(context)!;

    final invoicePaymentables = payment.invoices.toList();
    if (invoicePaymentables
        .where((paymentable) => paymentable.isEmpty)
        .isEmpty) {
      invoicePaymentables.add(PaymentableEntity());
    }

    final creditPaymentables = payment.credits.toList();
    if (creditPaymentables
        .where((paymentable) => paymentable.isEmpty)
        .isEmpty) {
      creditPaymentables.add(PaymentableEntity());
    }

    double paymentTotal = 0;
    double creditTotal = 0;
    invoicePaymentables.forEach((invoice) {
      paymentTotal += invoice.amount;
    });
    creditPaymentables.forEach((credit) {
      creditTotal += credit.amount;
    });

    double? limit;
    if (payment.amount != 0) {
      limit = payment.amount - payment.applied - paymentTotal;
    } else if (creditTotal != 0) {
      limit = creditTotal - paymentTotal;
    }

    final body = Form(
      key: _formKey,
      child: Column(
        key: ValueKey('__payment_${payment.id}_${payment.updatedAt}__'),
        children: <Widget>[
          FormCard(
            children: <Widget>[
              if (payment.isNew) ...[
                EntityDropdown(
                  autofocus: true,
                  entityType: EntityType.client,
                  labelText: AppLocalization.of(context)!.client,
                  entityId: payment.clientId,
                  validator: (String? val) => (val ?? '').trim().isEmpty
                      ? AppLocalization.of(context)!.pleaseSelectAClient
                      : null,
                  onSelected: (client) {
                    viewModel.onChanged(payment.rebuild(
                      (b) => b
                        ..clientId = client?.id ?? ''
                        ..credits.clear()
                        ..invoices.clear(),
                    ));
                  },
                  entityList: memoizedDropdownClientList(
                      state.clientState.map,
                      state.clientState.list,
                      state.userState.map,
                      state.staticState),
                ),
                if (state.company.enableApplyingPayments)
                  DecoratedFormField(
                    controller: _amountController,
                    autocorrect: false,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    label: localization.amount,
                    onSavePressed: _onSavePressed,
                  ),
              ] else
                DecoratedFormField(
                  controller: _numberController,
                  label: localization.paymentNumber,
                  onSavePressed: (context) => _onSavePressed,
                  validator: (value) =>
                      value.isEmpty ? localization.pleaseEnterAValue : null,
                  keyboardType: TextInputType.text,
                ),
              if (payment.isNew || payment.isApplying == true)
                for (var index = 0; index < invoicePaymentables.length; index++)
                  PaymentableEditor(
                    key: ValueKey(
                        '__invoice_paymentable_${index}_${invoicePaymentables[index].invoiceId}__'),
                    viewModel: viewModel,
                    paymentable: invoicePaymentables[index],
                    index: index,
                    entityType: EntityType.invoice,
                    limit: limit,
                    onSavePressed: _onSavePressed,
                  ),
              if (payment.isApplying != true)
                DatePicker(
                  validator: (String val) => val.trim().isEmpty
                      ? AppLocalization.of(context)!.pleaseSelectADate
                      : null,
                  labelText: localization.paymentDate,
                  selectedDate: payment.date,
                  onSelected: (date, _) {
                    viewModel.onChanged(payment.rebuild((b) => b..date = date));
                  },
                ),
              if (payment.isApplying != true)
                EntityDropdown(
                  entityType: EntityType.paymentType,
                  entityList: memoizedPaymentTypeList(
                      viewModel.staticState.paymentTypeMap),
                  labelText: localization.paymentType,
                  entityId: payment.typeId,
                  onSelected: (paymentType) => viewModel.onChanged(payment
                      .rebuild((b) => b..typeId = paymentType?.id ?? '')),
                ),
              if (payment.isNew || payment.isApplying == true)
                if (state.company.isModuleEnabled(EntityType.credit))
                  for (var index = 0;
                      index < creditPaymentables.length;
                      index++)
                    PaymentableEditor(
                      key: ValueKey(
                          '__credit_paymentable_${index}_${creditPaymentables[index].creditId}__'),
                      viewModel: viewModel,
                      paymentable: creditPaymentables[index],
                      index: index,
                      entityType: EntityType.credit,
                      limit: 0,
                      onSavePressed: _onSavePressed,
                    ),
              if (payment.isApplying != true)
                DecoratedFormField(
                  controller: _transactionReferenceController,
                  label: localization.transactionReference,
                  onSavePressed: _onSavePressed,
                  keyboardType: TextInputType.text,
                ),
              CustomField(
                controller: _custom1Controller,
                field: CustomFieldType.payment1,
                value: payment.customValue1,
                onSavePressed: _onSavePressed,
              ),
              CustomField(
                controller: _custom2Controller,
                field: CustomFieldType.payment2,
                value: payment.customValue2,
                onSavePressed: _onSavePressed,
              ),
              CustomField(
                controller: _custom3Controller,
                field: CustomFieldType.payment3,
                value: payment.customValue3,
                onSavePressed: _onSavePressed,
              ),
              CustomField(
                controller: _custom4Controller,
                field: CustomFieldType.payment4,
                value: payment.customValue4,
                onSavePressed: _onSavePressed,
              ),
              if (payment.isApplying != true)
                DecoratedFormField(
                  controller: _privateNotesController,
                  label: localization.privateNotes,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                ),
            ],
          ),
          FormCard(
            isLast: true,
            children: [
              if (payment.isNew)
                SwitchListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.sendEmail),
                  value: payment.sendEmail ?? false,
                  subtitle: Text(localization.emailReceipt),
                  onChanged: (value) => viewModel
                      .onChanged(payment.rebuild((b) => b..sendEmail = value)),
                ),
              SwitchListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: Text(localization.convertCurrency),
                value: _showConvertCurrency,
                onChanged: (value) {
                  if (!value) {
                    _exchangeRateController.removeListener(_onChanged);
                    _exchangeRateController.text = '';
                    _exchangeRateController.addListener(_onChanged);

                    viewModel.onChanged(payment.rebuild((b) => b
                      ..exchangeCurrencyId = ''
                      ..exchangeRate = 1));
                  } else {
                    final currency = state
                        .staticState.currencyMap[payment.exchangeCurrencyId];
                    convertCurrency(currency);
                  }
                  setState(() {
                    _showConvertCurrency = value;
                  });
                },
              ),
              if (_showConvertCurrency) ...[
                EntityDropdown(
                  entityType: EntityType.currency,
                  entityList:
                      memoizedCurrencyList(viewModel.staticState.currencyMap),
                  labelText: localization.currency,
                  entityId: payment.exchangeCurrencyId,
                  onSelected: (SelectableEntity? currency) =>
                      convertCurrency(currency),
                ),
                DecoratedFormField(
                  key: ValueKey(
                      '__payment_amount_${payment.exchangeCurrencyId}__'),
                  controller: _exchangeRateController,
                  label: localization.exchangeRate,
                  onSavePressed: _onSavePressed,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (_convertedAmount == 0) {
                      return;
                    }

                    final amount = payment.isNew
                        ? (paymentTotal - creditTotal)
                        : payment.amount;
                    final exchangeRate = _convertedAmount! / amount;
                    _exchangeRateController.removeListener(_onChanged);
                    _exchangeRateController.text = formatNumber(
                        exchangeRate, context,
                        formatNumberType: FormatNumberType.inputMoney)!;
                    _exchangeRateController.addListener(_onChanged);

                    viewModel.onChanged(
                        payment.rebuild((b) => b..exchangeRate = exchangeRate));
                    _convertedAmount = 0;
                  },
                  child: DecoratedFormField(
                    key: ValueKey(
                        '__payment_amount_${paymentTotal}_${creditTotal}_${payment.exchangeRate}__'),
                    initialValue:
                        payment.exchangeRate != 1 && payment.exchangeRate != 0
                            ? formatNumber(
                                (payment.isNew
                                        ? paymentTotal - creditTotal
                                        : payment.amount) *
                                    payment.exchangeRate,
                                context,
                                formatNumberType: FormatNumberType.inputMoney)
                            : '',
                    label: localization.convertedAmount,
                    onChanged: (value) {
                      _convertedAmount = parseDouble(value);
                    },
                    onSavePressed: _onSavePressed,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                  ),
                ),
              ],
            ],
          )
        ],
      ),
    );

    if (payment.isApplying == true && isDesktop(context)) {
      return AlertDialog(
          backgroundColor: Theme.of(context).canvasColor,
          contentPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.only(right: 4),
          title: Text(localization.applyPayment),
          content: SingleChildScrollView(
            child: SizedBox(
              child: body,
              width: kDialogWidth,
            ),
          ),
          actions: <Widget>[
            if (viewModel.state.isSaving)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 30,
                  width: 30,
                ),
              )
            else ...[
              TextButton(
                child: Text(localization.cancel.toUpperCase()),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(localization.apply.toUpperCase()),
                onPressed: () => _onSavePressed(context),
              ),
            ],
          ]);
    } else {
      return EditScaffold(
        entity: payment,
        title: viewModel.payment.isNew
            ? localization.enterPayment
            : payment.isApplying == true
                ? localization.applyPayment
                : localization.editPayment,
        onCancelPressed: (context) => viewModel.onCancelPressed(context),
        onSavePressed: _onSavePressed,
        body: ScrollableListView(
          children: [body],
        ),
        bottomNavigationBar: PaymentEditFooter(
          payment: payment,
        ),
      );
    }
  }
}

class PaymentableEditor extends StatefulWidget {
  const PaymentableEditor({
    Key? key,
    required this.viewModel,
    required this.paymentable,
    required this.index,
    required this.entityType,
    required this.limit,
    required this.onSavePressed,
  }) : super(key: key);

  final PaymentEditVM viewModel;
  final PaymentableEntity paymentable;
  final int index;
  final EntityType entityType;
  final double? limit;
  final Function(BuildContext) onSavePressed;

  @override
  _PaymentableEditorState createState() => _PaymentableEditorState();
}

class _PaymentableEditorState extends State<PaymentableEditor> {
  final _amountController = TextEditingController();
  String? _invoiceId;
  String? _creditId;
  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final paymentable = widget.paymentable;
    _amountController.text = formatNumber(paymentable.amount, context,
            formatNumberType: FormatNumberType.inputMoney) ??
        '0';
    if (paymentable.entityType == EntityType.invoice) {
      _invoiceId = paymentable.invoiceId;
    } else {
      _creditId = paymentable.creditId;
    }

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

  void _onChanged([String? clientId]) {
    PaymentableEntity paymentable;
    if (widget.entityType == EntityType.invoice) {
      paymentable = widget.paymentable.rebuild((b) => b
        ..invoiceId = _invoiceId ?? widget.paymentable.invoiceId
        ..amount = parseDouble(_amountController.text));
    } else {
      paymentable = widget.paymentable.rebuild((b) => b
        ..creditId = _creditId ?? widget.paymentable.creditId
        ..amount = parseDouble(_amountController.text));
    }

    if (paymentable == widget.paymentable || paymentable.isEmpty) {
      return;
    }

    PaymentEntity payment;

    if (widget.entityType == EntityType.invoice) {
      if (widget.index == widget.viewModel.payment.invoices.length) {
        payment = widget.viewModel.payment
            .rebuild((b) => b..invoices.add(paymentable));
      } else {
        payment = widget.viewModel.payment
            .rebuild((b) => b..invoices[widget.index] = paymentable);
      }
    } else {
      if (widget.index == widget.viewModel.payment.credits.length) {
        payment = widget.viewModel.payment
            .rebuild((b) => b..credits.add(paymentable));
      } else {
        payment = widget.viewModel.payment
            .rebuild((b) => b..credits[widget.index] = paymentable);
      }
    }

    if (clientId != null) {
      payment = payment.rebuild((b) => b..clientId = clientId);
    }

    widget.viewModel.onChanged(payment);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final payment = viewModel.payment;
    final paymentable = widget.paymentable;
    final localization = AppLocalization.of(context);

    final paymentList = memoizedDropdownInvoiceList(
      state.invoiceState.map,
      state.clientState.map,
      state.vendorState.map,
      state.invoiceState.list,
      payment.clientId,
      state.userState.map,
      payment.invoices.map((p) => p.invoiceId).toList(),
      state.company.settings.recurringNumberPrefix,
    );

    final creditList = memoizedDropdownCreditList(
        state.creditState.map,
        state.clientState.map,
        state.vendorState.map,
        state.creditState.list,
        payment.clientId,
        state.userState.map,
        payment.credits.map((p) => p.creditId).toList());

    // If a client isn't selected or a client is selected but the client
    // doesn't have any more credits then don't show the picker
    if (widget.entityType == EntityType.credit &&
        (payment.clientId.isEmpty ||
            (creditList.isEmpty && (paymentable.creditId ?? '').isEmpty))) {
      return SizedBox();
    } else if (widget.entityType == EntityType.invoice &&
        paymentList.isEmpty &&
        (paymentable.invoiceId ?? '').isEmpty) {
      return SizedBox();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.entityType == EntityType.invoice)
          Expanded(
            child: EntityDropdown(
              allowClearing: false,
              entityType: EntityType.invoice,
              labelText: AppLocalization.of(context)!.invoice,
              entityId: paymentable.invoiceId,
              entityList: paymentList,
              overrideSuggestedLabel: (entity) {
                if (entity == null) {
                  return '';
                } else {
                  return entity.listDisplayName.isEmpty
                      ? localization!.pending
                      : entity.listDisplayName;
                }
              },
              overrideSuggestedAmount: (entity) {
                return formatNumber(entity.listDisplayAmount, context,
                    clientId: (entity as InvoiceEntity).clientId);
              },
              onSelected: (selected) {
                final invoice = selected as InvoiceEntity;
                final amount = widget.limit != null
                    ? min(widget.limit!, invoice.balanceOrAmount)
                    : invoice.balanceOrAmount;
                _amountController.text = formatNumber(amount, context,
                        formatNumberType: FormatNumberType.inputMoney) ??
                    '0';
                _invoiceId = invoice.id;
                _onChanged(invoice.clientId);
              },
            ),
          ),
        if (widget.entityType == EntityType.credit)
          Expanded(
            child: EntityDropdown(
              allowClearing: false,
              entityType: EntityType.credit,
              labelText: AppLocalization.of(context)!.credit,
              entityId: paymentable.creditId,
              entityList: creditList,
              overrideSuggestedLabel: (entity) {
                if (entity == null) {
                  return '';
                } else {
                  return entity.listDisplayName.isEmpty
                      ? localization!.pending
                      : entity.listDisplayName;
                }
              },
              overrideSuggestedAmount: (entity) {
                return formatNumber(entity.listDisplayAmount, context,
                    clientId: (entity as InvoiceEntity).clientId);
              },
              onSelected: (selected) {
                final credit = selected as InvoiceEntity;
                _amountController.text = formatNumber(
                        credit.balanceOrAmount, context,
                        formatNumberType: FormatNumberType.inputMoney) ??
                    '0';
                _creditId = credit.id;
                _onChanged(credit.clientId);
              },
            ),
          ),
        if ((_creditId ?? '').isNotEmpty || (_invoiceId ?? '').isNotEmpty) ...[
          SizedBox(
            width: kTableColumnGap,
          ),
          Expanded(
            child: DecoratedFormField(
                showClear: false,
                controller: _amountController,
                autocorrect: false,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                label: widget.entityType == EntityType.invoice
                    ? localization!.amount
                    : localization!.applied,
                onSavePressed: widget.onSavePressed),
          ),
        ],
        if ((widget.entityType == EntityType.invoice &&
                payment.invoices.isNotEmpty &&
                _invoiceId != null) ||
            (widget.entityType == EntityType.credit &&
                payment.credits.isNotEmpty &&
                _creditId != null)) ...[
          SizedBox(
            width: kTableColumnGap,
          ),
          IconButton(
            icon: Icon(Icons.clear, color: Colors.grey),
            tooltip: localization!.remove,
            onPressed: paymentable.isEmpty
                ? null
                : () {
                    if (widget.entityType == EntityType.invoice) {
                      viewModel.onChanged(payment
                          .rebuild((b) => b..invoices.removeAt(widget.index)));
                    } else {
                      viewModel.onChanged(payment
                          .rebuild((b) => b..credits.removeAt(widget.index)));
                    }
                  },
          ),
        ],
      ],
    );
  }
}
