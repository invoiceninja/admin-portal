import 'package:invoiceninja/ui/app/forms/custom_field.dart';
import 'package:invoiceninja/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';

class InvoiceEditItems extends StatelessWidget {
  const InvoiceEditItems({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final InvoiceEditItemsVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;

    if (invoice.invoiceItems.isEmpty) {
      return Center(
        child: Text(
          localization.clickPlusToAddItem,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),
        ),
      );
    }

    final invoiceItems = invoice.invoiceItems.map((invoiceItem) =>
        ItemEditDetails(
            viewModel: viewModel,
            key: Key('__${EntityType.invoiceItem}_${invoiceItem.id}__'),
            invoiceItem: invoiceItem,
            index: invoice.invoiceItems.indexOf(invoiceItem)));

    return ListView(
      children: invoiceItems.toList(),
    );
  }
}

class ItemEditDetails extends StatefulWidget {
  const ItemEditDetails({
    Key key,
    @required this.index,
    @required this.invoiceItem,
    @required this.viewModel,
  }) : super(key: key);

  final int index;
  final InvoiceItemEntity invoiceItem;
  final InvoiceEditItemsVM viewModel;

  @override
  ItemEditDetailsState createState() => ItemEditDetailsState();
}

class ItemEditDetailsState extends State<ItemEditDetails> {
  final _productKeyController = TextEditingController();
  final _notesController = TextEditingController();
  final _costController = TextEditingController();
  final _qtyController = TextEditingController();
  final _discountController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _productKeyController,
      _notesController,
      _costController,
      _qtyController,
      _discountController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final state = widget.viewModel.state;
    final invoiceItem = widget.invoiceItem;

    _productKeyController.text = invoiceItem.productKey;
    _notesController.text = invoiceItem.notes;
    _costController.text = formatNumber(invoiceItem.cost, state,
        formatNumberType: FormatNumberType.input);
    _qtyController.text = formatNumber(invoiceItem.qty, state,
        formatNumberType: FormatNumberType.input);
    _discountController.text = formatNumber(invoiceItem.discount, state,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = invoiceItem.customValue1;
    _custom2Controller.text = invoiceItem.customValue2;

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
    final invoiceItem = widget.invoiceItem.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text.trim()
      ..cost = double.tryParse(_costController.text) ?? 0.0
      ..qty = double.tryParse(_qtyController.text) ?? 0.0
      ..discount = double.tryParse(_discountController.text) ?? 0.0
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
    );
    if (invoiceItem != widget.invoiceItem) {
      widget.viewModel.onChangedInvoiceItem(invoiceItem, widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoiceItem = widget.invoiceItem;
    final company = viewModel.state.selectedCompany;

    void _confirmDelete() {
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              semanticLabel: localization.areYouSure,
              title: Text(localization.areYouSure),
              actions: <Widget>[
                new FlatButton(
                    child: Text(localization.cancel.toUpperCase()),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new FlatButton(
                    child: Text(localization.ok.toUpperCase()),
                    onPressed: () {
                      widget.viewModel.onRemoveInvoiceItemPressed(widget.index);
                      Navigator.pop(context);
                    })
              ],
            ),
      );
    }

    return FormCard(
      children: <Widget>[
        TextFormField(
          autocorrect: false,
          controller: _productKeyController,
          decoration: InputDecoration(
            labelText: localization.product,
          ),
        ),
        TextFormField(
          autocorrect: false,
          controller: _notesController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: localization.description,
          ),
        ),
        CustomField(
          controller: _custom1Controller,
          labelText: company.getCustomFieldLabel(CustomFieldType.product1),
          options: company.getCustomFieldValues(CustomFieldType.product1),
        ),
        CustomField(
          controller: _custom2Controller,
          labelText: company.getCustomFieldLabel(CustomFieldType.product2),
          options: company.getCustomFieldValues(CustomFieldType.product2),
        ),
        TextFormField(
          controller: _costController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: localization.unitCost,
          ),
        ),
        TextFormField(
          controller: _qtyController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: localization.quantity,
          ),
        ),
        TextFormField(
          controller: _discountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: localization.discount,
          ),
        ),
        company.enableInvoiceTaxes
            ? TaxRateDropdown(
                onSelected: (taxRate) => viewModel.onChangedInvoiceItem(
                    invoiceItem.rebuild((b) => b
                      ..taxRate1 = taxRate.rate
                      ..taxName1 = taxRate.name),
                    widget.index),
                labelText: localization.tax,
                state: viewModel.state,
                initialTaxName: invoiceItem.taxName1,
                initialTaxRate: invoiceItem.taxRate1,
              )
            : Container(),
        company.enableInvoiceTaxes && company.enableSecondTaxRate
            ? TaxRateDropdown(
                onSelected: (taxRate) => viewModel.onChangedInvoiceItem(
                    invoiceItem.rebuild((b) => b
                      ..taxRate2 = taxRate.rate
                      ..taxName2 = taxRate.name),
                    widget.index),
                labelText: localization.tax,
                state: viewModel.state,
                initialTaxName: invoiceItem.taxName2,
                initialTaxRate: invoiceItem.taxRate2,
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: FlatButton(
                child: Text(
                  localization.remove,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                onPressed: _confirmDelete,
              ),
            )
          ],
        ),
      ],
    );
  }
}
