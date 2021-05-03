import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/client_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/discount_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditDetails extends StatefulWidget {
  const InvoiceEditDetails({
    Key key,
    @required this.viewModel,
    this.entityType = EntityType.invoice,
  }) : super(key: key);

  final EntityEditDetailsVM viewModel;
  final EntityType entityType;

  @override
  InvoiceEditDetailsState createState() => InvoiceEditDetailsState();
}

class InvoiceEditDetailsState extends State<InvoiceEditDetails> {
  final _invoiceNumberController = TextEditingController();
  final _poNumberController = TextEditingController();
  final _discountController = TextEditingController();
  final _partialController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();
  final _surcharge1Controller = TextEditingController();
  final _surcharge2Controller = TextEditingController();
  final _surcharge3Controller = TextEditingController();
  final _surcharge4Controller = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _invoiceNumberController,
      _poNumberController,
      _discountController,
      _partialController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
      _surcharge1Controller,
      _surcharge2Controller,
      _surcharge3Controller,
      _surcharge4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice;
    _invoiceNumberController.text = invoice.number;
    _poNumberController.text = invoice.poNumber;
    _discountController.text = formatNumber(invoice.discount, context,
        formatNumberType: FormatNumberType.inputMoney);
    _partialController.text = formatNumber(invoice.partial, context,
        formatNumberType: FormatNumberType.inputMoney);
    _custom1Controller.text = invoice.customValue1;
    _custom2Controller.text = invoice.customValue2;
    _custom3Controller.text = invoice.customValue3;
    _custom4Controller.text = invoice.customValue4;
    _surcharge1Controller.text = formatNumber(invoice.customSurcharge1, context,
        formatNumberType: FormatNumberType.inputMoney);
    _surcharge2Controller.text = formatNumber(invoice.customSurcharge2, context,
        formatNumberType: FormatNumberType.inputMoney);
    _surcharge3Controller.text = formatNumber(invoice.customSurcharge3, context,
        formatNumberType: FormatNumberType.inputMoney);
    _surcharge4Controller.text = formatNumber(invoice.customSurcharge4, context,
        formatNumberType: FormatNumberType.inputMoney);
    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

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
    final invoice = widget.viewModel.invoice.rebuild((b) => b
      ..number = _invoiceNumberController.text.trim()
      ..poNumber = _poNumberController.text.trim()
      ..discount = parseDouble(_discountController.text)
      ..partial = parseDouble(_partialController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim()
      ..customSurcharge1 = parseDouble(_surcharge1Controller.text)
      ..customSurcharge2 = parseDouble(_surcharge2Controller.text)
      ..customSurcharge3 = parseDouble(_surcharge3Controller.text)
      ..customSurcharge4 = parseDouble(_surcharge4Controller.text));
    if (invoice != widget.viewModel.invoice) {
      _debouncer.run(() {
        widget.viewModel.onChanged(invoice);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final invoice = viewModel.invoice;
    final company = viewModel.company;
    final originalInvoice =
        state.getEntity(invoice.entityType, invoice.id) as InvoiceEntity;

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            invoice.isNew
                ? ClientPicker(
                    clientId: invoice.clientId,
                    clientState: state.clientState,
                    onSelected: (client) =>
                        viewModel.onClientChanged(context, invoice, client),
                    onAddPressed: (completer) =>
                        viewModel.onAddClientPressed(context, completer),
                  )
                : DecoratedFormField(
                    controller: _invoiceNumberController,
                    label: widget.entityType == EntityType.credit
                        ? localization.creditNumber
                        : widget.entityType == EntityType.quote
                            ? localization.quoteNumber
                            : localization.invoiceNumber,
                    validator: (String val) => val.trim().isEmpty &&
                            invoice.isOld &&
                            originalInvoice.number.isNotEmpty
                        ? AppLocalization.of(context).pleaseEnterAnInvoiceNumber
                        : null,
                  ),
            UserPicker(
              userId: invoice.assignedUserId,
              onChanged: (userId) => viewModel.onChanged(
                  invoice.rebuild((b) => b..assignedUserId = userId)),
            ),
            if (invoice.isRecurringInvoice) ...[
              AppDropdownButton<String>(
                  labelText: localization.frequency,
                  value: invoice.frequencyId,
                  onChanged: (dynamic value) {
                    viewModel.onChanged(
                        invoice.rebuild((b) => b..frequencyId = value));
                  },
                  items: kFrequencies.entries
                      .map((entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(localization.lookup(entry.value)),
                          ))
                      .toList()),
              DatePicker(
                labelText: (invoice.lastSentDate ?? '').isNotEmpty
                    ? localization.nextSendDate
                    : localization.startDate,
                onSelected: (date) => viewModel
                    .onChanged(invoice.rebuild((b) => b..nextSendDate = date)),
                selectedDate: invoice.nextSendDate,
                firstDate: DateTime.now(),
              ),
              AppDropdownButton<int>(
                showUseDefault: true,
                labelText: localization.remainingCycles,
                value: invoice.remainingCycles,
                blankValue: null,
                onChanged: (dynamic value) => viewModel.onChanged(
                    invoice.rebuild((b) => b..remainingCycles = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.endless),
                    value: -1,
                  ),
                  ...List<int>.generate(37, (i) => i)
                      .map((value) => DropdownMenuItem(
                            child: Text('$value'),
                            value: value,
                          ))
                      .toList()
                ],
              ),
              AppDropdownButton<String>(
                labelText: localization.dueDate,
                value: invoice.dueDateDays ?? '',
                onChanged: (dynamic value) => viewModel
                    .onChanged(invoice.rebuild((b) => b..dueDateDays = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.usePaymentTerms),
                    value: 'terms',
                  ),
                  ...List<int>.generate(31, (i) => i + 1)
                      .map((value) => DropdownMenuItem(
                            child: Text(value == 1
                                ? localization.firstDayOfTheMonth
                                : value == 31
                                    ? localization.lastDayOfTheMonth
                                    : localization.dayCount
                                        .replaceFirst(':count', '$value')),
                            value: '$value',
                          ))
                      .toList()
                ],
              ),
            ] else ...[
              DatePicker(
                validator: (String val) => val.trim().isEmpty
                    ? AppLocalization.of(context).pleaseSelectADate
                    : null,
                labelText: widget.entityType == EntityType.credit
                    ? localization.creditDate
                    : widget.entityType == EntityType.quote
                        ? localization.quoteDate
                        : localization.invoiceDate,
                selectedDate: invoice.date,
                onSelected: (date) {
                  viewModel.onChanged(invoice.rebuild((b) => b..date = date));
                },
              ),
              if (widget.entityType != EntityType.credit)
                DatePicker(
                  labelText: widget.entityType == EntityType.quote
                      ? localization.validUntil
                      : localization.dueDate,
                  selectedDate: invoice.dueDate,
                  onSelected: (date) {
                    viewModel
                        .onChanged(invoice.rebuild((b) => b..dueDate = date));
                  },
                ),
              DecoratedFormField(
                label: localization.partialDeposit,
                controller: _partialController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (String value) {
                  final amount = parseDouble(_partialController.text);
                  final total = invoice.calculateTotal(
                      precision: precisionForInvoice(state, invoice));
                  if (amount < 0 || (amount != 0 && amount > total)) {
                    return localization.partialValue;
                  } else {
                    return null;
                  }
                },
              ),
              if (invoice.partial != null && invoice.partial > 0)
                DatePicker(
                  labelText: localization.partialDueDate,
                  selectedDate: invoice.partialDueDate,
                  onSelected: (date) {
                    viewModel.onChanged(
                        invoice.rebuild((b) => b..partialDueDate = date));
                  },
                ),
            ],
            DecoratedFormField(
              label: localization.poNumber,
              controller: _poNumberController,
            ),
            DiscountField(
              controller: _discountController,
              value: invoice.discount,
              isAmountDiscount: invoice.isAmountDiscount,
              onTypeChanged: (value) => viewModel.onChanged(
                  invoice.rebuild((b) => b..isAmountDiscount = value)),
            ),
            if (invoice.isRecurringInvoice)
              AppDropdownButton<String>(
                  labelText: localization.autoBill,
                  value: invoice.autoBill,
                  onChanged: (dynamic value) => viewModel
                      .onChanged(invoice.rebuild((b) => b..autoBill = value)),
                  items: [
                    SettingsEntity.AUTO_BILL_ALWAYS,
                    SettingsEntity.AUTO_BILL_OPT_OUT,
                    SettingsEntity.AUTO_BILL_OPT_IN,
                    SettingsEntity.AUTO_BILL_OFF,
                  ]
                      .map((value) => DropdownMenuItem(
                            child: Text(localization.lookup(value)),
                            value: value,
                          ))
                      .toList()),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.invoice1,
              value: invoice.customValue1,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.invoice2,
              value: invoice.customValue2,
            ),
            CustomField(
              controller: _custom3Controller,
              field: CustomFieldType.invoice3,
              value: invoice.customValue3,
            ),
            CustomField(
              controller: _custom4Controller,
              field: CustomFieldType.invoice4,
              value: invoice.customValue4,
            ),
            if (company.hasCustomField(CustomFieldType.surcharge1))
              DecoratedFormField(
                label: company.getCustomFieldLabel(CustomFieldType.surcharge1),
                controller: _surcharge1Controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            if (company.hasCustomField(CustomFieldType.surcharge2))
              DecoratedFormField(
                controller: _surcharge2Controller,
                label: company.getCustomFieldLabel(CustomFieldType.surcharge2),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            if (company.hasCustomField(CustomFieldType.surcharge3))
              DecoratedFormField(
                label: company.getCustomFieldLabel(CustomFieldType.surcharge3),
                controller: _surcharge3Controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            if (company.hasCustomField(CustomFieldType.surcharge4))
              DecoratedFormField(
                controller: _surcharge4Controller,
                label: company.getCustomFieldLabel(CustomFieldType.surcharge4),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            if (company.enableFirstInvoiceTaxRate ||
                invoice.taxName1.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) =>
                    viewModel.onChanged(invoice.applyTax(taxRate)),
                labelText: localization.tax,
                initialTaxName: invoice.taxName1,
                initialTaxRate: invoice.taxRate1,
              ),
            if (company.enableSecondInvoiceTaxRate ||
                invoice.taxName2.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) => viewModel
                    .onChanged(invoice.applyTax(taxRate, isSecond: true)),
                labelText: localization.tax,
                initialTaxName: invoice.taxName2,
                initialTaxRate: invoice.taxRate2,
              ),
            if (company.enableThirdInvoiceTaxRate ||
                invoice.taxName3.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) => viewModel
                    .onChanged(invoice.applyTax(taxRate, isThird: true)),
                labelText: localization.tax,
                initialTaxName: invoice.taxName3,
                initialTaxRate: invoice.taxRate3,
              ),
            DesignPicker(
              initialValue: invoice.designId,
              onSelected: (value) => viewModel
                  .onChanged(invoice.rebuild((b) => b..designId = value?.id)),
            ),
            DecoratedFormField(
              key: ValueKey('__exchange_rate_${invoice.clientId}__'),
              label: localization.exchangeRate,
              initialValue: formatNumber(invoice.exchangeRate, context,
                  formatNumberType: FormatNumberType.inputAmount),
              onChanged: (value) => viewModel.onChanged(
                  invoice.rebuild((b) => b..exchangeRate = parseDouble(value))),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ],
    );
  }
}
