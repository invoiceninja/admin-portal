import 'package:invoiceninja_flutter/ui/app/forms/client_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/discount_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
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
        formatNumberType: FormatNumberType.input);
    _partialController.text = formatNumber(invoice.partial, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = invoice.customValue1;
    _custom2Controller.text = invoice.customValue2;
    _surcharge1Controller.text = formatNumber(invoice.customSurcharge1, context,
        formatNumberType: FormatNumberType.input);
    _surcharge2Controller.text = formatNumber(invoice.customSurcharge2, context,
        formatNumberType: FormatNumberType.input);
    _surcharge3Controller.text = formatNumber(invoice.customSurcharge3, context,
        formatNumberType: FormatNumberType.input);
    _surcharge4Controller.text = formatNumber(invoice.customSurcharge4, context,
        formatNumberType: FormatNumberType.input);
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
    _debouncer.run(() {
      final invoice = widget.viewModel.invoice.rebuild((b) => b
        ..number = _invoiceNumberController.text.trim()
        ..poNumber = _poNumberController.text.trim()
        ..discount = parseDouble(_discountController.text)
        ..partial = parseDouble(_partialController.text)
        ..customValue1 = _custom1Controller.text.trim()
        ..customValue2 = _custom2Controller.text.trim()
        ..customSurcharge1 = parseDouble(_surcharge1Controller.text)
        ..customSurcharge2 = parseDouble(_surcharge2Controller.text)
        ..customSurcharge3 = parseDouble(_surcharge3Controller.text)
        ..customSurcharge4 = parseDouble(_surcharge4Controller.text));
      if (invoice != widget.viewModel.invoice) {
        widget.viewModel.onChanged(invoice);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final company = viewModel.company;

    return ListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            invoice.isNew
                ? ClientPicker(
                    clientId: invoice.clientId,
                    clientState: viewModel.state.clientState,
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
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseEnterAnInvoiceNumber
                        : null,
                  ),
            UserPicker(
              userId: invoice.assignedUserId,
              onChanged: (userId) => viewModel.onChanged(
                  invoice.rebuild((b) => b..assignedUserId = userId)),
            ),
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
            if (company.enableFirstInvoiceTaxRate)
              TaxRateDropdown(
                onSelected: (taxRate) =>
                    viewModel.onChanged(invoice.applyTax(taxRate)),
                labelText: localization.tax,
                initialTaxName: invoice.taxName1,
                initialTaxRate: invoice.taxRate1,
              ),
            if (company.enableSecondInvoiceTaxRate)
              TaxRateDropdown(
                onSelected: (taxRate) => viewModel
                    .onChanged(invoice.applyTax(taxRate, isSecond: true)),
                labelText: localization.tax,
                initialTaxName: invoice.taxName2,
                initialTaxRate: invoice.taxRate2,
              ),
            if (company.enableThirdInvoiceTaxRate)
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
                  formatNumberType: FormatNumberType.input),
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
