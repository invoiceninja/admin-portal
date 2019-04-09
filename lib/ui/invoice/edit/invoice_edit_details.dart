import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditDetails extends StatefulWidget {
  const InvoiceEditDetails({
    Key key,
    @required this.viewModel,
    this.isQuote = false,
  }) : super(key: key);

  final EntityEditDetailsVM viewModel;
  final bool isQuote;

  @override
  InvoiceEditDetailsState createState() => InvoiceEditDetailsState();
}

class InvoiceEditDetailsState extends State<InvoiceEditDetails> {
  final _invoiceNumberController = TextEditingController();
  final _invoiceDateController = TextEditingController();
  final _poNumberController = TextEditingController();
  final _discountController = TextEditingController();
  final _partialController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _surcharge1Controller = TextEditingController();
  final _surcharge2Controller = TextEditingController();
  final _designController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _invoiceNumberController,
      _invoiceDateController,
      _poNumberController,
      _discountController,
      _partialController,
      _custom1Controller,
      _custom2Controller,
      _surcharge1Controller,
      _surcharge2Controller,
      _designController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice;
    _invoiceNumberController.text = invoice.invoiceNumber;
    _invoiceDateController.text = invoice.invoiceDate;
    _poNumberController.text = invoice.poNumber;
    _discountController.text = formatNumber(invoice.discount, context,
        formatNumberType: FormatNumberType.input);
    _partialController.text = formatNumber(invoice.partial, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = invoice.customTextValue1;
    _custom2Controller.text = invoice.customTextValue2;
    _surcharge1Controller.text = formatNumber(invoice.customValue1, context,
        formatNumberType: FormatNumberType.input);
    _surcharge2Controller.text = formatNumber(invoice.customValue2, context,
        formatNumberType: FormatNumberType.input);
    _designController.text = invoice.designId != null
        ? kInvoiceDesigns.elementAt(invoice.designId - 1)
        : '';
    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

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
    final invoice = widget.viewModel.invoice.rebuild((b) => b
      ..invoiceNumber = widget.viewModel.invoice.isNew
          ? ''
          : _invoiceNumberController.text.trim()
      ..poNumber = _poNumberController.text.trim()
      ..discount = parseDouble(_discountController.text)
      ..partial = parseDouble(_partialController.text)
      ..customTextValue1 = _custom1Controller.text.trim()
      ..customTextValue2 = _custom2Controller.text.trim()
      ..customValue1 = parseDouble(_surcharge1Controller.text)
      ..customValue2 = parseDouble(_surcharge2Controller.text));
    if (invoice != widget.viewModel.invoice) {
      widget.viewModel.onChanged(invoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final company = viewModel.company;

    var designs = new List<String>.from(kInvoiceDesigns);
    if (!(company.hasCustomDesign1 ?? true)) {
      designs.remove(kDesignCustom1);
    }
    if (!(company.hasCustomDesign2 ?? true)) {
      designs.remove(kDesignCustom2);
    }
    if (!(company.hasCustomDesign3 ?? true)) {
      designs.remove(kDesignCustom3);
    }
    if (!company.isProPlan) {
      designs = designs.sublist(0, 4);
    }

    return ListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            invoice.isNew
                ? EntityDropdown(
                    entityType: EntityType.client,
                    labelText: localization.client,
                    initialValue: (viewModel.clientMap[invoice.clientId] ??
                            ClientEntity())
                        .displayName,
                    entityMap: viewModel.clientMap,
                    entityList: memoizedDropdownClientList(
                        viewModel.clientMap, viewModel.clientList),
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseSelectAClient
                        : null,
                    onSelected: (client) {
                      viewModel.onChanged(
                          invoice.rebuild((b) => b..clientId = client.id));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddClientPressed(context, completer);
                    },
                  )
                : TextFormField(
                    autocorrect: false,
                    controller: _invoiceNumberController,
                    decoration: InputDecoration(
                      labelText: widget.isQuote
                          ? localization.quoteNumber
                          : localization.invoiceNumber,
                    ),
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseEnterAnInvoiceNumber
                        : null,
                  ),
            DatePicker(
              validator: (String val) => val.trim().isEmpty
                  ? AppLocalization.of(context).pleaseSelectADate
                  : null,
              labelText: widget.isQuote
                  ? localization.quoteDate
                  : localization.invoiceDate,
              selectedDate: invoice.invoiceDate,
              onSelected: (date) {
                viewModel
                    .onChanged(invoice.rebuild((b) => b..invoiceDate = date));
              },
            ),
            DatePicker(
              labelText: widget.isQuote
                  ? localization.validUntil
                  : localization.dueDate,
              selectedDate: invoice.dueDate,
              onSelected: (date) {
                viewModel.onChanged(invoice.rebuild((b) => b..dueDate = date));
              },
            ),
            TextFormField(
              controller: _partialController,
              decoration: InputDecoration(
                labelText: localization.partialDeposit,
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            invoice.partial != null && invoice.partial > 0
                ? DatePicker(
                    labelText: localization.partialDueDate,
                    selectedDate: invoice.partialDueDate,
                    onSelected: (date) {
                      viewModel.onChanged(
                          invoice.rebuild((b) => b..partialDueDate = date));
                    },
                  )
                : Container(),
            TextFormField(
              autocorrect: false,
              controller: _poNumberController,
              decoration: InputDecoration(
                labelText: localization.poNumber,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _discountController,
                    decoration: InputDecoration(
                      labelText: localization.discount,
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<bool>(
                    value: invoice.isAmountDiscount,
                    items: [
                      DropdownMenuItem<bool>(
                        child: Text(
                          localization.percent,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        value: false,
                      ),
                      DropdownMenuItem<bool>(
                        child: Text(
                          localization.amount,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        value: true,
                      )
                    ],
                    onChanged: (bool value) => viewModel.onChanged(
                        invoice.rebuild((b) => b..isAmountDiscount = value)),
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
            CustomField(
              controller: _custom1Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.invoice1),
              options: company.getCustomFieldValues(CustomFieldType.invoice1),
            ),
            CustomField(
              controller: _custom2Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.invoice2),
              options: company.getCustomFieldValues(CustomFieldType.invoice2),
            ),
            company.getCustomFieldLabel(CustomFieldType.surcharge1).isNotEmpty
                ? TextFormField(
                    controller: _surcharge1Controller,
                    decoration: InputDecoration(
                      labelText: company
                          .getCustomFieldLabel(CustomFieldType.surcharge1),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  )
                : Container(),
            company.getCustomFieldLabel(CustomFieldType.surcharge2).isNotEmpty
                ? TextFormField(
                    controller: _surcharge2Controller,
                    decoration: InputDecoration(
                      labelText: company
                          .getCustomFieldLabel(CustomFieldType.surcharge2),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  )
                : Container(),
            company.enableInvoiceTaxes
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onChanged(invoice.applyTax(taxRate)),
                    labelText: localization.tax,
                    initialTaxName: invoice.taxName1,
                    initialTaxRate: invoice.taxRate1,
                  )
                : Container(),
            company.enableInvoiceTaxes && company.enableSecondTaxRate
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) => viewModel
                        .onChanged(invoice.applyTax(taxRate, isSecond: true)),
                    labelText: localization.tax,
                    initialTaxName: invoice.taxName2,
                    initialTaxRate: invoice.taxRate2,
                  )
                : Container(),
            invoice.designId == null // TODO Remove check in v2
                ? SizedBox()
                : PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    onSelected: (String design) {
                      _designController.text = design;
                      viewModel.onChanged(invoice.rebuild((b) =>
                          b..designId = kInvoiceDesigns.indexOf(design) + 1));
                    },
                    child: InkWell(
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: _designController,
                          decoration: InputDecoration(
                            labelText: localization.design,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (BuildContext context) => designs
                        .map((design) => PopupMenuItem<String>(
                              value: design,
                              child: Text(design),
                            ))
                        .toList()),
          ],
        ),
      ],
    );
  }
}
