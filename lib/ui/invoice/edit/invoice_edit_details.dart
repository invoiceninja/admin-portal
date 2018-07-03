import 'package:invoiceninja/redux/client/client_selectors.dart';
import 'package:invoiceninja/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/ui/app/entity_dropdown.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/app/forms/date_picker.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

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

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _invoiceNumberController,
      _invoiceDateController,
      _poNumberController,
      _discountController,
      _partialController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice;
    _invoiceNumberController.text = invoice.invoiceNumber;
    _invoiceDateController.text = invoice.invoiceDate;
    _poNumberController.text = invoice.poNumber;
    _discountController.text = formatNumber(
        invoice.discount, widget.viewModel.state,
        formatNumberType: FormatNumberType.input);
    _partialController.text = formatNumber(
        invoice.partial, widget.viewModel.state,
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
      ..partial = double.tryParse(_partialController.text) ?? 0.0);
    if (invoice != widget.viewModel.invoice) {
      widget.viewModel.onChanged(invoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final company = viewModel.state.selectedCompany;

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
                  )
                : TextFormField(
                    autocorrect: false,
                    controller: _invoiceNumberController,
                    decoration: InputDecoration(
                      labelText: localization.invoiceNumber,
                    ),
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
              autocorrect: false,
              controller: _partialController,
              decoration: InputDecoration(
                labelText: localization.partial,
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
                    autocorrect: false,
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
            company.enableInvoiceTaxes ? TaxRateDropdown(
              onSelected: (taxRate) =>
                  viewModel.onChanged(invoice.rebuild((b) => b
                    ..taxRate1 = taxRate.rate
                    ..taxName1 = taxRate.name)),
              labelText: localization.tax,
              state: viewModel.state,
              initialTaxName: invoice.taxName1,
              initialTaxRate: invoice.taxRate1,
            ) : Container(),
            company.enableInvoiceTaxes && company.enableSecondTaxRate ? TaxRateDropdown(
              onSelected: (taxRate) =>
                  viewModel.onChanged(invoice.rebuild((b) => b
                    ..taxRate2 = taxRate.rate
                    ..taxName2 = taxRate.name)),
              labelText: localization.tax,
              state: viewModel.state,
              initialTaxName: invoice.taxName2,
              initialTaxRate: invoice.taxRate2,
            ) : Container(),
          ],
        ),
      ],
    );
  }
}
