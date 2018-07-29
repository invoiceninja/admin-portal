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
  }) : super(key: key);

  final InvoiceEditDetailsVM viewModel;

  @override
  InvoiceEditDetailsState createState() => new InvoiceEditDetailsState();
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
    ];
    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice;
    _invoiceNumberController.text = invoice.invoiceNumber;
    _invoiceDateController.text = invoice.invoiceDate;
    _poNumberController.text = invoice.poNumber;
    _discountController.text = formatNumber(
        invoice.discount, context,
        formatNumberType: FormatNumberType.input);
    _partialController.text = formatNumber(
        invoice.partial, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = invoice.customTextValue1;
    _custom2Controller.text = invoice.customTextValue2;
    _surcharge1Controller.text = formatNumber(
        invoice.customValue1, context,
        formatNumberType: FormatNumberType.input);
    _surcharge2Controller.text = formatNumber(
        invoice.customValue2, context,
        formatNumberType: FormatNumberType.input);

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
      ..discount = double.tryParse(_discountController.text) ?? 0.0
      ..partial = double.tryParse(_partialController.text) ?? 0.0
      ..customTextValue1 = _custom1Controller.text.trim()
      ..customTextValue2 = _custom2Controller.text.trim()
      ..customValue1 = double.tryParse(_surcharge1Controller.text) ?? 0.0
      ..customValue2 = double.tryParse(_surcharge2Controller.text) ?? 0.0
    );
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

    return ListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            invoice.isNew
                ? EntityDropdown(
                    entityType: EntityType.client,
                    labelText: localization.client,
                    initialValue:
                        viewModel.clientMap[invoice.clientId]?.displayName,
                    entityMap: viewModel.clientMap,
                    entityList: memoizedDropdownClientList(
                        viewModel.clientMap, viewModel.clientList),
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseSelectAClient
                        : null,
                    onSelected: (clientId) {
                      viewModel.onChanged(
                          invoice.rebuild((b) => b..clientId = clientId));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddClientPressed(context, completer);
                    },
                  )
                : TextFormField(
                    autocorrect: false,
                    controller: _invoiceNumberController,
                    decoration: InputDecoration(
                      labelText: localization.invoiceNumber,
                    ),
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseEnterAnInvoiceNumber
                        : null,
                  ),
            DatePicker(
              validator: (String val) => val.trim().isEmpty
                  ? AppLocalization.of(context).pleaseSelectADate
                  : null,
              labelText: localization.invoiceDate,
              selectedDate: invoice.invoiceDate,
              onSelected: (date) {
                viewModel
                    .onChanged(invoice.rebuild((b) => b..invoiceDate = date));
              },
            ),
            DatePicker(
              labelText: localization.dueDate,
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
              keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
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
                )
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
            company.getCustomFieldLabel(CustomFieldType.surcharge1).isNotEmpty ? TextFormField(
              controller: _surcharge1Controller,
              decoration: InputDecoration(
                labelText: company.getCustomFieldLabel(CustomFieldType.surcharge1),
              ),
              keyboardType: TextInputType.number,
            ) : Container(),
            company.getCustomFieldLabel(CustomFieldType.surcharge2).isNotEmpty ? TextFormField(
              controller: _surcharge2Controller,
              decoration: InputDecoration(
                labelText: company.getCustomFieldLabel(CustomFieldType.surcharge2),
              ),
              keyboardType: TextInputType.number,
            ) : Container(),
            company.enableInvoiceTaxes
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onChanged(invoice.rebuild((b) => b
                          ..taxRate1 = taxRate.rate
                          ..taxName1 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: invoice.taxName1,
                    initialTaxRate: invoice.taxRate1,
                  )
                : Container(),
            company.enableInvoiceTaxes && company.enableSecondTaxRate
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onChanged(invoice.rebuild((b) => b
                          ..taxRate2 = taxRate.rate
                          ..taxName2 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: invoice.taxName2,
                    initialTaxRate: invoice.taxRate2,
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
