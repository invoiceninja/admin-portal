import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuoteEditDetails extends StatefulWidget {
  const QuoteEditDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final QuoteEditDetailsVM viewModel;

  @override
  QuoteEditDetailsState createState() => QuoteEditDetailsState();
}

class QuoteEditDetailsState extends State<QuoteEditDetails> {
  final _quoteNumberController = TextEditingController();
  final _quoteDateController = TextEditingController();
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
      _quoteNumberController,
      _quoteDateController,
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

    final quote = widget.viewModel.quote;
    _quoteNumberController.text = quote.invoiceNumber;
    _quoteDateController.text = quote.invoiceDate;
    _poNumberController.text = quote.poNumber;
    _discountController.text = formatNumber(quote.discount, context,
        formatNumberType: FormatNumberType.input);
    _partialController.text = formatNumber(quote.partial, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = quote.customTextValue1;
    _custom2Controller.text = quote.customTextValue2;
    _surcharge1Controller.text = formatNumber(quote.customValue1, context,
        formatNumberType: FormatNumberType.input);
    _surcharge2Controller.text = formatNumber(quote.customValue2, context,
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
    final quote = widget.viewModel.quote.rebuild((b) => b
      ..invoiceNumber = widget.viewModel.quote.isNew
          ? ''
          : _quoteNumberController.text.trim()
      ..poNumber = _poNumberController.text.trim()
      ..discount = parseDouble(_discountController.text)
      ..partial = parseDouble(_partialController.text)
      ..customTextValue1 = _custom1Controller.text.trim()
      ..customTextValue2 = _custom2Controller.text.trim()
      ..customValue1 = parseDouble(_surcharge1Controller.text)
      ..customValue2 = parseDouble(_surcharge2Controller.text));
    if (quote != widget.viewModel.quote) {
      widget.viewModel.onChanged(quote);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final quote = viewModel.quote;
    final company = viewModel.company;

    return ListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            quote.isNew
                ? EntityDropdown(
                    entityType: EntityType.client,
                    labelText: localization.client,
                    initialValue:
                        viewModel.clientMap[quote.clientId]?.displayName,
                    entityMap: viewModel.clientMap,
                    entityList: memoizedDropdownClientList(
                        viewModel.clientMap, viewModel.clientList),
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseSelectAClient
                        : null,
                    onSelected: (clientId) {
                      viewModel.onChanged(
                          quote.rebuild((b) => b..clientId = clientId));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddClientPressed(context, completer);
                    },
                  )
                : TextFormField(
                    autocorrect: false,
                    controller: _quoteNumberController,
                    decoration: InputDecoration(
                      labelText: localization.quoteNumber,
                    ),
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseEnterAQuoteNumber
                        : null,
                  ),
            DatePicker(
              validator: (String val) => val.trim().isEmpty
                  ? AppLocalization.of(context).pleaseSelectADate
                  : null,
              labelText: localization.quoteDate,
              selectedDate: quote.invoiceDate,
              onSelected: (date) {
                viewModel
                    .onChanged(quote.rebuild((b) => b..invoiceDate = date));
              },
            ),
            DatePicker(
              labelText: localization.dueDate,
              selectedDate: quote.dueDate,
              onSelected: (date) {
                viewModel.onChanged(quote.rebuild((b) => b..dueDate = date));
              },
            ),
            TextFormField(
              controller: _partialController,
              decoration: InputDecoration(
                labelText: localization.partialDeposit,
              ),
              keyboardType: TextInputType.number,
            ),
            quote.partial != null && quote.partial > 0
                ? DatePicker(
                    labelText: localization.partialDueDate,
                    selectedDate: quote.partialDueDate,
                    onSelected: (date) {
                      viewModel.onChanged(
                          quote.rebuild((b) => b..partialDueDate = date));
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
                    value: quote.isAmountDiscount,
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
                        quote.rebuild((b) => b..isAmountDiscount = value)),
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
            company.getCustomFieldLabel(CustomFieldType.surcharge1).isNotEmpty
                ? TextFormField(
                    controller: _surcharge1Controller,
                    decoration: InputDecoration(
                      labelText: company
                          .getCustomFieldLabel(CustomFieldType.surcharge1),
                    ),
                    keyboardType: TextInputType.number,
                  )
                : Container(),
            company.getCustomFieldLabel(CustomFieldType.surcharge2).isNotEmpty
                ? TextFormField(
                    controller: _surcharge2Controller,
                    decoration: InputDecoration(
                      labelText: company
                          .getCustomFieldLabel(CustomFieldType.surcharge2),
                    ),
                    keyboardType: TextInputType.number,
                  )
                : Container(),
            company.enableInvoiceTaxes
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onChanged(quote.applyTax(taxRate)),
                    labelText: localization.tax,
                    initialTaxName: quote.taxName1,
                    initialTaxRate: quote.taxRate1,
                  )
                : Container(),
            company.enableInvoiceTaxes && company.enableSecondTaxRate
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onChanged(quote.applyTax(taxRate)),
                    labelText: localization.tax,
                    initialTaxName: quote.taxName2,
                    initialTaxRate: quote.taxRate2,
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
